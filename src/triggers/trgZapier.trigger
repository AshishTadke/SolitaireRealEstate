trigger trgZapier on Zapier_Lead__c (after insert) {
    
    
    List<Lead> leadList = new List<Lead>();
    Lead l = new Lead();
    String msg;
    
    for(Zapier_Lead__c z : Trigger.New)
    {
        
        l.LastName = z.Name;
        l.Email= z.email__c;
        l.MobilePhone = z.Mobile_No__c;
        l.LeadSource  = z.Lead_Source__c;
        l.Lead_Sub_Source__c = z.Lead_Sub_Source__c;
        l.Campaign_Code__c = z.Campaign_Code__c;
        l.RDS_Project__c = z.Project__c;
        l.Zapier_Lead__c = True;
        l.ownerid = z.ownerid;
        leadList.add(l);
    }
    if (leadList != null) {
           List < DupResultsDTO > dupList = LeadManagementServices.leadPreprocessing(leadList, 'WEB');
                if (dupList.isEmpty()) {
                    try {
                        Database.saveResult[] srList = Database.insert(leadList, true);
                        for (Database.SaveResult sr: srList) {
                            if (sr.isSuccess()) {
                                // Operation was successful, so get the ID of the record that was processed
                                System.debug('Successfully inserted lead. lead ID: ' + sr.getId());
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
                                
                            }
                        }
                    } catch (System.DmlException ex) {
                        String msg = null;
                        for (Integer i = 0; i < ex.getNumDml(); i++) {
                            msg = 'Lead Insert Failed :' + ex.getMessage();
                        }
                       
                    }
                } else {
                   
                }
             
            }
}