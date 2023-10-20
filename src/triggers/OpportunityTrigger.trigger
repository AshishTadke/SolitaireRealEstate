trigger OpportunityTrigger on Opportunity (before insert, before update, After Insert,After Update) 
{
        //OpportunityTriggerHandler objOpp = new OpportunityTriggerHandler();   
        List<Opportunity> oppoList = new List<Opportunity>();
        List<Team_Members__c> lstTeamMembers= new List<Team_Members__c>();
        ////Added by shailesh for Registration////
        List<Opportunity> oList = new List<Opportunity>();
       // set<id> projId = new set<id>();
    
    if(Trigger.isInsert && Trigger.isBefore)
       {
        
        for(opportunity op : trigger.new){
           // projId.add(op.Project__c); 
        
        if(op.Project__c != null){
          list<Team_Members__c> lstTeamMembers = [select id,User__c,User_Active__c,Counter__c,Team__c,
          Last_Assignment__c from Team_Members__c where Team__r.Team_Type__c= 'Opportunity Owner Assignment Team' AND User_Active__c = true AND IsActive__c = true AND Team__r.Project__c =:op.Project__c];        
           system.debug('lstTeamMembers size  ::::: '+lstTeamMembers .size());
            system.debug('lstTeamMembers   ::::: '+lstTeamMembers);
             list<Team_Members__c> lstTeamMembersToUpdate = new List<Team_Members__c >();
            // system.debug('lstTeamMembersToUpdate ::::: '+lstTeamMembersToUpdate );
         
            if(lstTeamMembers != null && lstTeamMembers.size() >= 1)
            {
                datetime lsttime = system.now();
                Id ownerId = op.ownerId;
                for(Team_Members__c objTM : lstTeamMembers )
                {
                    if(lsttime!= null && objTM.Last_Assignment__c < lsttime)
                    {
                        lsttime = objTM.Last_Assignment__c;
                        ownerId = objTM.user__c;
                    }
               }    
                  for(Team_Members__c objTM : lstTeamMembers)
                {
                    if(objTM.user__c == ownerId)
                    {
                            objTM.Last_Assignment__c = system.now();
                            if(objTM.Counter__c != null)
                            objTM.Counter__c = objTM.Counter__c+1;
                            objTM.Ownerid = ownerId;
                            objTM.Last_Assignment__c = system.now();
                            lstTeamMembersToUpdate.add(objTM);                                    
                    }
                    
                }
                op.ownerId = ownerId;
              }  
              if(lstTeamMembersToUpdate != null && lstTeamMembersToUpdate.size() > 0)
                update lstTeamMembersToUpdate;

             }  
           }
       }
      

        
   
        
        if(Trigger.isInsert) 
        {
            if(Trigger.isAfter) 
            {     
                 // objOpp.insertAfter(Trigger.new);
                 // OpportunityManagementServices.updateSLBMFieldsOnAccAI(Trigger.new);  
                  
                    ////////////////////// Added by vikas for SCPPD updation on dated 15/07/2016 /////////////////////////
          for(Opportunity oppObj : Trigger.new)
          {
               if(oppObj.Registration_Date__c != null)
               {
                    oppoList.add(oppObj);
               }     
          
          }
          system.debug('oppList.size in trigger ::::: '+oppoList.size());
          
          
          
          if(oppoList.size() > 0)
          {
          
          OpportunityManagementServices.updateSCPPDDueDate(oppoList);
          
          }       
            }
        } 
        
        
      /*  if(Trigger.isUpdate && Trigger.isBefore)
        {
          
          objOpp.beforeUpdate(Trigger.new, Trigger.OldMap);
          
       }*/
        
        if(Trigger.isUpdate) 
        {
            if(Trigger.isAfter) 
            
            {
                  
                 
               if(checkRecursion.isFirstRun())
               {   //system.debug('afterUpdate');
                   // OpportunityManagementServices.updateSLBMFieldsOnAccAU(Trigger.oldMap, Trigger.newMap);  //Update Budget - Min-max
                    //objOpp.afterUpdate(Trigger.new, Trigger.OldMap);
                     
                       ////////////////////// Added by vikas for SCPPD updation on dated 15/07/2016 /////////////////////////
                  for(Opportunity oppObj : Trigger.new)
                  {
                       if(oppObj.Registration_Date__c != null)
                       {
                            oppoList.add(oppObj);
                       }  
                       if(Trigger.oldMap.get(oppObj.Id).Start_Registration__c == false && Trigger.newMap.get(oppObj.Id).Start_Registration__c == true)
                       {
                            oList.add(oppObj);
                       }  
                  
                  }
                  system.debug('oppList.size in trigger ::::: '+oppoList.size());
                  if(oppoList.size() > 0)
                  {
                      OpportunityManagementServices.updateSCPPDDueDate(oppoList);
                  }  
                  if(!oList.isEmpty())
                  {
                      OpportunityManagementServices.updateBasicCPPHforRegistration(oList);
                  }
              }     
            }
        } 
}