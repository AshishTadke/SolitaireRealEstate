public with sharing class CampaignManagementServices {
    /* Method searches campaign details based on tollfree number, campaign code or campaign Id
  
  /* send a map bucketed by fieldName and the list of campaign codes 
   to search from the campaign object. For example:
   TollFreeNumber, [18002525,1800555]
   CampaignCode,[1234,2222,8888] 
   CampaignId, [CrecordId1, CRecordId2]*/

    public static Map < String, Campaign > searchCampaign(Map < String, List < String >> campaignDetails) {
        List < Campaign > searchRes1 = new List < Campaign > ();
        List < Campaign > searchRes2 = new List < Campaign > ();
        List < Campaign > searchRes3 = new List < Campaign > ();

        if (!campaignDetails.isEmpty() && campaignDetails.containsKey('CAMPAIGNCODE')) {
            for (Integer i = 0; i < campaignDetails.get('CAMPAIGNCODE').size(); i++) {
                if (campaignDetails.get('CAMPAIGNCODE').get(i) == null) {
                    campaignDetails.get('CAMPAIGNCODE').remove(i);
                }
            }
            searchRes2 = [select Name, Type, Description, Primary_Project__c, Primary_Project__r.Name, CreatedDate, isActive, StartDate, EndDate, TollFree_Number__c, Digital_Maketing_Campaign_Code__c from
                Campaign where Digital_Maketing_Campaign_Code__c in : campaignDetails.get('CAMPAIGNCODE') and isActive = true
            ];


        }

        // added logic to search by campaign id
        Map < String, Campaign > searchResponse = new Map < String, Campaign > ();


        for (campaign c: searchRes2) {
            if (!searchResponse.containsKey(c.Digital_Maketing_Campaign_Code__c)) searchResponse.put(c.Digital_Maketing_Campaign_Code__c, c);
        }

        return searchResponse;
    }

    public static void AddCampaignToLead(Map < Campaign, List < Lead >> campaignMap) {
        List < CampaignMember > cmList = new List < campaignMember > ();

        if (campaignMap != null && !campaignMap.isEmpty()) {
            for (Campaign c: campaignMap.keyset()) {
                for (lead eachLead: campaignMap.get(c)) {
                    CampaignMember cm = new CampaignMember(CampaignId = c.Id, LeadId = eachLead.Id, Status = 'Responded');
                    cmList.add(cm);
                }
            }
        }
        try {
            Database.saveResult[] srList = Database.insert(cmList, false);
            List < String > customMsgList = new List < String > ();

            for (Database.SaveResult sr: srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted members. member ID: ' + sr.getId());
                } else {
                    // Operation failed, so get all errors  
                    for (Database.Error err: sr.getErrors()) {
                        if (err.getMessage().equals('This entity is already a member of this campaign') || err.getMessage().contains('more than once')) {
                            System.debug('Ignore error: Lead already a member error');
                        } else {
                            customMsgList.add(err.getMessage());
                        }
                    }
                }
            }
            if (customMsgList != null && !customMsgList.isEmpty()) {
                System.debug('Campaign Member Insert Error:' + customMsgList);
                throw new GlobalException(customMsgList, '', 'CampaignManagmentServices.AddCampaignToLead()');
            }
        } catch (System.DmlException ex) {
            List < String > customMsgList = new List < String > ();
            for (Integer i = 0; i < ex.getNumDml(); i++) {
                String msg = 'Campaign Member Insert Failed :' + ex.getMessage();
                customMsgList.add(msg);
            }
            throw new GlobalException(customMsgList, '', 'CampaignManagmentServices.AddCampaignToLead()');
        }
    }

    public static void AddCampaignToAccount(Map < Campaign, List < Account >> campaignMap) {
        List < CampaignMember > cmList = new List < campaignMember > ();

        if (campaignMap != null && !campaignMap.isEmpty()) {
            for (Campaign c: campaignMap.keyset()) {
                for (account eachAcc: campaignMap.get(c)) {
                    CampaignMember cm = new CampaignMember(CampaignId = c.Id, contactId = eachAcc.PersonContactId, Status = 'Responded');
                    cmList.add(cm);
                }
            }
        }
        try {
            Database.saveResult[] srList = Database.insert(cmList, false);
            List < String > customMsgList = new List < String > ();

            for (Database.SaveResult sr: srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted members. member ID: ' + sr.getId());
                } else {
                    // Operation failed, so get all errors  
                    for (Database.Error err: sr.getErrors()) {
                        if (err.getMessage().equals('This entity is already a member of this campaign') || err.getMessage().contains('more than once') || err.getMessage().contains('Already a campaign member')) {
                            System.debug('Ignore error: Lead already a member error' + err.getMessage());
                        } else {
                            System.debug('Dont ignore : the error is added to customMsgList' + err.getMessage());
                            customMsgList.add(err.getMessage());
                        }
                    }
                }
            }
            if (customMsgList != null && !customMsgList.isEmpty()) {
                System.debug('Campaign Member Insert Error:' + customMsgList);
                throw new GlobalException(customMsgList, '', 'CampaignManagmentServices.AddCampaignToLead()' + customMsgList);
            }
        } catch (System.DmlException ex) {
            List < String > customMsgList = new List < String > ();
            for (Integer i = 0; i < ex.getNumDml(); i++) {
                String msg = 'Campaign Member Insert Failed :' + ex.getMessage();
                customMsgList.add(msg);
            }
            throw new GlobalException(customMsgList, '', 'CampaignManagmentServices.AddCampaignToLead()');
        }
    }

}