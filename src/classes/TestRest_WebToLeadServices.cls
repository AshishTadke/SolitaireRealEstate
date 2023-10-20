@isTest
private Class TestRest_WebToLeadServices {
  @isTest
  static void createWebLead(){
    TestDataFactory.createProject('Project Xanadu', '111');
    TestDataFactory.createCampaignCCNew( 'Test_campaign_1', 'TV', '2001');
        
    REST_WebToLeadServices.REST_Request wlGood = new REST_WebToLeadServices.REST_Request();
    wlGood.fullName = 'Digital Lead';
    wlGood.emailAddress = 'click2call@email.com';
    wlGood.country = 'India';
    wlGood.city = 'Mumbai';
    wlGood.dialingCode = '91';
    wlGood.mobileNumber = '9080706050';
    wlGood.source = 'DIGITAL MARKETING';
    wlGood.projectInterested = 'Project Xanadu';
    wlGood.budget = '7 to 9 Cr';
    wlGood.CampaignCode = '2001'; 
    //wlGood.source = 'Test Source';
    wlGood.webBannerSource = 'Test web banner';
    wlGood.IPAddress = '192.168.02.201';
   
    REST_WebToLeadServices.REST_Request wlBad = new REST_WebToLeadServices.REST_Request();
    wlBad.fullName = 'Click2Call Lead';
    wlBad.emailAddress = 'click2call@email.com';
    wlBad.country = 'India';
    wlBad.city = 'Mumbai';
    wlBad.dialingCode = '91';
    wlBad.mobileNumber = '9080706050';
    wlBad.source = 'DIGITAL MARKETING';
    wlBad.projectInterested = 'Xanadu';
    wlBad.budget = '7 to 9 Cr';
    wlBad.CampaignCode = '2001';
    
    REST_WebToLeadServices.REST_Request  wlUgly = new REST_WebToLeadServices.REST_Request();
    
    REST_WebToLeadServices.REST_Request  wlWorst = new REST_WebToLeadServices.REST_Request ();
    wlWorst.fullName = 'Digital Lead';
    wlWorst.emailAddress = 'click2call@email.com.com.com.com';
    wlWorst.country = 'India';
    wlWorst.city = 'Mumbai';
    wlWorst.dialingCode = '91';
    wlWorst.mobileNumber = '90807060501234556';
    wlWorst.source = 'DIGITAL MARKETING';
    wlWorst.projectInterested = 'Project Xanadu';
    wlWorst.budget = '7 to 9 Cr';
    wlWorst.CampaignCode = '2001';
 
        
    Test.startTest();
    REST_WebToLeadServices.REST_result rGood = REST_WebToLeadServices.createLeadFromWeb(wlGood);
    REST_WebToLeadServices.REST_result rBad = REST_WebToLeadServices.createLeadFromWeb(wlBad);
    REST_WebToLeadServices.REST_result rUgly = REST_WebToLeadServices.createLeadFromWeb(wlUgly);
    REST_WebToLeadServices.REST_result rWorst = REST_WebToLeadServices.createLeadFromWeb(wlWorst);
  
    
    
    System.assertEquals('INVALID SOURCE', rUgly.message);
    
    System.assertEquals('INVALID PROJECT SELECTED', rBad.message);
       
    List<lead> ll = [Select Id, lastName from Lead where Id = : rGood.recordId];
    System.assertEquals('SUCCESS', rGood.message);
    System.assertEquals(1,ll.size());
    System.assertEquals(rGood.recordId,ll[0].Id);
   
    
    // creating an throwing exception to cover for the global exception class
    // just fitting it inside this TM , its too small have a TM class / method of its own
    Task t = new Task(activityDate = system.today(), subject ='new task', priority='normal', status ='open');
    insert t;
    List < String > customMsgList = new List < String > ();
    String msg = 'Task not created';
    System.debug('Missed Call Task not Created:');
    customMsgList.add(msg);
    try {
      throw new GlobalException(customMsgList, 'ERR001', 'TestMethod');
    } catch(GlobalException g){
      List<String> msg1 = g.getErrorMsg();
      String errCode = g.getErrorCode();
      String className = g.getClassDetails();
    }
    
    Map<String,Set<Id>> dupMap = new Map<String,Set<Id>>();
    DupResultsDTO drDTO = new DupResultsDTO(ll[0], ll[0].Id, t.Id, dupMap);
    
    Test.stopTest();    
    
  }
  

}