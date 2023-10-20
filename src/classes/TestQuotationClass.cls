@isTest
private  class TestQuotationClass {

@isTest
    private static void QuotationStartPageTest() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
        objlglentity.Name = 'RS';
        objlglentity.RDS_Company_Code__c='rs';
        objlglentity.RDS_Service_Tax_No__c= '123456789012345';
        objlglentity.RDS_Company_Name__c='111';
        objlglentity.RDS_Address1__c='123';
        objlglentity.RDS_Address2__c='234';
        objlglentity.RDS_City__c='delhi';
        objlglentity.RDS_Pin_Code__c='201301';
        objlglentity.RDS_Phone__c='9953528045';
        objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
        
        Broker__c objBroK = new Broker__c();
        objBroK.Broker_Code__c = '12346';
        objBroK.Broker_Name__c = 'Brokname';
        objBroK.Status__c = 'Actives';
        objBroK=RDSCommon.CreateBroker(objBroK);
        
        Project__c objpr = new Project__c();
        objpr.Project_Code__c = 'T35';
        objpr.Name = 'TestProject';
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
        objpr.Discount1_Type__c = 'General';
        //objpr.Discount1_Effective_Till__c = system.today().addDays(100);
        objpr.Discount1_Per_Sq_Ft__c = 100;
        objpr.Discount2_Type__c = 'Armed Forces';
        objpr.Discount2_Per_Sq_Ft__c = 150;
        objpr.Discount3_Type__c = 'Corporate';
        objpr.Discount3_Per_Sq_Ft__c = 200;
        objpr.Discount4_Type__c = 'Employee';
        objpr.Discount4_Per_Sq_Ft__c = 250;
        objpr.Discount5_Type__c = 'NRI';
        objpr.Discount5_Per_Sq_Ft__c = 300;
        objpr.Discount6_Type__c = 'Physically Challenged';
        objpr.Discount6_Per_Sq_Ft__c = 350;
        objpr.Discount8_Description__c = 'summer offer';
        objpr.Discount8_Type__c = 'Special Offer';
        objpr.Discount8_Per_Sq_Ft__c = 1000;
        objpr.Discount9_Description__c = 'DAM';
        objpr.Discount9_Type__c = 'DAM';
        objpr.Discount9_Per_Sq_Ft__c = 2000;
        //objpr.Discount2_Effective_Till__c = system.today().addDays(100);
        objpr.Discount2_Lumpsum__c = 100000;
        objpr.Allotment_Charges_1__c = 10000;
        objpr.Allotment_Charges_2__c = 10000;
        objpr.Allotment_Charges_3__c = 10000;
        objpr.Allotment_Charges_4__c = 10000;
        objpr.Allotment_Charges_5__c = 10000;
        objpr=RDSCommon.CreateProject(objpr);
        
        Project_Unit_Type__c objProjectUnitType = new Project_Unit_Type__c();
        objProjectUnitType.name='ONE BHK';
        objProjectUnitType.RDS_Project__c =objpr.id;
        objProjectUnitType=RDSCommon.CreateProjectUnitType(objProjectUnitType);
        
        Tower__c t = new Tower__c();
        t.Name = 'Tower X';
        t.ProjectName__c = objpr.Id;
        t = RDSCommon.CreateTower(t);
        
        Tax_Slab__c taxS = new Tax_Slab__C();
         taxS.name = 'GST';
         taxS.From_Date__c = System.today().addDays(-10);
         taxS.Percentage__c = 4.20;
         taxS = RDSCommon.CreateTaxSlab(taxS);
         
         Tax_Breakup__c tb1 = new Tax_breakup__c();
         tb1.Taxable_Percentage__c = 66.66667;
         tb1.Tax_percentage__c = 9;
         tb1.tax_code__c = 'CGST';
         tb1.Tax_Name__c = 'CGST';
         tb1.Tax_Slab__c = taxS.id;
         tb1.Effective_from__c = system.today().addDays(-10);
         tb1.Tax_Split_Type__c = 'CGST';
         tb1.Tax_Type__c = 'Service tax';
         insert tb1;
         
         Tax_Breakup__c tb2 = new Tax_breakup__c();
         tb2.Taxable_Percentage__c = 66.66667;
         tb2.Tax_percentage__c = 9;
         tb2.tax_code__c = 'SGST';
         tb2.Tax_Name__c = 'SGST';
         tb2.Tax_Slab__c = taxS.id;
         tb2.Effective_from__c = system.today().addDays(-10);
         tb2.Tax_Split_Type__c = 'SGST';
         tb2.Tax_Type__c = 'Service tax';
         insert tb2;
         
         
         Tax_Slab__c taxS1 = new Tax_Slab__C();
         taxS1.name = 'GST-18';
         taxS1.From_Date__c = System.today().addDays(-10);
         taxS1.Percentage__c = 14;
         taxS1 = RDSCommon.CreateTaxSlab(taxS1);
         
           Tax_Breakup__c tb3 = new Tax_breakup__c();
         tb3.Taxable_Percentage__c = 100;
         tb3.Tax_percentage__c = 9;
         tb3.tax_code__c = 'CGST';
         tb3.Tax_Name__c = 'CGST';
         tb3.Tax_Slab__c = taxS1.id;
         tb3.Effective_from__c = system.today().addDays(-10);
         tb3.Tax_Split_Type__c = 'CGST';
         tb3.Tax_Type__c = 'Service tax';
         insert tb3;
         
         Tax_Breakup__c tb4 = new Tax_breakup__c();
         tb4.Taxable_Percentage__c = 100;
         tb4.Tax_percentage__c = 9;
         tb4.tax_code__c = 'SGST';
         tb4.Tax_Name__c = 'SGST';
         tb4.Tax_Slab__c = taxS1.id;
         tb4.Effective_from__c = system.today().addDays(-10);
         tb4.Tax_Split_Type__c = 'SGST';
         tb4.Tax_Type__c = 'Service tax';
         insert tb4; 
         
         Global_Charges__c ObjGloChrg = new Global_Charges__c();
         ObjGloChrg.Name = 'Basic';
         ObjGloChrg.Code__c = '011';
         ObjGloChrg.Description__c = 'Basic';
         ObjGloChrg.Sequence_No__c = 99;
         ObjGloChrg.Charge_Type__c = 'Basic';
         ObjGloChrg.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
         
         Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
         ObjGloChrg1.Name = 'Club Membership';
         ObjGloChrg1.Code__c = '012';
         ObjGloChrg1.Description__c = 'Club Membership';
         ObjGloChrg1.Sequence_No__c = 100;
         ObjGloChrg1.Charge_Type__c = 'Society Charges';
         ObjGloChrg1.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg1=RDSCommon.CreateGlobalCharges(ObjGloChrg1);
         
         Global_Charges__c ObjGloChrg2 = new Global_Charges__c();
         ObjGloChrg2.Name = 'Tax Charge';
         ObjGloChrg2.Code__c = '015';
         ObjGloChrg2.Description__c = 'SERVICE TAX';
         ObjGloChrg2.Sequence_No__c = 105;
         ObjGloChrg2.Charge_Type__c = 'Tax';
         ObjGloChrg2.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg2=RDSCommon.CreateGlobalCharges(ObjGloChrg2);
         
         /*Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
         ObjGloChrg3.Name = 'MVAT';
         ObjGloChrg3.Code__c = '016';
         ObjGloChrg3.Description__c = 'MVAT';
         ObjGloChrg3.Sequence_No__c = 106;
         ObjGloChrg3.Charge_Type__c = 'Debotors';
         ObjGloChrg3.Nature_of_Charge__c = 'Debotors';
         ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);*/
         
         Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
         ObjGloChrg4.Name = 'Registration Charges';
         ObjGloChrg4.Code__c = '017';
         ObjGloChrg4.Description__c = 'Registration Charges';
         ObjGloChrg4.Sequence_No__c = 107;
         ObjGloChrg4.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
         
         Global_Charges__c ObjGloChrg7 = new Global_Charges__c();
         ObjGloChrg7.Name = 'Development Charges';
         ObjGloChrg7.Code__c = '020';
         ObjGloChrg7.Description__c = 'Development Charges';
         ObjGloChrg7.Sequence_No__c = 110;
         ObjGloChrg7.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg7.Short_Name__c = 'DEVELOP';
         ObjGloChrg7=RDSCommon.CreateGlobalCharges(ObjGloChrg7);
         
         Global_Charges__c ObjGloChrg8 = new Global_Charges__c();
         ObjGloChrg8.Name = 'Infrastructure Charges';
         ObjGloChrg8.Code__c = '021';
         ObjGloChrg8.Description__c = 'Infrastructure Charges';
         ObjGloChrg8.Sequence_No__c = 111;
         ObjGloChrg8.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg8.Short_Name__c = 'INFRA';
         ObjGloChrg8=RDSCommon.CreateGlobalCharges(ObjGloChrg8);
         
         Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
         ObjGloChrg5.Name = 'Floor Rise';
         ObjGloChrg5.Code__c = '018';
         ObjGloChrg5.Description__c = 'Floor Rise';
         ObjGloChrg5.Sequence_No__c = 108;
         ObjGloChrg5.Charge_Type__c = 'Debtors';
         ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
         
         Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
         ObjGloChrg6.Name = 'Premium 1';
         ObjGloChrg6.Code__c = '019';
         ObjGloChrg6.Description__c = 'Premium 1';
         ObjGloChrg6.Sequence_No__c = 109;
         ObjGloChrg6.Charge_Type__c = 'Debtors';
         ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
         
         Project_Charges__c PCharge = new Project_Charges__c();
         PCharge.Charge_Code__c = ObjGloChrg.Id;
         PCharge.Project__c = objpr.Id;
         PCharge.Name = 'Basic';
         PCharge.Active__c = true;
         PCharge.Applied_This_Charge_To_FA__c = true;
         PCharge.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge.S_Charge_Bucket__c = 'Agreement Value';
         PCharge.S_Payable_At__c = 'As per payment milestone';
         PCharge.Payment_Plan_Applicable__c = true;
         pCharge.Service_Tax_Percentage__c = 'GST';
         pCharge.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge=RDSCommon.CreateProjectCharges(PCharge);
         
         Project_Charges__c PCharge1 = new Project_Charges__c();
         PCharge1.Charge_Code__c = ObjGloChrg1.Id;
         PCharge1.Project__c = objpr.Id;
         PCharge1.Name = 'Club Membership';
         PCharge1.Active__c = true;
         PCharge1.Applied_This_Charge_To_FA__c = true;
         PCharge1.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge1.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge1.S_Charge_Bucket__c = 'Other Charges';
         PCharge1.S_Payable_At__c = 'At Possession';
         PCharge1.Payment_Plan_Applicable__c = true;
         PCharge1.Service_Tax_Percentage__c = 'GST-18';
         PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
         
         /*Project_Charges__c PCharge2 = new Project_Charges__c();
         PCharge2.Charge_Code__c = ObjGloChrg3.Id;
         PCharge2.Project__c = objpr.Id;
         PCharge2.Name = 'MVAT';
         PCharge2.Active__c = false;
         PCharge2.Applied_This_Charge_To_FA__c = true;
         PCharge2.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge2.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge2.S_Payable_At__c = 'At Regsistration';
         PCharge2.S_Charge_Percentage__c = 1;
         PCharge2.Payment_Plan_Applicable__c = false;
         PCharge2=RDSCommon.CreateProjectCharges(PCharge2);*/
         
         Project_Charges__c PCharge3 = new Project_Charges__c();
         PCharge3.Charge_Code__c = ObjGloChrg4.Id;
         PCharge3.Project__c = objpr.Id;
         PCharge3.Name = 'Registration Charges';
         PCharge3.Active__c = false;
         PCharge3.Applied_This_Charge_To_FA__c = true;
         PCharge3.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge3.S_Charge_Percentage__c = 1;
         PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge3.S_Payable_At__c = 'At Registration';
         PCharge3.Payment_Plan_Applicable__c = false;
         PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
         
         Project_Charges__c PCharge6 = new Project_Charges__c();
         PCharge6.Charge_Code__c = ObjGloChrg7.Id;
         PCharge6.Project__c = objpr.Id;
         PCharge6.Name = 'Development Charges';
         PCharge6.Active__c = true;
         PCharge6.Applied_This_Charge_To_FA__c = true;
         PCharge6.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge6.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge6.Interest_Applicable_on_this_charge__c = true;
         PCharge6.S_Charge_Bucket__c = 'Agreement Value';
         PCharge6.S_Payable_At__c = 'As per payment milestone';
         PCharge6.Remarks__c = 'Development Charges';
         PCharge6.Service_Tax_Percentage__c = 'GST';
         PCharge6.Payment_Plan_Applicable__c = false;
         PCharge6=RDSCommon.CreateProjectCharges(PCharge6);
         
         Project_Charges__c PCharge7 = new Project_Charges__c();
         PCharge7.Charge_Code__c = ObjGloChrg8.Id;
         PCharge7.Project__c = objpr.Id;
         PCharge7.Name = 'Infrastructure Charges';
         PCharge7.Active__c = true;
         PCharge7.Applied_This_Charge_To_FA__c = true;
         PCharge7.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge7.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge7.Interest_Applicable_on_this_charge__c = true;
         PCharge7.S_Charge_Bucket__c = 'Agreement Value';
         PCharge7.S_Payable_At__c = 'As per payment milestone';
         PCharge7.Remarks__c = 'Infrastructure Charges';
         PCharge7.Service_Tax_Percentage__c = 'GST';
         PCharge7.Payment_Plan_Applicable__c = false;
         PCharge7=RDSCommon.CreateProjectCharges(PCharge7);
         
         Project_Charges__c PCharge4 = new Project_Charges__c();
         PCharge4.Charge_Code__c = ObjGloChrg5.Id;
         PCharge4.Project__c = objpr.Id;
         PCharge4.Name = 'Floor Rise';
         PCharge4.Active__c = true;
         PCharge4.Applied_This_Charge_To_FA__c = true;
         PCharge4.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge4.S_Charge_Bucket__c = 'Agreement Value';
         PCharge4.S_Payable_At__c = 'As per payment milestone';
         PCharge4.Payment_Plan_Applicable__c = false;
         PCharge4.Service_Tax_Percentage__c = 'GST';
         PCharge4.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
         
         Project_Charges__c PCharge5 = new Project_Charges__c();
         PCharge5.Charge_Code__c = ObjGloChrg6.Id;
         PCharge5.Project__c = objpr.Id;
         PCharge5.Name = 'Premium 1';
         PCharge5.Active__c = true;
         PCharge5.Applied_This_Charge_To_FA__c = true;
         PCharge5.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge5.S_Charge_Bucket__c = 'Agreement Value';
         PCharge5.S_Payable_At__c = 'As per payment milestone';
         PCharge5.Payment_Plan_Applicable__c = false;
         PCharge5.Service_Tax_Percentage__c = 'GST';
         PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
         
         Project_Unit__c objPU1 = new Project_Unit__c();    
         objPU1.Name = 'TestFive';      
         objPU1.Project__c = objpr.Id;
         objPU1.Project_Unit_Type__c=objProjectUnitType.id;
         objPU1.Param1__c = '5';
         objPU1.UnitNo__c ='TestFive';
         objPU1.Unit_status__c='Booked';
         objPU1.Actual_Area_value__c = 2218;
         objPU1.Floor__c = 8;
         objPU1.TowerName__c = t.Id;
         objPU1.Single_car_park_Earmarked__c = 0;
         objPU1.Single_Open_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Tandem_car_park_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Stack__c = 0;
         
         objPU1.Discount1_Type__c = 'General';
         objPU1.Discount1_Per_Sq_Ft__c = 100;
         objPU1.Discount2_Type__c = 'Armed Forces';
         objPU1.Discount2_Per_Sq_Ft__c = 200;
         objPU1.Discount3_Type__c = 'Corporate';
         objPU1.Discount3_Per_Sq_Ft__c = 250;
         objPU1.Discount4_Type__c = 'Physically Challenged';
         objPU1.Discount4_Per_Sq_Ft__c = 300;
         
         objPU1.Discount8_Type__c = 'Special Offer';
         objPU1.Discount8_Per_Sq_Ft__c = 300;
         objPU1.Discount8_Description__c = 'Summer Offer';
         objPU1.Discount9_Type__c = 'DAM';
         objPU1.Discount9_Per_Sq_Ft__c = 350;
         objPU1.Discount9_Description__c = 'DAM';
         objPU1=RDSCommon.CreateProjectUnit(objPU1);
         
         Account objac = new Account();
         objac.FirstName = 'Shock';
         objac.LastName = 'Wave';
         objac.Project__c = objpr.Id;
         objac.Correspondence_Address__c = 'Delhi';
         objac.Category__c = 'General';
         objac.Unit__c = objPU1.Id;
         objac=RDSCommon.CreateAccount(objac);
         
         Opportunity objOpportunity = new Opportunity();
         objOpportunity.Name = 'Test';
         objOpportunity.CloseDate = System.today();
         objOpportunity.AccountId = objac.Id; 
         objOpportunity.Status__c = 'Active'; 
         objOpportunity.StageName = 'Opportunity Identified'; 
         objOpportunity.Project__c = objpr.Id; 
         objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
         
         Project_Construction_Stages__c objPCS = new Project_Construction_Stages__c();
         objPCS.Project__c = objpr.Id;
         objPCS.Name = 'Commencement of Raft/Foundation';
         objPCS.Code__c ='Test';
         objPCS.Description__c='Commencement of Raft/Foundation';
         objPCS.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS.Tower__c = t.Id;
         insert objPCS;
         
         Project_Construction_Stages__c objPCS1 = new Project_Construction_Stages__c();
         objPCS1.Project__c = objpr.Id;
         objPCS1.Name = 'At Fit Out Possession';
         objPCS1.Code__c ='Test1';
         objPCS1.Description__c='At Fit Out Possession';
         objPCS1.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS1.Tower__c = t.Id;
         insert objPCS1;
         
         // rateList creation
         Rate_List_Header__c objRlh = new Rate_List_Header__c();
         objRlh.Name = 'Basic RL Header';
         objRlh.Project__c = objpr.Id;
         objRlh.Project_Charges__c = PCharge.Id;
         objRlh.Rate_list__c = 'All Charges';
         objRlh.Effective_From__c = system.today().addDays(-3);
         objRlh=RDSCommon.CreateRateListHeader(objRlh);
         
         Rate_List_Detail__c objRld = new Rate_List_Detail__c();
         objRld.Name = 'Basic RL Detail';
         objRld.Charge_Based_On__c = 'Rate';
         objRld.Percent__c = 23600;
         objRld.Project__c = objpr.Id;
         objRld.Rate_List_Header__c = objRlh.id;
         objRld = RDSCommon.CreateRateListHeader(objRld);
         
         Rate_List__c objRL = new Rate_List__c();
         objRL.Rate_List_HeaderID__c = objRlh.Id;
         objRL.Project__c = objpr.Id;
         objRL.Global_Charges__c = ObjGloChrg.Id;
         objRL.Project_Charges__c = PCharge.Id;
         objRL.Project_Unit__c = objPU1.Id;
         objRL.Value__c = 2218;
         objRL.Rate__c = 23600;
         objRL.Charge_Based_On_Master__c = 'Rate';
         objRL.Charge_on_Area_Type__c = 'Saleable Area';
         objRL.Rate_List_Detail__c = objRLd.id;
         objRL=RDSCommon.CreateRateList(objRL);
         
         Rate_List__c objRL1 = new Rate_List__c();
         objRL1.Project__c = objpr.Id;
         objRL1.Global_Charges__c = ObjGloChrg5.Id;
         objRL1.Project_Charges__c = PCharge4.Id;
         objRL1.Project_Unit__c = objPU1.Id;
         objRL1.Value__c = 2218;
         objRL1.Rate__c = 100;
         objRL1.Charge_Based_On_Master__c = 'Rate';
         objRL1.Charge_on_Area_Type__c = 'Saleable Area';
         objRL1.Rate_List_Detail__c = objRLd.id;
         objRL1=RDSCommon.CreateRateList(objRL1);
         
         Rate_List__c objRL2 = new Rate_List__c();
         objRL2.Project__c = objpr.Id;
         objRL2.Global_Charges__c = ObjGloChrg6.Id;
         objRL2.Project_Charges__c = PCharge5.Id;
         objRL2.Project_Unit__c = objPU1.Id;
         objRL2.Value__c = 2218;
         objRL2.Rate__c = 200;
         objRL2.Charge_Based_On_Master__c = 'Rate';
         objRL2.Charge_on_Area_Type__c = 'Saleable Area';
         objRL2.Rate_List_Detail__c = objRLd.id;
         objRL2=RDSCommon.CreateRateList(objRL2);
         
         Rate_List__c objRL3 = new Rate_List__c();
         objRL3.Project__c = objpr.Id;
         objRL3.Global_Charges__c = ObjGloChrg7.Id;
         objRL3.Project_Charges__c = PCharge6.Id;
         objRL3.Project_Unit__c = objPU1.Id;
         objRL3.Rate__c = 190;
         objRL3.Charge_Based_On_Master__c = 'Rate';
         objRL3.Charge_on_Area_Type__c = 'Saleable Area';
         objRL3=RDSCommon.CreateRateList(objRL3);
         
         Rate_List__c objRL4 = new Rate_List__c();
         objRL4.Project__c = objpr.Id;
         objRL4.Global_Charges__c = ObjGloChrg8.Id;
         objRL4.Project_Charges__c = PCharge7.Id;
         objRL4.Project_Unit__c = objPU1.Id;
         objRL4.Rate__c = 210;
         objRL4.Charge_Based_On_Master__c = 'Rate';
         objRL4.Charge_on_Area_Type__c = 'Saleable Area';
         objRL4=RDSCommon.CreateRateList(objRL4);
         
         Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
         objPaymentPlan.Name ='Pay Plan 1';
         objPaymentPlan.Project__c = objpr .Id;
         objPaymentPlan.Tower__c = t.Id;
         objPaymentPlan.Sub_Vention__c = true;
         objPaymentPlan.Subvention_Base_Rate__c = 50;
         objPaymentPlan.No_GST_on_Token__c = true;
         insert objPaymentPlan;
         
         Standard_Pay_Plan_Header__c objSPP = new Standard_Pay_Plan_Header__c();
         objSPP.Project__c = objpr.Id;
         objSPP.Charge_Code__c= PCharge.Id;
         objSPP.Payment_Plan__c=objPaymentPlan.id;
         objSPP.Name='Basic Header';
         objSPP.Plan_Code__c= '89';
         objSPP.tower__c = t.ID;
         objSPP.Effective_from__c = System.today();
         objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
         
         Standard_Pay_Plan_Header__c objSPP1 = new Standard_Pay_Plan_Header__c();
         objSPP1.Project__c = objpr.Id;
         objSPP1.tower__c = t.ID;
         objSPP1.Charge_Code__c= PCharge1.Id;
         objSPP1.Payment_Plan__c=objPaymentPlan.id;
         objSPP1.Name='Club Header';
         objSPP1.Plan_Code__c= '90';
         objSPP1.Effective_from__c = System.today();
         objSPP1=RDSCommon.CreateStandardPayPlanHeader(objSPP1);
         
         // standard payment plan details creation for basic 
         // created 4 installments/milestones. two due date based and 2 Construction Linked
         Standard_Customer_Pay_Plan_Detail__c    objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD.Project__c=objpr.id;
         objSPPD.tower__c = t.ID;
         objSPPD.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD.Days_Months__c='Day(s)';
         objSPPD.Days_Months_Value__c=5;
         objSPPD.Amount__c='Amount';
         objSPPD.Amount_Value__c=110000;
         objSPPD.Installment__c = 100;
         objSPPD= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD);
         
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD4 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD4.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD4.Project__c=objpr.id;
         objSPPD4.tower__c = t.ID;
         objSPPD4.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD4.Days_Months__c='Day(s)';
         objSPPD4.Days_Months_Value__c=0;
         objSPPD4.Amount__c='Amount';
         objSPPD4.Calculate_Installment_Amount_as__c=10;
         objSPPD4.Total_Charge_Value_Minus__c = 110000;
         objSPPD4= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD4);
         
          Standard_Customer_Pay_Plan_Detail__c    objSPPD2 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD2.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD2.Project__c=objpr.id;
         objSPPD2.tower__c = t.ID;
         objSPPD2.Is_to_be_Paid__c='Construction Stage';
         objSPPD2.Days_Months__c='Day(s)';
         objSPPD2.Project_Construction_Stages__c=objPCS.id;
         objSPPD2.Days_Months_Value__c=5;
         objSPPD2.Amount__c='Percentage';
         objSPPD2.Amount_Value__c=40;
         objSPPD2.Installment__c = 102;
         objSPPD2= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD2);
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD3 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD3.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD3.Project__c=objpr.id;
         objSPPD3.tower__c = t.ID;
         objSPPD3.Is_to_be_Paid__c='Construction Stage';
         objSPPD3.Days_Months__c='Day(s)';
         objSPPD3.Project_Construction_Stages__c=objPCS1.id;
         objSPPD3.Days_Months_Value__c=5;
         objSPPD3.Amount__c='Percentage';
         objSPPD3.Amount_Value__c=50;
         objSPPD3.Installment__c = 103;
         objSPPD3= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD3);
         
         // detail record for club member ship charges
         // collected 100% in a single installment on fit out possession
         Standard_Customer_Pay_Plan_Detail__c    objSPPD5 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD5.Standard_Pay_Plan_Header__c = objSPP1.id;
         objSPPD5.Project__c=objpr.id;
         objSPPD5.tower__c = t.ID;
         objSPPD5.Is_to_be_Paid__c='Construction Stage';
         objSPPD5.Days_Months__c='Day(s)';
         objSPPD5.Project_Construction_Stages__c=objPCS1.id;
         objSPPD5.Days_Months_Value__c=5;
         objSPPD5.Amount__c='Percentage';
         objSPPD5.Amount_Value__c=100;
         objSPPD5.Installment__c = 100;
         objSPPD5= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD5);
         
         Team__c objTeam = new Team__c();
         objTeam.Name = 'Sales Approvers Team';
         objTeam.Project__c = objpr.id;
         objTeam.Team_Type__c = 'Sales Approvers Team';
         objTeam.Tower__c = t.id;
         insert objTeam;
         
         //create users
         User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
         User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
         User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
         
         // insert team as team members
         Team_Members__c tm1 = new Team_Members__c();
         tm1.Team__c = objTeam.Id;
         tm1.User_Active__c = true;
         tm1.Approver_Type__c = 'First Level';
         tm1.User__c = a1.id;
         insert tm1;
         
         Team_Members__c tm2 = new Team_Members__c();
         tm2.Team__c = objTeam.Id;
         tm2.User_Active__c = true;
         tm2.Approver_Type__c = 'Second Level';
         tm2.User__c = a2.id;
         insert tm2;
         
         Team_Members__c tm3 = new Team_Members__c();
         tm3.Team__c = objTeam.Id;
         tm3.User_Active__c = true;
         tm3.Approver_Type__c = 'Third Level';
         tm3.User__c = a3.id;
         insert tm3;
         
         
         PageReference pRef = Page.QuotationStartPage;
         Test.setCurrentPage(pRef);
         //put the necessary query string params
         ApexPages.currentPage().getParameters().put('oppId',objOpportunity.id);
         ApexPages.currentPage().getParameters().put('id', objPU1.id);
         //ApexPages.currentPage().getParameters().put('subPlanId', objPaymentPlan.id);
         QuotationStartController qEx = new QuotationStartController();
         
         qEx.populatePaymentPlan();
         qEx.startQuote();
         qEx.qObj.Plan_Type__c = 'Subvention Plan';
         qEx.selectedPlanId = objPaymentPlan.id;
         qEx.startQuote();
         qEx.cancel();
         
         Decimal calculateAllotmentCharges = InventoryCostServices.calculateAllotmentCharges(objPU1.id);
         Legal_Entity__c getLegalEntityDetails = InventoryCostServices.getLegalEntityDetails(objpr.id,objPU1.id);
         
     }

     @isTest
    private static void QuotationPageTest111() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
        objlglentity.Name = 'RS';
        objlglentity.RDS_Company_Code__c='rs';
        objlglentity.RDS_Service_Tax_No__c= '123456789012345';
        objlglentity.RDS_Company_Name__c='111';
        objlglentity.RDS_Address1__c='123';
        objlglentity.RDS_Address2__c='234';
        objlglentity.RDS_City__c='delhi';
        objlglentity.RDS_Pin_Code__c='201301';
        objlglentity.RDS_Phone__c='9953528045';
        objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
        
        Broker__c objBroK = new Broker__c();
        objBroK.Broker_Code__c = '12346';
        objBroK.Broker_Name__c = 'Brokname';
        objBroK.Status__c = 'Actives';
        objBroK=RDSCommon.CreateBroker(objBroK);
        
        Project__c objpr = new Project__c();
        objpr.Project_Code__c = 'T35';
        objpr.Name = 'TestProject';
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
        objpr.Discount1_Type__c = 'General';
        //objpr.Discount1_Effective_Till__c = system.today().addDays(100);
        objpr.Discount1_Per_Sq_Ft__c = 100;
        objpr.Discount2_Type__c = 'Armed Forces';
        objpr.Discount2_Per_Sq_Ft__c = 150;
        objpr.Discount3_Type__c = 'Corporate';
        objpr.Discount3_Per_Sq_Ft__c = 200;
        objpr.Discount4_Type__c = 'Employee';
        objpr.Discount4_Per_Sq_Ft__c = 250;
        objpr.Discount5_Type__c = 'NRI';
        objpr.Discount5_Per_Sq_Ft__c = 300;
        objpr.Discount6_Type__c = 'Physically Challenged';
        objpr.Discount6_Per_Sq_Ft__c = 350;
        objpr.Discount8_Description__c = 'summer offer';
        objpr.Discount8_Type__c = 'Special Offer';
        objpr.Discount8_Per_Sq_Ft__c = 1000;
        objpr.Discount9_Description__c = 'DAM';
        objpr.Discount9_Type__c = 'DAM';
        objpr.Discount9_Per_Sq_Ft__c = 2000;
        //objpr.Discount2_Effective_Till__c = system.today().addDays(100);
        objpr.Discount2_Lumpsum__c = 100000;
        objpr.Allotment_Charges_1__c = 10000;
        objpr.Allotment_Charges_2__c = 10000;
        objpr.Allotment_Charges_3__c = 10000;
        objpr.Allotment_Charges_4__c = 10000;
        objpr.Allotment_Charges_5__c = 10000;
        objpr=RDSCommon.CreateProject(objpr);
        
        Project_Unit_Type__c objProjectUnitType = new Project_Unit_Type__c();
        objProjectUnitType.name='ONE BHK';
        objProjectUnitType.RDS_Project__c =objpr.id;
        objProjectUnitType=RDSCommon.CreateProjectUnitType(objProjectUnitType);
        
        Tower__c t = new Tower__c();
        t.Name = 'Tower X';
        t.ProjectName__c = objpr.Id;
        t = RDSCommon.CreateTower(t);
        
        Tax_Slab__c taxS = new Tax_Slab__C();
         taxS.name = 'GST';
         taxS.From_Date__c = System.today().addDays(-10);
         taxS.Percentage__c = 4.20;
         taxS = RDSCommon.CreateTaxSlab(taxS);
         
         Tax_Breakup__c tb1 = new Tax_breakup__c();
         tb1.Taxable_Percentage__c = 66.66667;
         tb1.Tax_percentage__c = 9;
         tb1.tax_code__c = 'CGST';
         tb1.Tax_Name__c = 'CGST';
         tb1.Tax_Slab__c = taxS.id;
         tb1.Effective_from__c = system.today().addDays(-10);
         tb1.Tax_Split_Type__c = 'CGST';
         tb1.Tax_Type__c = 'Service tax';
         insert tb1;
         
         Tax_Breakup__c tb2 = new Tax_breakup__c();
         tb2.Taxable_Percentage__c = 66.66667;
         tb2.Tax_percentage__c = 9;
         tb2.tax_code__c = 'SGST';
         tb2.Tax_Name__c = 'SGST';
         tb2.Tax_Slab__c = taxS.id;
         tb2.Effective_from__c = system.today().addDays(-10);
         tb2.Tax_Split_Type__c = 'SGST';
         tb2.Tax_Type__c = 'Service tax';
         insert tb2;
         
         
         Tax_Slab__c taxS1 = new Tax_Slab__C();
         taxS1.name = 'GST-18';
         taxS1.From_Date__c = System.today().addDays(-10);
         taxS1.Percentage__c = 14;
         taxS1 = RDSCommon.CreateTaxSlab(taxS1);
         
           Tax_Breakup__c tb3 = new Tax_breakup__c();
         tb3.Taxable_Percentage__c = 100;
         tb3.Tax_percentage__c = 9;
         tb3.tax_code__c = 'CGST';
         tb3.Tax_Name__c = 'CGST';
         tb3.Tax_Slab__c = taxS1.id;
         tb3.Effective_from__c = system.today().addDays(-10);
         tb3.Tax_Split_Type__c = 'CGST';
         tb3.Tax_Type__c = 'Service tax';
         insert tb3;
         
         Tax_Breakup__c tb4 = new Tax_breakup__c();
         tb4.Taxable_Percentage__c = 100;
         tb4.Tax_percentage__c = 9;
         tb4.tax_code__c = 'SGST';
         tb4.Tax_Name__c = 'SGST';
         tb4.Tax_Slab__c = taxS1.id;
         tb4.Effective_from__c = system.today().addDays(-10);
         tb4.Tax_Split_Type__c = 'SGST';
         tb4.Tax_Type__c = 'Service tax';
         insert tb4; 
         
         Global_Charges__c ObjGloChrg = new Global_Charges__c();
         ObjGloChrg.Name = 'Basic';
         ObjGloChrg.Code__c = '011';
         ObjGloChrg.Description__c = 'Basic';
         ObjGloChrg.Sequence_No__c = 99;
         ObjGloChrg.Charge_Type__c = 'Basic';
         ObjGloChrg.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
         
         Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
         ObjGloChrg1.Name = 'Club Membership';
         ObjGloChrg1.Code__c = '012';
         ObjGloChrg1.Description__c = 'Club Membership';
         ObjGloChrg1.Sequence_No__c = 100;
         ObjGloChrg1.Charge_Type__c = 'Society Charges';
         ObjGloChrg1.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg1=RDSCommon.CreateGlobalCharges(ObjGloChrg1);
         
         Global_Charges__c ObjGloChrg2 = new Global_Charges__c();
         ObjGloChrg2.Name = 'Tax Charge';
         ObjGloChrg2.Code__c = '015';
         ObjGloChrg2.Description__c = 'SERVICE TAX';
         ObjGloChrg2.Sequence_No__c = 105;
         ObjGloChrg2.Charge_Type__c = 'Tax';
         ObjGloChrg2.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg2=RDSCommon.CreateGlobalCharges(ObjGloChrg2);
         
         /*Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
         ObjGloChrg3.Name = 'MVAT';
         ObjGloChrg3.Code__c = '016';
         ObjGloChrg3.Description__c = 'MVAT';
         ObjGloChrg3.Sequence_No__c = 106;
         ObjGloChrg3.Charge_Type__c = 'Debotors';
         ObjGloChrg3.Nature_of_Charge__c = 'Debotors';
         ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);*/
         
         Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
         ObjGloChrg4.Name = 'Registration Charges';
         ObjGloChrg4.Code__c = '017';
         ObjGloChrg4.Description__c = 'Registration Charges';
         ObjGloChrg4.Sequence_No__c = 107;
         ObjGloChrg4.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
         
         Global_Charges__c ObjGloChrg7 = new Global_Charges__c();
         ObjGloChrg7.Name = 'Development Charges';
         ObjGloChrg7.Code__c = '020';
         ObjGloChrg7.Description__c = 'Development Charges';
         ObjGloChrg7.Sequence_No__c = 110;
         ObjGloChrg7.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg7.Short_Name__c = 'DEVELOP';
         ObjGloChrg7=RDSCommon.CreateGlobalCharges(ObjGloChrg7);
         
         Global_Charges__c ObjGloChrg8 = new Global_Charges__c();
         ObjGloChrg8.Name = 'Infrastructure Charges';
         ObjGloChrg8.Code__c = '021';
         ObjGloChrg8.Description__c = 'Infrastructure Charges';
         ObjGloChrg8.Sequence_No__c = 111;
         ObjGloChrg8.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg8.Short_Name__c = 'INFRA';
         ObjGloChrg8=RDSCommon.CreateGlobalCharges(ObjGloChrg8);
         
         Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
         ObjGloChrg5.Name = 'Floor Rise';
         ObjGloChrg5.Code__c = '018';
         ObjGloChrg5.Description__c = 'Floor Rise';
         ObjGloChrg5.Sequence_No__c = 108;
         ObjGloChrg5.Charge_Type__c = 'Debtors';
         ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
         
         Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
         ObjGloChrg6.Name = 'Premium 1';
         ObjGloChrg6.Code__c = '019';
         ObjGloChrg6.Description__c = 'Premium 1';
         ObjGloChrg6.Sequence_No__c = 109;
         ObjGloChrg6.Charge_Type__c = 'Debtors';
         ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
         
         Project_Charges__c PCharge = new Project_Charges__c();
         PCharge.Charge_Code__c = ObjGloChrg.Id;
         PCharge.Project__c = objpr.Id;
         PCharge.Name = 'Basic';
         PCharge.Active__c = true;
         PCharge.Applied_This_Charge_To_FA__c = true;
         PCharge.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge.S_Charge_Bucket__c = 'Agreement Value';
         PCharge.S_Payable_At__c = 'As per payment milestone';
         PCharge.Payment_Plan_Applicable__c = true;
         pCharge.Service_Tax_Percentage__c = 'GST';
         pCharge.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge=RDSCommon.CreateProjectCharges(PCharge);
         
         Project_Charges__c PCharge1 = new Project_Charges__c();
         PCharge1.Charge_Code__c = ObjGloChrg1.Id;
         PCharge1.Project__c = objpr.Id;
         PCharge1.Name = 'Club Membership';
         PCharge1.Active__c = true;
         PCharge1.Applied_This_Charge_To_FA__c = true;
         PCharge1.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge1.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge1.S_Charge_Bucket__c = 'Other Charges';
         PCharge1.S_Payable_At__c = 'At Possession';
         PCharge1.Payment_Plan_Applicable__c = true;
         PCharge1.Service_Tax_Percentage__c = 'GST-18';
         PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
         
         /*Project_Charges__c PCharge2 = new Project_Charges__c();
         PCharge2.Charge_Code__c = ObjGloChrg3.Id;
         PCharge2.Project__c = objpr.Id;
         PCharge2.Name = 'MVAT';
         PCharge2.Active__c = false;
         PCharge2.Applied_This_Charge_To_FA__c = true;
         PCharge2.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge2.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge2.S_Payable_At__c = 'At Regsistration';
         PCharge2.S_Charge_Percentage__c = 1;
         PCharge2.Payment_Plan_Applicable__c = false;
         PCharge2=RDSCommon.CreateProjectCharges(PCharge2);*/
         
         Project_Charges__c PCharge3 = new Project_Charges__c();
         PCharge3.Charge_Code__c = ObjGloChrg4.Id;
         PCharge3.Project__c = objpr.Id;
         PCharge3.Name = 'Registration Charges';
         PCharge3.Active__c = false;
         PCharge3.Applied_This_Charge_To_FA__c = true;
         PCharge3.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge3.S_Charge_Percentage__c = 1;
         PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge3.S_Payable_At__c = 'At Registration';
         PCharge3.Payment_Plan_Applicable__c = false;
         PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
         
         Project_Charges__c PCharge6 = new Project_Charges__c();
         PCharge6.Charge_Code__c = ObjGloChrg7.Id;
         PCharge6.Project__c = objpr.Id;
         PCharge6.Name = 'Development Charges';
         PCharge6.Active__c = true;
         PCharge6.Applied_This_Charge_To_FA__c = true;
         PCharge6.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge6.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge6.Interest_Applicable_on_this_charge__c = true;
         PCharge6.S_Charge_Bucket__c = 'Agreement Value';
         PCharge6.S_Payable_At__c = 'As per payment milestone';
         PCharge6.Remarks__c = 'Development Charges';
         PCharge6.Service_Tax_Percentage__c = 'GST';
         PCharge6.Payment_Plan_Applicable__c = false;
         PCharge6=RDSCommon.CreateProjectCharges(PCharge6);
         
         Project_Charges__c PCharge7 = new Project_Charges__c();
         PCharge7.Charge_Code__c = ObjGloChrg8.Id;
         PCharge7.Project__c = objpr.Id;
         PCharge7.Name = 'Infrastructure Charges';
         PCharge7.Active__c = true;
         PCharge7.Applied_This_Charge_To_FA__c = true;
         PCharge7.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge7.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge7.Interest_Applicable_on_this_charge__c = true;
         PCharge7.S_Charge_Bucket__c = 'Agreement Value';
         PCharge7.S_Payable_At__c = 'As per payment milestone';
         PCharge7.Remarks__c = 'Infrastructure Charges';
         PCharge7.Service_Tax_Percentage__c = 'GST';
         PCharge7.Payment_Plan_Applicable__c = false;
         PCharge7=RDSCommon.CreateProjectCharges(PCharge7);
         
         Project_Charges__c PCharge4 = new Project_Charges__c();
         PCharge4.Charge_Code__c = ObjGloChrg5.Id;
         PCharge4.Project__c = objpr.Id;
         PCharge4.Name = 'Floor Rise';
         PCharge4.Active__c = true;
         PCharge4.Applied_This_Charge_To_FA__c = true;
         PCharge4.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge4.S_Charge_Bucket__c = 'Agreement Value';
         PCharge4.S_Payable_At__c = 'As per payment milestone';
         PCharge4.Payment_Plan_Applicable__c = false;
         PCharge4.Service_Tax_Percentage__c = 'GST';
         PCharge4.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
         
         Project_Charges__c PCharge5 = new Project_Charges__c();
         PCharge5.Charge_Code__c = ObjGloChrg6.Id;
         PCharge5.Project__c = objpr.Id;
         PCharge5.Name = 'Premium 1';
         PCharge5.Active__c = true;
         PCharge5.Applied_This_Charge_To_FA__c = true;
         PCharge5.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge5.S_Charge_Bucket__c = 'Agreement Value';
         PCharge5.S_Payable_At__c = 'As per payment milestone';
         PCharge5.Payment_Plan_Applicable__c = false;
         PCharge5.Service_Tax_Percentage__c = 'GST';
         PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
         
         Project_Unit__c objPU1 = new Project_Unit__c();    
         objPU1.Name = 'TestFive';      
         objPU1.Project__c = objpr.Id;
         objPU1.Project_Unit_Type__c=objProjectUnitType.id;
         objPU1.Param1__c = '5';
         objPU1.UnitNo__c ='TestFive';
         objPU1.Unit_status__c='Booked';
         objPU1.Actual_Area_value__c = 2218;
         objPU1.Floor__c = 8;
         objPU1.TowerName__c = t.Id;
         objPU1.Single_car_park_Earmarked__c = 0;
         objPU1.Single_Open_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Tandem_car_park_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Stack__c = 0;
         
         objPU1.Discount1_Type__c = 'General';
         objPU1.Discount1_Per_Sq_Ft__c = 100;
         objPU1.Discount2_Type__c = 'Armed Forces';
         objPU1.Discount2_Per_Sq_Ft__c = 200;
         objPU1.Discount3_Type__c = 'Corporate';
         objPU1.Discount3_Per_Sq_Ft__c = 250;
         objPU1.Discount4_Type__c = 'Physically Challenged';
         objPU1.Discount4_Per_Sq_Ft__c = 300;
         
         objPU1.Discount8_Type__c = 'Special Offer';
         objPU1.Discount8_Per_Sq_Ft__c = 300;
         objPU1.Discount8_Description__c = 'Summer Offer';
         objPU1.Discount9_Type__c = 'DAM';
         objPU1.Discount9_Per_Sq_Ft__c = 350;
         objPU1.Discount9_Description__c = 'DAM';
         objPU1=RDSCommon.CreateProjectUnit(objPU1);
         
         Account objac = new Account();
         objac.FirstName = 'Shock';
         objac.LastName = 'Wave';
         objac.Project__c = objpr.Id;
         objac.Correspondence_Address__c = 'Delhi';
         objac.Category__c = 'General';
         objac.Unit__c = objPU1.Id;
         objac=RDSCommon.CreateAccount(objac);
         
         Opportunity objOpportunity = new Opportunity();
         objOpportunity.Name = 'Test';
         objOpportunity.CloseDate = System.today();
         objOpportunity.AccountId = objac.Id; 
         objOpportunity.Status__c = 'Active'; 
         objOpportunity.StageName = 'Opportunity Identified'; 
         objOpportunity.Project__c = objpr.Id; 
         objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
         
         Project_Construction_Stages__c objPCS = new Project_Construction_Stages__c();
         objPCS.Project__c = objpr.Id;
         objPCS.Name = 'Commencement of Raft/Foundation';
         objPCS.Code__c ='Test';
         objPCS.Description__c='Commencement of Raft/Foundation';
         objPCS.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS.Tower__c = t.Id;
         insert objPCS;
         
         Project_Construction_Stages__c objPCS1 = new Project_Construction_Stages__c();
         objPCS1.Project__c = objpr.Id;
         objPCS1.Name = 'At Fit Out Possession';
         objPCS1.Code__c ='Test1';
         objPCS1.Description__c='At Fit Out Possession';
         objPCS1.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS1.Tower__c = t.Id;
         insert objPCS1;
         
         // rateList creation
         Rate_List_Header__c objRlh = new Rate_List_Header__c();
         objRlh.Name = 'Basic RL Header';
         objRlh.Project__c = objpr.Id;
         objRlh.Project_Charges__c = PCharge.Id;
         objRlh.Rate_list__c = 'All Charges';
         objRlh.Effective_From__c = system.today().addDays(-3);
         objRlh=RDSCommon.CreateRateListHeader(objRlh);
         
         Rate_List_Detail__c objRld = new Rate_List_Detail__c();
         objRld.Name = 'Basic RL Detail';
         objRld.Charge_Based_On__c = 'Rate';
         objRld.Percent__c = 23600;
         objRld.Project__c = objpr.Id;
         objRld.Rate_List_Header__c = objRlh.id;
         objRld = RDSCommon.CreateRateListHeader(objRld);
         
         Rate_List__c objRL = new Rate_List__c();
         objRL.Rate_List_HeaderID__c = objRlh.Id;
         objRL.Project__c = objpr.Id;
         objRL.Global_Charges__c = ObjGloChrg.Id;
         objRL.Project_Charges__c = PCharge.Id;
         objRL.Project_Unit__c = objPU1.Id;
         objRL.Value__c = 2218;
         objRL.Rate__c = 23600;
         objRL.Charge_Based_On_Master__c = 'Rate';
         objRL.Charge_on_Area_Type__c = 'Saleable Area';
         objRL.Rate_List_Detail__c = objRLd.id;
         objRL=RDSCommon.CreateRateList(objRL);
         
         Rate_List__c objRL1 = new Rate_List__c();
         objRL1.Project__c = objpr.Id;
         objRL1.Global_Charges__c = ObjGloChrg5.Id;
         objRL1.Project_Charges__c = PCharge4.Id;
         objRL1.Project_Unit__c = objPU1.Id;
         objRL1.Value__c = 2218;
         objRL1.Rate__c = 100;
         objRL1.Charge_Based_On_Master__c = 'Rate';
         objRL1.Charge_on_Area_Type__c = 'Saleable Area';
         objRL1.Rate_List_Detail__c = objRLd.id;
         objRL1=RDSCommon.CreateRateList(objRL1);
         
         Rate_List__c objRL2 = new Rate_List__c();
         objRL2.Project__c = objpr.Id;
         objRL2.Global_Charges__c = ObjGloChrg6.Id;
         objRL2.Project_Charges__c = PCharge5.Id;
         objRL2.Project_Unit__c = objPU1.Id;
         objRL2.Value__c = 2218;
         objRL2.Rate__c = 200;
         objRL2.Charge_Based_On_Master__c = 'Rate';
         objRL2.Charge_on_Area_Type__c = 'Saleable Area';
         objRL2.Rate_List_Detail__c = objRLd.id;
         objRL2=RDSCommon.CreateRateList(objRL2);
         
         Rate_List__c objRL3 = new Rate_List__c();
         objRL3.Project__c = objpr.Id;
         objRL3.Global_Charges__c = ObjGloChrg7.Id;
         objRL3.Project_Charges__c = PCharge6.Id;
         objRL3.Project_Unit__c = objPU1.Id;
         objRL3.Rate__c = 190;
         objRL3.Charge_Based_On_Master__c = 'Rate';
         objRL3.Charge_on_Area_Type__c = 'Saleable Area';
         objRL3=RDSCommon.CreateRateList(objRL3);
         
         Rate_List__c objRL4 = new Rate_List__c();
         objRL4.Project__c = objpr.Id;
         objRL4.Global_Charges__c = ObjGloChrg8.Id;
         objRL4.Project_Charges__c = PCharge7.Id;
         objRL4.Project_Unit__c = objPU1.Id;
         objRL4.Rate__c = 210;
         objRL4.Charge_Based_On_Master__c = 'Rate';
         objRL4.Charge_on_Area_Type__c = 'Saleable Area';
         objRL4=RDSCommon.CreateRateList(objRL4);
         
         Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
         objPaymentPlan.Name ='Pay Plan 1';
         objPaymentPlan.Project__c = objpr .Id;
         objPaymentPlan.Tower__c = t.Id;
         objPaymentPlan.Sub_Vention__c = true;
         objPaymentPlan.Subvention_Base_Rate__c = 50;
         objPaymentPlan.No_GST_on_Token__c = true;
         insert objPaymentPlan;
         
         Standard_Pay_Plan_Header__c objSPP = new Standard_Pay_Plan_Header__c();
         objSPP.Project__c = objpr.Id;
         objSPP.Charge_Code__c= PCharge.Id;
         objSPP.Payment_Plan__c=objPaymentPlan.id;
         objSPP.Name='Basic Header';
         objSPP.Plan_Code__c= '89';
         objSPP.tower__c = t.ID;
         objSPP.Effective_from__c = System.today();
         objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
         
         Standard_Pay_Plan_Header__c objSPP1 = new Standard_Pay_Plan_Header__c();
         objSPP1.Project__c = objpr.Id;
         objSPP1.tower__c = t.ID;
         objSPP1.Charge_Code__c= PCharge1.Id;
         objSPP1.Payment_Plan__c=objPaymentPlan.id;
         objSPP1.Name='Club Header';
         objSPP1.Plan_Code__c= '90';
         objSPP1.Effective_from__c = System.today();
         objSPP1=RDSCommon.CreateStandardPayPlanHeader(objSPP1);
         
         // standard payment plan details creation for basic 
         // created 4 installments/milestones. two due date based and 2 Construction Linked
         Standard_Customer_Pay_Plan_Detail__c    objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD.Project__c=objpr.id;
         objSPPD.tower__c = t.ID;
         objSPPD.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD.Days_Months__c='Day(s)';
         objSPPD.Days_Months_Value__c=5;
         objSPPD.Amount__c='Amount';
         objSPPD.Amount_Value__c=110000;
         objSPPD.Installment__c = 100;
         objSPPD= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD);
         
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD4 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD4.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD4.Project__c=objpr.id;
         objSPPD4.tower__c = t.ID;
         objSPPD4.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD4.Days_Months__c='Day(s)';
         objSPPD4.Days_Months_Value__c=0;
         objSPPD4.Amount__c='Amount';
         objSPPD4.Calculate_Installment_Amount_as__c=10;
         objSPPD4.Total_Charge_Value_Minus__c = 110000;
         objSPPD4= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD4);
         
          Standard_Customer_Pay_Plan_Detail__c    objSPPD2 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD2.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD2.Project__c=objpr.id;
         objSPPD2.tower__c = t.ID;
         objSPPD2.Is_to_be_Paid__c='Construction Stage';
         objSPPD2.Days_Months__c='Day(s)';
         objSPPD2.Project_Construction_Stages__c=objPCS.id;
         objSPPD2.Days_Months_Value__c=5;
         objSPPD2.Amount__c='Percentage';
         objSPPD2.Amount_Value__c=40;
         objSPPD2.Installment__c = 102;
         objSPPD2= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD2);
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD3 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD3.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD3.Project__c=objpr.id;
         objSPPD3.tower__c = t.ID;
         objSPPD3.Is_to_be_Paid__c='Construction Stage';
         objSPPD3.Days_Months__c='Day(s)';
         objSPPD3.Project_Construction_Stages__c=objPCS1.id;
         objSPPD3.Days_Months_Value__c=5;
         objSPPD3.Amount__c='Percentage';
         objSPPD3.Amount_Value__c=50;
         objSPPD3.Installment__c = 103;
         objSPPD3= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD3);
         
         // detail record for club member ship charges
         // collected 100% in a single installment on fit out possession
         Standard_Customer_Pay_Plan_Detail__c    objSPPD5 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD5.Standard_Pay_Plan_Header__c = objSPP1.id;
         objSPPD5.Project__c=objpr.id;
         objSPPD5.tower__c = t.ID;
         objSPPD5.Is_to_be_Paid__c='Construction Stage';
         objSPPD5.Days_Months__c='Day(s)';
         objSPPD5.Project_Construction_Stages__c=objPCS1.id;
         objSPPD5.Days_Months_Value__c=5;
         objSPPD5.Amount__c='Percentage';
         objSPPD5.Amount_Value__c=100;
         objSPPD5.Installment__c = 100;
         objSPPD5= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD5);
         
         Team__c objTeam = new Team__c();
         objTeam.Name = 'Sales Approvers Team';
         objTeam.Project__c = objpr.id;
         objTeam.Team_Type__c = 'Sales Approvers Team';
         objTeam.Tower__c = t.id;
         insert objTeam;
         
         Car_Parking_Charge__c cp = new Car_Parking_Charge__c();
         cp.Project__c = objpr.id;
         cp.Category__c = 'Additional';
         cp.Status__c = 'Vacant';
         cp.Parking__c = 'single Open';
         insert cp; 
         
         //create users
         User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
         User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
         User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
         
         // insert team as team members
         Team_Members__c tm1 = new Team_Members__c();
         tm1.Team__c = objTeam.Id;
         tm1.User_Active__c = true;
         tm1.Approver_Type__c = 'First Level';
         tm1.User__c = a1.id;
         insert tm1;
         
         Team_Members__c tm2 = new Team_Members__c();
         tm2.Team__c = objTeam.Id;
         tm2.User_Active__c = true;
         tm2.Approver_Type__c = 'Second Level';
         tm2.User__c = a2.id;
         insert tm2;
         
         Team_Members__c tm3 = new Team_Members__c();
         tm3.Team__c = objTeam.Id;
         tm3.User_Active__c = true;
         tm3.Approver_Type__c = 'Third Level';
         tm3.User__c = a3.id;
         insert tm3;
         
         Test.startTest();
         PageReference pRef2 = Page.Quotation2;
         Test.setCurrentPage(pRef2);
         //put the necessary query string params
         ApexPages.currentPage().getParameters().put('oppId',objOpportunity.id);
         ApexPages.currentPage().getParameters().put('id', objPU1.id);
         ApexPages.currentPage().getParameters().put('subPlanId', objPaymentPlan.id);
         QuotationExtn qExNew = new QuotationExtn();
         qExNew.QueryPlanDetails();
         qExNew.q.Single_Open_Additional__c = 1;
         qExNew.addCarPark();
         qExNew.rowNumber = 1;
         qExNew.addType = 'new';
         qExNew.rowModify();
         qExNew.rowNumber = 1;
         qExNew.addType = 'clone';
         qExNew.rowModify();
         qExNew.rowNumber = 3;
         qExNew.addType = 'remove';
         qExNew.rowModify();
         qExNew.rowNumber = 2;
         qExNew.addType = 'remove';
         qExNew.rowModify();
         qExNew.updatePaymentSchedule();
         qExNew.savePaymentSchedule();
         qExNew.cancelEdit();
         qExNew.openDiscountPage();
         qExNew.backtoQuotePage();
         qExNew.clearDiscount();
         qExNew.getOldBaseRate();
         qExNew.reloadURL();
         //qExNew.savePrint();
         /*qExNew.baseRate = 1110.0;
         qExNew.discountVal = 100000;
         qExNew.changeBaseRate();*/
         Test.stopTest();
     
     }
     
     @isTest
    private static void QuotationPageTest222() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
        objlglentity.Name = 'RS';
        objlglentity.RDS_Company_Code__c='rs';
        objlglentity.RDS_Service_Tax_No__c= '123456789012345';
        objlglentity.RDS_Company_Name__c='111';
        objlglentity.RDS_Address1__c='123';
        objlglentity.RDS_Address2__c='234';
        objlglentity.RDS_City__c='delhi';
        objlglentity.RDS_Pin_Code__c='201301';
        objlglentity.RDS_Phone__c='9953528045';
        objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
        
        Broker__c objBroK = new Broker__c();
        objBroK.Broker_Code__c = '12346';
        objBroK.Broker_Name__c = 'Brokname';
        objBroK.Status__c = 'Actives';
        objBroK=RDSCommon.CreateBroker(objBroK);
        
        Project__c objpr = new Project__c();
        objpr.Project_Code__c = 'T35';
        objpr.Name = 'TestProject';
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
        objpr.Discount1_Type__c = 'General';
        //objpr.Discount1_Effective_Till__c = system.today().addDays(100);
        objpr.Discount1_Per_Sq_Ft__c = 100;
        objpr.Discount2_Type__c = 'Armed Forces';
        objpr.Discount2_Per_Sq_Ft__c = 150;
        objpr.Discount3_Type__c = 'Corporate';
        objpr.Discount3_Per_Sq_Ft__c = 200;
        objpr.Discount4_Type__c = 'Employee';
        objpr.Discount4_Per_Sq_Ft__c = 250;
        objpr.Discount5_Type__c = 'NRI';
        objpr.Discount5_Per_Sq_Ft__c = 300;
        objpr.Discount6_Type__c = 'Physically Challenged';
        objpr.Discount6_Per_Sq_Ft__c = 350;
        objpr.Discount8_Description__c = 'summer offer';
        objpr.Discount8_Type__c = 'Special Offer';
        objpr.Discount8_Per_Sq_Ft__c = 1000;
        objpr.Discount9_Description__c = 'DAM';
        objpr.Discount9_Type__c = 'DAM';
        objpr.Discount9_Per_Sq_Ft__c = 2000;
        //objpr.Discount2_Effective_Till__c = system.today().addDays(100);
        objpr.Discount2_Lumpsum__c = 100000;
        objpr.Allotment_Charges_1__c = 10000;
        objpr.Allotment_Charges_2__c = 10000;
        objpr.Allotment_Charges_3__c = 10000;
        objpr.Allotment_Charges_4__c = 10000;
        objpr.Allotment_Charges_5__c = 10000;
        objpr=RDSCommon.CreateProject(objpr);
        
        Project_Unit_Type__c objProjectUnitType = new Project_Unit_Type__c();
        objProjectUnitType.name='ONE BHK';
        objProjectUnitType.RDS_Project__c =objpr.id;
        objProjectUnitType=RDSCommon.CreateProjectUnitType(objProjectUnitType);
        
        Tower__c t = new Tower__c();
        t.Name = 'Tower X';
        t.ProjectName__c = objpr.Id;
        t = RDSCommon.CreateTower(t);
        
        Tax_Slab__c taxS = new Tax_Slab__C();
         taxS.name = 'GST';
         taxS.From_Date__c = System.today().addDays(-10);
         taxS.Percentage__c = 4.20;
         taxS = RDSCommon.CreateTaxSlab(taxS);
         
         Tax_Breakup__c tb1 = new Tax_breakup__c();
         tb1.Taxable_Percentage__c = 66.66667;
         tb1.Tax_percentage__c = 9;
         tb1.tax_code__c = 'CGST';
         tb1.Tax_Name__c = 'CGST';
         tb1.Tax_Slab__c = taxS.id;
         tb1.Effective_from__c = system.today().addDays(-10);
         tb1.Tax_Split_Type__c = 'CGST';
         tb1.Tax_Type__c = 'Service tax';
         insert tb1;
         
         Tax_Breakup__c tb2 = new Tax_breakup__c();
         tb2.Taxable_Percentage__c = 66.66667;
         tb2.Tax_percentage__c = 9;
         tb2.tax_code__c = 'SGST';
         tb2.Tax_Name__c = 'SGST';
         tb2.Tax_Slab__c = taxS.id;
         tb2.Effective_from__c = system.today().addDays(-10);
         tb2.Tax_Split_Type__c = 'SGST';
         tb2.Tax_Type__c = 'Service tax';
         insert tb2;
         
         
         Tax_Slab__c taxS1 = new Tax_Slab__C();
         taxS1.name = 'GST-18';
         taxS1.From_Date__c = System.today().addDays(-10);
         taxS1.Percentage__c = 14;
         taxS1 = RDSCommon.CreateTaxSlab(taxS1);
         
           Tax_Breakup__c tb3 = new Tax_breakup__c();
         tb3.Taxable_Percentage__c = 100;
         tb3.Tax_percentage__c = 9;
         tb3.tax_code__c = 'CGST';
         tb3.Tax_Name__c = 'CGST';
         tb3.Tax_Slab__c = taxS1.id;
         tb3.Effective_from__c = system.today().addDays(-10);
         tb3.Tax_Split_Type__c = 'CGST';
         tb3.Tax_Type__c = 'Service tax';
         insert tb3;
         
         Tax_Breakup__c tb4 = new Tax_breakup__c();
         tb4.Taxable_Percentage__c = 100;
         tb4.Tax_percentage__c = 9;
         tb4.tax_code__c = 'SGST';
         tb4.Tax_Name__c = 'SGST';
         tb4.Tax_Slab__c = taxS1.id;
         tb4.Effective_from__c = system.today().addDays(-10);
         tb4.Tax_Split_Type__c = 'SGST';
         tb4.Tax_Type__c = 'Service tax';
         insert tb4; 
         
         Global_Charges__c ObjGloChrg = new Global_Charges__c();
         ObjGloChrg.Name = 'Basic';
         ObjGloChrg.Code__c = '011';
         ObjGloChrg.Description__c = 'Basic';
         ObjGloChrg.Sequence_No__c = 99;
         ObjGloChrg.Charge_Type__c = 'Basic';
         ObjGloChrg.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
         
         Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
         ObjGloChrg1.Name = 'Club Membership';
         ObjGloChrg1.Code__c = '012';
         ObjGloChrg1.Description__c = 'Club Membership';
         ObjGloChrg1.Sequence_No__c = 100;
         ObjGloChrg1.Charge_Type__c = 'Society Charges';
         ObjGloChrg1.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg1=RDSCommon.CreateGlobalCharges(ObjGloChrg1);
         
         Global_Charges__c ObjGloChrg2 = new Global_Charges__c();
         ObjGloChrg2.Name = 'Tax Charge';
         ObjGloChrg2.Code__c = '015';
         ObjGloChrg2.Description__c = 'SERVICE TAX';
         ObjGloChrg2.Sequence_No__c = 105;
         ObjGloChrg2.Charge_Type__c = 'Tax';
         ObjGloChrg2.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg2=RDSCommon.CreateGlobalCharges(ObjGloChrg2);
         
         /*Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
         ObjGloChrg3.Name = 'MVAT';
         ObjGloChrg3.Code__c = '016';
         ObjGloChrg3.Description__c = 'MVAT';
         ObjGloChrg3.Sequence_No__c = 106;
         ObjGloChrg3.Charge_Type__c = 'Debotors';
         ObjGloChrg3.Nature_of_Charge__c = 'Debotors';
         ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);*/
         
         Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
         ObjGloChrg4.Name = 'Registration Charges';
         ObjGloChrg4.Code__c = '017';
         ObjGloChrg4.Description__c = 'Registration Charges';
         ObjGloChrg4.Sequence_No__c = 107;
         ObjGloChrg4.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
         
         Global_Charges__c ObjGloChrg7 = new Global_Charges__c();
         ObjGloChrg7.Name = 'Development Charges';
         ObjGloChrg7.Code__c = '020';
         ObjGloChrg7.Description__c = 'Development Charges';
         ObjGloChrg7.Sequence_No__c = 110;
         ObjGloChrg7.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg7.Short_Name__c = 'DEVELOP';
         ObjGloChrg7=RDSCommon.CreateGlobalCharges(ObjGloChrg7);
         
         Global_Charges__c ObjGloChrg8 = new Global_Charges__c();
         ObjGloChrg8.Name = 'Infrastructure Charges';
         ObjGloChrg8.Code__c = '021';
         ObjGloChrg8.Description__c = 'Infrastructure Charges';
         ObjGloChrg8.Sequence_No__c = 111;
         ObjGloChrg8.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg8.Short_Name__c = 'INFRA';
         ObjGloChrg8=RDSCommon.CreateGlobalCharges(ObjGloChrg8);
         
         Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
         ObjGloChrg5.Name = 'Floor Rise';
         ObjGloChrg5.Code__c = '018';
         ObjGloChrg5.Description__c = 'Floor Rise';
         ObjGloChrg5.Sequence_No__c = 108;
         ObjGloChrg5.Charge_Type__c = 'Debtors';
         ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
         
         Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
         ObjGloChrg6.Name = 'Premium 1';
         ObjGloChrg6.Code__c = '019';
         ObjGloChrg6.Description__c = 'Premium 1';
         ObjGloChrg6.Sequence_No__c = 109;
         ObjGloChrg6.Charge_Type__c = 'Debtors';
         ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
         
         Project_Charges__c PCharge = new Project_Charges__c();
         PCharge.Charge_Code__c = ObjGloChrg.Id;
         PCharge.Project__c = objpr.Id;
         PCharge.Name = 'Basic';
         PCharge.Active__c = true;
         PCharge.Applied_This_Charge_To_FA__c = true;
         PCharge.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge.S_Charge_Bucket__c = 'Agreement Value';
         PCharge.S_Payable_At__c = 'As per payment milestone';
         PCharge.Payment_Plan_Applicable__c = true;
         pCharge.Service_Tax_Percentage__c = 'GST';
         pCharge.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge=RDSCommon.CreateProjectCharges(PCharge);
         
         Project_Charges__c PCharge1 = new Project_Charges__c();
         PCharge1.Charge_Code__c = ObjGloChrg1.Id;
         PCharge1.Project__c = objpr.Id;
         PCharge1.Name = 'Club Membership';
         PCharge1.Active__c = true;
         PCharge1.Applied_This_Charge_To_FA__c = true;
         PCharge1.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge1.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge1.S_Charge_Bucket__c = 'Other Charges';
         PCharge1.S_Payable_At__c = 'At Possession';
         PCharge1.Payment_Plan_Applicable__c = true;
         PCharge1.Service_Tax_Percentage__c = 'GST-18';
         PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
         
         
         Project_Charges__c PCharge3 = new Project_Charges__c();
         PCharge3.Charge_Code__c = ObjGloChrg4.Id;
         PCharge3.Project__c = objpr.Id;
         PCharge3.Name = 'Registration Charges';
         PCharge3.Active__c = false;
         PCharge3.Applied_This_Charge_To_FA__c = true;
         PCharge3.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge3.S_Charge_Percentage__c = 1;
         PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge3.S_Payable_At__c = 'At Registration';
         PCharge3.Payment_Plan_Applicable__c = false;
         PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
         
         Project_Charges__c PCharge6 = new Project_Charges__c();
         PCharge6.Charge_Code__c = ObjGloChrg7.Id;
         PCharge6.Project__c = objpr.Id;
         PCharge6.Name = 'Development Charges';
         PCharge6.Active__c = true;
         PCharge6.Applied_This_Charge_To_FA__c = true;
         PCharge6.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge6.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge6.Interest_Applicable_on_this_charge__c = true;
         PCharge6.S_Charge_Bucket__c = 'Agreement Value';
         PCharge6.S_Payable_At__c = 'As per payment milestone';
         PCharge6.Remarks__c = 'Development Charges';
         PCharge6.Service_Tax_Percentage__c = 'GST';
         PCharge6.Payment_Plan_Applicable__c = false;
         PCharge6=RDSCommon.CreateProjectCharges(PCharge6);
         
         Project_Charges__c PCharge7 = new Project_Charges__c();
         PCharge7.Charge_Code__c = ObjGloChrg8.Id;
         PCharge7.Project__c = objpr.Id;
         PCharge7.Name = 'Infrastructure Charges';
         PCharge7.Active__c = true;
         PCharge7.Applied_This_Charge_To_FA__c = true;
         PCharge7.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge7.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge7.Interest_Applicable_on_this_charge__c = true;
         PCharge7.S_Charge_Bucket__c = 'Agreement Value';
         PCharge7.S_Payable_At__c = 'As per payment milestone';
         PCharge7.Remarks__c = 'Infrastructure Charges';
         PCharge7.Service_Tax_Percentage__c = 'GST';
         PCharge7.Payment_Plan_Applicable__c = false;
         PCharge7=RDSCommon.CreateProjectCharges(PCharge7);
         
         Project_Charges__c PCharge4 = new Project_Charges__c();
         PCharge4.Charge_Code__c = ObjGloChrg5.Id;
         PCharge4.Project__c = objpr.Id;
         PCharge4.Name = 'Floor Rise';
         PCharge4.Active__c = true;
         PCharge4.Applied_This_Charge_To_FA__c = true;
         PCharge4.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge4.S_Charge_Bucket__c = 'Agreement Value';
         PCharge4.S_Payable_At__c = 'As per payment milestone';
         PCharge4.Payment_Plan_Applicable__c = false;
         PCharge4.Service_Tax_Percentage__c = 'GST';
         PCharge4.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
         
         Project_Charges__c PCharge5 = new Project_Charges__c();
         PCharge5.Charge_Code__c = ObjGloChrg6.Id;
         PCharge5.Project__c = objpr.Id;
         PCharge5.Name = 'Premium 1';
         PCharge5.Active__c = true;
         PCharge5.Applied_This_Charge_To_FA__c = true;
         PCharge5.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge5.S_Charge_Bucket__c = 'Agreement Value';
         PCharge5.S_Payable_At__c = 'As per payment milestone';
         PCharge5.Payment_Plan_Applicable__c = false;
         PCharge5.Service_Tax_Percentage__c = 'GST';
         PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
         
         Project_Unit__c objPU1 = new Project_Unit__c();    
         objPU1.Name = 'TestFive';      
         objPU1.Project__c = objpr.Id;
         objPU1.Project_Unit_Type__c=objProjectUnitType.id;
         objPU1.Param1__c = '5';
         objPU1.UnitNo__c ='TestFive';
         objPU1.Unit_status__c='Booked';
         objPU1.Actual_Area_value__c = 2218;
         objPU1.Floor__c = 8;
         objPU1.TowerName__c = t.Id;
         objPU1.Single_car_park_Earmarked__c = 0;
         objPU1.Single_Open_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Tandem_car_park_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Stack__c = 0;
         
         objPU1.Discount1_Type__c = 'General';
         objPU1.Discount1_Per_Sq_Ft__c = 100;
         objPU1.Discount2_Type__c = 'Armed Forces';
         objPU1.Discount2_Per_Sq_Ft__c = 200;
         objPU1.Discount3_Type__c = 'Corporate';
         objPU1.Discount3_Per_Sq_Ft__c = 250;
         objPU1.Discount4_Type__c = 'Physically Challenged';
         objPU1.Discount4_Per_Sq_Ft__c = 300;
         
         objPU1.Discount8_Type__c = 'Special Offer';
         objPU1.Discount8_Per_Sq_Ft__c = 300;
         objPU1.Discount8_Description__c = 'Summer Offer';
         objPU1.Discount9_Type__c = 'DAM';
         objPU1.Discount9_Per_Sq_Ft__c = 350;
         objPU1.Discount9_Description__c = 'DAM';
         objPU1=RDSCommon.CreateProjectUnit(objPU1);
         
         Account objac = new Account();
         objac.FirstName = 'Shock';
         objac.LastName = 'Wave';
         objac.Project__c = objpr.Id;
         objac.Correspondence_Address__c = 'Delhi';
         objac.Category__c = 'General';
         objac.Unit__c = objPU1.Id;
         objac=RDSCommon.CreateAccount(objac);
         
         Opportunity objOpportunity = new Opportunity();
         objOpportunity.Name = 'Test';
         objOpportunity.CloseDate = System.today();
         objOpportunity.AccountId = objac.Id; 
         objOpportunity.Status__c = 'Active'; 
         objOpportunity.StageName = 'Opportunity Identified'; 
         objOpportunity.Project__c = objpr.Id; 
         objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
         
         Project_Construction_Stages__c objPCS = new Project_Construction_Stages__c();
         objPCS.Project__c = objpr.Id;
         objPCS.Name = 'Commencement of Raft/Foundation';
         objPCS.Code__c ='Test';
         objPCS.Description__c='Commencement of Raft/Foundation';
         objPCS.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS.Tower__c = t.Id;
         insert objPCS;
         
         Project_Construction_Stages__c objPCS1 = new Project_Construction_Stages__c();
         objPCS1.Project__c = objpr.Id;
         objPCS1.Name = 'At Fit Out Possession';
         objPCS1.Code__c ='Test1';
         objPCS1.Description__c='At Fit Out Possession';
         objPCS1.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS1.Tower__c = t.Id;
         insert objPCS1;
         
         // rateList creation
         Rate_List_Header__c objRlh = new Rate_List_Header__c();
         objRlh.Name = 'Basic RL Header';
         objRlh.Project__c = objpr.Id;
         objRlh.Project_Charges__c = PCharge.Id;
         objRlh.Rate_list__c = 'All Charges';
         objRlh.Effective_From__c = system.today().addDays(-3);
         objRlh=RDSCommon.CreateRateListHeader(objRlh);
         
         Rate_List_Detail__c objRld = new Rate_List_Detail__c();
         objRld.Name = 'Basic RL Detail';
         objRld.Charge_Based_On__c = 'Rate';
         objRld.Percent__c = 23600;
         objRld.Project__c = objpr.Id;
         objRld.Rate_List_Header__c = objRlh.id;
         objRld = RDSCommon.CreateRateListHeader(objRld);
         
         Rate_List__c objRL = new Rate_List__c();
         objRL.Rate_List_HeaderID__c = objRlh.Id;
         objRL.Project__c = objpr.Id;
         objRL.Global_Charges__c = ObjGloChrg.Id;
         objRL.Project_Charges__c = PCharge.Id;
         objRL.Project_Unit__c = objPU1.Id;
         objRL.Value__c = 2218;
         objRL.Rate__c = 23600;
         objRL.Charge_Based_On_Master__c = 'Rate';
         objRL.Charge_on_Area_Type__c = 'Saleable Area';
         objRL.Rate_List_Detail__c = objRLd.id;
         objRL=RDSCommon.CreateRateList(objRL);
         
         Rate_List__c objRL1 = new Rate_List__c();
         objRL1.Project__c = objpr.Id;
         objRL1.Global_Charges__c = ObjGloChrg5.Id;
         objRL1.Project_Charges__c = PCharge4.Id;
         objRL1.Project_Unit__c = objPU1.Id;
         objRL1.Value__c = 2218;
         objRL1.Rate__c = 100;
         objRL1.Charge_Based_On_Master__c = 'Rate';
         objRL1.Charge_on_Area_Type__c = 'Saleable Area';
         objRL1.Rate_List_Detail__c = objRLd.id;
         objRL1=RDSCommon.CreateRateList(objRL1);
         
         Rate_List__c objRL2 = new Rate_List__c();
         objRL2.Project__c = objpr.Id;
         objRL2.Global_Charges__c = ObjGloChrg6.Id;
         objRL2.Project_Charges__c = PCharge5.Id;
         objRL2.Project_Unit__c = objPU1.Id;
         objRL2.Value__c = 2218;
         objRL2.Rate__c = 200;
         objRL2.Charge_Based_On_Master__c = 'Rate';
         objRL2.Charge_on_Area_Type__c = 'Saleable Area';
         objRL2.Rate_List_Detail__c = objRLd.id;
         objRL2=RDSCommon.CreateRateList(objRL2);
         
         Rate_List__c objRL3 = new Rate_List__c();
         objRL3.Project__c = objpr.Id;
         objRL3.Global_Charges__c = ObjGloChrg7.Id;
         objRL3.Project_Charges__c = PCharge6.Id;
         objRL3.Project_Unit__c = objPU1.Id;
         objRL3.Rate__c = 190;
         objRL3.Charge_Based_On_Master__c = 'Rate';
         objRL3.Charge_on_Area_Type__c = 'Saleable Area';
         objRL3=RDSCommon.CreateRateList(objRL3);
         
         Rate_List__c objRL4 = new Rate_List__c();
         objRL4.Project__c = objpr.Id;
         objRL4.Global_Charges__c = ObjGloChrg8.Id;
         objRL4.Project_Charges__c = PCharge7.Id;
         objRL4.Project_Unit__c = objPU1.Id;
         objRL4.Rate__c = 210;
         objRL4.Charge_Based_On_Master__c = 'Rate';
         objRL4.Charge_on_Area_Type__c = 'Saleable Area';
         objRL4=RDSCommon.CreateRateList(objRL4);
         
         Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
         objPaymentPlan.Name ='Pay Plan 1';
         objPaymentPlan.Project__c = objpr .Id;
         objPaymentPlan.Tower__c = t.Id;
         objPaymentPlan.Sub_Vention__c = true;
         objPaymentPlan.Subvention_Base_Rate__c = 50;
         objPaymentPlan.No_GST_on_Token__c = true;
         insert objPaymentPlan;
         
         Standard_Pay_Plan_Header__c objSPP = new Standard_Pay_Plan_Header__c();
         objSPP.Project__c = objpr.Id;
         objSPP.Charge_Code__c= PCharge.Id;
         objSPP.Payment_Plan__c=objPaymentPlan.id;
         objSPP.Name='Basic Header';
         objSPP.Plan_Code__c= '89';
         objSPP.tower__c = t.ID;
         objSPP.Effective_from__c = System.today();
         objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
         
         Standard_Pay_Plan_Header__c objSPP1 = new Standard_Pay_Plan_Header__c();
         objSPP1.Project__c = objpr.Id;
         objSPP1.tower__c = t.ID;
         objSPP1.Charge_Code__c= PCharge1.Id;
         objSPP1.Payment_Plan__c=objPaymentPlan.id;
         objSPP1.Name='Club Header';
         objSPP1.Plan_Code__c= '90';
         objSPP1.Effective_from__c = System.today();
         objSPP1=RDSCommon.CreateStandardPayPlanHeader(objSPP1);
         
         // standard payment plan details creation for basic 
         // created 4 installments/milestones. two due date based and 2 Construction Linked
         Standard_Customer_Pay_Plan_Detail__c    objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD.Project__c=objpr.id;
         objSPPD.tower__c = t.ID;
         objSPPD.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD.Days_Months__c='Day(s)';
         objSPPD.Days_Months_Value__c=5;
         objSPPD.Amount__c='Amount';
         objSPPD.Amount_Value__c=110000;
         objSPPD.Installment__c = 100;
         objSPPD= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD);
         
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD4 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD4.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD4.Project__c=objpr.id;
         objSPPD4.tower__c = t.ID;
         objSPPD4.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD4.Days_Months__c='Day(s)';
         objSPPD4.Days_Months_Value__c=0;
         objSPPD4.Amount__c='Amount';
         objSPPD4.Calculate_Installment_Amount_as__c=10;
         objSPPD4.Total_Charge_Value_Minus__c = 110000;
         objSPPD4= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD4);
         
          Standard_Customer_Pay_Plan_Detail__c    objSPPD2 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD2.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD2.Project__c=objpr.id;
         objSPPD2.tower__c = t.ID;
         objSPPD2.Is_to_be_Paid__c='Construction Stage';
         objSPPD2.Days_Months__c='Day(s)';
         objSPPD2.Project_Construction_Stages__c=objPCS.id;
         objSPPD2.Days_Months_Value__c=5;
         objSPPD2.Amount__c='Percentage';
         objSPPD2.Amount_Value__c=40;
         objSPPD2.Installment__c = 102;
         objSPPD2= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD2);
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD3 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD3.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD3.Project__c=objpr.id;
         objSPPD3.tower__c = t.ID;
         objSPPD3.Is_to_be_Paid__c='Construction Stage';
         objSPPD3.Days_Months__c='Day(s)';
         objSPPD3.Project_Construction_Stages__c=objPCS1.id;
         objSPPD3.Days_Months_Value__c=5;
         objSPPD3.Amount__c='Percentage';
         objSPPD3.Amount_Value__c=50;
         objSPPD3.Installment__c = 103;
         objSPPD3= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD3);
         
         // detail record for club member ship charges
         // collected 100% in a single installment on fit out possession
         Standard_Customer_Pay_Plan_Detail__c    objSPPD5 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD5.Standard_Pay_Plan_Header__c = objSPP1.id;
         objSPPD5.Project__c=objpr.id;
         objSPPD5.tower__c = t.ID;
         objSPPD5.Is_to_be_Paid__c='Construction Stage';
         objSPPD5.Days_Months__c='Day(s)';
         objSPPD5.Project_Construction_Stages__c=objPCS1.id;
         objSPPD5.Days_Months_Value__c=5;
         objSPPD5.Amount__c='Percentage';
         objSPPD5.Amount_Value__c=100;
         objSPPD5.Installment__c = 100;
         objSPPD5= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD5);
         
         Team__c objTeam = new Team__c();
         objTeam.Name = 'Sales Approvers Team';
         objTeam.Project__c = objpr.id;
         objTeam.Team_Type__c = 'Sales Approvers Team';
         objTeam.Tower__c = t.id;
         insert objTeam;
         
         /* Car_Parking_Charge__c cp = new Car_Parking_Charge__c();
         cp.Project__c = objpr.id;
         cp.Category__c = 'Additional';
         cp.Status__c = 'Vacant';
         cp.Parking__c = 'single Open';
         insert cp; */
         
         //create users
         User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
         User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
         User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
         
         // insert team as team members
         Team_Members__c tm1 = new Team_Members__c();
         tm1.Team__c = objTeam.Id;
         tm1.User_Active__c = true;
         tm1.Approver_Type__c = 'First Level';
         tm1.User__c = a1.id;
         insert tm1;
         
         Team_Members__c tm2 = new Team_Members__c();
         tm2.Team__c = objTeam.Id;
         tm2.User_Active__c = true;
         tm2.Approver_Type__c = 'Second Level';
         tm2.User__c = a2.id;
         insert tm2;
         
         Team_Members__c tm3 = new Team_Members__c();
         tm3.Team__c = objTeam.Id;
         tm3.User_Active__c = true;
         tm3.Approver_Type__c = 'Third Level';
         tm3.User__c = a3.id;
         insert tm3;
         
         Test.startTest();
         PageReference pRef2 = Page.Quotation2;
         Test.setCurrentPage(pRef2);
         //put the necessary query string params
         ApexPages.currentPage().getParameters().put('oppId',objOpportunity.id);
         ApexPages.currentPage().getParameters().put('id', objPU1.id);
         ApexPages.currentPage().getParameters().put('subPlanId', objPaymentPlan.id);
         QuotationExtn qExNew = new QuotationExtn();
         
         qExNew.baseRate = 1110.0;
         qExNew.discountVal = 100000;
         qExNew.changeBaseRate();
         Test.stopTest();
         
         Map<String,Project_Charges__c> getProjectChargesMap = InventoryCostServices.getProjectChargesMap(objpr.id);
         Map<String,Decimal> getTaxRateForCharges = InventoryCostServices.getTaxRateForCharges(objpr.id);
         Map<String,List<Tax_Breakup__c>> getChildTaxRateForCharges = InventoryCostServices.getChildTaxRateForCharges(objpr.id);
       
     }
     
      @isTest
    private static void QuotationPageTest333() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
        objlglentity.Name = 'RS';
        objlglentity.RDS_Company_Code__c='rs';
        objlglentity.RDS_Service_Tax_No__c= '123456789012345';
        objlglentity.RDS_Company_Name__c='111';
        objlglentity.RDS_Address1__c='123';
        objlglentity.RDS_Address2__c='234';
        objlglentity.RDS_City__c='delhi';
        objlglentity.RDS_Pin_Code__c='201301';
        objlglentity.RDS_Phone__c='9953528045';
        objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
        
        Broker__c objBroK = new Broker__c();
        objBroK.Broker_Code__c = '12346';
        objBroK.Broker_Name__c = 'Brokname';
        objBroK.Status__c = 'Actives';
        objBroK=RDSCommon.CreateBroker(objBroK);
        
        Project__c objpr = new Project__c();
        objpr.Project_Code__c = 'T35';
        objpr.Name = 'TestProject';
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
        objpr.Discount1_Type__c = 'General';
        //objpr.Discount1_Effective_Till__c = system.today().addDays(100);
        objpr.Discount1_Per_Sq_Ft__c = 100;
        objpr.Discount2_Type__c = 'Armed Forces';
        objpr.Discount2_Per_Sq_Ft__c = 150;
        objpr.Discount3_Type__c = 'Corporate';
        objpr.Discount3_Per_Sq_Ft__c = 200;
        objpr.Discount4_Type__c = 'Employee';
        objpr.Discount4_Per_Sq_Ft__c = 250;
        objpr.Discount5_Type__c = 'NRI';
        objpr.Discount5_Per_Sq_Ft__c = 300;
        objpr.Discount6_Type__c = 'Physically Challenged';
        objpr.Discount6_Per_Sq_Ft__c = 350;
        objpr.Discount8_Description__c = 'summer offer';
        objpr.Discount8_Type__c = 'Special Offer';
        objpr.Discount8_Per_Sq_Ft__c = 1000;
        objpr.Discount9_Description__c = 'DAM';
        objpr.Discount9_Type__c = 'DAM';
        objpr.Discount9_Per_Sq_Ft__c = 2000;
        //objpr.Discount2_Effective_Till__c = system.today().addDays(100);
        objpr.Discount2_Lumpsum__c = 100000;
        objpr.Allotment_Charges_1__c = 10000;
        objpr.Allotment_Charges_2__c = 10000;
        objpr.Allotment_Charges_3__c = 10000;
        objpr.Allotment_Charges_4__c = 10000;
        objpr.Allotment_Charges_5__c = 10000;
        objpr=RDSCommon.CreateProject(objpr);
        
        Project_Unit_Type__c objProjectUnitType = new Project_Unit_Type__c();
        objProjectUnitType.name='ONE BHK';
        objProjectUnitType.RDS_Project__c =objpr.id;
        objProjectUnitType=RDSCommon.CreateProjectUnitType(objProjectUnitType);
        
        Tower__c t = new Tower__c();
        t.Name = 'Tower X';
        t.ProjectName__c = objpr.Id;
        t = RDSCommon.CreateTower(t);
        
        Tax_Slab__c taxS = new Tax_Slab__C();
         taxS.name = 'GST';
         taxS.From_Date__c = System.today().addDays(-10);
         taxS.Percentage__c = 4.20;
         taxS = RDSCommon.CreateTaxSlab(taxS);
         
         Tax_Breakup__c tb1 = new Tax_breakup__c();
         tb1.Taxable_Percentage__c = 66.66667;
         tb1.Tax_percentage__c = 9;
         tb1.tax_code__c = 'CGST';
         tb1.Tax_Name__c = 'CGST';
         tb1.Tax_Slab__c = taxS.id;
         tb1.Effective_from__c = system.today().addDays(-10);
         tb1.Tax_Split_Type__c = 'CGST';
         tb1.Tax_Type__c = 'Service tax';
         insert tb1;
         
         Tax_Breakup__c tb2 = new Tax_breakup__c();
         tb2.Taxable_Percentage__c = 66.66667;
         tb2.Tax_percentage__c = 9;
         tb2.tax_code__c = 'SGST';
         tb2.Tax_Name__c = 'SGST';
         tb2.Tax_Slab__c = taxS.id;
         tb2.Effective_from__c = system.today().addDays(-10);
         tb2.Tax_Split_Type__c = 'SGST';
         tb2.Tax_Type__c = 'Service tax';
         insert tb2;
         
         
         Tax_Slab__c taxS1 = new Tax_Slab__C();
         taxS1.name = 'GST-18';
         taxS1.From_Date__c = System.today().addDays(-10);
         taxS1.Percentage__c = 14;
         taxS1 = RDSCommon.CreateTaxSlab(taxS1);
         
           Tax_Breakup__c tb3 = new Tax_breakup__c();
         tb3.Taxable_Percentage__c = 100;
         tb3.Tax_percentage__c = 9;
         tb3.tax_code__c = 'CGST';
         tb3.Tax_Name__c = 'CGST';
         tb3.Tax_Slab__c = taxS1.id;
         tb3.Effective_from__c = system.today().addDays(-10);
         tb3.Tax_Split_Type__c = 'CGST';
         tb3.Tax_Type__c = 'Service tax';
         insert tb3;
         
         Tax_Breakup__c tb4 = new Tax_breakup__c();
         tb4.Taxable_Percentage__c = 100;
         tb4.Tax_percentage__c = 9;
         tb4.tax_code__c = 'SGST';
         tb4.Tax_Name__c = 'SGST';
         tb4.Tax_Slab__c = taxS1.id;
         tb4.Effective_from__c = system.today().addDays(-10);
         tb4.Tax_Split_Type__c = 'SGST';
         tb4.Tax_Type__c = 'Service tax';
         insert tb4; 
         
         Global_Charges__c ObjGloChrg = new Global_Charges__c();
         ObjGloChrg.Name = 'Basic';
         ObjGloChrg.Code__c = '011';
         ObjGloChrg.Description__c = 'Basic';
         ObjGloChrg.Sequence_No__c = 99;
         ObjGloChrg.Charge_Type__c = 'Basic';
         ObjGloChrg.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
         
         Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
         ObjGloChrg1.Name = 'Club Membership Charges';
         ObjGloChrg1.Code__c = '012';
         ObjGloChrg1.Description__c = 'Club Membership Charges';
         ObjGloChrg1.Sequence_No__c = 100;
         ObjGloChrg1.Charge_Type__c = 'Society Charges';
         ObjGloChrg1.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg1=RDSCommon.CreateGlobalCharges(ObjGloChrg1);
         
         Global_Charges__c ObjGloChrg2 = new Global_Charges__c();
         ObjGloChrg2.Name = 'Tax Charge';
         ObjGloChrg2.Code__c = '015';
         ObjGloChrg2.Description__c = 'SERVICE TAX';
         ObjGloChrg2.Sequence_No__c = 105;
         ObjGloChrg2.Charge_Type__c = 'Tax';
         ObjGloChrg2.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg2=RDSCommon.CreateGlobalCharges(ObjGloChrg2);
         
         /*Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
         ObjGloChrg3.Name = 'MVAT';
         ObjGloChrg3.Code__c = '016';
         ObjGloChrg3.Description__c = 'MVAT';
         ObjGloChrg3.Sequence_No__c = 106;
         ObjGloChrg3.Charge_Type__c = 'Debotors';
         ObjGloChrg3.Nature_of_Charge__c = 'Debotors';
         ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);*/
         
         Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
         ObjGloChrg4.Name = 'Registration Charges';
         ObjGloChrg4.Code__c = '017';
         ObjGloChrg4.Description__c = 'Registration Charges';
         ObjGloChrg4.Sequence_No__c = 107;
         ObjGloChrg4.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
         
         Global_Charges__c ObjGloChrg7 = new Global_Charges__c();
         ObjGloChrg7.Name = 'Development Charges';
         ObjGloChrg7.Code__c = '020';
         ObjGloChrg7.Description__c = 'Development Charges';
         ObjGloChrg7.Sequence_No__c = 110;
         ObjGloChrg7.Charge_Type__c = 'Debtors';
         ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg7.Short_Name__c = 'DEVELOP';
         ObjGloChrg7=RDSCommon.CreateGlobalCharges(ObjGloChrg7);
         
         Global_Charges__c ObjGloChrg8 = new Global_Charges__c();
         ObjGloChrg8.Name = 'Infrastructure Charges';
         ObjGloChrg8.Code__c = '021';
         ObjGloChrg8.Description__c = 'Infrastructure Charges';
         ObjGloChrg8.Sequence_No__c = 111;
         ObjGloChrg8.Charge_Type__c = 'Debtors';
         ObjGloChrg8.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg8.Short_Name__c = 'INFRA';
         ObjGloChrg8=RDSCommon.CreateGlobalCharges(ObjGloChrg8);
         
         Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
         ObjGloChrg5.Name = 'Floor Rise';
         ObjGloChrg5.Code__c = '018';
         ObjGloChrg5.Description__c = 'Floor Rise';
         ObjGloChrg5.Sequence_No__c = 108;
         ObjGloChrg5.Charge_Type__c = 'Debtors';
         ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
         
         Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
         ObjGloChrg6.Name = 'Premium 1';
         ObjGloChrg6.Code__c = '019';
         ObjGloChrg6.Description__c = 'Premium 1';
         ObjGloChrg6.Sequence_No__c = 109;
         ObjGloChrg6.Charge_Type__c = 'Debtors';
         ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
         
         Global_Charges__c ObjGloChrg9 = new Global_Charges__c();
         ObjGloChrg9.Name = 'Premium 2';
         ObjGloChrg9.Code__c = '030';
         ObjGloChrg9.Description__c = 'Premium 2';
         ObjGloChrg9.Sequence_No__c = 121;
         ObjGloChrg9.Charge_Type__c = 'Debtors';
         ObjGloChrg9.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg9=RDSCommon.CreateGlobalCharges(ObjGloChrg9);
         
         Global_Charges__c ObjGloChrg10 = new Global_Charges__c();
         ObjGloChrg10.Name = 'Premium 3';
         ObjGloChrg10.Code__c = '031';
         ObjGloChrg10.Description__c = 'Premium 3';
         ObjGloChrg10.Sequence_No__c = 123;
         ObjGloChrg10.Charge_Type__c = 'Debtors';
         ObjGloChrg10.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg10=RDSCommon.CreateGlobalCharges(ObjGloChrg10);
         
         Global_Charges__c ObjGloChrg11 = new Global_Charges__c();
         ObjGloChrg11.Name = 'Premium 4';
         ObjGloChrg11.Code__c = '032';
         ObjGloChrg11.Description__c = 'Premium 4';
         ObjGloChrg11.Sequence_No__c = 124;
         ObjGloChrg11.Charge_Type__c = 'Debtors';
         ObjGloChrg11.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg11=RDSCommon.CreateGlobalCharges(ObjGloChrg11);
         
         Global_Charges__c ObjGloChrg12 = new Global_Charges__c();
         ObjGloChrg12.Name = 'Maintenance Charges 1';
         ObjGloChrg12.Code__c = '033';
         ObjGloChrg12.Description__c = 'Maintenance Charges 1';
         ObjGloChrg12.Sequence_No__c = 125;
         ObjGloChrg12.Charge_Type__c = 'Debtors';
         ObjGloChrg12.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg12=RDSCommon.CreateGlobalCharges(ObjGloChrg12);
         
         Global_Charges__c ObjGloChrg13 = new Global_Charges__c();
         ObjGloChrg13.Name = 'Maintenance Charges 2';
         ObjGloChrg13.Code__c = '034';
         ObjGloChrg13.Description__c = 'Maintenance Charges 2';
         ObjGloChrg13.Sequence_No__c = 126;
         ObjGloChrg13.Charge_Type__c = 'Debtors';
         ObjGloChrg13.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg13=RDSCommon.CreateGlobalCharges(ObjGloChrg13);
         
         Global_Charges__c ObjGloChrg14 = new Global_Charges__c();
         ObjGloChrg14.Name = 'Maintenance Charges 3';
         ObjGloChrg14.Code__c = '035';
         ObjGloChrg14.Description__c = 'Maintenance Charges 3';
         ObjGloChrg14.Sequence_No__c = 127;
         ObjGloChrg14.Charge_Type__c = 'Debtors';
         ObjGloChrg14.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg14=RDSCommon.CreateGlobalCharges(ObjGloChrg14);
         
         Global_Charges__c ObjGloChrg15 = new Global_Charges__c();
         ObjGloChrg15.Name = 'Premium 1';
         ObjGloChrg15.Code__c = '036';
         ObjGloChrg15.Description__c = 'Project Specific Charges 1';
         ObjGloChrg15.Sequence_No__c = 128;
         ObjGloChrg15.Charge_Type__c = 'Debtors';
         ObjGloChrg15.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg15=RDSCommon.CreateGlobalCharges(ObjGloChrg15);
         
         Global_Charges__c ObjGloChrg16 = new Global_Charges__c();
         ObjGloChrg16.Name = 'Premium 1';
         ObjGloChrg16.Code__c = '037';
         ObjGloChrg16.Description__c = 'Project Specific Charges 2';
         ObjGloChrg16.Sequence_No__c = 129;
         ObjGloChrg16.Charge_Type__c = 'Debtors';
         ObjGloChrg16.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg16=RDSCommon.CreateGlobalCharges(ObjGloChrg16);
         
         Global_Charges__c ObjGloChrg17 = new Global_Charges__c();
         ObjGloChrg17.Name = 'Premium 1';
         ObjGloChrg17.Code__c = '038';
         ObjGloChrg17.Description__c = 'Project Specific Charges 3';
         ObjGloChrg17.Sequence_No__c = 130;
         ObjGloChrg17.Charge_Type__c = 'Debtors';
         ObjGloChrg17.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg17=RDSCommon.CreateGlobalCharges(ObjGloChrg17);
         
         Global_Charges__c ObjGloChrg18 = new Global_Charges__c();
         ObjGloChrg18.Name = 'Ultimate Organization formation & related charges';
         ObjGloChrg18.Code__c = '039';
         ObjGloChrg18.Description__c = 'Ultimate Organization formation & related charges';
         ObjGloChrg18.Sequence_No__c = 131;
         ObjGloChrg18.Charge_Type__c = 'Debtors';
         ObjGloChrg18.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg18=RDSCommon.CreateGlobalCharges(ObjGloChrg18);
         
         Global_Charges__c ObjGloChrg19 = new Global_Charges__c();
         ObjGloChrg19.Name = 'Legal Charges';
         ObjGloChrg19.Code__c = '040';
         ObjGloChrg19.Description__c = 'Legal Charges';
         ObjGloChrg19.Sequence_No__c = 132;
         ObjGloChrg19.Charge_Type__c = 'Debtors';
         ObjGloChrg19.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg19=RDSCommon.CreateGlobalCharges(ObjGloChrg19);
         
         Global_Charges__c ObjGloChrg20 = new Global_Charges__c();
         ObjGloChrg20.Name = 'Electric & Water connection & related infrastructure';
         ObjGloChrg20.Code__c = '041';
         ObjGloChrg20.Description__c = 'Electric & Water connection & related infrastructure';
         ObjGloChrg20.Sequence_No__c = 133;
         ObjGloChrg20.Charge_Type__c = 'Debtors';
         ObjGloChrg20.Nature_of_Charge__c = 'Debtors';
         ObjGloChrg20=RDSCommon.CreateGlobalCharges(ObjGloChrg20);
         
         
         Project_Charges__c PCharge = new Project_Charges__c();
         PCharge.Charge_Code__c = ObjGloChrg.Id;
         PCharge.Project__c = objpr.Id;
         PCharge.Name = 'Basic';
         PCharge.Active__c = true;
         PCharge.Applied_This_Charge_To_FA__c = true;
         PCharge.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge.S_Charge_Bucket__c = 'Agreement Value';
         PCharge.S_Payable_At__c = 'As per payment milestone';
         PCharge.Payment_Plan_Applicable__c = true;
         pCharge.Service_Tax_Percentage__c = 'GST';
         pCharge.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge=RDSCommon.CreateProjectCharges(PCharge);
         
         Project_Charges__c PCharge1 = new Project_Charges__c();
         PCharge1.Charge_Code__c = ObjGloChrg1.Id;
         PCharge1.Project__c = objpr.Id;
         PCharge1.Name = 'Club Membership Charges';
         PCharge1.Active__c = true;
         PCharge1.Applied_This_Charge_To_FA__c = true;
         PCharge1.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge1.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge1.S_Charge_Bucket__c = 'Other Charges';
         PCharge1.S_Payable_At__c = 'At Possession';
         PCharge1.Payment_Plan_Applicable__c = true;
         PCharge1.Service_Tax_Percentage__c = 'GST-18';
         PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
         
         
         Project_Charges__c PCharge3 = new Project_Charges__c();
         PCharge3.Charge_Code__c = ObjGloChrg4.Id;
         PCharge3.Project__c = objpr.Id;
         PCharge3.Name = 'Registration Charges';
         PCharge3.Active__c = false;
         PCharge3.Applied_This_Charge_To_FA__c = true;
         PCharge3.S_Charge_Calculated_As__c = 'Percentage of Agreement Value';
         PCharge3.S_Charge_Percentage__c = 1;
         PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
         PCharge3.S_Payable_At__c = 'At Registration';
         PCharge3.Payment_Plan_Applicable__c = false;
         PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
         
         Project_Charges__c PCharge6 = new Project_Charges__c();
         PCharge6.Charge_Code__c = ObjGloChrg7.Id;
         PCharge6.Project__c = objpr.Id;
         PCharge6.Name = 'Development Charges';
         PCharge6.Active__c = true;
         PCharge6.Applied_This_Charge_To_FA__c = true;
         PCharge6.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge6.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge6.Interest_Applicable_on_this_charge__c = true;
         PCharge6.S_Charge_Bucket__c = 'Agreement Value';
         PCharge6.S_Payable_At__c = 'As per payment milestone';
         PCharge6.Remarks__c = 'Development Charges';
         PCharge6.Service_Tax_Percentage__c = 'GST';
         PCharge6.Payment_Plan_Applicable__c = false;
         PCharge6=RDSCommon.CreateProjectCharges(PCharge6);
         
         Project_Charges__c PCharge7 = new Project_Charges__c();
         PCharge7.Charge_Code__c = ObjGloChrg8.Id;
         PCharge7.Project__c = objpr.Id;
         PCharge7.Name = 'Infrastructure Charges';
         PCharge7.Active__c = true;
         PCharge7.Applied_This_Charge_To_FA__c = true;
         PCharge7.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge7.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge7.Interest_Applicable_on_this_charge__c = true;
         PCharge7.S_Charge_Bucket__c = 'Agreement Value';
         PCharge7.S_Payable_At__c = 'As per payment milestone';
         PCharge7.Remarks__c = 'Infrastructure Charges';
         PCharge7.Service_Tax_Percentage__c = 'GST';
         PCharge7.Payment_Plan_Applicable__c = false;
         PCharge7=RDSCommon.CreateProjectCharges(PCharge7);
         
         Project_Charges__c PCharge4 = new Project_Charges__c();
         PCharge4.Charge_Code__c = ObjGloChrg5.Id;
         PCharge4.Project__c = objpr.Id;
         PCharge4.Name = 'Floor Rise';
         PCharge4.Active__c = true;
         PCharge4.Applied_This_Charge_To_FA__c = true;
         PCharge4.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge4.S_Charge_Bucket__c = 'Agreement Value';
         PCharge4.S_Payable_At__c = 'As per payment milestone';
         PCharge4.Payment_Plan_Applicable__c = false;
         PCharge4.Service_Tax_Percentage__c = 'GST';
         PCharge4.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
         
         Project_Charges__c PCharge5 = new Project_Charges__c();
         PCharge5.Charge_Code__c = ObjGloChrg6.Id;
         PCharge5.Project__c = objpr.Id;
         PCharge5.Name = 'Premium 1';
         PCharge5.Active__c = true;
         PCharge5.Applied_This_Charge_To_FA__c = true;
         PCharge5.S_Charge_Calculated_As__c = 'Rate List at Unit Level';
         PCharge5.S_Charge_Bucket__c = 'Agreement Value';
         PCharge5.S_Payable_At__c = 'As per payment milestone';
         PCharge5.Payment_Plan_Applicable__c = false;
         PCharge5.Service_Tax_Percentage__c = 'GST';
         PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
         
         Project_Charges__c PCharge19 = new Project_Charges__c();
         PCharge19.Charge_Code__c = ObjGloChrg9.Id;
         PCharge19.Project__c = objpr.Id;
         PCharge19.Name = 'Premium 2';
         PCharge19.Active__c = true;
         PCharge19.Applied_This_Charge_To_FA__c = true;
         PCharge19.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         PCharge19.S_Charge_Bucket__c = 'Agreement Value';
         PCharge19.S_Payable_At__c = 'As per payment milestone';
         PCharge19.Payment_Plan_Applicable__c = false;
         PCharge19.Service_Tax_Percentage__c = 'GST';
         PCharge19.Service_Tax_Applicable_on_this_charge__c = true;
         pCharge19.S_Lumpsum_Charge_Amount__c = 0;
         PCharge19=RDSCommon.CreateProjectCharges(PCharge19);
         
         Project_Charges__c PCharge20 = new Project_Charges__c();
         PCharge20.Charge_Code__c = ObjGloChrg10.Id;
         PCharge20.Project__c = objpr.Id;
         PCharge20.Name = 'Premium 3';
         PCharge20.Active__c = true;
         PCharge20.Applied_This_Charge_To_FA__c = true;
         PCharge20.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         PCharge20.S_Charge_Bucket__c = 'Agreement Value';
         PCharge20.S_Payable_At__c = 'As per payment milestone';
         PCharge20.Payment_Plan_Applicable__c = false;
         PCharge20.Service_Tax_Percentage__c = 'GST';
         PCharge20.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge20.S_Lumpsum_Charge_Amount__c = 0;
         PCharge20=RDSCommon.CreateProjectCharges(PCharge20);
         
         Project_Charges__c PCharge8 = new Project_Charges__c();
         PCharge8.Charge_Code__c = ObjGloChrg11.Id;
         PCharge8.Project__c = objpr.Id;
         PCharge8.Name = 'Premium 4';
         PCharge8.Active__c = true;
         PCharge8.Applied_This_Charge_To_FA__c = true;
         PCharge8.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         PCharge8.S_Charge_Bucket__c = 'Agreement Value';
         PCharge8.S_Payable_At__c = 'As per payment milestone';
         PCharge8.Payment_Plan_Applicable__c = false;
         PCharge8.Service_Tax_Percentage__c = 'GST';
         PCharge8.Service_Tax_Applicable_on_this_charge__c = true;
         pCharge8.S_Lumpsum_Charge_Amount__c = 0;
         PCharge8 =RDSCommon.CreateProjectCharges(PCharge8);
         
         Project_Charges__c PCharge9 = new Project_Charges__c();
         PCharge9.Charge_Code__c = ObjGloChrg12.Id;
         PCharge9.Project__c = objpr.Id;
         PCharge9.Name = 'Maintenance Charges 1';
         PCharge9.Active__c = true;
         PCharge9.Applied_This_Charge_To_FA__c = true;
         PCharge9.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge9.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge9.S_Charge_Bucket__c = 'Other Charges';
         PCharge9.S_Payable_At__c = 'At Possession';
         PCharge9.Payment_Plan_Applicable__c = false;
         PCharge9.Service_Tax_Percentage__c = 'GST-18';
         PCharge9.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge9=RDSCommon.CreateProjectCharges(PCharge9);
         
         Project_Charges__c PCharge10 = new Project_Charges__c();
         PCharge10.Charge_Code__c = ObjGloChrg13.Id;
         PCharge10.Project__c = objpr.Id;
         PCharge10.Name = 'Maintenance Charges 2';
         PCharge10.Active__c = true;
         PCharge10.Applied_This_Charge_To_FA__c = true;
         PCharge10.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge10.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge10.S_Charge_Bucket__c = 'Other Charges';
         PCharge10.S_Payable_At__c = 'At Possession';
         PCharge10.Payment_Plan_Applicable__c = false;
         PCharge10.Service_Tax_Percentage__c = 'GST-18';
         PCharge10.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge10=RDSCommon.CreateProjectCharges(PCharge10);
         
         Project_Charges__c PCharge11 = new Project_Charges__c();
         PCharge11.Charge_Code__c = ObjGloChrg14.Id;
         PCharge11.Project__c = objpr.Id;
         PCharge11.Name = 'Maintenance Charges 3';
         PCharge11.Active__c = true;
         PCharge11.Applied_This_Charge_To_FA__c = true;
         PCharge11.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge11.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge11.S_Charge_Bucket__c = 'Other Charges';
         PCharge11.S_Payable_At__c = 'At Possession';
         PCharge11.Payment_Plan_Applicable__c = false;
         PCharge11.Service_Tax_Percentage__c = 'GST-18';
         PCharge11.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge11=RDSCommon.CreateProjectCharges(PCharge11);
         
         Project_Charges__c PCharge12 = new Project_Charges__c();
         PCharge12.Charge_Code__c = ObjGloChrg15.Id;
         PCharge12.Project__c = objpr.Id;
         PCharge12.Name = 'Project Specific Charges 1';
         PCharge12.Active__c = true;
         PCharge12.Applied_This_Charge_To_FA__c = true;
         PCharge12.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge12.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge12.S_Charge_Bucket__c = 'Other Charges';
         PCharge12.S_Payable_At__c = 'At Possession';
         PCharge12.Payment_Plan_Applicable__c = false;
         PCharge12.Service_Tax_Percentage__c = 'GST-18';
         PCharge12.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge12=RDSCommon.CreateProjectCharges(PCharge12);
         
         Project_Charges__c PCharge13 = new Project_Charges__c();
         PCharge13.Charge_Code__c = ObjGloChrg16.Id;
         PCharge13.Project__c = objpr.Id;
         PCharge13.Name = 'Project Specific Charges 2';
         PCharge13.Active__c = true;
         PCharge13.Applied_This_Charge_To_FA__c = true;
         PCharge13.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge13.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge13.S_Charge_Bucket__c = 'Other Charges';
         PCharge13.S_Payable_At__c = 'At Possession';
         PCharge13.Payment_Plan_Applicable__c = false;
         PCharge13.Service_Tax_Percentage__c = 'GST-18';
         PCharge13.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge13=RDSCommon.CreateProjectCharges(PCharge13);
         
         Project_Charges__c PCharge14 = new Project_Charges__c();
         PCharge14.Charge_Code__c = ObjGloChrg17.Id;
         PCharge14.Project__c = objpr.Id;
         PCharge14.Name = 'Project Specific Charges 3';
         PCharge14.Active__c = true;
         PCharge14.Applied_This_Charge_To_FA__c = true;
         PCharge14.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge14.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge14.S_Charge_Bucket__c = 'Other Charges';
         PCharge14.S_Payable_At__c = 'At Possession';
         PCharge14.Payment_Plan_Applicable__c = false;
         PCharge14.Service_Tax_Percentage__c = 'GST-18';
         PCharge14.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge14=RDSCommon.CreateProjectCharges(PCharge14);
         
         Project_Charges__c PCharge15 = new Project_Charges__c();
         PCharge15.Charge_Code__c = ObjGloChrg18.Id;
         PCharge15.Project__c = objpr.Id;
         PCharge15.Name = 'Ultimate Organization formation & related charges';
         PCharge15.Active__c = true;
         PCharge15.Applied_This_Charge_To_FA__c = true;
         PCharge15.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge15.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge15.S_Charge_Bucket__c = 'Other Charges';
         PCharge15.S_Payable_At__c = 'At Possession';
         PCharge15.Payment_Plan_Applicable__c = false;
         PCharge15.Service_Tax_Percentage__c = 'GST-18';
         PCharge15.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge15=RDSCommon.CreateProjectCharges(PCharge15);
         
         Project_Charges__c PCharge16 = new Project_Charges__c();
         PCharge16.Charge_Code__c = ObjGloChrg19.Id;
         PCharge16.Project__c = objpr.Id;
         PCharge16.Name = 'Legal Charges';
         PCharge16.Active__c = true;
         PCharge16.Applied_This_Charge_To_FA__c = true;
         PCharge16.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge16.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge16.S_Charge_Bucket__c = 'Other Charges';
         PCharge16.S_Payable_At__c = 'At Possession';
         PCharge16.Payment_Plan_Applicable__c = false;
         PCharge16.Service_Tax_Percentage__c = 'GST-18';
         PCharge16.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge16=RDSCommon.CreateProjectCharges(PCharge16);
         
         Project_Charges__c PCharge17 = new Project_Charges__c();
         PCharge17.Charge_Code__c = ObjGloChrg20.Id;
         PCharge17.Project__c = objpr.Id;
         PCharge17.Name = 'Electric & Water connection & related infrastructure';
         PCharge17.Active__c = true;
         PCharge17.Applied_This_Charge_To_FA__c = true;
         PCharge17.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
         pCharge17.S_Lumpsum_Charge_Amount__c = 100000;
         PCharge17.S_Charge_Bucket__c = 'Other Charges';
         PCharge17.S_Payable_At__c = 'At Possession';
         PCharge17.Payment_Plan_Applicable__c = false;
         PCharge17.Service_Tax_Percentage__c = 'GST-18';
         PCharge17.Service_Tax_Applicable_on_this_charge__c = true;
         PCharge17=RDSCommon.CreateProjectCharges(PCharge17);
         
         Project_Unit__c objPU1 = new Project_Unit__c();    
         objPU1.Name = 'TestFive';      
         objPU1.Project__c = objpr.Id;
         objPU1.Project_Unit_Type__c=objProjectUnitType.id;
         objPU1.Param1__c = '5';
         objPU1.UnitNo__c ='TestFive';
         objPU1.Unit_status__c='Booked';
         objPU1.Actual_Area_value__c = 2218;
         objPU1.Floor__c = 8;
         objPU1.TowerName__c = t.Id;
         objPU1.Single_car_park_Earmarked__c = 0;
         objPU1.Single_Open_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Tandem_car_park_Earmarked__c = 0;
         objPU1.Tandem_Open_Earmarked__c = 0;
         objPU1.Stack__c = 0;
         
         objPU1.Discount1_Type__c = 'General';
         objPU1.Discount1_Per_Sq_Ft__c = 100;
         objPU1.Discount2_Type__c = 'Armed Forces';
         objPU1.Discount2_Per_Sq_Ft__c = 200;
         objPU1.Discount3_Type__c = 'Corporate';
         objPU1.Discount3_Per_Sq_Ft__c = 250;
         objPU1.Discount4_Type__c = 'Physically Challenged';
         objPU1.Discount4_Per_Sq_Ft__c = 300;
         
         objPU1.Discount8_Type__c = 'Special Offer';
         objPU1.Discount8_Per_Sq_Ft__c = 300;
         objPU1.Discount8_Description__c = 'Summer Offer';
         objPU1.Discount9_Type__c = 'DAM';
         objPU1.Discount9_Per_Sq_Ft__c = 350;
         objPU1.Discount9_Description__c = 'DAM';
         objPU1=RDSCommon.CreateProjectUnit(objPU1);
         
         Account objac = new Account();
         objac.FirstName = 'Shock';
         objac.LastName = 'Wave';
         objac.Project__c = objpr.Id;
         objac.Correspondence_Address__c = 'Delhi';
         objac.Category__c = 'General';
         objac.Unit__c = objPU1.Id;
         objac=RDSCommon.CreateAccount(objac);
         
         Opportunity objOpportunity = new Opportunity();
         objOpportunity.Name = 'Test';
         objOpportunity.CloseDate = System.today();
         objOpportunity.AccountId = objac.Id; 
         objOpportunity.Status__c = 'Active'; 
         objOpportunity.StageName = 'Opportunity Identified'; 
         objOpportunity.Project__c = objpr.Id; 
         objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
         
         Project_Construction_Stages__c objPCS = new Project_Construction_Stages__c();
         objPCS.Project__c = objpr.Id;
         objPCS.Name = 'Commencement of Raft/Foundation';
         objPCS.Code__c ='Test';
         objPCS.Description__c='Commencement of Raft/Foundation';
         objPCS.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS.Tower__c = t.Id;
         insert objPCS;
         
         Project_Construction_Stages__c objPCS1 = new Project_Construction_Stages__c();
         objPCS1.Project__c = objpr.Id;
         objPCS1.Name = 'At Fit Out Possession';
         objPCS1.Code__c ='Test1';
         objPCS1.Description__c='At Fit Out Possession';
         objPCS1.Planned_date_of_completion__c = System.today().addDays(365);
         objPCS1.Tower__c = t.Id;
         insert objPCS1;
         
         // rateList creation
         Rate_List_Header__c objRlh = new Rate_List_Header__c();
         objRlh.Name = 'Basic RL Header';
         objRlh.Project__c = objpr.Id;
         objRlh.Project_Charges__c = PCharge.Id;
         objRlh.Rate_list__c = 'All Charges';
         objRlh.Effective_From__c = system.today().addDays(-3);
         objRlh=RDSCommon.CreateRateListHeader(objRlh);
         
         Rate_List_Detail__c objRld = new Rate_List_Detail__c();
         objRld.Name = 'Basic RL Detail';
         objRld.Charge_Based_On__c = 'Rate';
         objRld.Percent__c = 23600;
         objRld.Project__c = objpr.Id;
         objRld.Rate_List_Header__c = objRlh.id;
         objRld = RDSCommon.CreateRateListHeader(objRld);
         
         Rate_List__c objRL = new Rate_List__c();
         objRL.Rate_List_HeaderID__c = objRlh.Id;
         objRL.Project__c = objpr.Id;
         objRL.Global_Charges__c = ObjGloChrg.Id;
         objRL.Project_Charges__c = PCharge.Id;
         objRL.Project_Unit__c = objPU1.Id;
         objRL.Value__c = 2218;
         objRL.Rate__c = 23600;
         objRL.Charge_Based_On_Master__c = 'Rate';
         objRL.Charge_on_Area_Type__c = 'Saleable Area';
         objRL.Rate_List_Detail__c = objRLd.id;
         objRL=RDSCommon.CreateRateList(objRL);
         
         Rate_List__c objRL1 = new Rate_List__c();
         objRL1.Project__c = objpr.Id;
         objRL1.Global_Charges__c = ObjGloChrg5.Id;
         objRL1.Project_Charges__c = PCharge4.Id;
         objRL1.Project_Unit__c = objPU1.Id;
         objRL1.Value__c = 2218;
         objRL1.Rate__c = 100;
         objRL1.Charge_Based_On_Master__c = 'Rate';
         objRL1.Charge_on_Area_Type__c = 'Saleable Area';
         objRL1.Rate_List_Detail__c = objRLd.id;
         objRL1=RDSCommon.CreateRateList(objRL1);
         
         Rate_List__c objRL2 = new Rate_List__c();
         objRL2.Project__c = objpr.Id;
         objRL2.Global_Charges__c = ObjGloChrg6.Id;
         objRL2.Project_Charges__c = PCharge5.Id;
         objRL2.Project_Unit__c = objPU1.Id;
         objRL2.Value__c = 2218;
         objRL2.Rate__c = 200;
         objRL2.Charge_Based_On_Master__c = 'Rate';
         objRL2.Charge_on_Area_Type__c = 'Saleable Area';
         objRL2.Rate_List_Detail__c = objRLd.id;
         objRL2=RDSCommon.CreateRateList(objRL2);
         
         Rate_List__c objRL3 = new Rate_List__c();
         objRL3.Project__c = objpr.Id;
         objRL3.Global_Charges__c = ObjGloChrg7.Id;
         objRL3.Project_Charges__c = PCharge6.Id;
         objRL3.Project_Unit__c = objPU1.Id;
         objRL3.Rate__c = 190;
         objRL3.Charge_Based_On_Master__c = 'Rate';
         objRL3.Charge_on_Area_Type__c = 'Saleable Area';
         objRL3=RDSCommon.CreateRateList(objRL3);
         
         Rate_List__c objRL4 = new Rate_List__c();
         objRL4.Project__c = objpr.Id;
         objRL4.Global_Charges__c = ObjGloChrg8.Id;
         objRL4.Project_Charges__c = PCharge7.Id;
         objRL4.Project_Unit__c = objPU1.Id;
         objRL4.Rate__c = 210;
         objRL4.Charge_Based_On_Master__c = 'Rate';
         objRL4.Charge_on_Area_Type__c = 'Saleable Area';
         objRL4=RDSCommon.CreateRateList(objRL4);
         
         Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
         objPaymentPlan.Name ='Pay Plan 1';
         objPaymentPlan.Project__c = objpr .Id;
         objPaymentPlan.Tower__c = t.Id;
         objPaymentPlan.Sub_Vention__c = true;
         objPaymentPlan.Subvention_Base_Rate__c = 50;
         objPaymentPlan.No_GST_on_Token__c = true;
         insert objPaymentPlan;
         
         Standard_Pay_Plan_Header__c objSPP = new Standard_Pay_Plan_Header__c();
         objSPP.Project__c = objpr.Id;
         objSPP.Charge_Code__c= PCharge.Id;
         objSPP.Payment_Plan__c=objPaymentPlan.id;
         objSPP.Name='Basic Header';
         objSPP.Plan_Code__c= '89';
         objSPP.tower__c = t.ID;
         objSPP.Effective_from__c = System.today();
         objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
         
         Standard_Pay_Plan_Header__c objSPP1 = new Standard_Pay_Plan_Header__c();
         objSPP1.Project__c = objpr.Id;
         objSPP1.tower__c = t.ID;
         objSPP1.Charge_Code__c= PCharge1.Id;
         objSPP1.Payment_Plan__c=objPaymentPlan.id;
         objSPP1.Name='Club Header';
         objSPP1.Plan_Code__c= '90';
         objSPP1.Effective_from__c = System.today();
         objSPP1=RDSCommon.CreateStandardPayPlanHeader(objSPP1);
         
         // standard payment plan details creation for basic 
         // created 4 installments/milestones. two due date based and 2 Construction Linked
         Standard_Customer_Pay_Plan_Detail__c    objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD.Project__c=objpr.id;
         objSPPD.tower__c = t.ID;
         objSPPD.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD.Days_Months__c='Day(s)';
         objSPPD.Days_Months_Value__c=5;
         objSPPD.Amount__c='Amount';
         objSPPD.Amount_Value__c=110000;
         objSPPD.Installment__c = 100;
         objSPPD= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD);
         
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD4 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD4.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD4.Project__c=objpr.id;
         objSPPD4.tower__c = t.ID;
         objSPPD4.Is_to_be_Paid__c='From Dt. of Booking';
         objSPPD4.Days_Months__c='Day(s)';
         objSPPD4.Days_Months_Value__c=0;
         objSPPD4.Amount__c='Amount';
         objSPPD4.Calculate_Installment_Amount_as__c=10;
         objSPPD4.Total_Charge_Value_Minus__c = 110000;
         objSPPD4= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD4);
         
          Standard_Customer_Pay_Plan_Detail__c    objSPPD2 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD2.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD2.Project__c=objpr.id;
         objSPPD2.tower__c = t.ID;
         objSPPD2.Is_to_be_Paid__c='Construction Stage';
         objSPPD2.Days_Months__c='Day(s)';
         objSPPD2.Project_Construction_Stages__c=objPCS.id;
         objSPPD2.Days_Months_Value__c=5;
         objSPPD2.Amount__c='Percentage';
         objSPPD2.Amount_Value__c=40;
         objSPPD2.Installment__c = 102;
         objSPPD2= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD2);
         
         Standard_Customer_Pay_Plan_Detail__c    objSPPD3 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD3.Standard_Pay_Plan_Header__c = objSPP.id;
         objSPPD3.Project__c=objpr.id;
         objSPPD3.tower__c = t.ID;
         objSPPD3.Is_to_be_Paid__c='Construction Stage';
         objSPPD3.Days_Months__c='Day(s)';
         objSPPD3.Project_Construction_Stages__c=objPCS1.id;
         objSPPD3.Days_Months_Value__c=5;
         objSPPD3.Amount__c='Percentage';
         objSPPD3.Amount_Value__c=50;
         objSPPD3.Installment__c = 103;
         objSPPD3= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD3);
         
         // detail record for club member ship charges
         // collected 100% in a single installment on fit out possession
         Standard_Customer_Pay_Plan_Detail__c    objSPPD5 = new Standard_Customer_Pay_Plan_Detail__c();
         objSPPD5.Standard_Pay_Plan_Header__c = objSPP1.id;
         objSPPD5.Project__c=objpr.id;
         objSPPD5.tower__c = t.ID;
         objSPPD5.Is_to_be_Paid__c='Construction Stage';
         objSPPD5.Days_Months__c='Day(s)';
         objSPPD5.Project_Construction_Stages__c=objPCS1.id;
         objSPPD5.Days_Months_Value__c=5;
         objSPPD5.Amount__c='Percentage';
         objSPPD5.Amount_Value__c=100;
         objSPPD5.Installment__c = 100;
         objSPPD5= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD5);
         
         Team__c objTeam = new Team__c();
         objTeam.Name = 'Sales Approvers Team';
         objTeam.Project__c = objpr.id;
         objTeam.Team_Type__c = 'Sales Approvers Team';
         objTeam.Tower__c = t.id;
         insert objTeam;
         
         /* Car_Parking_Charge__c cp = new Car_Parking_Charge__c();
         cp.Project__c = objpr.id;
         cp.Category__c = 'Additional';
         cp.Status__c = 'Vacant';
         cp.Parking__c = 'single Open';
         insert cp; */
         
         //create users
         User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
         User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
         User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
         
         // insert team as team members
         Team_Members__c tm1 = new Team_Members__c();
         tm1.Team__c = objTeam.Id;
         tm1.User_Active__c = true;
         tm1.Approver_Type__c = 'First Level';
         tm1.User__c = a1.id;
         insert tm1;
         
         Team_Members__c tm2 = new Team_Members__c();
         tm2.Team__c = objTeam.Id;
         tm2.User_Active__c = true;
         tm2.Approver_Type__c = 'Second Level';
         tm2.User__c = a2.id;
         insert tm2;
         
         Team_Members__c tm3 = new Team_Members__c();
         tm3.Team__c = objTeam.Id;
         tm3.User_Active__c = true;
         tm3.Approver_Type__c = 'Third Level';
         tm3.User__c = a3.id;
         insert tm3;
         
         Test.startTest();
         PageReference pRef2 = Page.Quotation2;
         Test.setCurrentPage(pRef2);
         //put the necessary query string params
         ApexPages.currentPage().getParameters().put('oppId',objOpportunity.id);
         ApexPages.currentPage().getParameters().put('id', objPU1.id);
         ApexPages.currentPage().getParameters().put('subPlanId', objPaymentPlan.id);
         QuotationExtn qExNew = new QuotationExtn();
         qExNew.QueryPlanDetails();
         
         qExNew.savePrint();
         
         Test.stopTest();
       
     }
}