public class S_ChequeReceiving {
     public List < rMainWrapper > rwList {
      get;
      set;
     }
     public List < Receipt__C > lstReceipt {
      get;
      set;
     }
     public Boolean error {
      get;
      set;
     }
     public S_ChequeReceiving() {
        error = false;
        getlist();
     }
     public PaginationController.PaginationWrapper pgw;
     public Transient List<Receipt__c> objR {get;set;}
     public Transient List<Receipt__c> dummyList {get;set;}
     

     public void getlist() {
     
        objR = new List<Receipt__c>();
        pgw = new PaginationController.PaginationWrapper();
        pgw.list_size = 100;
        pgw.counter = 0;
        pgw.created_date = '';
        dummyList = new List<Receipt__c>();
        
        
         rwList = new List<rMainWrapper>();
            lstReceipt = new list < Receipt__c > ([select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC limit:pgw.list_size offset:pgw.counter]);
           
           
       dummyList = [select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC];                     
          
                       
           if(dummyList.size() > 0){
                pgw.total_size = dummyList.size();    
                pgw.last_date =  dummyList[dummyList.size() - 1].name;            
           }
         
               
           
          if (lstReceipt.size() > 0) {
               for (Receipt__c r: lstReceipt) {
                   if (String.isNotBlank(r.Receipt_Status__c) && r.Receipt_Status__c.equalsIgnoreCase('UnProcessed') && !r.Physically_Cheque_Received__c) {
                        r.Receipt_Status__c = 'UnProcessed';
                    } 
                    String applicantNames;
                    if(String.isNotBlank(r.Opportunity__r.Primary_Name__c)) 
                        applicantNames = r.Opportunity__r.Primary_Name__c;
                    if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                        applicantNames += ',' + r.Opportunity__r.Other_Applicants_Name__c;
                    else if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c))
                        applicantNames = r.Opportunity__r.Other_Applicants_Name__c;
                    rMainWrapper rw = new rMainWrapper(r, applicantNames);
                    rwList.add(rw);
                }
          }
     }

     public void Save() {
            error = false;
            
          for (rMainWrapper rw: rwList) {
                rw.style0='';
                rw.style1='';
                rw.style2='';
                System.debug('RECEIPT DATA:' + rw);
                // throw an error if physical verification is checked but the status of verification is blank
               if (rw.rCloned.Physically_Cheque_Received__c == true && 
                    String.isnotBlank(rw.r.Receipt_status__c) && 
                    rw.r.Receipt_status__c.equalsIgnoreCase('UnProcessed') && 
                    String.isBlank(rw.rCloned.Reason_for_rejection_new__c)
                ) {
                    rw.style0 = 'error';
                    error = true;
                    // throw an error if Foreign Curreny payment is accepted but forex amt is not filled
               } else if (rw.rCloned.Physically_Cheque_Received__c == true && 
                    String.isnotBlank(rw.r.Receipt_status__c) && 
                    rw.r.Receipt_status__c.equalsIgnoreCase('Processed-Sent for Banking') && 
                    String.isNotBlank(rw.rCloned.Banking__c) &&
                    rw.rCloned.Banking__c.equalsIgnoreCase('Payment Successful') && 
                    String.isNotBlank(rw.r.Currency__c) &&
                    !(rw.r.Currency__c.equalsIgnoreCase('Indian Rupee') || rw.r.Currency__c.equalsIgnoreCase('RUPEES')) &&
                    rw.rCloned.Forex__c == null
                ) {
                    rw.style2 = 'error';
                    error = true;
               }
          }
          System.debug('out of loop1');
          List<Receipt__c> updateReceiptList = new List<Receipt__c>();
          List<Task> lstTask = new List<Task>();
          if (error) {
            System.debug('In error');
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please correct the errors below'));
            return;
          }else{
              for (rMainWrapper rw: rwList) {
                rw.style0='';
                rw.style1='';
                rw.style2='';
                // physical verification is accepted or rejected, store the status in the receipt
                System.debug('List of receipts for processing:' + rw);
                if (rw.rCloned.Physically_Cheque_Received__c == true && 
                String.isNotBlank(rw.r.Receipt_status__c) && 
                rw.r.Receipt_status__c.equalsIgnoreCase('UnProcessed') && 
                String.isNotBlank(rw.rCloned.Reason_for_rejection_new__c)
                ) {
                    
                    if (rw.rCloned.Reason_for_rejection_new__c.equalsIgnoreCase('Accepted')) {
                        rw.r.Receipt_status__c = 'Processed-Sent for Banking';
                        rw.r.Physically_Cheque_Received__c = true;
                        rw.r.Reason_for_rejection_new__c = rw.rCloned.Reason_for_rejection_new__c;
                    } else {
                        rw.r.Receipt_status__c = 'Physical Verification Rejected';
                        rw.r.Physically_Cheque_Received__c = true;
                        rw.r.Reason_for_rejection_new__c = rw.rCloned.Reason_for_rejection_new__c;
                        Task objTask = new Task();
                        objTask.Subject = rw.r.Cheque_DD__c + ' ' + 'is rejected by Finance Team for ' + rw.r.Reason_for_rejection_new__c;
                        objTask.WhatId = rw.r.Id;
                        objTask.OwnerId = rw.r.OwnerId;
                        objTask.Description = rw.r.Reason__c;
                        lstTask.add(objTask);
                    }
                    rw.r.status_change_date__c = system.today();
                    updateReceiptList.add(rw.r);
                    // if banking is completed, store the payment received /rejected status
               } else if (rw.rCloned.Physically_Cheque_Received__c == true && 
                    String.isnotBlank(rw.r.Receipt_status__c) && 
                    rw.r.Receipt_status__c.equalsIgnoreCase('Processed-Sent for Banking') && 
                    String.isNotBlank(rw.rCloned.Banking__c)
                ) {
                    if (rw.rCloned.Banking__c.equalsIgnoreCase('Payment Successful')) {
                     rw.r.Receipt_status__c = 'Cleared';
                     rw.r.Banking__c = rw.rCloned.Banking__c;
                     if(rw.rCloned.Forex__c != null && !(rw.r.Currency__c.equalsIgnoreCase('Indian Rupee') || rw.r.Currency__c.equalsIgnoreCase('RUPEES'))) {
                        rw.r.Forex__c = rw.rCloned.Forex__c;
                        rw.r.Amount_Rs__c = rw.r.Forex__c;
                        rw.r.Currency__c = 'Indian Rupee';
                        rw.r.Total_Amount__c = rw.r.Forex__c;
                        rw.r.On_Account_Money__c = rw.r.Forex__c;
                     }
                    } else {
                        System.debug('Inside Dishonored loop:' + rw);
                     rw.r.Receipt_status__c = 'Dishonored';
                     rw.r.Banking__c = rw.rCloned.Banking__c;
                     Task objTask = new Task();
                     objTask.Subject = rw.r.Cheque_DD__c + ' ' + 'is rejected by Finance Team for ' + rw.r.Banking__c;
                     objTask.WhatId = rw.r.Id;
                     objTask.OwnerId = rw.r.OwnerId;
                     objTask.Description = rw.r.Reason__c;
                     lstTask.add(objTask);
                    }
                    rw.r.status_change_date__c = system.today();
                    updateReceiptList.add(rw.r);
                }
              }
          }
          if(updateReceiptList.size() > 0){
            System.debug('In Update:' + updateReceiptList);
            update updateReceiptList;
          }
          if(lstTask.size() > 0) {
            System.debug('In Task creation:');
            insert lstTask;
          }
     getlist();
     return;
    }

    public pagereference Back() {
        return new pagereference('/home/home.jsp');
    }
    
    public class rMainWrapper {
         public Receipt__c r {
          get;
          set;
         }
         public Receipt__c rCloned {
          get;
          set;
         }
         public String style0 {
          get;
          set;
         }
         public String applicantNames {
          get;
          set;
         }
         public String style1 {
          get;
          set;
         }
         public String style2 {
          get;
          set;
         }
         
         public rMainWrapper(Receipt__c r, String applicantNames) {
          this.r = r;
          this.applicantNames = applicantNames;
          this.rCloned = new Receipt__c();
          this.rCloned.Physically_Cheque_Received__c = r.Physically_Cheque_Received__c;
          if(r.Banking__c != null)
            this.rCloned.Banking__c = r.Banking__c;
          
          if(r.Reason_for_rejection_new__c != null)
             this.rCloned.Reason_for_rejection_new__c = r.Reason_for_rejection_new__c;
          
          if(r.Forex__c != null)
            this.rCloned.Forex__c = r.Forex__c;
          
          this.style0 = '';
          this.style1 = '';
          this.style2 = '';
         }
    }
    
    public Boolean getDisablePrevious() { //this will disable the previous and beginning buttons
         // system.debug('PGW:' + pgw);
         // system.debug('in previous:: '+PaginationController.DisableNext(pgw));
       return(PaginationController.DisablePrevious(pgw));
      
       
    }
    public Boolean getDisableNext() { //this will disable the next and end buttons
      //system.debug('PGW:' + pgw);
      //system.debug('in next:: '+PaginationController.DisableNext(pgw));
       return(PaginationController.DisableNext(pgw));
    }
    
     public PageReference Beginning() { //user clicked beginning
        pgw= PaginationController.Beginning(pgw);
        
        //objR = new List<Receipt__c>();
       
        //wrapperscppdList = new List<wrapperclass>();
        
         rwList = new List<rMainWrapper>();
            lstReceipt = new list < Receipt__c > ([select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC limit:pgw.list_size offset:pgw.counter]);
          if (lstReceipt.size() > 0) {
               for (Receipt__c r: lstReceipt) {
                   if (String.isNotBlank(r.Receipt_Status__c) && r.Receipt_Status__c.equalsIgnoreCase('UnProcessed') && !r.Physically_Cheque_Received__c) {
                        r.Receipt_Status__c = 'UnProcessed';
                    } 
                    String applicantNames;
                    if(String.isNotBlank(r.Opportunity__r.Primary_Name__c)) 
                        applicantNames = r.Opportunity__r.Primary_Name__c;
                    if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                        applicantNames += ',' + r.Opportunity__r.Other_Applicants_Name__c;
                    else if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c))
                        applicantNames = r.Opportunity__r.Other_Applicants_Name__c;
                    rMainWrapper rw = new rMainWrapper(r, applicantNames);
                    rwList.add(rw);
                }
          }
         
         
        return null;
     }   
     
     public PageReference Previous() { //user clicked previous button
       pgw = PaginationController.Previous(pgw);
       
       //objR = new List<Receipt__c>();
         
      // wrapperscppdList = new List<wrapperclass>();
         
         rwList = new List<rMainWrapper>();
            lstReceipt = new list < Receipt__c > ([select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC limit:pgw.list_size offset:pgw.counter]);
          if (lstReceipt.size() > 0) {
               for (Receipt__c r: lstReceipt) {
                   if (String.isNotBlank(r.Receipt_Status__c) && r.Receipt_Status__c.equalsIgnoreCase('UnProcessed') && !r.Physically_Cheque_Received__c) {
                        r.Receipt_Status__c = 'UnProcessed';
                    } 
                    String applicantNames;
                    if(String.isNotBlank(r.Opportunity__r.Primary_Name__c)) 
                        applicantNames = r.Opportunity__r.Primary_Name__c;
                    if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                        applicantNames += ',' + r.Opportunity__r.Other_Applicants_Name__c;
                    else if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c))
                        applicantNames = r.Opportunity__r.Other_Applicants_Name__c;
                    rMainWrapper rw = new rMainWrapper(r, applicantNames);
                    rwList.add(rw);
                }
          }
         
         return null;
     }   
     
     public PageReference Next() { //user clicked next button
        pgw = PaginationController.Next(pgw);
        
        //objR = new List<Receipt__c>();
        
       // wrapperscppdList = new List<wrapperclass>();
       
               rwList = new List<rMainWrapper>();
            lstReceipt = new list < Receipt__c > ([select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC limit:pgw.list_size offset:pgw.counter]);
          if (lstReceipt.size() > 0) {
               for (Receipt__c r: lstReceipt) {
                   if (String.isNotBlank(r.Receipt_Status__c) && r.Receipt_Status__c.equalsIgnoreCase('UnProcessed') && !r.Physically_Cheque_Received__c) {
                        r.Receipt_Status__c = 'UnProcessed';
                    } 
                    String applicantNames;
                    if(String.isNotBlank(r.Opportunity__r.Primary_Name__c)) 
                        applicantNames = r.Opportunity__r.Primary_Name__c;
                    if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                        applicantNames += ',' + r.Opportunity__r.Other_Applicants_Name__c;
                    else if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c))
                        applicantNames = r.Opportunity__r.Other_Applicants_Name__c;
                    rMainWrapper rw = new rMainWrapper(r, applicantNames);
                    rwList.add(rw);
                }
          }
         
        return null;
     }  
     
     public PageReference End() { //user clicked end
        pgw = PaginationController.End(pgw);
        
        //objR = new List<Receipt__c>();
         
        //wrapperscppdList = new List<wrapperclass>();
         //system.debug('last anem:: '+pgw.last_date);
         //system.debug('limit is::'+pgw.last_limit);
         
        rwList = new List<rMainWrapper>();
            lstReceipt = new list < Receipt__c > ([select Receipt_Number__c, id, OwnerId, Physically_Cheque_Received__c, Total_Amount__c, 
            Cheque_DD__c, Cheque_DD_Date__c, Mode__c,Drawn_in_favour_of__c,
           Bank__r.name, Cheque_DD_Amount_Rs__c, Project_Unit__c, Project_Unit__r.Project__r.name, Currency__c,PAN_no_of_TDS_Deductor__c,
           Project_Unit__r.name, Opportunity__c, Reason__c, Opportunity__r.name, 
           Opportunity__r.Primary_Name__c,Opportunity__r.Other_Applicants_Name__c,
           name, Amount_Rs__c, DraweeBank__c, Reason_for_rejection_new__c, Receipt_Status__c, Banking__c, FOREX__c
           from Receipt__c
           where Receipt_Status__c NOT IN('Dishonored', 'Cleared', 'Physical Verification Rejected')
           Order By CreatedDate DESC limit:pgw.list_size offset:pgw.counter]);
          if (lstReceipt.size() > 0) {
               for (Receipt__c r: lstReceipt) {
                   if (String.isNotBlank(r.Receipt_Status__c) && r.Receipt_Status__c.equalsIgnoreCase('UnProcessed') && !r.Physically_Cheque_Received__c) {
                        r.Receipt_Status__c = 'UnProcessed';
                    } 
                    String applicantNames;
                    if(String.isNotBlank(r.Opportunity__r.Primary_Name__c)) 
                        applicantNames = r.Opportunity__r.Primary_Name__c;
                    if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                        applicantNames += ',' + r.Opportunity__r.Other_Applicants_Name__c;
                    else if(String.isNotBlank(r.Opportunity__r.Other_Applicants_Name__c))
                        applicantNames = r.Opportunity__r.Other_Applicants_Name__c;
                    rMainWrapper rw = new rMainWrapper(r, applicantNames);
                    rwList.add(rw);
                }
          }
        
        return null;
     }
      public Integer getTotal_size() {
        return (PaginationController.getTotal_size(pgw));
    }
    
    
    public Integer getPageNumber() {
         return (PaginationController.getPageNumber(pgw));
    }
    
      public Integer getTotalPages() {
    return (PaginationController.getTotalPages(pgw));
    }
}