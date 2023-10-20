Public Class DemandsAndReceiptsClass{
     Public id CPPHidpage {get;set;}
     public id Id{get;set;}
     public List <Demand_Invoice__c> Demand {get; set;}
     public List <Standard_Customer_Pay_Plan_Detail__c> SCPPDList {get; set;}
     public List <Receipt__c> Receipts{get; set;}
     public List <Receipt__c> Receiptslist{get; set;}
     public List <Receipt_Details__c> ReceiptsDetails{get; set;}
     public List <Task> tasklist{get; set;}  
     public Id what_id {get;set;}
     public Id who_id {get;set;}
     public Id scppd {get;set;}
     public List <Receipt__c> Receipts1{get;set;}
     List<Id> ReceiptsIds = new List<Id>();   
     public List<Case> caseList{get;set;}
    public DemandsAndReceiptsClass()
    {
     Receiptslist = new List<Receipt__c>();
      system.debug('&&&&&&&&&&&&&&&&');
        if(ApexPages.currentPage().getParameters().get('CPPHid') != null && ApexPages.currentPage().getParameters().get('CPPHid') != '')
         {   
             CPPHidpage  = ApexPages.currentPage().getParameters().get('CPPHid');
             Demand = [Select id, Invoice_Date__c,Due_Date__c, Name, Is_Advanced_Demand__c, Total_Amount__c, Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c, Customer__c, Customer__r.Name,
             Standard_Customer_Pay_Plan_Detail__r.Call_Comments__c From Demand_Invoice__c  Where Standard_Customer_Pay_Plan_Detail__c =: CPPHidpage];
             //Receipts = [Select id, Name,DraweeBank__c, Receipt_Date__c, Receipt_Status__c, Mode__c, Token_Amount_Receipt__c, Token_Amount_ST__c, Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c From Receipt__c Where Standard_Customer_Pay_Plan_Detail__c =: CPPHidpage];
             ReceiptsDetails = [Select id, Receipts__c, Receipts__r.Name, Receipts__r.DraweeBank__c, Receipts__r.Receipt_Date__c, Receipts__r.Receipt_Status__c, Receipts__r.Mode__c, Receipts__r.Token_Amount_Receipt__c, Receipts__r.Token_Amount_ST__c, Receipts__r.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c From Receipt_Details__c Where Standard_Customer_Pay_Plan_Detail__c =: CPPHidpage];
            
            for(Receipt_Details__c rd: ReceiptsDetails){ 
                ReceiptsIds.add(rd.Receipts__c); 
             }
             System.Debug('ReceiptsIds'+ReceiptsIds);
             System.Debug('ReceiptsIds Size'+ReceiptsIds.size());
             Set<Id> mySet = new Set<Id>();
             if(ReceiptsIds.size() > 0)
             {
                 mySet.addAll(ReceiptsIds);
             }
             System.Debug('Set'+mySet);
             System.Debug('ReceiptsIds'+ReceiptsIds);
             Receipts = new List<Receipt__c>();
             if(ReceiptsIds.size() > 0)
             {
                 Receipts = [Select id, Name,DraweeBank__c, Receipt_Date__c, Receipt_Status__c, Mode__c, Token_Amount_Receipt__c, Token_Amount_ST__c,Receipt_Against__c, Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c From Receipt__c Where id in : ReceiptsIds];
             }
             if(Receipts.size() > 0)
             {
                 system.debug('Receipts1  '+Receipts);
                 system.debug('Receipts1  '+Receipts.size());
             }
             System.Debug('before task query');
             tasklist = [Select id, ActivityDate, Communication_Type__c,Reason_For_Call__c, Next_Action_Date__c,PTP_Amount__c,Payment_Instrument__c,Address__c, Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c,L2__c,L3__c From Task where Standard_Customer_Pay_Plan_Detail__c =:CPPHidpage];
             System.Debug('taskList'+tasklist);
             SCPPDList = [Select Is_to_be__c,Customer_Pay_Plan_Header__r.Customer__r.Project__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Project_Unit__r.Name, Customer_Pay_Plan_Header__r.Customer__r.Name, Customer_Pay_Plan_Header__r.Customer__c, Customer_Pay_Plan_Header__r.Customer__r.Account.Name, Customer_Pay_Plan_Header__r.Customer__r.Account.Id from Standard_Customer_Pay_Plan_Detail__c where Id =:CPPHidpage];
             System.Debug('SCPPDList'+SCPPDList);
        }
      
          
       if(ApexPages.currentPage().getParameters().get('Id') != null && ApexPages.currentPage().getParameters().get('Id') != '')
       {   
           Id= ApexPages.currentPage().getParameters().get('Id');
           system.debug('Id====='+Id);
           system.debug('Inside the method');
           Receiptslist= [Select id, Name,DraweeBank__c, Receipt_Date__c, Receipt_Status__c, Mode__c, Token_Amount_Receipt__c, Token_Amount_ST__c,Receipt_Against__c, Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c From Receipt__c Where Booking__c =:Id];
           system.debug('Receiptslist'+Receiptslist);            
       }
       //Added by shailesh to show Collection related History//
       if(SCPPDList != null)
       {
           system.debug('Id====='+Id);
           caseList = [Select Id,Origin,Mode__c,Reason,L1__c,L2__c,L3__c,L4__c,Priority,Status,Reason_Outcome__c,AccountId,ContactId,CaseNumber,CreatedDate
                              ,ClosedDate,Attempted_By__c from Case where AccountId =: SCPPDList[0].Customer_Pay_Plan_Header__r.Customer__r.AccountId and L1__c = 'Collection Related'];
           System.debug('CASE LIST::'+caseList);
       }
    
   }
    
    public PageReference redirectUser(){    
    String subject = 'Post Sales Call';
    String status = 'Completed';
    String tasktype = 'Post Sales Call';
    String retURL = '/apex/DemandsAndReceipts?CPPHid='+CPPHidpage;
    String SaveURL = retURL;
    String CancelURL= retURL;
    String OppName ='';
    if( SCPPDList.size()>0)
    {
        what_id = SCPPDList[0].Customer_Pay_Plan_Header__r.Customer__c;
        who_id = SCPPDList[0].Customer_Pay_Plan_Header__r.Customer__r.Account.Id;    
        scppd = CPPHidpage;
        OppName = SCPPDList[0].Customer_Pay_Plan_Header__r.Customer__r.Name;      
    } 
    ///////////////////////// -------------------------------- commented by vikas for new case ------------------------------------////////////////////////////
    //PageReference ref = new PageReference('/apex/CallAttemptEditPage2?subject='+subject+'&status='+status+'&tasktype='+tasktype+'&origin=Page&who_id='+who_id+'&what_id='+what_id+'&scppd='+scppd+'&retURL='+retURL+'&CancelURL='+retURL+'&SaveURL='+retURL);
    /////////////////////// ----------------------- Added by vikas for new case ----------------------------------------------////////////////////////////////
    PageReference ref = new PageReference('/500/e?CF00NR0000001pLyN='+OppName+'&def_account_id='+who_id+'&retURL='+retURL+'&CancelURL='+retURL+'&SaveURL='+retURL); //// CF00NR0000001pLyN this id of opportunity name field from case view source page 
    //ref += 'subject='+subject; 

    
    //subject=Post%20Sales%20Call&status=Completed&tasktype=Post%20Sales%20Call&origin=Page&who_id=001O000000miUf5IAE&what_id=006O0000007k74QIAQ&retURL=/006O0000007k74QIAQ&saveURL=/006O0000007k74QIAQ&cancelURL=/006O0000007k74QIAQ
    
    
    return ref;
}
}