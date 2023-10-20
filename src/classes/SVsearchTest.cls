@isTest
 public class SVsearchTest
 {
     @isTest
         private static void WalkInSearchPageTest() { 
             project__c p = createProject();
             //Lead l = createleadTemplate1();
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
                 walkInSearch.NewLead.RDS_Alternate_Email_Id__c='testlead1@test.in';
                 walkInSearch.OpportunityId = o.Id;
                 walkInSearch.saveMethod();
                 walkInSearch.searchAllLead();
                 
                 SVsearch walkInSearch1 = new SVsearch ();
                 
                 walkInSearch1.strProjectId = p.Id; 
                 walkInSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch1.saveMethod();
                 walkInSearch1.searchAllLead();
               
                 SVsearch walkInSearch11= new SVsearch ();
                 //Lead l = createleadTemplate1();
                
             Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708789';
             leadObj.RDS_Project__c =p.Id;
             //leadObj.Budget_In_lacs__c=100; 
             insert leadObj;
             
                 walkInSearch11.strProjectId = p.Id;
                 //cifSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch11.NewLead = leadObj;
                 walkInSearch11.saveMethod();
                 walkInSearch11.searchAllLead();
                 walkInSearch11.goBack();
                 //cifSearch11.createEventOnDuplicateOpty();
             test.stopTest();
         }
         
         @isTest
         private static void walkInMainformserachpageTest() {
             project__c p = createProject();
             //Lead l = createleadTemplate1();
             Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708788';
             leadObj.RDS_Project__c =p.Id;
             //leadObj.Budget_In_lacs__c=100; 
             insert leadObj;
             
             Account a = createPAAccount();
             Opportunity o = createOpp(a.Id,p.Id);
             test.startTest();
                 pageReference pageRef = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef);
                 ApexPages.currentPage().getParameters().put('id',leadObj.Id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 //SiteVisitWalkin walkInForm = new SiteVisitWalkin();
                 svSearch svs = new SVSearch();
                 SVS.NewLead.MobilePhone = '1212121212';
                 svs.searchAllLead();
                // walkInForm.redirectNext();
                // walkInForm.validateLeadSource();
               //  walkInForm.GoBackToLead();
               
                 pageReference pageRef1 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef1);
                 ApexPages.currentPage().getParameters().put('id',leadObj.Id);
                 ApexPages.currentPage().getParameters().put('optyid',o.Id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 //SiteVisitWalkin walkInForm1 = new SiteVisitWalkin();
                 //walkInForm1.redirectNext();
                 
                 pageReference pageRef11 = page.VisitFormEditPage2;
                 Test.setCurrentPage(pageRef11);
                 ApexPages.currentPage().getParameters().put('Accid',a.Id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 //SiteVisitWalkin walkInForm11 = new SiteVisitWalkin();
                  
                  
                 /* walkInForm11.CIFObj.Ethnicity__c = 'test';
                 walkInForm11.CIFObj.BudgetIn_Cr__c = 100;
                 walkInForm11.CIFObj.Preferred_Location__c = 'test';
                 walkInForm11.CIFObj.Configuration__c = '1.5 BHK';
                 walkInForm11.CIFObj.TimeLine__c = 'Ready Possession';
                 walkInForm11.CIFObj.Source__c = 'Digital';*/
                 // walkInForm11.redirectNext(); 
                 test.stopTest();
             
         }
         /* @isTest
         private static void cifFormpagetest2 () {
             project__c p = createProject();
             //Lead l = createleadTemplate1();
             Account a = createPAAccount();
             Opportunity o = createOpp(a.Id,p.Id);
             test.startTest();
                 pageReference pageRef1 = page.CIFFormPage;
                 Test.setCurrentPage(pageRef1);
                 ApexPages.currentPage().getParameters().put('optyid',o.Id);
                 ApexPages.currentPage().getParameters().put('projectId',p.Id);
                 CIFFormPageController cifForm1 = new CIFFormPageController();
                 cifForm1.redirectNext();
            test.stopTest();  
         }
         */
        
         
         private static Project__c createProject() {
                Project__c objProject = new Project__c();
                objProject.name = 'test';
                objProject.Project_Code__c='test';
              //  objProject.RW_Status__c = 'Active';
                insert objProject ;
            return objProject;
         } 
         private static Lead createleadTemplate1 () {
                Project__c p = createProject();                
                Lead objLead = new Lead();
                objLead.LastName = 'test';
                objLead.Status = 'Not Sure';
                objLead.Email = 'test@gmail.com';
                objLead.RDS_Alternate_Email_Id__c='testlead1@test.in';
                objLead.Rating = 'Hot';
               
                objLead.MobilePhone= '1212121212';
                objLead.LeadSource = 'Digital';
                //objLead.Corporate_Company__c  = 'Other';
                objLead.Lead_Sub_Source__c= 'Facebook';
                objLead.LeadSource= 'Digital';
                objLead.Lead_Sub_Source__c= 'Digital';
                //objLead.Walk_in_Source_c__c= 'Digital';
                //objLead.Walk_in_Sub_Source__c= 'Facebook';
                //objLead.Remarks__c= 'test remark';
                objLead.RDS_Project__c= p.id; 
                objLead.RDS_Country__c= 'India';
                //objLead.State__c = 'Odisha';
                //objLead.City__c = 'Bhubaneshwar';
                //objLead.Budget_In_lacs__c= 100;
                objLead.RDS_Unit_type_configuration__c= '1.5 BHK';
                //objLead.RDS_Location__c= 'MANGLAUR';
                //objLead.RND_Timeline__c= 'Ready Possession';
               // objLead.RW_Date_of_Birth__c = System.today().addDays(-10);
               // objLead.RW_Customer_Type__c = 'NRI';
               // objLead.Occupation__c= 'test';
                //objLead.Ethnicity__c= 'test';
                //objLead.RW_Budget_Rs_in_Cr__c = 10000;
                insert objLead;
             return objLead;
         }
         private static Account createPAAccount () {
                List<RecordType> personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
                Account objAcc = new Account(lastName='portal account', personEmail = 'standarduser@testorg.com', personMobilePhone= '1212121212', 
                                    RecordType = personAccountRecordType[0],Mobile_No__c = '1212121212',
                                    Occupation__c = 'test',Ethnicity__c = 'test');
                insert objAcc;
             return objAcc;
         }
         
         
         private static Opportunity createOpp (Id accId, Id projId) {
             //Account a = createPAAccount();
             //project__c p = createProject();
             
                Opportunity objOpp = new Opportunity();
                objopp.Name = 'TestOpp';
                objopp.Accountid = accId;
                objopp.CloseDate = System.today().addDays(30);
                objopp.StageName = 'Qualification';//'Unit Booked';
                objopp.Project__c = projId;
                
                objopp.S_Budget_In_lacs__c= 100;
                //objopp.Ethnicity__c = 'test';
                //objopp.Location__c = 'MANGLAUR';
                //objopp.Unit_type_configuration__c= '1.5 BHK';
               // objopp.Time_line__c = 'Ready Possession';
                objopp.Walk_in_Source__c= 'Channel Partner';
                objopp.Walk_in_Sub_Source__c= 'Facebook';
                //objopp.Is_Revisit_done__c=true;
                //objopp.Revisit_Date_Time__c=System.now();
                //objopp.Channel_Partner_Name__c='360 Realty Solutions';
                //objopp.Walk_In_CP__c='360 Realty Solutions';
                //objopp.CP_Mobile_Number__c='1212121212';
                //objopp.CP_RERA_ID__c='12333211233';
                //objopp.RW_Project_Unit__c = u.Id;
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
               // objopp.Ethnicity__c = 'test';
                //objopp.Location__c = 'MANGLAUR';
                //objopp.Unit_type_configuration__c= '1.5 BHK';
               // objopp.Time_line__c = 'Ready Possession';
                objopp.Walk_in_Source__c= 'Digital';
                objopp.Walk_in_Sub_Source__c= 'Facebook';
                //objopp.Is_Revisit_done__c=true;
                //objopp.Revisit_Date_Time__c=System.now();
                //objopp.Channel_Partner_Name__c='360 Realty Solutions';
                //objopp.Walk_In_CP__c='360 Realty Solutions';
                //objopp.CP_Mobile_Number__c='1212121212';
                //objopp.CP_RERA_ID__c='12333211233';
                objopp.S_Active__c = true;
                //objopp.RW_Project_Unit__c = u.Id;
                insert objOpp;
                Opportunity objOppToreturn = [Select id,Project__c,AccountId ,StageName 
                                                      from Opportunity where id =:objOpp.id];
             return objOppToreturn ;
         }
         
        @isTest
         private static void WalkInSearchPageTest2() { 
             project__c p = createProject();
             //Lead l = createleadTemplate1();
             Account a = createPAAccount();
           //  Opportunity o = createOpp1(a.Id,p.Id);
             test.startTest();
                 pageReference pageRef = page.Site_Visit_Search_Page;
                 Test.setCurrentPage(pageRef);
                 SVsearch walkInSearch = new SVsearch ();
                 walkInSearch.strProjectId = p.Id;
                 walkInSearch.NewLead.MobilePhone= '';
                 walkInSearch.NewLead.lastName = 'testlead';
                 walkInSearch.NewLead.Email = 'testlead@test.in';
                 walkInSearch.NewLead.RDS_Alternate_Email_Id__c='testlead1@test.in';
           //      walkInSearch.OpportunityId = o.Id;
                 walkInSearch.saveMethod();
                 walkInSearch.searchAllLead();
                 
                 SVsearch walkInSearch1 = new SVsearch ();
                 
                 walkInSearch1.strProjectId = p.Id; 
                 walkInSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch1.saveMethod();
                 walkInSearch1.searchAllLead();
               
                 SVsearch walkInSearch11= new SVsearch ();
                 //Lead l = createleadTemplate1();
                 Lead leadObj=new Lead();
             leadObj.LastName='Test Lead';
             leadObj.MobilePhone='9860708780';
             leadObj.RDS_Project__c =p.Id;
             
             //leadObj.Budget_In_lacs__c=100; 
             insert leadObj;
             
                 walkInSearch11.strProjectId = p.Id;
                 //cifSearch1.NewLead.MobilePhone= '1212121212';
                 walkInSearch11.NewLead = leadObj;
                 walkInSearch11.saveMethod();
                 walkInSearch11.searchAllLead();
                 walkInSearch11.goBack();
                 
                 
                 //cifSearch11.createEventOnDuplicateOpty();
                 
             SVsearch walkInSearch12= new SVsearch ();
                Opportunity oppOBJ = new Opportunity();
                oppOBJ.Name = 'Test 123';
                oppOBJ.Accountid = a.Id;
                oppOBJ.CloseDate = System.today().addDays(30);
                oppOBJ.StageName = 'Qualification';//'Unit Booked';
                oppOBJ.Project__c = p.Id;
                oppOBJ.S_Budget_In_lacs__c= 100;
                oppOBJ.Walk_in_Source__c= 'Channel Partner';
                oppOBJ.Walk_in_Sub_Source__c= 'Facebook';
                //oppOBJ.Is_Revisit_done__c=true;
                //oppOBJ.Revisit_Date_Time__c=System.now();
                //oppOBJ.Channel_Partner_Name__c='360 Realty Solutions';
                //oppOBJ.CP_Mobile_Number__c='1212121212';
                //oppOBJ.CP_RERA_ID__c='12333211233';
                oppOBJ.S_Active__c = true;
                insert oppOBJ;
             walkInSearch12.strProjectId= p.ID;
             walkInSearch12.OpportunityId = oppOBJ.Id;
             walkInSearch12.updateRevisitOnOpty();
             test.stopTest();
         } 
}