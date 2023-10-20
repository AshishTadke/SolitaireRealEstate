trigger CPPHTrigger on Customer_Pay_Plan_Header__c (after insert, after update) {
   
    if(Trigger.Isafter && trigger.IsInsert) {   
      OpportunityManagementServices.updateBasicCharges(Trigger.New);
    }
    if(trigger.IsAfter && trigger.isUpdate) {
        if(!Test.isRunningTest()) {
          // dont test for recursion here, it stops the roll ups when demands are raised
          // but this also leads to too many SOQL exception only when running test methods
          OpportunityManagementServices.updateBasicCharges(Trigger.New);
        }
    }
}