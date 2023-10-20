@isTest
private class TestDeDupeChecker {
    
     @isTest static void TestLeadDuplicateSingleEmail() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplate('TestLeadA' , 'testleada@twgtest.com', '9876544000', false);
        
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestLeadADuplicate' , Email= 'testleada@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
            Test.stopTest();
            
        // Verify that the duplicates are identified by checking the dupresults list size 
            //System.assert(d.size()>0);
            Lead l = [SELECT lastName, Email, MobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
           // System.assertEquals(d[0].duplicateMaster, l.Id);
           // System.assertEquals('TestLeadA',l.lastName);
            //System.assertEquals(true,l.masterrecord__c);
    }
    
    @isTest static void TestLeadDuplicateSingleMobile() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplate('TestLeadA' , 'testleada@twgtest.com', '9876544444', false);
        
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestLeadADuplicate' , email = 'testleadanew@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
            Test.stopTest();
            
        // Verify that the duplicates are identified by checking the dupresults list size 
           // System.assert(d.size()>0);
            Lead l = [SELECT lastName, Email, MobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
           // System.assertEquals(d[0].duplicateMaster, l.Id);
           // System.assertEquals('TestLeadA',l.lastName);
           // System.assertEquals(true,l.masterrecord__c);
    }
    
    @isTest static void TestLeadDuplicateSingleAltMobile() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplateF('TestLeadA' , 'testleada@twgtest.com', '9876544444', '9876544433', false);
        // Perform test
        Test.startTest();
          List<Lead> leadList = new List<Lead>();
          Lead lead1 = new Lead(lastName='TestLeadADuplicate' , email = 'testleadanew@twgtest.com' , mobilePhone='9876544433');
      leadList.add(lead1);
      List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
      Test.stopTest();
      
    // Verify that the duplicates are identified by checking the dupresults list size 
      //System.assert(d.size()>0);
      Lead l = [SELECT lastName, Email, mobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
     // System.assertEquals(d[0].duplicateMaster, l.Id);
    //  System.assertEquals('TestLeadADuplicate',l.lastName);
     // System.assertEquals(true,l.masterrecord__c);
    }
    
    @isTest static void TestLeadDuplicateSingleAltEmail() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplateE('TestLeadA' , 'testleada@twgtest.com', 'alternate@twgtest.com', '9876544444', false);
        // Perform test
        Test.startTest();
          List<Lead> leadList = new List<Lead>();
          Lead lead1 = new Lead(lastName='TestLeadADuplicate' , email = 'alternate@twgtest.com' , mobilePhone='9876544444');
      leadList.add(lead1);
      List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
      Test.stopTest();
      
    // Verify that the duplicates are identified by checking the dupresults list size 
      //System.assert(d.size()>0);
      Lead l = [SELECT lastName, Email, MobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
     // System.assertEquals(d[0].duplicateMaster, l.Id);
    //  System.assertEquals('TestLeadADuplicate',l.lastName);
     // System.assertEquals(true,l.masterrecord__c);
    }
    
    @isTest static void TestLeadDuplicateMultipleA() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplate('TestLeadA' , 'testleada@twgtest.com', '9876544444', false);
        Lead leadB = TestDataFactory.createLeadTemplate('TestLeadB' , 'testleadb@twgtest.com', '9769684159', false);
        
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestLeadADuplicate' , email = 'testleada@twgtest.com' , mobilePhone='9769684159');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
            Test.stopTest();
            
        // Verify that the duplicates are identified by checking the dupresults list size 
           // System.assert(d.size()>0);
            Lead l = [SELECT lastName, Email, MobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
           /* System.assertEquals(d[0].duplicateMaster, l.Id);
            System.assertEquals('TestLeadA',l.lastName);
            System.assertEquals(true,l.masterrecord__c); */
    } 
    
    @isTest static void TestLeadDuplicateMultipleB() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplate('TestLeadA' , 'testleada@twgtest.com', '9876544444', true);
        Lead leadB = TestDataFactory.createLeadTemplate('TestLeadB' , 'testleadb@twgtest.com', '9769684159', false);
        
        
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestIamThird' , email = 'testleada@twgtest.com' , mobilePhone='9769684159');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
        //System.assert(d.size()>0);
        Lead l = [SELECT lastName, Email, MobilePhone, MasterRecord__c FROM lead WHERE Id = :leadA.Id];
        //System.assertEquals(l.Id,d[0].duplicateMaster);
       // System.assertEquals(true,l.MasterRecord__c);    
        //System.assertEquals('TestLeadA', l.lastName);
    }  
    
    @isTest static void TestPADuplicateA() {
        // Test data setup
        // Create one lead with a with specific params
        Campaign c1 = TestDataFactory.createCampaignCCNew('W54 Campaigns -NEWS', 'Newspapers','1111');
     //   Campaign c2 = TestDataFactory.createCampaignTF('W54 Campaigns -HOARDINGS', '1800900900', 'Hoardings');
      //  Channel__c channel = TestDataFactory.createChannel('Today@Dubai');
        Account acc = TestDataFactory.createPATemplateB('TestPA1' , 'testleada@twgtest.com', '9876544441', false, '1111');
                
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestIamaLead' , email = 'testleada@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
       // System.assert(d.size()>0);
        Account a = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c FROM Account WHERE Id = :acc.Id];
       // System.assertEquals(a.Id,d[0].duplicateMaster);
       // System.assertEquals(true,a.MasterRecord__c);
       // System.assertEquals('TestPA1', a.lastName);
   //     System.assertEquals('NRI' ,a.Residential_Status__c);
        
    //    Campaign c3 = TestDataFactory.createCampaignTF('TWG-WEBSITE', '1800700700', 'Other');
    //    Channel__c channel1 = TestDataFactory.createChannel('EconomicTimes_Local');
        
          a.Campaign_Code__c = '1111';
    //    a.Tollfree_Number__c = '1800700700';
    //    a.Channel_Code__c = channel1.channel_code__c;
        update a;
        Account newa = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c, PersonContactId FROM Account WHERE Id = :a.Id];
      //  System.assertEquals('Indian' ,newa.Residential_Status__c);
        
        //system.debug('PersonContactId in TestPADuplicateA**'+newa.PersonContactId);
        List<CampaignMember> cm1List = [Select Id from CampaignMember where ContactId =: newa.PersonContactId];
        System.assertEquals(1,cm1List.Size());
    } 
    
   /* @isTest static void TestPADuplicateAltEmail() {
        // Test data setup
        // Create one lead with a with specific params
        Campaign c1 = TestDataFactory.createCampaignCCNew('W54 Campaigns -NEWS', 'Newspapers','1111');
     //   Campaign c2 = TestDataFactory.createCampaignTF('W54 Campaigns -HOARDINGS', '1800900900', 'Hoardings');
     //   Channel__c channel = TestDataFactory.createChannel('Today@Dubai');
        Account acc = TestDataFactory.createPATemplateAlt('TestPA1' , 'testleada@twgtest.com', '9876544441', false, '1111');
                
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestIamaLead' , email = 'testleada@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
        //System.assert(d.size()>0);
        Account a = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(a.Id,d[0].duplicateMaster);
        System.assertEquals(true,a.MasterRecord__c);
        System.assertEquals('TestPA1', a.lastName);
     //   System.assertEquals('NRI' ,a.Residential_Status__c);
        
     //   Campaign c3 = TestDataFactory.createCampaignTF('TWG-WEBSITE', '1800700700', 'Other');
     //   Channel__c channel1 = TestDataFactory.createChannel('EconomicTimes_Local');
        
        a.Campaign_Code__c = '1111';
    //    a.Tollfree_Number__c = '1800700700';
    //    a.Channel_Code__c = channel1.channel_code__c;
        update a;
        Account newa = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c, PersonContactId FROM Account WHERE Id = :a.Id];
     //   System.assertEquals('Indian' ,newa.Residential_Status__c);
        
        List<CampaignMember> cm1List = [Select Id from CampaignMember where ContactId =: newa.PersonContactId];
        System.assertEquals(1,cm1List.Size());
    }
    */
    
    @isTest static void TestPADuplicateAltMobile() {
        // Test data setup
        // Create one lead with a with specific params
        Campaign c1 = TestDataFactory.createCampaignCCNew('W54 Campaigns -NEWS', 'Newspapers','1111');
     //   Campaign c2 = TestDataFactory.createCampaignTF('W54 Campaigns -HOARDINGS', '1800900900', 'Hoardings');
     //   Channel__c channel = TestDataFactory.createChannel('Today@Dubai');
        Account acc = TestDataFactory.createPATemplateAlt('TestPA1' , 'testleada@twgtest.com', '9876544441', false, '1111');
                
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestIamaLead' , email = 'testleadnew@twgtest.com' , mobilePhone='9876544441');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
       // System.assert(d.size()>0);
        Account a = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c FROM Account WHERE Id = :acc.Id];
       // System.assertEquals(a.Id,d[0].duplicateMaster);
       // System.assertEquals(true,a.MasterRecord__c);
       // System.assertEquals('TestPA1', a.lastName);
     //   System.assertEquals('NRI' ,a.Residential_Status__c);
        
     //   Campaign c3 = TestDataFactory.createCampaignTF('TWG-WEBSITE', '1800700700', 'Other');
     //   Channel__c channel1 = TestDataFactory.createChannel('EconomicTimes_Local');
        
        a.Campaign_Code__c = '1111';
     //   a.Tollfree_Number__c = '1800700700';
     //   a.Channel_Code__c = channel1.channel_code__c;
        update a;
        Account newa = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c, PersonContactId  FROM Account WHERE Id = :a.Id];
     //   System.assertEquals('Indian' ,newa.Residential_Status__c);
        
        List<CampaignMember> cm1List = [Select Id from CampaignMember where ContactId =: newa.PersonContactId];
       // System.assertEquals(1,cm1List.Size());
    }
    
    @isTest static void TestPADuplicateB() {
        // Test data setup
        // Create one lead with a with specific params
        Account accA = TestDataFactory.createPATemplate('TestPA1' , 'testpa1@twgtest.com', '9876544444', true);
        Account accB = TestDataFactory.createPATemplate('TestPA2' , 'testpa2@twgtest.com', '9876544443', false);
        
                
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestIamaLead' , email = 'testpa2@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'WEB');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
       // System.assert(d.size()>0);
        Account a = [SELECT lastName, personEmail, personMobilePhone, MasterRecord__c FROM Account WHERE Id = :accA.Id];
      //  System.assertEquals(a.Id,d[0].duplicateMaster);
       // System.assertEquals(true,a.MasterRecord__c);
       // System.assertEquals('TestPA1', a.lastName);
    } 
    // if there is an existing master record the incoming record should update that
   
 /*   @isTest static void TestLeadDuplicateBulkA() {
        // Test data setup
        // Create one lead with a with specific params
        
        List<Lead> l = TestDataFactory.createLead(9);
                
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestLead0Dup' , email = 'testlead0@twgtest.com' , mobilePhone='1234567890');
            leadList.add(lead1);
            Lead lead2 = new Lead(lastName='TestLead1Dup' , email = 'testlead1@twgtest.com' , mobilePhone='1234567891');
            leadList.add(lead2);
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'BULKLOAD');
        Test.stopTest();
        
        // Verify that the duplicates are identified by checking the dupresults list size 
        System.assert(d.size()>0);
        List<Lead> lltwg = [SELECT lastName, email, MobilePhone, MasterRecord__c FROM lead WHERE lastName like 'TWGLead%'];
        List<Lead> lltest = [SELECT lastName, email, MobilePhone, MasterRecord__c FROM lead WHERE lastName like 'Test%'];
        
        System.assertEquals(9,lltwg.size());
        System.assertEquals(0,lltest.size());
        
    }  */
    
       
 /*   @isTest static void TestLeadDuplicateBulkB() {
        // Test data setup
        // Create one lead with a with specific params
       // User u = TestDataFactory.createUserSysAdmin('ankur', 'priyadarshan', 'dev.user@twg.com',  'dev.user@twg.com');
        User u = [Select Id, Name from User where username like 'dev.user@twg.com%'];
        Test.startTest();
        System.runAs(u) {
            // The following code runs as user 'u' 
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
            try {
                List<Lead> l1 = TestDataFactory.createLead(9);
                List<Lead> l2 = TestDataFactory.createLead(9);
            }  catch(Exception DmlException) {
                // Do nothing
            }
        }
       Test.stopTest();        
        // Verify that the duplicates are identified by checking the dupresults list size 
        List<Lead> lltwg = [SELECT lastName, email, MobilePhone, MasterRecord__c FROM lead WHERE lastName like 'TWGLead%'];     
       // System.assertEquals(9,lltwg.size());
    }   */
    
    @isTest static void TestLeadDuplicateException() {
        // Test data setup
        // Create one lead with a with specific params
        Lead leadA = TestDataFactory.createLeadTemplate('TestLeadA' , 'testleada@twgtest.com', '9876544000', false);
        
        // Perform test
        Test.startTest();
            List<Lead> leadList = new List<Lead>();
            Lead lead1 = new Lead(lastName='TestLeadADuplicate' , email = 'testleada@twgtest.com' , mobilePhone='9876544444');
            leadList.add(lead1);
            try {
            List<DupResultsDTO> d = LeadManagementServices.leadPreProcessing(leadList, 'UNKNOWN');
            } catch (Exception GlobalException) {
                // Do nothing
            }
        Test.stopTest();

    }          
}