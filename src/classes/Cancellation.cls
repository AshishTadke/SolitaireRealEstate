public class Cancellation {
    
    // This method, will identify the customer that are to be marked for cancellation.
    // default on token, [cheque bounce] or any one that has a payment overdue are candidates for cancellation
    // check the percentage paid so far and the registration status to determine the cancellation category
    // update the opportunity with cancellation details 
    // exclude customers that are already in the cancellation process and inactive customers
    public static void markForCancellation() {
      List<Receipt__c> bounceList = new List<Receipt__c>();
      bounceList = [Select Id, Name, Mode__c, Receipt_Status__c, Job_Run__c, Cancellation_Initiated__c, Opportunity__c 
                                        from Receipt__C
                                        where 
                                        Receipt_Status__c = 'Dishonored' 
                                        and Job_Run__c = false
                                        and Opportunity__r.Status__c ='Active' 
                                          and Opportunity__r.Cancellation_In_Progress__c = false
                                        and Opportunity__r.StageName = 'Booking confirmed'];
      Set<Id> customerId = new Set<Id>();    
      // storing the id of the object that triggered the registration
      Map<Id,Id> customerCancellationTriggerMap  = new Map<Id,Id>();
      List<Booking__c> bookingList = new List<Booking__c>();    
      Map<Id,Decimal> customerTokenAmountMap = new Map<Id,Decimal>();                              
      if(bounceList.size() > 0) {
        for(Receipt__c r : bounceList) {
          customerId.add(r.Opportunity__c);
          customerCancellationTriggerMap.put(r.Opportunity__c, r.Id);
          r.Job_Run__c = true;
        }
        bookingList = [Select Id, Quotation__R.Token_Amount__c, Quotation__r.ST_Token_Amount__c,Customer__c from booking__c where Customer__c in :customerId];
        Map<String,List<Tax_breakup__c>> taxSlabMap = InventoryCostServices.getChildTaxSlabs();
            Decimal TDSAmount = 0;
        for(Booking__c b : bookingList) {
              if(taxSlabMap.containsKey('TDS')) {
                     TDSAmount = ((taxSlabMap.get('TDS')[0].Tax_Percentage__c * b.Quotation__R.Token_Amount__c)/100).setscale(0,RoundingMode.HALF_UP);
              }
          customerTokenAmountMap.put(b.Customer__c, b.Quotation__R.Token_Amount__c + b.Quotation__r.ST_Token_Amount__c - TDSAmount);
          TDSAmount = 0;
        }
      }
      
      List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
      scppdList = [Select Id, Name, Customer_Pay_Plan_Header__r.Customer__c , milestone_demand_id__c
                                  from Standard_Customer_Pay_Plan_Detail__c 
                                  where 
                                  IsPaymentOverdue__c = true
                                  and Customer_Pay_Plan_Header__r.Customer__r.Status__c = 'Active'
                                  and Customer_Pay_Plan_Header__r.Customer__r.Cancellation_In_Progress__c = false
                                  and Customer_Pay_Plan_Header__r.Customer__r.StageName = 'Booking confirmed'];
      if(scppdList.size() > 0) {
        for(Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
          customerId.add(scppd.Customer_Pay_Plan_Header__r.Customer__c);
          if(!(customerCancellationTriggerMap.containsKey(scppd.Customer_Pay_Plan_Header__r.Customer__c)))
            customerCancellationTriggerMap.put(scppd.Customer_Pay_Plan_Header__r.Customer__c, scppd.milestone_demand_id__c);
        }
      }                            
      
      List<Customer_Pay_Plan_Header__c> cpphList = new List<Customer_Pay_Plan_Header__c>();
      if(customerId.size() > 0) {
        cpphList = [Select Registration_Reached__c, Registration_Intimation_Sent__c, Amount_Recd_Till_Date__c, Service_Tax_Recd_Till_Date__c, 
                                              Percent_Paid__c, Customer__c, Customer__r.Registration_Status__c 
                                              from Customer_Pay_Plan_Header__c
                                              where
                                              Customer__c in : customerId];
      }
      Map<Id, String> customerCancelTypeMap = new Map<Id,String>();
      System.debug('cpph data:' + cpphList);
      if(cpphList.size() > 0) {
        for(Customer_Pay_Plan_Header__c cpph : cpphList) {
          if(cpph.Amount_Recd_Till_Date__c == null)
            cpph.Amount_Recd_Till_Date__c = 0;
          if(cpph.Service_Tax_Recd_Till_Date__c == null)
            cpph.Service_Tax_Recd_Till_Date__c = 0;
          if(cpph.Customer__r.Registration_Status__c != null &&  cpph.Customer__r.Registration_Status__c.equalsIgnoreCase('Agreement Registered')) {
            customerCancelTypeMap.put(cpph.Customer__c, 'Termination Post Registration');
          } else if(cpph.Amount_Recd_Till_Date__c + cpph.Service_Tax_Recd_Till_Date__c <  customerTokenAmountMap.get(cpph.Customer__c)) {
            customerCancelTypeMap.put(cpph.Customer__c, 'Default On Token');
          } else if(cpph.Percent_Paid__c > 5 &&  cpph.Percent_Paid__c < 19.9) {
            customerCancelTypeMap.put(cpph.Customer__c, 'Termination Post booking Pre-confirmation');
          } else if(cpph.Percent_Paid__c >= 19.9) {
            customerCancelTypeMap.put(cpph.Customer__c, 'Termination Post confirmation Pre-registration');
          } 
        }
      }
      
      List<Opportunity> oList = new List<Opportunity>();
      if(customerCancelTypeMap.size() > 0) {
        oList = [Select Id, Name , Status__c from Opportunity where id in : customerCancelTypeMap.keySet()];
        if(oList != null && oList.size() > 0)
        for(Opportunity customer : oList) {
          customer.Cancellation_In_Progress__c = true;
          customer.Cancellation_Type__c = customerCancelTypeMap.get(customer.Id);
          customer.cancellation_Initiation_Record__c = customerCancellationTriggerMap.get(customer.Id);
          customer.Cancellation_Remarks__c = System.today().format() + ': Customer marked for cancellation on basis of ' + customer.Cancellation_Type__c;
          if(customer.Cancellation_Type__c.equals('Default On Token'))
            customer.L1_to_be_sent_on__c = system.today().addDays(4);
          else
            customer.L1_to_be_sent_on__c = system.today().addDays(2);
          customer.Cancellation_Remarks__c += '\n' + System.today().format() + ': First letter will be generated on ' + customer.L1_to_be_sent_on__c.format();
          System.debug('Opportunity:' + customer.Id + ':'+ customer.Name);
        }
        
        update oList;
      }
      if(bounceList.size() > 0) {
        update bounceList;
      }
    }
    
    // for the customers that are currently in cancellation process, 
    // check if the outstandings have been paid off. If yes, take them out of the loop
    public static void removeFromCancellationProcess() {      
      Set<Id> customerId = new Set<Id>();
      List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
      scppdList = [Select Id, Name, Customer_Pay_Plan_Header__r.Customer__c 
                                  from Standard_Customer_Pay_Plan_Detail__c 
                                  where 
                                  Customer_Pay_Plan_Header__r.Customer__r.Cancellation_In_Progress__c = true
                                  and Customer_Pay_Plan_Header__r.Customer__r.Status__c = 'Active'
                                  and (IsPaymentOverdue__c = true
                                  OR 
                                  Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c > 0)];
      if(scppdList.size() > 0) {
        for(Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
          customerId.add(scppd.Customer_Pay_Plan_Header__r.Customer__c);
        }
      }
      
      List<Opportunity> oList = new List<Opportunity>();
      oList = [Select Id, Name 
                from Opportunity 
                where 
                Cancellation_In_Progress__c = true 
                and Id not in :customerId];  
      if(oList != null && oList.size() > 0) {
        for(Opportunity o : oList) {
          o.Cancellation_In_Progress__c = false;
          o.L1_to_be_sent_on__c = null;
          o.L2_to_be_sent_on__c = null;
          o.L3_to_be_sent_on__c = null;
          o.L4_to_be_sent_on__c = null;
          if(o.Cancellation_Remarks__c != null)
            o.Cancellation_Remarks__c += '\n' + System.today().format() + ': Customer moved out of cancellation as all dues are paid';
          else
            o.Cancellation_Remarks__c = '\n' + System.today().format() + ': Customer moved out of cancellation as all dues are paid';
          system.debug('Cancellation process stopped for:' + o.Id + ':' + o.Name);
        }
      }
      update oList;
    }
    
    // For the customers that are still in cancellation process after performing the previous step, [removing customer who have cleared dues]
    // based on their letter category, intiate the next step if the Letter to sent date is today
    // enter a record in the cancellation table 
    public static void createCancellationRecords() {
      List<Opportunity> oList = new List<Opportunity>();
      oList = [Select Id, Name, Cancellation_Type__c, latest_letter__c, L1_to_be_sent_on__c, L2_to_be_sent_on__c, L3_to_be_sent_on__c, L4_to_be_sent_on__c, 
                                                Cancellation_remarks__c, relationship_manager__c,Project_Unit__c,
                                                Primary_Email__c, Other_Applicants_Email__c, Future_Correspondence_Contact_Email__c
                                                from Opportunity
                                                where cancellation_in_progress__c = true
                                                and is_final_intimation_sent__c = false
                                                and cancellation_complete__c = false
                                                and 
                                                (L1_to_be_sent_on__c = TOMORROW OR
                                                L2_to_be_sent_on__c = TOMORROW OR
                                                L3_to_be_sent_on__c = TOMORROW OR
                                                L4_to_be_sent_on__c = TOMORROW)  ];
                                                
      List<Cancellation_Intimation__c> cList = new List<Cancellation_Intimation__c>();  
      System.debug('oList:' + oList);                                        
      if(oList.size() > 0) {
        for(Opportunity o : oList) {
          Cancellation_Intimation__c c = new Cancellation_Intimation__c();
          c.Customer__c = o.Id;
          c.Unit__c = o.Project_Unit__c;
          c.Letter_generated_date__c = system.today();
          if(o.L1_to_be_sent_on__c == system.today().addDays(1) && o.Cancellation_Type__c.equals('Default on Token')) {
            c.Letter_Category__c = 'L1';
          } else if(o.L1_to_be_sent_on__c == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post booking Pre-confirmation')) {
            c.Letter_Category__c = 'L2';
          } else if(o.L1_to_be_sent_on__c == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post confirmation Pre-registration')) {
            c.Letter_Category__c = 'L4';
          } else if(o.L1_to_be_sent_on__c == system.today().addDays(1) && o.Cancellation_Type__c.equalsIgnoreCase('Termination Post Registration')) {
            c.Letter_Category__c = 'L8';
          } else if(o.L2_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post booking Pre-confirmation')) {
            c.Letter_Category__c = 'L3';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L2_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post confirmation Pre-registration')) {
            c.Letter_Category__c = 'L5';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L2_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equalsIgnoreCase('Termination Post Registration')) {
            c.Letter_Category__c = 'L9';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L3_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post confirmation Pre-registration')) {
            c.Letter_Category__c = 'L6';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L3_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equalsIgnoreCase('Termination Post Registration')) {
            c.Letter_Category__c = 'L10';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L4_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equals('Termination Post confirmation Pre-registration')) {
            c.Letter_Category__c = 'L7';
            c.Previous_Letter__c = o.latest_letter__c;
          } else if(o.L4_to_be_sent_on__c  == system.today().addDays(1) && o.Cancellation_Type__c.equalsIgnoreCase('Termination Post Registration')) {
            c.Letter_Category__c = 'L11';
            c.Previous_Letter__c = o.latest_letter__c;
          }
          system.debug('Letter_Category__c:: '+c.Letter_Category__c);
       if(c.Letter_Category__c != null){  
          if(c.Letter_Category__c.equalsIgnoreCase('L1')) {
          c.letterType__c = 'Cancellation letter for dishonor of booking cheque';
          c.subject__c = 'Cancellation of Application Form.';          
        } else if (c.Letter_Category__c.equalsIgnoreCase('L2')) {
          c.letterType__c = 'Pre-registration [FINAL REMINDER-Pre 19.9% amount]';
          c.subject__c = 'Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L3')) {
          c.letterType__c = 'TERMINATION LETTER-pre 19.9% payment';
          c.subject__c = 'Cancellation of Application Form.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L4')) {
          c.letterType__c = 'Pre-registration [FIRST REMINDER]';
          c.subject__c = 'First Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L5')) {
          c.letterType__c = 'Pre-registration [SECOND REMINDER]';
          c.subject__c = 'Second Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L6')) {
          c.letterType__c = 'Pre-registration [FINAL REMINDER]';
          c.subject__c = 'Final Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L7')) {
          c.letterType__c = 'Pre-registration [TERIMATION LETTER]';
          c.subject__c = 'Notice of Cancellation of Application.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L8')) {
          c.letterType__c = 'Post-registration [FIRST REMINDER]';
          c.subject__c = 'First Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L9')) {
          c.letterType__c = 'Post-registration [SECOND REMINDER]';
          c.subject__c = 'Second Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L10')) {
          c.letterType__c = 'Post-registration [FINAL REMINDER]';
          c.subject__c = 'Final Reminder for payment of outstanding installment with Interest.';
        } else if (c.Letter_Category__c.equalsIgnoreCase('L11')) {
          c.letterType__c = 'Post-registration [TERIMATION LETTER]';
          c.subject__c = 'Notice of Cancellation of Application.';
        } else {
          c.letterType__c = 'Not implemented';
        }
      } 
          c.ownerId = o.relationship_manager__c;
          cList.add(c);
          o.Cancellation_Remarks__c += '\n' + System.today().format() + ': Cancellation letter category ' + c.Letter_Category__c + ' generated by system';
        }
      }
      System.debug('cList:' + cList);
      if(oList.size() > 0)
        update oList;
      if(cList.size() > 0)
        insert cList;  
    }
    
    public static void unitRelease() {
      List<Opportunity> oList = new List<Opportunity>();
      Set<Id> unitSet = new Set<Id>();
      List<Project_Unit__c> unitList = new List<Project_Unit__c>();
      oList = [Select Id, Name, Cancellation_Type__c, latest_letter__c, L1_to_be_sent_on__c, L2_to_be_sent_on__c, L3_to_be_sent_on__c, L4_to_be_sent_on__c, 
                                                Cancellation_remarks__c, relationship_manager__c,Project_Unit__c,
                                                Primary_Email__c, Other_Applicants_Email__c, 
                                                Future_Correspondence_Contact_Email__c,
                                                Project_Unit__r.Unit_status__c,
                                                Project_Unit__r.Name
                                                from Opportunity
                                                where cancellation_in_progress__c = true
                                                and is_final_intimation_sent__c = true
                                                and unit_release_date__c = TODAY
                                                and Status__c = 'Active'];
      for(Opportunity o : oList) {
        o.StageName = 'Cancelled';
        o.status__c = 'Inactive';
        o.Cancellation_Remarks__c += '\n' + System.today().format() + ': Unit '  + o.Project_Unit__r.Name + ' has been released';
        o.Cancellation_IN_Progress__c = false;
        o.Cancellation_Complete__c = true;
        unitSet.add(o.Project_Unit__c);
      }
      if(unitSet.size() >0) {
        unitList = [Select Id , Unit_status__c, booking__c, customer__c from Project_Unit__c where id in : unitSet];
        for(Project_Unit__c pu : unitList) {
          pu.Unit_status__c = 'Vacant';
          pu.Booking__c = null;
          pu.Customers__c = null;
        }
        update unitList;
      }
      update oList;
    }
}