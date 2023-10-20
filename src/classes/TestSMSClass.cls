@isTest
private  Class TestSMSClass{
  @isTest  
    private static void CallSMS() {
        
        //create Account
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@xanadutest.com', '9876544441', false);
        //create Project 
        Project__c p = TestDataFactory.createProject('Testsms','222');
        //create Opportunity
        List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p.id, 1);
        SMS_Schedule_SMS_c__c ss  = TestDataFactory.createSMSRecord(oList[0].Id);
    
    }   
}