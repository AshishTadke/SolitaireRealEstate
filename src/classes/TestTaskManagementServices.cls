@isTest
private  Class TestTaskManagementServices {
  @isTest  
  static void TaskTest() {
    Project__c p = TestDataFactory.createProject('Xanadu_prj','111');
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@ozonetest.com', '9876544441', false);
        
        List<Lead> llist = TestDataFactory.createLead(3);
        List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p.Id, 3);
        
        system.debug(oList[0].Name);                
       
          List<Task> tList1 = TestDataFactory.createTasksForOpp(oList[0].Id, 2, 'Presales Call');
          List<Task> tList2 = TestDataFactory.createTasksForOpp(oList[1].Id, 2, 'Site Visit');
          Test.startTest(); 
          List<Task> tList11 = TestDataFactory.createTasksForLead(lList[0].Id, 2, 'Presales Call');
          List<Task> tList22 = TestDataFactory.createTasksForLead(lList[1].Id, 2, 'Enquiry Received');
        
          List<Opportunity> updatedOList = [Select Id, Presales_Call_counter__c from Opportunity where Id = :oList[0].Id];
          
          List<Opportunity> updatedOList1 = [Select Id, visit_counter__c from Opportunity where Id = :oList[1].Id];
          
          System.assertEquals(2, updatedOList[0].Presales_Call_counter__c);
          System.assertEquals(2, updatedOList1[0].visit_counter__c);
          
        Test.stopTest();
 
  }
}