global class WebToLeadServices {

    global static final String PARAM_MISSING = 'MISSING REQUIRED PARAMETERS';
    global static final String PROJECT_INVALID = 'INVALID PROJECT SELECTED';
    global static final String SOURCE_INVALID = 'INVALID SOURCE';


    global class result {
        webservice Integer returnCode;
        webservice String message;
        webservice Id recordId;
    }

    global class WebLead {
        webservice String fullName;
        webservice String emailAddress;
        webservice String country;
        webservice String city;       // added as per client's requirement
        webservice String dialingCode;
        webservice String mobileNumber;
        webservice String projectInterested;
        webservice String budget;
        webservice String CampaignCode;
        webservice String source; //click2call, microsite, corpsite, liveserv etc.
        webservice String webbannerSource;
        webservice String UTMCampaign;
        webservice String UTMDisplay;
        webservice String UTMMedium;
        webservice String UTMSource;
        webservice String UTMTerm;
        webservice String IPAddress;
    }

    webservice static result createLeadFromWeb(WebLead wl) {
        List < Lead > leadList = new List < Lead > ();
        Lead l = null;
        result r = new result();
        String projectId = null;
        System.debug('WEB LEAD:' + wl);
        if (String.isNotBlank(wl.source) && wl.source.equals('DIGITAL MARKETING')) {
           if (String.isBlank(wl.fullName) || String.isBlank(wl.mobileNumber) || String.isBlank(wl.emailAddress) || String.isBlank(wl.dialingCode) || String.isBlank(wl.source) || String.isBlank(wl.city)) {
                System.debug('Missing Required Parameters');
                r.returnCode = 1;
                r.message = PARAM_MISSING;
                r.recordId = null;
                return r;
            } else {
                List < Project__c > pList = [Select Id, Name from project__c where Name = : wl.projectInterested];
                if (pList.size() == 1) {
                    projectId = pList[0].Id;
                } else {
                    System.debug('Project Error:' + pList);
                    r.returnCode = 1;
                    r.message = PROJECT_INVALID;
                    r.recordId = null;
                    return r;
                }
                l = new Lead(
                lastName = wl.fullName,
                RDS_Mobile__c = wl.mobileNumber,
                RDS_Email__c = wl.emailAddress,
                MobilePhone = wl.mobileNumber,
                Email = wl.emailAddress,
                leadsource = 'Presales',
                Lead_Sub_Source__c = 'Web',
                RDS_Country__c = wl.country,
                City_R__c = wl.city,
                RDS_Country_Code__c = wl.dialingCode,
                RDS_Budget__c = wl.budget,
                RDS_Project__c = projectId,
                Source_Remarks__c = wl.source,
                Campaign_Code__c = wl.CampaignCode,
               web_banner_source__c = wl.webBannerSource,
                IP_address_web2lead__c = wl.IPAddress,
          
        /////////////////////////--------------- vikas added below field on dated 23-08-16 -----------------------------/////////////////////
                UTM_Campaign__c = wl.UTMCampaign,
                UTM_Display__c = wl.UTMDisplay,
                UTM_Medium__c = wl.UTMMedium,
                UTM_Source__c = wl.UTMSource,
                UTM_Term__c = wl.UTMTerm);
        /////////////////--------------------- vikas added end here -------------------------------///////////////////////////////
            }
        } else {
            System.debug('Invalid Source:' + wl.source);
            r.returnCode = 1;
            r.message = SOURCE_INVALID;
            r.recordId = null;
            return r;
        }
        if (l != null) {
            leadList.add(l);
            try {
                List < DupResultsDTO > dupList = LeadManagementServices.leadPreprocessing(leadList, 'WEB');
                if (dupList.isEmpty()) {
                    try {
                        Database.saveResult[] srList = Database.insert(leadList, true);
                        for (Database.SaveResult sr: srList) {
                            if (sr.isSuccess()) {
                                // Operation was successful, so get the ID of the record that was processed
                                System.debug('Successfully inserted lead. lead ID: ' + sr.getId());
                                r.recordId = sr.getId();
                                r.returnCode = 0;
                                r.message = 'SUCCESS';
                                try {
                                    // once the lead is created, save the entire enquiry information as a task of type enquiry received.
                                    // this is so that the complete form info is saved somewhere
                                    Map < Id, Lead > enquiryMap = new Map < Id, Lead > ();
                                    enquiryMap.put(sr.getId(), l);
                                    Map < Id, Task > whoIdMap = new Map < Id, Task > ();
                                    whoIdMap = TaskManagementServices.createTaskforEnquiries(enquiryMap);
                                } catch (Exception ex) {
                                    System.debug('Catch and Ignore enquiry task create exception:' + ex.getMessage());
                                }
                            } else {
                                // Operation failed, so get all errors  
                                String msg = null;
                                for (Database.Error err: sr.getErrors()) {
                                    msg = 'Lead Insert Failed :' + err.getMessage();
                                }
                                r.returnCode = 1;
                                r.message = msg;
                                r.recordId = null;
                                return r;
                            }
                        }
                    } catch (System.DmlException ex) {
                        String msg = null;
                        for (Integer i = 0; i < ex.getNumDml(); i++) {
                            msg = 'Lead Insert Failed :' + ex.getMessage();
                        }
                        r.returnCode = 1;
                        r.message = msg;
                        r.recordId = null;
                        return r;
                    }
                } else {
                    r.recordId = dupList[0].duplicateMaster;
                    r.returnCode = 0;
                    r.message = 'SUCCESS';
                }
            } catch (GlobalException g) {
                r.returnCode = 1;
                r.message = g.getErrorMsg()[0];
                r.recordId = null;
                return r;
            }
            return r;
        } else {
            System.debug('Lead list empty:');
            r.returnCode = 1;
            r.message =  'UNKNOWN EXCEPTION';
            r.recordId = null;
            return r;
        }
    }
}