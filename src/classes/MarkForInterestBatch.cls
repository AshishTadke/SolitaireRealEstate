global class MarkForInterestBatch implements Database.Batchable <sObject>, Schedulable 
{
     Public String Query;
    
    public MarkForInterestBatch() 
    {
     Query = 'Select Id,Charge_Amount_Billed__c,Charge_Amount_Due__c,Service_Tax_Amount_Due__c,Service_Tax_Amount_Billed__c,Customer_Pay_Plan_Header__r.Customer__c,Payment_Due_Date__c,Project__c FROM Standard_Customer_Pay_Plan_Detail__c WHERE IsPaymentOverdue__c=true AND Customer_Pay_Plan_Header__c != null AND Customer_Pay_Plan_Header__r.Customer__c != null AND Customer_Pay_Plan_Header__r.Customer__r.Status__C = \'Active\' AND marked_for_interest__c = false';
                                  
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext info, List<Standard_Customer_Pay_Plan_Detail__c> scppdList){
       if(scppdList.size() > 0){
            InterestManagementServices.markForInterestCalculation(scppdList);
       }
    }
    
    global void finish(Database.BatchableContext info){     
    }   
    
    global void execute(SchedulableContext sc) {
      MarkForInterestBatch b = new MarkForInterestBatch (); 
      database.executebatch(b,10);
     }    
}