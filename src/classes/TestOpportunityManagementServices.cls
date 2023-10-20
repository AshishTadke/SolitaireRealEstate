@isTest
private  Class TestOpportunityManagementServices 
{
  @isTest  
  static void SLBMTest() 
  {
        Project__c p = TestDataFactory.createProject('ONE', '111');
        Project__c p1 = TestDataFactory.createProject('TWO', '222');
        
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@xanadutest.com', '9876544441', false);
        
        List<Opportunity>  oList = TestDataFactory.createOpptyForAccountCross(acc.Id, p.Id, 3);
                        
        Test.startTest();
          
          List<Account> ua = [Select Id,S_Type_of_accomadation__c,S_PReason_for_Purchase__c,S_Possession_Type__c, S_Pr_History__c, S_Cross_Project_Exposure__c,Budget_in_Lacs_Max__c, Budget_in_Lacs_Min__c from Account where Id = :acc.Id]; //
         /* System.assertEquals(5000000,ua[0].Budget_in_Lacs_Max__c);
          System.assertEquals(5000000,ua[0].Budget_in_Lacs_Min__c);
          System.assertEquals('ONE',ua[0].S_Pr_History__c);
          System.assertEquals(3, ua[0].S_Cross_Project_Exposure__c);
          System.assertEquals('Capital Gain',ua[0].S_PReason_for_Purchase__c);
          System.assertEquals('Ready to Live In (RTLI)',ua[0].S_Possession_Type__c);*/
          
          
          oList[1].Project__c = p1.Id;
          oList[1].S_Budget_In_lacs__c = 2000;
          oList[2].S_Budget_In_lacs__c = 50000000;
          oList[2].Possession_Requirement__c = 'Under Construction (UC – 1 to 2 years)';
          oList[2].Purpose__c = 'Gift';
          
          update oList;
          
         List<Account> ua1 = [Select Id,S_Type_of_accomadation__c,S_PReason_for_Purchase__c,S_Possession_Type__c,Budget_in_Lacs_Max__c, Budget_in_Lacs_Min__c, S_Pr_History__c,S_Cross_Project_Exposure__c from Account where Id = :acc.Id];  //
          
         /* System.assertEquals(50000000,ua1[0].Budget_in_Lacs_Max__c);
          System.assertEquals(2000,ua1[0].Budget_in_Lacs_Min__c);
          System.assertEquals('ONE,TWO',ua1[0].S_Pr_History__c);
          System.assertEquals(3, ua1[0].S_Cross_Project_Exposure__c);
          System.assertEquals('Capital Gain,Gift',ua1[0].S_PReason_for_Purchase__c);
          System.assertEquals('Ready to Live In (RTLI),Under Construction (UC – 1 to 2 years)',ua1[0].S_Possession_Type__c);
                    */
        Test.stopTest();
 
  }
}