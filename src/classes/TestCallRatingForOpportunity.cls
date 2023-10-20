@isTest
private  Class TestCallRatingForOpportunity {
  @isTest  
  static void TaskTest() {
    Project__c p = TestDataFactory.createProject('Xanadu_prj','111');
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@ozonetest.com', '9876544441', false);
        
        List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p.Id, 3);
     
          
          
          List<Task> tList41 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit done','Open');
          List<Task> tList42 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Open','Visit proposed');
          List<Task> tList43 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit confirmed','Open');
          List<Task> tList44 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Tele Meeting Done','Visit confirmed');
          List<Task> tList45 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Open','Follow Up');
          Test.startTest(); 
          List<Task> tList46 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'No Show','Open');
          List<Task> tList47 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit done','Visit proposed');
          List<Task> tList48 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Meeting Proposed','Visit confirmed');
          List<Task> tList49 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit done','Lost');
          //List<Task> tList50 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit done','Follow Up');
          //List<Task> tList51 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit confirmed','Follow Up');
          //List<Task> tList52 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit confirmed','Lost');
          //List<Task> tList53 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit confirmed','Visit confirmed');
          //List<Task> tList54 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit confirmed','Visit proposed');
        
          //List<Task> tList55 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit proposed','Open');
     //     List<Task> tList56 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit proposed','Follow Up');
          //List<Task> tList57 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit proposed','Visit proposed');
     //     List<Task> tList58 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Visit proposed','Visit confirmed');
          //List<Task> tList59 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Visit proposed','Visit done');
          //List<Task> tList60 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Follow Up','Lost');
          //List<Task> tList61 = TestDataFactory.createTasksForLeadWithStatus(llist[0].Id, 1, 'Presales Call',  'Follow Up','Visit done');
    //      List<Task> tList62 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Follow Up','Open');
    //      List<Task> tList63 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'TMD + MD','Visit proposed');
    //      List<Task> tList64 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Lost','Open');
    //      List<Task> tList65 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Lost','Visit done');
    //      List<Task> tList66 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'TMD + MD','Visit proposed');
   //       List<Task> tList67 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Lost','Follow Up');
    //      List<Task> tList68 = TestDataFactory.createTasksForOppWithStatus(oList [0].Id, 1, 'Presales Call',  'Open','Lost');
  
          
          
        
       //   List<Opportunity> updatedOList = [Select Id, Presales_Call_counter__c from Opportunity where Id = :oList[0].Id];
          
    //      List<Opportunity> updatedOList1 = [Select Id, visit_counter__c from Opportunity where Id = :oList[1].Id];
    
            list <task> updatedtasklist = [Select id, Task_Type__c from task where whatid = :oList [0].id];
          
          System.assertEquals(9, updatedtasklist.size());
       //   System.assertEquals(2, updatedOList1[0].visit_counter__c);
          
        Test.stopTest();
 
  }
}