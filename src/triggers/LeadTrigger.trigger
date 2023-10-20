trigger LeadTrigger on Lead(before Insert, after Insert, before update, after update) {
    //<added by Shahbaj Khan on 9/12/2017-->//
    if (Trigger.IsInsert) {
        List < DupResultsDTO > dupResList = new List < DupResultsDTO > ();

        if (Trigger.IsBefore) {
            //check the user, if its batch user, only then call the preprocessing logic
            
            If(!(System.isBatch())) {
                dupResList = LeadManagementServices.leadPreProcessing(Trigger.new, 'BULKLOAD');
                if (!dupResList.isEmpty()) {
                    for (Lead l: Trigger.new) {
                        
                        System.debug('Trigger.new: ' + l);
                        for (DupResultsDTO d: dupResList) {
                            if (d.originalLead == l) {
                                System.debug('Trigger.new: dup match' + l + d.originalLead);

                                String errMsg = 'Duplicates exists for:' + l.lastName + '\n'+'you cannot create duplicates';
                                for (String dupType: d.duplicatesMapNew.keySet()) {
                                   errMsg = errMsg + '\n' + dupType + '\t' + 'duplicates are:' + d.duplicatesMapNew.get(dupType);
                                   //errMsg = errMsg + '\n' + dupType + '\t' + 'duplicates are:' + d.duplicatesMap.get(dupType);
                                  //errMsg = errMsg + '\n' + dupType +'\t'+ 'duplicates are:' + leadObj.lastName;
                                }
                                //errMsg += d.errmsg;
                                l.addError(errMsg, false);
                            }
                        }
                    }
                }

            }
            
        }
    }


    if (Trigger.IsInsert) {
        if (Trigger.isBefore) {
           
        }
        // this is after insert, calling the lead assignment rules here. It has to be after insert for it to work from a trigger
        // it is a future method call as the task getting created as part of web to lead will fail otherwise since it gets assigned to a
        // queue instead of a user    
        if (Trigger.isAfter) {
           
            try {
                LeadManagementServices.AddCampaignToLead(Trigger.new);
            } catch (GlobalException ex) {
                System.debug('Global Exception:' + ex.getErrorMsg() + ex.getClassDetails());
            }
        }
    }

    If(Trigger.isUpdate) {
        List < DupResultsDTO > dupResList = new List < DupResultsDTO > ();
        //<added by Shahbaj Khan on 9/12/2017-->//
        //System.debug('Inside Update Lead Trigger:' + checkRecursion.isFirstRun());
        
        //System.debug('Inside recursion check in update Lead Trigger:' + checkRecursion.isFirstRun());
        if (Trigger.isBefore) {
            if(checkRecursion.isFirstRun()) {
           If(!(System.isBatch())) {
           try{
            system.debug('before dupresult::: '+dupResList);
                dupResList = LeadManagementServices.leadPreProcessing(Trigger.new, 'BULKLOAD');
                system.debug('dupresult::: '+dupResList);
                if (!dupResList.isEmpty()) {
                    for (Lead l: Trigger.new) {
                        System.debug('Trigger.new: ' + l);
                        for (DupResultsDTO d: dupResList) {
                            if (d.originalLead == l) {
                                System.debug('Trigger.new: dup match' + l + d.originalLead);

                                String errMsg = 'Duplicates exists for:' + l.lastName + '\n'+'you cannot create duplicates';
                                for (String dupType: d.duplicatesMapNew.keySet()) {
                                    errMsg = errMsg + '\n' + dupType + '\t' + 'duplicates are:' + d.duplicatesMapNew.get(dupType);
                                   // errMsg = errMsg + '\n' + dupType + '\t' + 'duplicates are:' + d.duplicatesMapNew.get(dupType);
                                   // errMsg = errMsg + '\n' + dupType +'\t'+ 'duplicates are:' + d.duplicatesMap.get(l.Id);
                                }
                                l.addError(errMsg, false);
                            }
                        }
                    }
                }
               }catch (GlobalException ex) {
                    System.debug('Global Exception:' + ex.getErrorMsg() + ex.getClassDetails());
                }
            }
            

        }
        }
        //<Added by Shahbaj Khan ends here>//        
        else if (Trigger.isAfter) {
                
            
                System.debug('Firing after Update Lead Trigger:' + checkRecursion.isFirstRun());
                List < Lead > updateCMList = new List < Lead > ();
                for (lead l: trigger.new) {
                    if (Trigger.newMap.get(l.Id).Campaign_Code__C != Trigger.oldMap.get(l.Id).Campaign_Code__C) {
                        updateCMList.add(l);
                        
                    }
                }System.debug('UpdateCMList:' + updateCMList);
                if (updateCMList != null && updateCMList.size() > 0) {
                    try {
                        LeadManagementServices.AddCampaignToLead(updateCMList);
                    } catch (GlobalException ex) {
                        System.debug('Global Exception:' + ex.getErrorMsg() + ex.getClassDetails());
                    }
                }
                
            }
       }
    
}