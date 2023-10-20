global class CalculateInterestBatch implements Database.Batchable <sObject>, Schedulable 
{
     Public String Query;
    
    public CalculateInterestBatch() 
    {
     Query = 'Select Id, Name, Installment_Amount__c, Service_Tax_Amount__c, Milestone__c, project__r.RDS_Interest_Rate__c,Aging_System__c, Corrected_Age__c from Interest_Details__c where active__C = true';
                                  
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext info, List<Interest_Details__c> IDList){
       if(IDList.size() > 0){
            InterestManagementServices.calculateInterest(IDList);
       }
    }
    
    global void finish(Database.BatchableContext info){     
    }   
    
    global void execute(SchedulableContext sc) {
      CalculateInterestBatch b = new CalculateInterestBatch(); 
      database.executebatch(b,10);
     }    
}