@isTest
private class TestSendBrochureAttachmentClass 
{
    @isTest
    private static void TestProjectAttachment()
    {
        Project__c p = TestDataFactory.createProject('Test Project','01234');
        Lead l = TestDataFactory.createLeadTemplate('pmLead', 'pm@lead.com', '1002233344', false);
        User u = [Select Id, Name from User where Id =: UserInfo.getUserId()];
        System.runAs(u) {
          Test.startTest();
          TestDataFactory.createEmailTemplate('Sample Template','Brochure Link', 'Find the attached brochure link','E100');
              try {
                  PageReference pref = Page.SendBrochureAttachment;
                  Test.setCurrentPage(pRef);
                  pref.getParameters().put('id', l.id);
                  SendBrochureAttachmentClass pm = new SendBrochureAttachmentClass();
                  pm.selectedProject = p.Id;
                  pm.getPAT();
              }catch(GlobalException g){
                  System.assertEquals(g.getErrorMsg()[0],'Problem Fetching Attachment');
                  System.assertEquals(g.getClassDetails(),'ProjectManagementServices.getPAT()');
                  System.assertEquals(g.getErrorCode(),'');
              }
          
              TestDataFactory.createProjAttachment(p.Id);
              SendBrochureAttachmentClass pm = new SendBrochureAttachmentClass();
              PageReference pref = Page.SendBrochureAttachment;
              Test.setCurrentPage(pRef);
              pref.getParameters().put('id', l.id);
              pm.selectedProject = p.Id;
              List< SelectOption > sl = pm.getProjects;
              pm.getPAT();
              pm.callSendBrochure();
             // System.assertNotEquals(null, pm.projAttachment.AttachmentId);
             // System.assertEquals(pm.projAttachment.projectName, 'Strings Attached');
          Test.stopTest();
        }
    }
     
/*    @isTest
    private static void TestSendBrochure(){
      
       Project__c p = TestDataFactory.createProject('Strings Attached');
       List<Tower__c> tList = TestDataFactory.createTowers(10,p.Id);
       Account accA = TestDataFactory.createPATemplate('TestPA1' , 'testpa1@twgtest.com', '9876544444', true);
       
       User u = [Select Id, Name from User where username = 'dev.user@twg.com'];
        System.runAs(u) {
          Test.startTest();
            TestDataFactory.createEmailTemplate('tTemplate','Brochure Link', 'Find the attached brochure link','E200');
            PageReference pref = Page.sendBrochure;
            Test.setCurrentPage(pRef);
            pref.getParameters().put('id', accA.id);
            ProjectManagementServices pm = new ProjectManagementServices();
            List< SelectOption > sl = pm.getProjectsforTower;
            pm.selectedPojectForTower = p.Id;
            List<SelectOption> tl = pm.getTowers;
            pm.selectedTower = tList[0].Id;
            pm.SendTBrochure();
          Test.stopTest();
        }
    }
*/    

}