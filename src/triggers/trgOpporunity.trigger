trigger trgOpporunity on Opportunity (before insert, after insert, before update, after update) 
{   
    OpportunityTriggerHandler objOpp = new OpportunityTriggerHandler();    
    if(Trigger.isInsert && Trigger.isBefore)
    {
        objOpp.insertBefore(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter)
    {
        objOpp.insertAfter(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore)
    {
            objOpp.beforeUpdate(Trigger.new, Trigger.OldMap);
    }
    /** if(Trigger.isUpdate && Trigger.isafter)
    {
        if(checkRecursion.isFirstRun()){
            objOpp.afterUpdate(Trigger.new, Trigger.OldMap);
        }
    } **/
}