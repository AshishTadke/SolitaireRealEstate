@isTest
private  Class TestCallRatingForLead {
  @isTest  
  static void TaskTest() {
    Project__c p = TestDataFactory.createProject('Xanadu_prj','111');
    Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@ozonetest.com', '9876544441', false);
        
        List<Lead> llist = TestDataFactory.createLead(3);
     
          
          
          List<Task> tList41 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit done','Open');
          List<Task> tList42 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Open','Visit proposed');
          List<Task> tList43 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit confirmed','Booking Done');
          List<Task> tList44 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Meeting Proposed','Visit confirmed');
          List<Task> tList45 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Open','Follow Up');
          List<Task> tList46 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Open','Tele Meeting Done');
          List<Task> tList47 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit done','Visit proposed');
           Test.startTest(); 
          
          list <task> updatedtasklist = [Select id, Task_Type__c from task where whoid = :llist[0].id];
          
        Test.stopTest();
 
  }
  
  static void TaskTest222() {
    Project__c p = TestDataFactory.createProject('Xanadu_prj','111');
    Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@ozonetest.com', '9876544441', false);
        
        List<Lead> llist = TestDataFactory.createLead(3);
        List<Task> tList48 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Tele Meeting Fixed','Visit confirmed');
        List<Task> tList49 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit done','Lost');
        List<Task> tList50 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit done','Follow Up');
        List<Task> tList56 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit proposed','Follow Up');
        List<Task> tList58 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit proposed','Visit confirmed');
        List<Task> tList60 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Tele Meeting Done','Lost');
        
        list <task> updatedtasklist = [Select id, Task_Type__c from task where whoid = :llist[0].id];
          
        Test.stopTest();
  }  
  
  static void TaskTest333() {
    Project__c p = TestDataFactory.createProject('Xanadu_prj','111');
    Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@ozonetest.com', '9876544441', false);
        
        List<Lead> llist = TestDataFactory.createLead(3);
        List<Task> tList62 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Follow Up','Open');
        List<Task> tList63 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Follow Up','Visit proposed');
        List<Task> tList64 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Lost','Open');
        List<Task> tList65 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Booking Done','Visit done');
        List<Task> tList66 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'TMD + MD','Visit proposed');
        List<Task> tList67 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Lost','Follow Up');
        List<Task> tList68 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Open','Lost');
        
        list <task> updatedtasklist = [Select id, Task_Type__c from task where whoid = :llist[0].id];
          
        Test.stopTest();
  }          
}