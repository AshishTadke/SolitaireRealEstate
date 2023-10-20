trigger trgTaskHandler on Task (after update, after insert) {
    public list<Lead> lstLead{get; set;}
    for(Task objTask : trigger.New)
    {
        if(objTask.Status == 'Completed')
        {
            lstLead = [select id from Lead where Id =: objTask.WhoId];
            for(Lead ObjLead : lstLead)
            {
                ObjLead.OwnerId = objTask.OwnerId;
                update ObjLead;
            }
        }
    }
    if(Trigger.isInsert) 
    {
        if(Trigger.isAfter) 
        {
                TaskManagementServices.latestTaskRollupToOpp(Trigger.new);
                TaskManagementServices.latestTaskRollupToLead(Trigger.new);
            //    TaskManagementServices.updateSCPP(trigger.new);
            //    TaskManagementServices.HomeLoanTaskRollupToOpp(trigger.new);
            //    TaskManagementServices.RegTaskRollupToOpp(trigger.new);
                TaskManagementServices.createCommunicationEntries(trigger.new);
               
               List <Task> TaskLst2 = new List <Task> ();
              for(Task t: trigger.new)
              {
              
                    if(t.Task_Type__c=='Presales Call')
                    {
                        TaskLst2.add(t);
                    }
              }    
            TaskManagementServices.callStatusMethod(TaskLst2);
                
        }
    }
    if(Trigger.isUpdate) 
    {
        if(Trigger.isAfter) 
        {
            if(checkRecursion.isFirstRun()) 
            {
              ///------------------added by vikas for edit option on customer interaction to rollup on opp &lead------------////
              TaskManagementServices.latestTaskRollupToOpp(Trigger.new);
              TaskManagementServices.latestTaskRollupToLead(Trigger.new);
              /////// ------------------------------ vikas added end here ------------------------/////////////////////////
              
              //  TaskManagementServices.HomeLoanTaskRollupToOpp(trigger.new);
                TaskManagementServices.createCommunicationEntries(trigger.new);
              //  TaskManagementServices.RegTaskRollupToOpp(trigger.new);
            }
        }
    
    }
  
}