trigger AccountTrigger on Account(before Insert, after Insert, before update, after update) {
  
     if (Trigger.IsInsert) {   
        if (Trigger.isAfter) {
          List<Account> updateCMList = new List<Account>();
          for(Account a : trigger.new) {
              if(a.isPersonAccount && (a.Campaign_Code__c != null )) {  
              updateCMList.add(a);
            }
          }
          if (updateCMList != null && updateCMList.size() > 0) {
        try {
          PersonAccountManagementServices.AddCampaignToAccount(updateCMList);
        } catch (GlobalException ex) {
          System.debug('Global Exception:' + ex.getErrorMsg() + ex.getClassDetails());
        }
      }
        }
   
        }
    
    
    
      If(Trigger.isUpdate) {
        List < DupResultsDTO > dupResList = new List < DupResultsDTO > ();
        Map<lead,Account> leadaccMap = new Map<lead,Account>();
        if (Trigger.isBefore) {
            If(!(System.isBatch())) {
                 List<Lead> leadList=new List<Lead>();
                 for(Account acc:Trigger.New){
                 Lead leadObj=new Lead();
                 
                 leadObj.lastName = acc.lastName;
                 leadObj.MobilePhone=acc.PersonMobilePhone;
                 leadObj.Phone=acc.Phone;
                 leadObj.Email = acc.PersonEmail;
                 leadObj.RDS_Alternate_Email_Id__c= acc.Alternate_Email__c;
                 leadObj.Account_ID__c=acc.Id;
                 leadList.add(leadObj);
                 leadaccMap.put(leadObj, acc);
             }
            
                dupResList = LeadManagementServices.leadPreProcessing(leadList, 'BULKLOAD');
                if (!dupResList.isEmpty()) {
                    
                  for (Lead l: leadList) {
                        System.debug('Trigger.new: ' + l);
                        for (DupResultsDTO d: dupResList) {
                            if (d.originalLead == l) {
                                System.debug('Trigger.new: dup match' + l + d.originalLead);
                               String errMsg = 'Duplicates exists for:' + l.lastName + '\n'+'you cannot create duplicates';
                                //String errMsg = 'Duplicates exists for:' +l.FirstName+' '+l.MiddleName+' '+l.lastName + '\n';
                                
                                for (String dupType: d.duplicatesMapNew.keySet()) {
                                    errMsg = errMsg + '\n' + dupType + '\t' + 'duplicates are:' + d.duplicatesMapNew.get(dupType);   
                                   
                                }
                                leadAccMap.get(l).addError(errMsg,false);
                               
                            }
                        }
                }

              }
            }
          
        }
    
        if(Trigger.isAfter) {
          List < Account > updateCMList = new List < Account > ();
      for (account a: trigger.new) {
          if (Trigger.newMap.get(a.Id).Campaign_Code__C != Trigger.oldMap.get(a.Id).Campaign_Code__C )  
            updateCMList.add(a);
      }
      if (updateCMList != null && updateCMList.size() > 0) {
        try {
          PersonAccountManagementServices.AddCampaignToAccount(updateCMList);
        } catch (GlobalException ex) {
          System.debug('Global Exception:' + ex.getErrorMsg() + ex.getClassDetails());
        }
      }
        }

    
   }
 }