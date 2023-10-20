@isTest
private  Class TestNewSiteVisitController{
     @isTest
    private static void TestNewSitevisitController() {
    
        Legal_Entity__c objlglentity = new Legal_Entity__c();
        objlglentity.Name ='Test stetig';
        objlglentity.RDS_Company_Code__c='123';
        objlglentity.RDS_Service_Tax_No__c= '2342627892762';
        objlglentity.RDS_Company_Name__c='Stetig';
        objlglentity.RDS_Address1__c='Pune';
        objlglentity.RDS_Address2__c='ShivajiNagar';
        objlglentity.RDS_City__c='Pune Coty';
        objlglentity.RDS_Pin_Code__c='411019';
        objlglentity.RDS_Phone__c='9953528045';
        
        
        // Project Creation
        Project__c objpr = new Project__c();
        objpr.Project_Code__c = 'T35';
        objpr.Name = 'Solitair';
        objpr.Start_Date__c = System.today().addDays(-5);
        objpr.RDS_Company_Code__c = objlglentity.Id;
        objpr.RDS_Interest_Rate__c = 12;
        objpr.Project_Stage__c='Launch';
        objpr.Address__c = '1403, Fantasy Land, Utopia, Planet Mars, OUTERWORLD CODE -11011';
        objpr.Project_Property_Type__c = 'Residential';
        objpr.S_Floor_Rise_Rate__c = 150;
        objpr.S_Applicable_From_Floor__c = 5;
        objpr.S_View1_PLC__c = 10;
        objpr.S_View2_PLC__c = 20;
        objpr.S_View3_PLC__c = 30;
        objpr.NPV__c = 12;
        objpr.S_Ready_Reckoner_Rate__c = 24000;
        objpr.Token_Amount__c = 200000;
        objpr.Service_Tax_Required_On_Token_Amount__c = true;
        objpr.Total_Max_Discount_Allowed__c = 100;
        objpr.Discount1_Type__c = 'NRI Discount';
        objpr.Discount1_Effective_Till__c = system.today().addDays(100);
        objpr.Discount1_Per_Sq_Ft__c = 1000;
        objpr.Discount2_Type__c = 'Festive Discount';
        objpr.Discount2_Effective_Till__c = system.today().addDays(100);
        objpr.Discount2_Lumpsum__c = 100000;
        objpr.Days_To_Send_Demand__c = 10;
        objpr=RDSCommon.CreateProject(objpr);
        
        // Configuration type creation
        Project_Unit_Type__c objProjectUnitType = new Project_Unit_Type__c();
        objProjectUnitType.name='ONE BHK';
        objProjectUnitType.RDS_Project__c =objpr.id;
        objProjectUnitType=RDSCommon.CreateProjectUnitType(objProjectUnitType);
        
        // tower creation 
        Tower__c t = new Tower__c();
        t.Name = 'Tower X';
        t.ProjectName__c = objpr.Id;
        t = RDSCommon.CreateTower(t);
        
        // unit creation associated to project and tower
        Project_Unit__c objPU1 = new Project_Unit__c();    
        objPU1.Name = 'TestFive';      
        objPU1.Project__c = objpr.Id;
        objPU1.Project_Unit_Type__c=objProjectUnitType.id;
        objPU1.Param1__c = '5';
        objPU1.UnitNo__c ='TestFive';
        objPU1.Unit_status__c='Vacant';
        objPU1.Actual_Area_value__c = 2218;
        objPU1.TowerName__c = t.Id;
        objPU1.Legal_Entity__c = objlglentity.id;
        objPU1=RDSCommon.CreateProjectUnit(objPU1);
        
        // account creation 
        Account objac = new Account();
        objac.FirstName = 'Shock';
        objac.LastName = 'Wave';
        objac.Project__c = objpr.Id;
        objac.Correspondence_Address__c = 'Delhi';
        objac.Category__c = 'General';
        objac.Unit__c = objPU1.Id;
        objac.PersonEmail = 'shock@transformers.com';
        objac.PersonMobilePhone = '90909090';
        objac.BillingStreet = 'ABC street';
        objac.BillingCity = 'Mumbai';
        objac.BillingState = 'Maharashtra';
        objac.BillingPostalCode = '909999';
        objac.BillingCountry = 'India';
        objac=RDSCommon.CreateAccount(objac);
        
        Opportunity objOp1 = new Opportunity();
        objOp1.Name = 'Test';
        objOp1.CloseDate = System.today();
        objOp1.AccountId = objac.Id; 
        objOp1.Status__c = 'Active'; 
        objOp1.StageName = 'Opportunity Identified'; 
        objOp1.Project__c = objpr.Id; 
        objOp1=RDSCommon.CreateOpportunity(objOp1);
        
        Opportunity objOp2 = new Opportunity();
        objOp2.Name = 'Test02';
        objOp2.CloseDate = System.today();
        objOp2.AccountId = objac.Id; 
        objOp2.Status__c = 'Active'; 
        objOp2.StageName = 'Opportunity Identified'; 
        objOp2.Project__c = objpr.Id; 
        objOp2=RDSCommon.CreateOpportunity(objOp2);
        
        Test.startTest();
              
        PageReference pRef = Page.VisitFormEditPage3;
        Test.setCurrentPage(pRef);
        Apexpages.currentPage().getParameters().put('opid', objOp1.id);
        NewSitevisitController2 sv1 = new NewSitevisitController2();        
        sv1.sv.Date_Of_Birth__c = Date.newInstance(1980,09,04);
        sv1.Assign();
        sv1.Save();
        
        /*PageReference pRef2 = Page.CustomSiteVisitFormPage;
        Test.setCurrentPage(pRef2);
        Apexpages.currentPage().getParameters().put('opid', objOp2.id);
        NewSitevisitController sv2 = new NewSitevisitController();        
        sv2.sv.Date_Of_Birth__c = Date.newInstance(1980,04,09);
        sv2.Save();*/
        
        Test.stopTest();
    }                  

}