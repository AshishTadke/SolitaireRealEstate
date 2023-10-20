@isTest
 public class NewSiteVisitControllerTest
 {
     @isTest
         private static void WalkInSearchPageTest() { 
             project__c p = createProject();
             Account a = createPAAccount();
             Opportunity o = createOpp(a.Id,p.Id);
             
             test.startTest();
                 pageReference pageRef = page.Site_Visit_Search_Page;
                 Test.setCurrentPage(pageRef);
                 SVsearch walkInSearch = new SVsearch ();
                 walkInSearch.strProjectId = p.Id;
                 walkInSearch.NewLead.MobilePhone= '1212121213';
                 walkInSearch.NewLead.lastName = 'testlead';
                 walkInSearch.NewLead.Email = 'testlead@test.in';
                 walkInSearch.NewLead.RDS_Alternate_Email_Id__c = 'testlead1@test.in'; 
                 walkInSearch.OpportunityId = o.Id;
                 walkInSearch.saveMethod();
                 walkInSearch.searchAllLead();
                 
                 SVsearch walkInSearch1 = new SVsearch ();
                 
                 walkInSearch1.strProjectId = p.Id; 
                 walkInSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch1.saveMethod();
                 walkInSearch1.searchAllLead();
               
                 SVsearch walkInSearch11= new SVsearch ();
                
                
             Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708789';
             leadObj.Email='test@stetig.in';
             leadObj.RDS_Alternate_Email_Id__c='test1@stetig.in';
             leadObj.RDS_Project__c =p.Id;
             leadObj.Budget_In_lacs__c=100; 
             insert leadObj;
             
                 walkInSearch11.strProjectId = p.Id;
                 
                 walkInSearch11.NewLead = leadObj;
                 walkInSearch11.saveMethod();
                 walkInSearch11.searchAllLead();
                 walkInSearch11.goBack();
                 
             test.stopTest();
         }
         @isTest
         private static void walkInMainformserachpageTest() {
             project__c p = createProject();
             //Lead l = createleadTemplate1();
             Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708788';
             leadObj.Email ='test@test.stetig';
             leadObj.RDS_Project__c =p.Id;
             leadObj.Budget_In_lacs__c=100; 
             leadObj.Zones__c ='test';
             leadObj.Possession_Requirement__c = 'test';
             insert leadObj;
             
             
             
             
              NewSiteVisitController walkInForm10 = new NewSiteVisitController();
                 walkInForm10.strLeadId=leadObj.Id;
                   
             Account a = createPAAccount();
             
             Opportunity o = createOpp(a.Id,p.Id);
             walkInForm10.strOptyId=o.Id;
             walkInForm10.strAccountId=a.Id;
             test.startTest();
                 pageReference pageRef = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef);
                 ApexPages.currentPage().getParameters().put('Leadid',leadObj.id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                
                 NewSiteVisitController walkInForm = new NewSiteVisitController();
                 pageReference pageRef1 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef1);
                 
                 ApexPages.currentPage().getParameters().put('optyid',o.Id);
                 
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 NewSiteVisitController walkInForm1 = new NewSiteVisitController();
                 
                 pageReference pageRef11 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef11);
                 ApexPages.currentPage().getParameters().put('Accid',a.Id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 NewSiteVisitController walkInForm11 = new NewSiteVisitController();
                 
                
                pageReference pageRef22 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef22);
                 
                 ApexPages.currentPage().getParameters().put('mobile','1111122222');
                 NewSiteVisitController walkInForm22 = new NewSiteVisitController();
              
                 pageReference pageRef33 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef33);
                 
                  ApexPages.currentPage().getParameters().put('mobile','2222233333');                 
                  NewSiteVisitController walkInForm33 = new NewSiteVisitController();
                  walkInForm33.sv.Customer_Name1__c='Mr. Aditya Marne';
                  walkInForm33.sv.Mobile_No2__c = '1234567890';
                  walkInForm33.sv.Email2__c = 'test@testing.in';
                  walkInForm33.sv.Source1__c = 'Others';
                  walkInForm33.sv.City__c = 'Pune';
                  walkInForm33.sv.Occupation__c='CA';
                  walkInForm33.sv.Sub_Source2__c ='Exhibition';
                  walkInForm33.save();
                  
                 pageReference pageRef44 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef44);
                 
                  ApexPages.currentPage().getParameters().put('Leadid',LeadObj.Id);                 
                  NewSiteVisitController walkInForm44 = new NewSiteVisitController();
                  walkInForm44.sv.Customer_Name1__c='Mr. Aditya Marne';
                  walkInForm44.sv.Mobile_No2__c = '1234567890';
                  walkInForm44.sv.Email2__c = 'test@testing.in';
                  walkInForm44.sv.Source1__c = 'Others';
                  walkInForm44.sv.City__c = 'Pune';
                  walkInForm44.sv.Occupation__c='CA';
                  walkInForm44.sv.Sub_Source2__c ='Exhibition';
                  walkInForm44.save();
                  
                 
                  
                  
                  pageReference pageRef55 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef55);
                 
                  ApexPages.currentPage().getParameters().put('Optyid',o.Id);                 
                  NewSiteVisitController walkInForm55 = new NewSiteVisitController();
                  walkInForm55.sv.Customer_Name1__c='Mr. Aditya Marne';
                  walkInForm55.sv.Mobile_No2__c = '1234567890';
                  walkInForm55.sv.Email2__c = 'test@testing.in';
                  walkInForm55.sv.Source1__c = 'Others';
                  walkInForm55.sv.City__c = 'Pune';
                  walkInForm55.sv.Occupation__c='CA';
                  walkInForm55.sv.Sub_Source2__c ='Exhibition';
                  walkInForm55.strRecordTypeId = Schema.SObjectType.Site_Visit__c.getRecordTypeInfosByName().get('Site Visit Form').getRecordTypeId();
                  
                  walkInForm55.save();
                  
                  pageReference pageRef66 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef66);
                 
                  ApexPages.currentPage().getParameters().put('Accid',a.Id);                 
                  NewSiteVisitController walkInForm66 = new NewSiteVisitController();
                  walkInForm66.sv.Customer_Name1__c='Mr. Aditya Marne';
                  walkInForm66.sv.Mobile_No2__c = '1234567890';
                  walkInForm66.sv.Email2__c = 'test@testing.in';
                  walkInForm66.sv.Source1__c = 'Others';
                  walkInForm66.sv.City__c = 'Pune';
                  walkInForm66.sv.Occupation__c='CA';
                  walkInForm66.sv.Sub_Source2__c ='Exhibition';
                  walkInForm66.save();
              
              test.stopTest();  
             
         }
         @istest
         public static void anotherLead () {
             project__c p = createProject();
             Lead leadObj1 =new Lead();
             leadObj1.LastName='Test Lead';
             leadObj1.MobilePhone='9860708728';
             leadObj1.Email ='test@test2.stetig';
             leadObj1.RDS_Project__c =p.Id;
             leadObj1.Budget_In_lacs__c=100; 
             
               leadObj1.Possession_Requirement__c = 'test';
             insert leadObj1;
             
             pageReference pageRef444 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef444);
                 
                  ApexPages.currentPage().getParameters().put('Leadid',LeadObj1.Id); 
                  ApexPages.currentPage().getParameters().put('projectId',p.Id);                 
                  NewSiteVisitController walkInForm444 = new NewSiteVisitController();
                  walkInForm444.sv.Customer_Name1__c='Mr. Aditya Marne';
                  walkInForm444.sv.Mobile_No2__c = '1234567890';
                  walkInForm444.sv.Email2__c = 'test@testing.in';
                  walkInForm444.sv.Source1__c = 'Others';
                  walkInForm444.sv.City__c = 'Pune';
                  walkInForm444.sv.Occupation__c='CA';
                  walkInForm444.sv.Sub_Source2__c ='Exhibition';
                  walkInForm444.save();
         }
             
         
         private static Project__c createProject() {
                Project__c objProject = new Project__c();
                objProject.name = 'test 1';
                objProject.Project_Code__c='test';
                insert objProject ;
            return objProject;
         } 
          private static Project__c createProject1() {
                Project__c objProject = new Project__c();
                objProject.name = 'test';
                objProject.Project_Code__c='test';
                insert objProject ;
            return objProject;
         } 
         private static Lead createleadTemplate1 () {
                Project__c p = createProject();                
                Lead objLead = new Lead();
                objLead.LastName = 'test';
                objLead.Status = 'Not Sure';
                objLead.Email = 'test@gmail.com';
                objLead.Rating = 'Hot';
                objLead.MobilePhone= '1212121212';
                objLead.LeadSource = 'Digital';
                objLead.Lead_Sub_Source__c= 'Facebook';
                objLead.LeadSource= 'Digital';
                objLead.Lead_Sub_Source__c= 'Facebook';
                objLead.RDS_Project__c = p.id; 
                objLead.RDS_Country__c= 'India';
                objLead.Budget_In_lacs__c= 100;
                insert objLead;
             return objLead;
         }
         private static Account createPAAccount () {
                List<RecordType> personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
                Account objAcc = new Account(lastName='portal account', personEmail = 'standarduser@testorg.com', personMobilePhone= '1212121212', 
                                    RecordType = personAccountRecordType[0],Mobile_No__c = '1212121212',
                                    Occupation__c = 'test',Ethnicity__c = 'test',billingstreet='Test Street',billingcity='Test City',billingstate='Test State',
                                    billingcountry='Test Country',billingpostalcode='411007');
                insert objAcc;
             return objAcc;
         }
         private static Opportunity createOpp (Id accId, Id projId) {
                
                Opportunity objOpp = new Opportunity();
                objopp.Name = 'TestOpp';
                objopp.Accountid = accId;
                objopp.CloseDate = System.today().addDays(30);
                objopp.StageName = 'Qualification';//'Unit Booked';
                objopp.Project__c = projId;
                objopp.S_Budget_In_lacs__c= 100;
                objopp.Walk_in_Source__c= 'Digital';
                objopp.Walk_in_Sub_Source__c= 'Facebook';
                insert objOpp;
                Opportunity objOppToreturn = [Select id,Project__c,AccountId ,StageName 
                                                      from Opportunity where id =:objOpp.id];
             return objOppToreturn ;
         }
         
          private static Opportunity createOpp1 (Id accId, Id projId) {
             //Account a = createPAAccount();
             //project__c p = createProject();
             
                Opportunity objOpp = new Opportunity();
                objopp.Name = 'TestOpp';
                objopp.Accountid = accId;
                objopp.CloseDate = System.today().addDays(30);
                objopp.StageName = 'Qualification';//'Unit Booked';
                objopp.Project__c = projId;
                objopp.S_Budget_In_lacs__c= 100;
                objopp.Walk_in_Source__c= 'Digital';
                objopp.Walk_in_Sub_Source__c= 'Facebook';
                insert objOpp;
                Opportunity objOppToreturn = [Select id,Project__c,AccountId ,StageName 
                                                      from Opportunity where id =:objOpp.id];
             return objOppToreturn ;
         }
         
     @isTest
         private static void WalkInSearchPageTest2() { 
             project__c p = createProject();
             Account a = createPAAccount();
          
          test.startTest();
                 pageReference pageRef = page.Site_Visit_Search_Page;
                 Test.setCurrentPage(pageRef);
                 SVsearch walkInSearch = new SVsearch ();
                 walkInSearch.strProjectId = p.Id;
                 walkInSearch.NewLead.MobilePhone= '';
                 walkInSearch.NewLead.lastName = 'testlead';
                 walkInSearch.NewLead.Email = 'testlead@test.in';
                 walkInSearch.saveMethod();
                 walkInSearch.searchAllLead();
                 
                 SVsearch walkInSearch1 = new SVsearch ();
                 
                 walkInSearch1.strProjectId = p.Id; 
                 walkInSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch1.saveMethod();
                 walkInSearch1.searchAllLead();
               
                 SVsearch walkInSearch11= new SVsearch ();
                 Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708780';
             leadObj.RDS_Project__c =p.Id;
             insert leadObj;
             
                 walkInSearch11.strProjectId = p.Id;
                 walkInSearch11.NewLead = leadObj;
                 walkInSearch11.saveMethod();
                 walkInSearch11.searchAllLead();
                 walkInSearch11.goBack();
             test.stopTest();
         } 
 }