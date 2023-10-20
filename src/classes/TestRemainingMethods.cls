@isTest
private  Class TestRemainingMethods {
@isTest
    private static void testOppMgmtServices() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
            objlglentity.Name ='RS';
            objlglentity.RDS_Company_Code__c='rs';
            objlglentity.RDS_Service_Tax_No__c= '123456789012345';
            objlglentity.RDS_Company_Name__c='111';
            objlglentity.RDS_Address1__c='123';
            objlglentity.RDS_Address2__c='234';
            objlglentity.RDS_City__c='delhi';
            objlglentity.RDS_Pin_Code__c='201301';
            objlglentity.RDS_Phone__c='9953528045';
            objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
            
            // Broker Creation
             Broker__c objBroK = new Broker__c();
             objBroK.Broker_Code__c = '12346';
             objBroK.Broker_Name__c = 'Brokname';
             objBroK.Status__c = 'Actives';
             objBroK=RDSCommon.CreateBroker(objBroK);
            // Project Creation
            Project__c objpr = new Project__c();
            objpr.Project_Code__c = 'T35';
            objpr.Name = 'SOS';
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
              
              // Unit structure creation
             Unit_Number_Structure__c objUn = new Unit_Number_Structure__c();
             objUn.Name = 'testUN';
             objUn.Description__c = 'Desc';
             objUn.Sequence_No__c = 2;
             objUn.Project__c = objpr.Id;
             objUn.Maximum_Length__c = 2;
             objUn.Delimiter__c = '/';
             objUn=RDSCommon.CreateUnitNumberStructure(objUn);
            // tower creation 
             Tower__c t = new Tower__c();
             t.Name = 'Tower X';
             t.ProjectName__c = objpr.Id;
             t = RDSCommon.CreateTower(t);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'GST';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 12;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Breakup__c txb1 = new Tax_Breakup__c();
             txb1.Tax_Slab__c = taxS.id;
             txb1.Taxable_Percentage__c = 66.66667;
             txb1.Tax_Code__c = 'CGST';
             txb1.Tax_Name__c = 'CGST';
             txb1.Tax_Percentage__c = 9.000;
             txb1.Tax_Type__c = 'Service Tax';
             txb1.Tax_Split_Type__c = 'CGST';
             insert txb1;
             
             Tax_Breakup__c txb2 = new Tax_Breakup__c();
             txb2.Tax_Slab__c = taxS.id;
             txb2.Taxable_Percentage__c = 66.66667;
             txb2.Tax_Code__c = 'SGST';
             txb2.Tax_Name__c = 'SGST';
             txb2.Tax_Percentage__c = 9.000;
             txb2.Tax_Type__c = 'Service Tax';
             txb2.Tax_Split_Type__c = 'SGST';
             insert txb2;
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'GST-18';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 18.00;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
             
             Tax_Breakup__c txb3 = new Tax_Breakup__c();
             txb3.Tax_Slab__c = taxS1.id;
             txb3.Taxable_Percentage__c = 100.00000;
             txb3.Tax_Code__c = 'CGST';
             txb3.Tax_Name__c = 'CGST';
             txb3.Tax_Percentage__c = 9.000;
             txb3.Tax_Type__c = 'Service Tax';
             txb3.Tax_Split_Type__c = 'CGST';
             insert txb3;
             
             Tax_Breakup__c txb4 = new Tax_Breakup__c();
             txb4.Tax_Slab__c = taxS1.id;
             txb4.Taxable_Percentage__c = 100.00000;
             txb4.Tax_Code__c = 'SGST';
             txb4.Tax_Name__c = 'SGST';
             txb4.Tax_Percentage__c = 9.000;
             txb4.Tax_Type__c = 'Service Tax';
             txb4.Tax_Split_Type__c = 'SGST';
             insert txb4;
             
             // global charges creation
             Global_Charges__c ObjGloChrg = new Global_Charges__c();
             ObjGloChrg.Name = 'Basic';
             ObjGloChrg.Code__c = '011';
             ObjGloChrg.Description__c = 'Basic';
             ObjGloChrg.Sequence_No__c = 99;
             ObjGloChrg.Charge_Type__c = 'Basic';
             ObjGloChrg.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
             
             Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
             ObjGloChrg1.Name = 'Club Memebership';
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
             
             
             Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
             ObjGloChrg3.Name = 'Legal Charges';
             ObjGloChrg3.Code__c = '016';
             ObjGloChrg3.Description__c = 'LEGAL CHARGES';
             ObjGloChrg3.Sequence_No__c = 106;
             ObjGloChrg3.Charge_Type__c = 'Legal Charges';
             ObjGloChrg3.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);
             
             
             Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
             ObjGloChrg4.Name = 'Registration Charges';
             ObjGloChrg4.Code__c = '017';
             ObjGloChrg4.Description__c = 'REGISTRATION CHARGES';
             ObjGloChrg4.Sequence_No__c = 107;
             ObjGloChrg4.Charge_Type__c = 'Registration';
             ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
             
             Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
             ObjGloChrg5.Name = 'Stamp Duty';
             ObjGloChrg5.Code__c = '018';
             ObjGloChrg5.Description__c = 'STAMP DUTY';
             ObjGloChrg5.Sequence_No__c = 108;
             ObjGloChrg5.Charge_Type__c = 'Stamp Duty';
             ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
             
             Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
             ObjGloChrg6.Name = 'MVAT';
             ObjGloChrg6.Code__c = '019';
             ObjGloChrg6.Description__c = 'MVAT';
             ObjGloChrg6.Sequence_No__c = 109;
             ObjGloChrg6.Charge_Type__c = 'MVAT';
             ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
             
            Global_Charges__c  gh1 = new Global_Charges__c();
            gh1.name = 'Interest Installment';
            gh1.Code__c = '101';
            gh1.Description__c = 'Interest';
            gh1.Short_Name__c = 'INT';
            gh1.Sequence_No__c = 20;
            gh1.Charge_Type__c = 'Interest Rcvd';
            insert gh1;
            
            Global_Charges__c  gh2 = new Global_Charges__c();
            gh2.name = 'Interest Installment Waived';
            gh2.Code__c = '102';
            gh2.Description__c = 'Interest Installment Waived';
            gh2.Short_Name__c = 'INTWAIVE';
            gh2.Sequence_No__c = 21;
            gh2.Charge_Type__c = 'Interest Rcvd';
            insert gh2;
            
            Global_Charges__c  gh3 = new Global_Charges__c();
            gh3.name = 'Interest Servicetax';
            gh3.Code__c = '103';
            gh3.Description__c = 'Interest Servicetax';
            gh3.Short_Name__c = 'INTST';
            gh3.Sequence_No__c = 22;
            gh3.Charge_Type__c = 'Interest Rcvd';
            insert gh3;
            
            Global_Charges__c  gh4 = new Global_Charges__c();
            gh4.name = 'Interest Servicetax Waived';
            gh4.Code__c = '104';
            gh4.Description__c = 'Interest Servicetax Waived';
            gh4.Short_Name__c = 'INTSTWAI';
            gh4.Sequence_No__c = 23;
            gh4.Charge_Type__c = 'Interest Rcvd';
            insert gh4;
             
             
             // project charges creation
             // one basic
             // other is club membership, both are active.
             // one is lumpsum at project level and basic is based on ratelist defined for that unit
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
             PCharge1.S_Charge_Bucket__c = 'Society Charges';
             PCharge1.S_Payable_At__c = 'At Possession';
             PCharge1.Payment_Plan_Applicable__c = true;
             PCharge1.Service_Tax_Percentage__c = 'GST-18';
             PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
             PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
             
             Project_Charges__c PCharge2 = new Project_Charges__c();
             PCharge2.Charge_Code__c = ObjGloChrg3.Id;
             PCharge2.Project__c = objpr.Id;
             PCharge2.Name = 'Legal Charges';
             PCharge2.Active__c = true;
             PCharge2.Applied_This_Charge_To_FA__c = true;
             PCharge2.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
             PCharge2.S_Lumpsum_Charge_Amount__c = 100000;
             PCharge2.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge2.S_Payable_At__c = 'At Registration';
             PCharge2.Payment_Plan_Applicable__c = true;
             PCharge2=RDSCommon.CreateProjectCharges(PCharge2);
             
             Project_Charges__c PCharge3 = new Project_Charges__c();
             PCharge3.Charge_Code__c = ObjGloChrg4.Id;
             PCharge3.Project__c = objpr.Id;
             PCharge3.Name = 'Registration Charges';
             PCharge3.Active__c = true;
             PCharge3.Applied_This_Charge_To_FA__c = true;
             PCharge3.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
             PCharge3.S_Lumpsum_Charge_Amount__c = 30000;
             PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge3.S_Payable_At__c = 'At Registration';
             PCharge3.Payment_Plan_Applicable__c = true;
             PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
             
             Project_Charges__c PCharge4 = new Project_Charges__c();
             PCharge4.Charge_Code__c = ObjGloChrg5.Id;
             PCharge4.Project__c = objpr.Id;
             PCharge4.Name = 'Stamp Duty';
             PCharge4.Active__c = true;
             PCharge4.Applied_This_Charge_To_FA__c = true;
             PCharge4.S_Charge_Percentage__c = 5;
             PCharge3.S_Charge_Calculated_As__c = 'Higher of Ready Reckoner or Agreement Value';
             PCharge4.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge4.S_Payable_At__c = 'At Registration';
             PCharge4.Payment_Plan_Applicable__c = true;
             PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
             
             Project_Charges__c PCharge5 = new Project_Charges__c();
             PCharge5.Charge_Code__c = ObjGloChrg6.Id;
             PCharge5.Project__c = objpr.Id;
             PCharge5.Name = 'MVAT';
             PCharge5.Active__c = true;
             PCharge5.Applied_This_Charge_To_FA__c = true;
             PCharge5.S_Charge_Percentage__c = 1;
             PCharge5.S_Lumpsum_Charge_Amount__c = 30000;
             PCharge5.S_Charge_Calculated_As__c = 'Higher of Ready Reckoner or Agreement Value';
             PCharge5.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge5.S_Payable_At__c = 'At Registration';
             PCharge5.Payment_Plan_Applicable__c = true;
             PCharge5.Service_Tax_Percentage__c = 'GST-18';
             PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
             PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
             
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
             objPU1=RDSCommon.CreateProjectUnit(objPU1);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             
             //create users
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@xanadu.com', 'galvatron1@xanadu.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@xanadu.com', 'galvatron2@xanadu.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@xanadu.com', 'galvatron3@xanadu.com');
             
             // opportunity creation              
             Opportunity objOpportunity = new Opportunity();
             objOpportunity.Name = 'Test';
             objOpportunity.CloseDate = System.today();
             objOpportunity.AccountId = objac.Id; 
             objOpportunity.Status__c = 'Active'; 
             objOpportunity.StageName = 'Opportunity Identified'; 
             objOpportunity.Project__c = objpr.Id; 
             objOpportunity.Project_Unit__c = objPU1.Id;
             objOpportunity.Primary_Email__c = 'shock@transformers.com';
             objOpportunity.Other_Applicants_Email__c = 'three@crowd.com,noone@wold.com';
             objOpportunity.Other_Applicants_Name__c = 'Mr.Three is crowd,M/S.Amazing Girl';
             objOpportunity.Primary_Name__c = 'Sherlock Holmes';
             objOpportunity.Other_Applicants_Pancard__c= 'ROOOO101,BRBRBR01';
             objOpportunity.Primary_pancard__c  = 'IKJK099';
             objOpportunity.Permanent_Address__c = 'Somewhere only I know,Maharashtra,Nagpur,Maharashtra,India,875851';
             objOpportunity.Mailing_Address__c = 'Mailing Address,Nagpur,Maharashtra,India,900567';
             objOpportunity.Relationship_manager__c = a1.id;
             objOpportunity.Registration_Date__c = system.today().addDays(-2);
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
            
             // construction stage creation
             // two stages are being created
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
             objRL.Rate_List_Detail__c = objRLd.id;
             objRL=RDSCommon.CreateRateList(objRL);
             
             // payment plan creation associated to the construction stages
             Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
             objPaymentPlan.Name ='Pay Plan 1';
             objPaymentPlan.Project__c = objpr .Id;
             objPaymentPlan.Tower__c = t.Id;
             insert objPaymentPlan;
             
             // standard payment plan header creation
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
             
             Standard_Pay_Plan_Header__c objSPP2 = new Standard_Pay_Plan_Header__c();
             objSPP2.Project__c = objpr.Id;
             objSPP2.tower__c = t.ID;
             objSPP2.Charge_Code__c= PCharge2.Id;
             objSPP2.Payment_Plan__c=objPaymentPlan.id;
             objSPP2.Name='Legal Header';
             objSPP2.Plan_Code__c= '90';
             objSPP2.Effective_from__c = System.today();
             objSPP2=RDSCommon.CreateStandardPayPlanHeader(objSPP2);
             
             Standard_Pay_Plan_Header__c objSPP3 = new Standard_Pay_Plan_Header__c();
             objSPP3.Project__c = objpr.Id;
             objSPP3.tower__c = t.ID;
             objSPP3.Charge_Code__c= PCharge3.Id;
             objSPP3.Payment_Plan__c=objPaymentPlan.id;
             objSPP3.Name='Registration Header';
             objSPP3.Plan_Code__c= '90';
             objSPP3.Effective_from__c = System.today();
             objSPP3=RDSCommon.CreateStandardPayPlanHeader(objSPP3);
             
             Standard_Pay_Plan_Header__c objSPP4 = new Standard_Pay_Plan_Header__c();
             objSPP4.Project__c = objpr.Id;
             objSPP4.tower__c = t.ID;
             objSPP4.Charge_Code__c= PCharge4.Id;
             objSPP4.Payment_Plan__c=objPaymentPlan.id;
             objSPP4.Name='Stamp Duty Header';
             objSPP4.Plan_Code__c= '90';
             objSPP4.Effective_from__c = System.today();
             objSPP4=RDSCommon.CreateStandardPayPlanHeader(objSPP4);
             
             Standard_Pay_Plan_Header__c objSPP5 = new Standard_Pay_Plan_Header__c();
             objSPP5.Project__c = objpr.Id;
             objSPP5.tower__c = t.ID;
             objSPP5.Charge_Code__c= PCharge5.Id;
             objSPP5.Payment_Plan__c=objPaymentPlan.id;
             objSPP5.Name='MVAT Header';
             objSPP5.Plan_Code__c= '90';
             objSPP5.Effective_from__c = System.today();
             objSPP5=RDSCommon.CreateStandardPayPlanHeader(objSPP5);
             
             // detail record for registration charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD10 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD10.Standard_Pay_Plan_Header__c = objSPP2.id;
             objSPPD10.Project__c=objpr.id;
             objSPPD10.tower__c = t.ID;
             objSPPD10.Is_to_be_Paid__c='At Registration';
             objSPPD10.Days_Months__c='Day(s)';
             objSPPD10.Days_Months_Value__c=0;
             objSPPD10.Amount__c='Percentage';
             objSPPD10.Amount_Value__c=100;
             objSPPD10.Installment__c = 100;
             objSPPD10= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD10);
             
             
              // detail record for legal charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD11 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD11.Standard_Pay_Plan_Header__c = objSPP3.id;
             objSPPD11.Project__c=objpr.id;
             objSPPD11.tower__c = t.ID;
             objSPPD11.Is_to_be_Paid__c='At Registration';
             objSPPD11.Days_Months__c='Day(s)';
             objSPPD11.Days_Months_Value__c=0;
             objSPPD11.Amount__c='Percentage';
             objSPPD11.Amount_Value__c=100;
             objSPPD11.Installment__c = 100;
             objSPPD11= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD11);
             
             
              // detail record for stamp duty charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD12 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD12.Standard_Pay_Plan_Header__c = objSPP4.id;
             objSPPD12.Project__c=objpr.id;
             objSPPD12.tower__c = t.ID;
             objSPPD12.Is_to_be_Paid__c='At Registration';
             objSPPD12.Days_Months__c='Day(s)';
             objSPPD12.Days_Months_Value__c=0;
             objSPPD12.Amount__c='Percentage';
             objSPPD12.Amount_Value__c=100;
             objSPPD12.Installment__c = 100;
             objSPPD12= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD12);
             
             // detail record for stamp duty charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD13 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD13.Standard_Pay_Plan_Header__c = objSPP5.id;
             objSPPD13.Project__c=objpr.id;
             objSPPD13.tower__c = t.ID;
             objSPPD13.Is_to_be_Paid__c='At Registration';
             objSPPD13.Days_Months__c='Day(s)';
             objSPPD13.Days_Months_Value__c=0;
             objSPPD13.Amount__c='Percentage';
             objSPPD13.Amount_Value__c=100;
             objSPPD13.Installment__c = 100;
             objSPPD13= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD13);
             
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
             
             //create the approvers team
             Team__c objTeam = new Team__c();
             objTeam.Name = 'Sales Approvers Team';
             objTeam.Project__c = objpr.id;
             objTeam.Team_Type__c = 'Sales Approvers Team';
             objTeam.Tower__c = t.id;
             insert objTeam;
             
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

            Quotation__c q = new Quotation__c();
            q.Name = 'Q010101';
            q.Quote_Status__c = 'Valid';
            q.Prepared_Date__c = System.today();
            q.Project__c = objpr.Id;
            q.Project_Unit__c = objPU1.Id;
            q.FloorNo__c = 11;
            q.Opportunity__c = objOpportunity.Id;
            q.Appartment_Configuration__c = '1 BHK';
            q.Carpet_Area_Sq_Ft__c = 1200;
            q.Token_Amount__c =110000;
            q.ST_Token_Amount__c = 1000;
            q.Agreement_Value__c = 60422880;
            q.Agreement_Value_ST__c = 2537761;
            insert q;
            
            Receipt__c r1 = new Receipt__c();
            r1.Cheque_DD_Amount_Rs__c = 200000;
            r1.Cheque_DD__c = '908888';
            r1.Cheque_DD_Date__c = system.today();
            r1.Project__c = objpr.Id;
            r1.Project_Unit__c = objPU1.Id;
            r1.Opportunity__c = objOpportunity.Id;
            r1.CheckReceipt__c = true;
            r1.Token_Amount_Receipt__c = true;
            r1.Physically_Cheque_Received__c = true;
            r1.Approval_Status__c = 'Approved';
            r1.Receipt_Date__c = system.today();
            r1.DraweeBank__c = 'Axis Bank';
            r1.Total_Amount__c = 200000;
            r1.Currency__c = 'Indian Rupee';
            insert r1;
            
            Receipt__c r2 = new Receipt__c();
            r2.Cheque_DD_Amount_Rs__c = 8400;
            r2.Cheque_DD__c = '9088881';
            r2.Cheque_DD_Date__c = system.today();
            r2.Project__c = objpr.Id;
            r2.Project_Unit__c = objPU1.Id;
            r2.Opportunity__c = objOpportunity.Id;
            r2.CheckReceipt__c = true;
            r2.Physically_Cheque_Received__c = true;
            r2.Approval_Status__c = 'Approved';
            r2.Receipt_Date__c = system.today();
            r2.DraweeBank__c = 'CITI';
            r2.Total_Amount__c = 8400;
            insert r2;
            
            Booking__c objBooking;
            objBooking = new Booking__c();
            objBooking.Code__c='1234';
            objBooking.Reg_No__c='150224';
            objBooking.Project__c=objpr.id;
            objBooking.Direct__c=true;
            objBooking.Broker_Code__c='A-022';
            objBooking.Broker_Name__c=' Broker 1';
            objBooking.Customer_Name__c='Client';
            objBooking.Effective_From__c=system.today();
            objBooking.Application_No__c='Ap-01';
            objBooking.Status__c='Approved';
            objBooking.MG_Effect_Date__c=system.today();
            objBooking.MG_Per_Amt_Val__c=222;
            objBooking.Customer__c=objOpportunity.id;
            objBooking.UnitChange__c=true;
            objBooking.Area__c='Noida';
            objBooking.Remarks__c='Remarks';
            objBooking.Cretaed_On__c=system.today();
            objBooking.MG_Months_Year__c='jan-15';
            objBooking.MG_Mon_Year_Val__c=50;
            objBooking.Unit_No__c=objPU1.Id;
            objBooking.Advance_Registration_Reference_No__c='R-01';
            objBooking.Sharing_Per_Amt__c='1000.00';
            objBooking.MG_Per_Amt__c='2000.00';
            objBooking.Sharing_Per_Amt_Val__c=1400.00;
            objBooking.Quotation__c = q.Id;
            objBooking.Future_Correspondence_Contact__c = 'First Applicant';
            objBooking.Receipts__c = r1.Id;
            objBooking.ServiceReceipt__c = r2.Id;
            objBooking.Status__c = 'Booking In Process';
            objBooking.Opportunity__c = objOpportunity.id;
            insert objBooking;
            
            objPU1.Unit_Status__c = 'Sold';
            update objPU1;
            
            objOpportunity.Booking__c = objBooking.id;
            update objOpportunity;
            
            Customer_Pay_Plan_Header__c objCPPH = new Customer_Pay_Plan_Header__c();
              objCPPH.Amount__c=1000000.00;
              objCPPH.Customer__c=objopportunity.id; 
              objCPPH.Effect_From_Date__c=system.today(); 
              objCPPH.Global_Charges__c=ObjGloChrg.id; 
              objCPPH.Project__c=objpr.id; 
              objCPPH.Project_Unit__c=objPU1.id; 
              objCPPH.Standard_Pay_Plan_Header__c=objSPP.id;
              objCPPH.tower__c = t.ID;
              objCPPH.Quotation__c = q.id;
              objCPPH.PlanDt__c=system.today();
              objCPPH.Booking__c = objBooking.id;
              insert objCPPH;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdB1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdB1.Standard_Pay_Plan_Header__c = objSPP.id;
             scppdB1.Project__c=objpr.id;
             scppdB1.tower__c = t.ID;
             scppdB1.Is_to_be_Paid__c='From Dt. of Booking';
             scppdB1.Is_to_be__c = '0Day(s) from date of booking.';
             scppdB1.Days_Months__c='Day(s)';
             scppdB1.Days_Months_Value__c=0;
             scppdB1.Amount__c='Percentage';
             scppdB1.Installment__c=10000;
             scppdB1.Customer_Pay_Plan_Header__c = objCPPH.id;
             scppdB1.Due_Date__c = system.today();
             scppdB1.IsSendDemandLetter__c = false;
             scppdB1.Charge_Amount_Advance_Recd__c = 10000;
             scppdB1.Basic__c = 0;
             scppdB1.Development_Charges__c = 0;
             scppdB1.Floor_Rise__c = 0;
             scppdB1.Infrastructure_Charges__c = 0;
             scppdB1.Premium_1__c = 0;
             scppdB1.Premium_2__c = 0;
             scppdB1.Premium_3__c = 0;
             scppdB1.Premium_4__c = 0;
             scppdB1.Milestone_Percentage__c = 0;
             scppdB1.ST_On_Basic__c = 0;
             scppdB1.ST_On_Development_Charges__c = 0;
             scppdB1.ST_On_Floor_Rise__c = 0;
             scppdB1.ST_On_Infrastructure_Charges__c = 0;
             scppdB1.ST_on_Premium_1__c = 0;
             scppdB1.ST_on_Premium_2__c = 0;
             scppdB1.ST_on_Premium_3__c = 0;
             scppdB1.ST_on_Premium_4__c = 0;
             scppdB1.TDS__c = 0;
             scppdB1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdB1);
             
             
            Standard_Customer_Pay_Plan_Detail__c    scppdC1 = new Standard_Customer_Pay_Plan_Detail__c();
            scppdC1.Standard_Pay_Plan_Header__c = objSPP.id;
            scppdC1.Project__c=objpr.id;
            scppdC1.tower__c = t.ID;
            scppdC1.Is_to_be_Paid__c='Construction Stage';
            scppdC1.Days_Months__c='Day(s)';
            scppdC1.Project_Construction_Stages__c=objPCS1.id;
            scppdC1.Days_Months_Value__c=0;
            scppdC1.Amount__c='Percentage';
            scppdC1.Amount_Value__c=50;
            scppdC1.Installment__c = 103;
            scppdC1.Customer_Pay_Plan_Header__c = objCPPH.id;
            scppdC1.IsSendDemandLetter__c = false;
            scppdC1.Charge_Amount_Advance_Recd__c = 10000;
            scppdC1.Basic__c = 0;
             scppdC1.Development_Charges__c = 0;
             scppdC1.Floor_Rise__c = 0;
             scppdC1.Infrastructure_Charges__c = 0;
             scppdC1.Premium_1__c = 0;
             scppdC1.Premium_2__c = 0;
             scppdC1.Premium_3__c = 0;
             scppdC1.Premium_4__c = 0;
             scppdC1.Milestone_Percentage__c = 0;
             scppdC1.ST_On_Basic__c = 0;
             scppdC1.ST_On_Development_Charges__c = 0;
             scppdC1.ST_On_Floor_Rise__c = 0;
             scppdC1.ST_On_Infrastructure_Charges__c = 0;
             scppdC1.ST_on_Premium_1__c = 0;
             scppdC1.ST_on_Premium_2__c = 0;
             scppdC1.ST_on_Premium_3__c = 0;
             scppdC1.ST_on_Premium_4__c = 0;
             scppdC1.TDS__c = 0;
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
             
             // Legal
             Customer_Pay_Plan_Header__c objCPPH1 = new Customer_Pay_Plan_Header__c();
              objCPPH1.Amount__c=100000.00;
              objCPPH1.Customer__c=objopportunity.id; 
              objCPPH1.Effect_From_Date__c=system.today(); 
              objCPPH1.Global_Charges__c=ObjGloChrg3.id; 
              objCPPH1.Project__c=objpr.id; 
              objCPPH1.Project_Unit__c=objPU1.id; 
              objCPPH1.Standard_Pay_Plan_Header__c=objSPP2.id;
              objCPPH1.tower__c = t.ID;
              objCPPH1.Quotation__c = q.id;
              objCPPH1.PlanDt__c=system.today();
              objCPPH1.Booking__c = objBooking.id;
              insert objCPPH1;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdL1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdL1.Standard_Pay_Plan_Header__c = objSPP2.id;
             scppdL1.Project__c=objpr.id;
             scppdL1.tower__c = t.ID;
             scppdL1.Is_to_be_Paid__c='Registration';
             scppdL1.Is_to_be__c = 'At Registration';
             scppdL1.Days_Months__c='Day(s)';
             scppdL1.Days_Months_Value__c=0;
             scppdL1.Amount__c='Percentage';
             scppdL1.Installment__c=100000;
             scppdL1.Customer_Pay_Plan_Header__c = objCPPH1.id;
             scppdL1.Due_Date__c = system.today();
             scppdL1.IsSendDemandLetter__c = false;
             scppdL1.Charge_Amount_Advance_Recd__c = 10000;
             scppdL1.Basic__c = 0;
             scppdL1.Development_Charges__c = 0;
             scppdL1.Floor_Rise__c = 0;
             scppdL1.Infrastructure_Charges__c = 0;
             scppdL1.Premium_1__c = 0;
             scppdL1.Premium_2__c = 0;
             scppdL1.Premium_3__c = 0;
             scppdL1.Premium_4__c = 0;
             scppdL1.Milestone_Percentage__c = 0;
             scppdL1.ST_On_Basic__c = 0;
             scppdL1.ST_On_Development_Charges__c = 0;
             scppdL1.ST_On_Floor_Rise__c = 0;
             scppdL1.ST_On_Infrastructure_Charges__c = 0;
             scppdL1.ST_on_Premium_1__c = 0;
             scppdL1.ST_on_Premium_2__c = 0;
             scppdL1.ST_on_Premium_3__c = 0;
             scppdL1.ST_on_Premium_4__c = 0;
             scppdL1.TDS__c = 0;
             scppdL1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdL1);
             
             // Registration
             Customer_Pay_Plan_Header__c objCPPH2 = new Customer_Pay_Plan_Header__c();
              objCPPH2.Amount__c=30000.00;
              objCPPH2.Customer__c=objopportunity.id; 
              objCPPH2.Effect_From_Date__c=system.today(); 
              objCPPH2.Global_Charges__c=ObjGloChrg4.id; 
              objCPPH2.Project__c=objpr.id; 
              objCPPH2.Project_Unit__c=objPU1.id; 
              objCPPH2.Standard_Pay_Plan_Header__c=objSPP3.id;
              objCPPH2.tower__c = t.ID;
              objCPPH2.Quotation__c = q.id;
              objCPPH2.PlanDt__c=system.today();
              objCPPH2.Booking__c = objBooking.id;
              insert objCPPH2;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdR1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdR1.Standard_Pay_Plan_Header__c = objSPP3.id;
             scppdR1.Project__c=objpr.id;
             scppdR1.tower__c = t.ID;
             scppdR1.Is_to_be_Paid__c='Registration';
             scppdR1.Is_to_be__c = 'At Registration';
             scppdR1.Days_Months__c='Day(s)';
             scppdR1.Days_Months_Value__c=0;
             scppdR1.Amount__c='Percentage';
             scppdR1.Installment__c=30000;
             scppdR1.Customer_Pay_Plan_Header__c = objCPPH2.id;
             scppdR1.Due_Date__c = system.today();
             scppdR1.IsSendDemandLetter__c = false;
             scppdR1.Charge_Amount_Advance_Recd__c = 10000;
             scppdR1.Basic__c = 0;
             scppdR1.Development_Charges__c = 0;
             scppdR1.Floor_Rise__c = 0;
             scppdR1.Infrastructure_Charges__c = 0;
             scppdR1.Premium_1__c = 0;
             scppdR1.Premium_2__c = 0;
             scppdR1.Premium_3__c = 0;
             scppdR1.Premium_4__c = 0;
             scppdR1.Milestone_Percentage__c = 0;
             scppdR1.ST_On_Basic__c = 0;
             scppdR1.ST_On_Development_Charges__c = 0;
             scppdR1.ST_On_Floor_Rise__c = 0;
             scppdR1.ST_On_Infrastructure_Charges__c = 0;
             scppdR1.ST_on_Premium_1__c = 0;
             scppdR1.ST_on_Premium_2__c = 0;
             scppdR1.ST_on_Premium_3__c = 0;
             scppdR1.ST_on_Premium_4__c = 0;
             scppdR1.TDS__c = 0;
             scppdR1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdR1);
             
             // stamp duty
             Customer_Pay_Plan_Header__c objCPPH3 = new Customer_Pay_Plan_Header__c();
              objCPPH3.Amount__c=345000.00;
              objCPPH3.Customer__c=objopportunity.id; 
              objCPPH3.Effect_From_Date__c=system.today(); 
              objCPPH3.Global_Charges__c=ObjGloChrg5.id; 
              objCPPH3.Project__c=objpr.id; 
              objCPPH3.Project_Unit__c=objPU1.id; 
              objCPPH3.Standard_Pay_Plan_Header__c=objSPP4.id;
              objCPPH3.tower__c = t.ID;
              objCPPH3.Quotation__c = q.id;
              objCPPH3.PlanDt__c=system.today();
              objCPPH3.Booking__c = objBooking.id;
              insert objCPPH3;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdSD1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdSD1.Standard_Pay_Plan_Header__c = objSPP4.id;
             scppdSD1.Project__c=objpr.id;
             scppdSD1.tower__c = t.ID;
             scppdSD1.Is_to_be_Paid__c='Registration';
             scppdSD1.Is_to_be__c = 'At Registration';
             scppdSD1.Days_Months__c='Day(s)';
             scppdSD1.Days_Months_Value__c=0;
             scppdSD1.Amount__c='Percentage';
             scppdSD1.Installment__c=345000;
             scppdSD1.Customer_Pay_Plan_Header__c = objCPPH3.id;
             scppdSD1.Due_Date__c = system.today();
             scppdSD1.IsSendDemandLetter__c = false;
             scppdSD1.Charge_Amount_Advance_Recd__c = 10000;
             scppdSD1.Basic__c = 0;
             scppdSD1.Development_Charges__c = 0;
             scppdSD1.Floor_Rise__c = 0;
             scppdSD1.Infrastructure_Charges__c = 0;
             scppdSD1.Premium_1__c = 0;
             scppdSD1.Premium_2__c = 0;
             scppdSD1.Premium_3__c = 0;
             scppdSD1.Premium_4__c = 0;
             scppdSD1.Milestone_Percentage__c = 0;
             scppdSD1.ST_On_Basic__c = 0;
             scppdSD1.ST_On_Development_Charges__c = 0;
             scppdSD1.ST_On_Floor_Rise__c = 0;
             scppdSD1.ST_On_Infrastructure_Charges__c = 0;
             scppdSD1.ST_on_Premium_1__c = 0;
             scppdSD1.ST_on_Premium_2__c = 0;
             scppdSD1.ST_on_Premium_3__c = 0;
             scppdSD1.ST_on_Premium_4__c = 0;
             scppdSD1.TDS__c = 0;
             scppdSD1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdSD1);

             // mvat
             Customer_Pay_Plan_Header__c objCPPH4 = new Customer_Pay_Plan_Header__c();
              objCPPH4.Amount__c=150000.00;
              objCPPH4.Customer__c=objopportunity.id; 
              objCPPH4.Effect_From_Date__c=system.today(); 
              objCPPH4.Global_Charges__c=ObjGloChrg6.id; 
              objCPPH4.Project__c=objpr.id; 
              objCPPH4.Project_Unit__c=objPU1.id; 
              objCPPH4.Standard_Pay_Plan_Header__c=objSPP5.id;
              objCPPH4.tower__c = t.ID;
              objCPPH4.Quotation__c = q.id;
              objCPPH4.PlanDt__c=system.today();
              objCPPH4.Booking__c = objBooking.id;
              insert objCPPH4;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdM1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdM1.Standard_Pay_Plan_Header__c = objSPP5.id;
             scppdM1.Project__c=objpr.id;
             scppdM1.tower__c = t.ID;
             scppdM1.Is_to_be_Paid__c='From Dt. of Registration';
             scppdM1.Is_to_be__c = 'From Dt. of Registration';
             scppdM1.Days_Months__c='Day(s)';
             scppdM1.Days_Months_Value__c=0;
             scppdM1.Amount__c='Percentage';
             scppdM1.Installment__c=345000;
             scppdM1.Customer_Pay_Plan_Header__c = objCPPH4.id;
             scppdM1.Due_Date__c = system.today();
             scppdM1.IsSendDemandLetter__c = false;
             scppdM1.Charge_Amount_Advance_Recd__c = 10000;
             scppdM1.Basic__c = 0;
             scppdM1.Development_Charges__c = 0;
             scppdM1.Floor_Rise__c = 0;
             scppdM1.Infrastructure_Charges__c = 0;
             scppdM1.Premium_1__c = 0;
             scppdM1.Premium_2__c = 0;
             scppdM1.Premium_3__c = 0;
             scppdM1.Premium_4__c = 0;
             scppdM1.Milestone_Percentage__c = 0;
             scppdM1.ST_On_Basic__c = 0;
             scppdM1.ST_On_Development_Charges__c = 0;
             scppdM1.ST_On_Floor_Rise__c = 0;
             scppdM1.ST_On_Infrastructure_Charges__c = 0;
             scppdM1.ST_on_Premium_1__c = 0;
             scppdM1.ST_on_Premium_2__c = 0;
             scppdM1.ST_on_Premium_3__c = 0;
             scppdM1.ST_on_Premium_4__c = 0;
             scppdM1.TDS__c = 0;
             scppdM1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdM1);
             List<opportunity> objOpportunityList = new List<Opportunity>();
             objOpportunityList.add(objOpportunity);
             OpportunityManagementServices.updateBasicCPPHforRegistration(objOpportunityList); 
             OpportunityManagementServices.updateSCPPDDueDate(objOpportunityList);
             
             Global_Charges__c gc = new Global_Charges__c();
             gc.Code__c = '999';
             gc.Sequence_No__c = 200;
             gc.Description__c = 'Cheque Dishonor';
             gc.name = 'Cheque Dishonor';
             gc.Charge_Type__c = 'Cheque Dishonor';
             insert gc;
             
             Global_Charges__c gc2 = new Global_Charges__c();
             gc2.Code__c = '997';
             gc2.Sequence_No__c = 201;
             gc2.Description__c = 'Interest Installment';
             gc2.name = 'Interest Installment';
             gc2.Charge_Type__c = 'Interest Installment';
             insert gc2;
             
             Global_Charges__c gc3 = new Global_Charges__c();
             gc3.Code__c = '998';
             gc3.Sequence_No__c = 202;
             gc3.Description__c = 'Interest Servicetax';
             gc3.name = 'Interest Servicetax';
             gc3.Charge_Type__c = 'Interest Servicetax';
             insert gc3;
             
             Demand_Invoice__c di = new Demand_Invoice__c();
             di.Customer__c = objOpportunity.id;
             di.Total_Amount__c = 100000;
             di.Project__c = objpr.id;
             di.Invoice_Date__c = system.today().addDays(-10);
             di.Due_Date__c = system.today().addDays(10);
             di.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             di.Current_Demand_Service_Tax__c = 100000;
             insert di;
             
             list<id> diSet = new list<id>();
             diSet.add(di.id);
             LedgerManagementServices.createDebitLedgersForDemands(diSet);
             
             Receipt_Details__c rd = new Receipt_Details__c();
             rd.Amount__c = 100000;
             rd.Charges__c = PCharge.id;
             rd.Project__c = objpr.id;
             rd.Receipts__c = r1.id;
             rd.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             insert rd;
             
             Ledger__c lgrNew = new Ledger__c();
             lgrNew.Amount__c = 100000;
             lgrNew.Transaction_Date__c = system.today().addDays(-10);
             lgrNew.Debit_Credit__c = 'Debit';
             //lgrNew.Receipt_Details__c = rd.id;
             //lgrNew.Reciepts__c = r1.id;
             lgrNew.Global_Charges__c = ObjGloChrg2.id;
             lgrNew.Customer_Pay_Plan_Header__c = objCPPH.id;
             lgrNew.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             lgrNew.Remarks__c = 'Tax Received for: Basic';
             insert lgrNew;
             
             Ledger__c lgr = new Ledger__c();
             lgr.Amount__c = 100000;
             lgr.Transaction_Date__c = system.today().addDays(-10);
             lgr.Debit_Credit__c = 'Credit';
             lgr.Receipt_Details__c = rd.id;
             lgr.Reciepts__c = r1.id;
             lgr.Global_Charges__c = ObjGloChrg2.id;
             lgr.Customer_Pay_Plan_Header__c = objCPPH.id;
             lgr.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             lgr.Remarks__c = 'Tax Received for: Basic';
             insert lgr;
             
             
             trgReceiptHandler trg = new trgReceiptHandler();
             trg.dishonour(r1.id);
             
             ApexPages.currentPage().getParameters().put('id', r1.id);
             ApexPages.currentPage().getParameters().put('letterHead', 'true');
             PrintReceipt pr = new PrintReceipt(); 
             
             delete scppdB1;
             undelete scppdB1;
             
             delete rd;
             undelete rd;
             checkRecursion.resetFirstRun();
             delete lgr;
             undelete lgr;
             checkRecursion.resetFirstRun();
             delete lgrNew;
             undelete lgrNew;
    
    }
    @isTest
    private static void testDemandMgmtservi() {
        Legal_Entity__c objlglentity = new Legal_Entity__c();
            objlglentity.Name ='RS';
            objlglentity.RDS_Company_Code__c='rs';
            objlglentity.RDS_Service_Tax_No__c= '123456789012345';
            objlglentity.RDS_Company_Name__c='111';
            objlglentity.RDS_Address1__c='123';
            objlglentity.RDS_Address2__c='234';
            objlglentity.RDS_City__c='delhi';
            objlglentity.RDS_Pin_Code__c='201301';
            objlglentity.RDS_Phone__c='9953528045';
            objlglentity=RDSCommon.CreateLegalEntity(objlglentity);
            
            // Broker Creation
             Broker__c objBroK = new Broker__c();
             objBroK.Broker_Code__c = '12346';
             objBroK.Broker_Name__c = 'Brokname';
             objBroK.Status__c = 'Actives';
             objBroK=RDSCommon.CreateBroker(objBroK);
            // Project Creation
            Project__c objpr = new Project__c();
            objpr.Project_Code__c = 'T35';
            objpr.Name = 'SOS';
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
              
              // Unit structure creation
             Unit_Number_Structure__c objUn = new Unit_Number_Structure__c();
             objUn.Name = 'testUN';
             objUn.Description__c = 'Desc';
             objUn.Sequence_No__c = 2;
             objUn.Project__c = objpr.Id;
             objUn.Maximum_Length__c = 2;
             objUn.Delimiter__c = '/';
             objUn=RDSCommon.CreateUnitNumberStructure(objUn);
            // tower creation 
             Tower__c t = new Tower__c();
             t.Name = 'Tower X';
             t.ProjectName__c = objpr.Id;
             t = RDSCommon.CreateTower(t);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'GST';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 12;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Breakup__c txb1 = new Tax_Breakup__c();
             txb1.Tax_Slab__c = taxS.id;
             txb1.Taxable_Percentage__c = 66.66667;
             txb1.Tax_Code__c = 'CGST';
             txb1.Tax_Name__c = 'CGST';
             txb1.Tax_Percentage__c = 9.000;
             txb1.Tax_Type__c = 'Service Tax';
             txb1.Tax_Split_Type__c = 'CGST';
             insert txb1;
             
             Tax_Breakup__c txb2 = new Tax_Breakup__c();
             txb2.Tax_Slab__c = taxS.id;
             txb2.Taxable_Percentage__c = 66.66667;
             txb2.Tax_Code__c = 'SGST';
             txb2.Tax_Name__c = 'SGST';
             txb2.Tax_Percentage__c = 9.000;
             txb2.Tax_Type__c = 'Service Tax';
             txb2.Tax_Split_Type__c = 'SGST';
             insert txb2;
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'GST-18';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 18.00;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
             
             Tax_Breakup__c txb3 = new Tax_Breakup__c();
             txb3.Tax_Slab__c = taxS1.id;
             txb3.Taxable_Percentage__c = 100.00000;
             txb3.Tax_Code__c = 'CGST';
             txb3.Tax_Name__c = 'CGST';
             txb3.Tax_Percentage__c = 9.000;
             txb3.Tax_Type__c = 'Service Tax';
             txb3.Tax_Split_Type__c = 'CGST';
             insert txb3;
             
             Tax_Breakup__c txb4 = new Tax_Breakup__c();
             txb4.Tax_Slab__c = taxS1.id;
             txb4.Taxable_Percentage__c = 100.00000;
             txb4.Tax_Code__c = 'SGST';
             txb4.Tax_Name__c = 'SGST';
             txb4.Tax_Percentage__c = 9.000;
             txb4.Tax_Type__c = 'Service Tax';
             txb4.Tax_Split_Type__c = 'SGST';
             insert txb4;
             
             // global charges creation
             Global_Charges__c ObjGloChrg = new Global_Charges__c();
             ObjGloChrg.Name = 'Basic';
             ObjGloChrg.Code__c = '011';
             ObjGloChrg.Description__c = 'Basic';
             ObjGloChrg.Sequence_No__c = 99;
             ObjGloChrg.Charge_Type__c = 'Basic';
             ObjGloChrg.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
             
             Global_Charges__c ObjGloChrg1 = new Global_Charges__c();
             ObjGloChrg1.Name = 'Club Memebership';
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
             
             
             Global_Charges__c ObjGloChrg3 = new Global_Charges__c();
             ObjGloChrg3.Name = 'Legal Charges';
             ObjGloChrg3.Code__c = '016';
             ObjGloChrg3.Description__c = 'LEGAL CHARGES';
             ObjGloChrg3.Sequence_No__c = 106;
             ObjGloChrg3.Charge_Type__c = 'Legal Charges';
             ObjGloChrg3.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg3=RDSCommon.CreateGlobalCharges(ObjGloChrg3);
             
             
             Global_Charges__c ObjGloChrg4 = new Global_Charges__c();
             ObjGloChrg4.Name = 'Registration Charges';
             ObjGloChrg4.Code__c = '017';
             ObjGloChrg4.Description__c = 'REGISTRATION CHARGES';
             ObjGloChrg4.Sequence_No__c = 107;
             ObjGloChrg4.Charge_Type__c = 'Registration';
             ObjGloChrg4.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg4=RDSCommon.CreateGlobalCharges(ObjGloChrg4);
             
             Global_Charges__c ObjGloChrg5 = new Global_Charges__c();
             ObjGloChrg5.Name = 'Stamp Duty';
             ObjGloChrg5.Code__c = '018';
             ObjGloChrg5.Description__c = 'STAMP DUTY';
             ObjGloChrg5.Sequence_No__c = 108;
             ObjGloChrg5.Charge_Type__c = 'Stamp Duty';
             ObjGloChrg5.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg5=RDSCommon.CreateGlobalCharges(ObjGloChrg5);
             
             Global_Charges__c ObjGloChrg6 = new Global_Charges__c();
             ObjGloChrg6.Name = 'MVAT';
             ObjGloChrg6.Code__c = '019';
             ObjGloChrg6.Description__c = 'MVAT';
             ObjGloChrg6.Sequence_No__c = 109;
             ObjGloChrg6.Charge_Type__c = 'MVAT';
             ObjGloChrg6.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg6=RDSCommon.CreateGlobalCharges(ObjGloChrg6);
             
            Global_Charges__c  gh1 = new Global_Charges__c();
            gh1.name = 'Interest Installment';
            gh1.Code__c = '101';
            gh1.Description__c = 'Interest';
            gh1.Short_Name__c = 'INT';
            gh1.Sequence_No__c = 20;
            gh1.Charge_Type__c = 'Interest Rcvd';
            insert gh1;
            
            Global_Charges__c  gh2 = new Global_Charges__c();
            gh2.name = 'Interest Installment Waived';
            gh2.Code__c = '102';
            gh2.Description__c = 'Interest Installment Waived';
            gh2.Short_Name__c = 'INTWAIVE';
            gh2.Sequence_No__c = 21;
            gh2.Charge_Type__c = 'Interest Rcvd';
            insert gh2;
            
            Global_Charges__c  gh3 = new Global_Charges__c();
            gh3.name = 'Interest Servicetax';
            gh3.Code__c = '103';
            gh3.Description__c = 'Interest Servicetax';
            gh3.Short_Name__c = 'INTST';
            gh3.Sequence_No__c = 22;
            gh3.Charge_Type__c = 'Interest Rcvd';
            insert gh3;
            
            Global_Charges__c  gh4 = new Global_Charges__c();
            gh4.name = 'Interest Servicetax Waived';
            gh4.Code__c = '104';
            gh4.Description__c = 'Interest Servicetax Waived';
            gh4.Short_Name__c = 'INTSTWAI';
            gh4.Sequence_No__c = 23;
            gh4.Charge_Type__c = 'Interest Rcvd';
            insert gh4;
             
             
             // project charges creation
             // one basic
             // other is club membership, both are active.
             // one is lumpsum at project level and basic is based on ratelist defined for that unit
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
             PCharge1.S_Charge_Bucket__c = 'Society Charges';
             PCharge1.S_Payable_At__c = 'At Possession';
             PCharge1.Payment_Plan_Applicable__c = true;
             PCharge1.Service_Tax_Percentage__c = 'GST-18';
             PCharge1.Service_Tax_Applicable_on_this_charge__c = true;
             PCharge1=RDSCommon.CreateProjectCharges(PCharge1);
             
             Project_Charges__c PCharge2 = new Project_Charges__c();
             PCharge2.Charge_Code__c = ObjGloChrg3.Id;
             PCharge2.Project__c = objpr.Id;
             PCharge2.Name = 'Legal Charges';
             PCharge2.Active__c = true;
             PCharge2.Applied_This_Charge_To_FA__c = true;
             PCharge2.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
             PCharge2.S_Lumpsum_Charge_Amount__c = 100000;
             PCharge2.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge2.S_Payable_At__c = 'At Registration';
             PCharge2.Payment_Plan_Applicable__c = true;
             PCharge2=RDSCommon.CreateProjectCharges(PCharge2);
             
             Project_Charges__c PCharge3 = new Project_Charges__c();
             PCharge3.Charge_Code__c = ObjGloChrg4.Id;
             PCharge3.Project__c = objpr.Id;
             PCharge3.Name = 'Registration Charges';
             PCharge3.Active__c = true;
             PCharge3.Applied_This_Charge_To_FA__c = true;
             PCharge3.S_Charge_Calculated_As__c = 'Lumpsum at Project Level';
             PCharge3.S_Lumpsum_Charge_Amount__c = 30000;
             PCharge3.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge3.S_Payable_At__c = 'At Registration';
             PCharge3.Payment_Plan_Applicable__c = true;
             PCharge3=RDSCommon.CreateProjectCharges(PCharge3);
             
             Project_Charges__c PCharge4 = new Project_Charges__c();
             PCharge4.Charge_Code__c = ObjGloChrg5.Id;
             PCharge4.Project__c = objpr.Id;
             PCharge4.Name = 'Stamp Duty';
             PCharge4.Active__c = true;
             PCharge4.Applied_This_Charge_To_FA__c = true;
             PCharge4.S_Charge_Percentage__c = 5;
             PCharge3.S_Charge_Calculated_As__c = 'Higher of Ready Reckoner or Agreement Value';
             PCharge4.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge4.S_Payable_At__c = 'At Registration';
             PCharge4.Payment_Plan_Applicable__c = true;
             PCharge4=RDSCommon.CreateProjectCharges(PCharge4);
             
             Project_Charges__c PCharge5 = new Project_Charges__c();
             PCharge5.Charge_Code__c = ObjGloChrg6.Id;
             PCharge5.Project__c = objpr.Id;
             PCharge5.Name = 'MVAT';
             PCharge5.Active__c = true;
             PCharge5.Applied_This_Charge_To_FA__c = true;
             PCharge5.S_Charge_Percentage__c = 1;
             PCharge5.S_Lumpsum_Charge_Amount__c = 30000;
             PCharge5.S_Charge_Calculated_As__c = 'Higher of Ready Reckoner or Agreement Value';
             PCharge5.S_Charge_Bucket__c = 'Stamp Duty and Registration';
             PCharge5.S_Payable_At__c = 'At Registration';
             PCharge5.Payment_Plan_Applicable__c = true;
             PCharge5.Service_Tax_Percentage__c = 'GST-18';
             PCharge5.Service_Tax_Applicable_on_this_charge__c = true;
             PCharge5=RDSCommon.CreateProjectCharges(PCharge5);
             
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
             objPU1=RDSCommon.CreateProjectUnit(objPU1);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             
             //create users
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@xanadu.com', 'galvatron1@xanadu.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@xanadu.com', 'galvatron2@xanadu.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@xanadu.com', 'galvatron3@xanadu.com');
             
             // opportunity creation              
             Opportunity objOpportunity = new Opportunity();
             objOpportunity.Name = 'Test';
             objOpportunity.CloseDate = System.today();
             objOpportunity.AccountId = objac.Id; 
             objOpportunity.Status__c = 'Active'; 
             objOpportunity.StageName = 'Opportunity Identified'; 
             objOpportunity.Project__c = objpr.Id; 
             objOpportunity.Project_Unit__c = objPU1.Id;
             objOpportunity.Primary_Email__c = 'shock@transformers.com';
             objOpportunity.Other_Applicants_Email__c = 'three@crowd.com,noone@wold.com';
             objOpportunity.Other_Applicants_Name__c = 'Mr.Three is crowd,M/S.Amazing Girl';
             objOpportunity.Primary_Name__c = 'Sherlock Holmes';
             objOpportunity.Other_Applicants_Pancard__c= 'ROOOO101,BRBRBR01';
             objOpportunity.Primary_pancard__c  = 'IKJK099';
             objOpportunity.Permanent_Address__c = 'Somewhere only I know,Maharashtra,Nagpur,Maharashtra,India,875851';
             objOpportunity.Mailing_Address__c = 'Mailing Address,Nagpur,Maharashtra,India,900567';
             objOpportunity.Relationship_manager__c = a1.id;
             objOpportunity.Registration_Date__c = system.today().addDays(-2);
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
            
             // construction stage creation
             // two stages are being created
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
             objRL.Rate_List_Detail__c = objRLd.id;
             objRL=RDSCommon.CreateRateList(objRL);
             
             // payment plan creation associated to the construction stages
             Payment_Plan__c objPaymentPlan = new Payment_Plan__c(); 
             objPaymentPlan.Name ='Pay Plan 1';
             objPaymentPlan.Project__c = objpr .Id;
             objPaymentPlan.Tower__c = t.Id;
             insert objPaymentPlan;
             
             // standard payment plan header creation
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
             
             Standard_Pay_Plan_Header__c objSPP2 = new Standard_Pay_Plan_Header__c();
             objSPP2.Project__c = objpr.Id;
             objSPP2.tower__c = t.ID;
             objSPP2.Charge_Code__c= PCharge2.Id;
             objSPP2.Payment_Plan__c=objPaymentPlan.id;
             objSPP2.Name='Legal Header';
             objSPP2.Plan_Code__c= '90';
             objSPP2.Effective_from__c = System.today();
             objSPP2=RDSCommon.CreateStandardPayPlanHeader(objSPP2);
             
             Standard_Pay_Plan_Header__c objSPP3 = new Standard_Pay_Plan_Header__c();
             objSPP3.Project__c = objpr.Id;
             objSPP3.tower__c = t.ID;
             objSPP3.Charge_Code__c= PCharge3.Id;
             objSPP3.Payment_Plan__c=objPaymentPlan.id;
             objSPP3.Name='Registration Header';
             objSPP3.Plan_Code__c= '90';
             objSPP3.Effective_from__c = System.today();
             objSPP3=RDSCommon.CreateStandardPayPlanHeader(objSPP3);
             
             Standard_Pay_Plan_Header__c objSPP4 = new Standard_Pay_Plan_Header__c();
             objSPP4.Project__c = objpr.Id;
             objSPP4.tower__c = t.ID;
             objSPP4.Charge_Code__c= PCharge4.Id;
             objSPP4.Payment_Plan__c=objPaymentPlan.id;
             objSPP4.Name='Stamp Duty Header';
             objSPP4.Plan_Code__c= '90';
             objSPP4.Effective_from__c = System.today();
             objSPP4=RDSCommon.CreateStandardPayPlanHeader(objSPP4);
             
             Standard_Pay_Plan_Header__c objSPP5 = new Standard_Pay_Plan_Header__c();
             objSPP5.Project__c = objpr.Id;
             objSPP5.tower__c = t.ID;
             objSPP5.Charge_Code__c= PCharge5.Id;
             objSPP5.Payment_Plan__c=objPaymentPlan.id;
             objSPP5.Name='MVAT Header';
             objSPP5.Plan_Code__c= '90';
             objSPP5.Effective_from__c = System.today();
             objSPP5=RDSCommon.CreateStandardPayPlanHeader(objSPP5);
             
             // detail record for registration charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD10 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD10.Standard_Pay_Plan_Header__c = objSPP2.id;
             objSPPD10.Project__c=objpr.id;
             objSPPD10.tower__c = t.ID;
             objSPPD10.Is_to_be_Paid__c='At Registration';
             objSPPD10.Days_Months__c='Day(s)';
             objSPPD10.Days_Months_Value__c=0;
             objSPPD10.Amount__c='Percentage';
             objSPPD10.Amount_Value__c=100;
             objSPPD10.Installment__c = 100;
             objSPPD10= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD10);
             
             
              // detail record for legal charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD11 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD11.Standard_Pay_Plan_Header__c = objSPP3.id;
             objSPPD11.Project__c=objpr.id;
             objSPPD11.tower__c = t.ID;
             objSPPD11.Is_to_be_Paid__c='At Registration';
             objSPPD11.Days_Months__c='Day(s)';
             objSPPD11.Days_Months_Value__c=0;
             objSPPD11.Amount__c='Percentage';
             objSPPD11.Amount_Value__c=100;
             objSPPD11.Installment__c = 100;
             objSPPD11= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD11);
             
             
              // detail record for stamp duty charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD12 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD12.Standard_Pay_Plan_Header__c = objSPP4.id;
             objSPPD12.Project__c=objpr.id;
             objSPPD12.tower__c = t.ID;
             objSPPD12.Is_to_be_Paid__c='At Registration';
             objSPPD12.Days_Months__c='Day(s)';
             objSPPD12.Days_Months_Value__c=0;
             objSPPD12.Amount__c='Percentage';
             objSPPD12.Amount_Value__c=100;
             objSPPD12.Installment__c = 100;
             objSPPD12= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD12);
             
             // detail record for stamp duty charges
             // collected 100% in a single installment on registration
             Standard_Customer_Pay_Plan_Detail__c    objSPPD13 = new Standard_Customer_Pay_Plan_Detail__c();
             objSPPD13.Standard_Pay_Plan_Header__c = objSPP5.id;
             objSPPD13.Project__c=objpr.id;
             objSPPD13.tower__c = t.ID;
             objSPPD13.Is_to_be_Paid__c='At Registration';
             objSPPD13.Days_Months__c='Day(s)';
             objSPPD13.Days_Months_Value__c=0;
             objSPPD13.Amount__c='Percentage';
             objSPPD13.Amount_Value__c=100;
             objSPPD13.Installment__c = 100;
             objSPPD13= RDSCommon.CreateCustomerPayPlanHeaderDetail(objSPPD13);
             
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
             
             //create the approvers team
             Team__c objTeam = new Team__c();
             objTeam.Name = 'Sales Approvers Team';
             objTeam.Project__c = objpr.id;
             objTeam.Team_Type__c = 'Sales Approvers Team';
             objTeam.Tower__c = t.id;
             insert objTeam;
             
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

            Quotation__c q = new Quotation__c();
            q.Name = 'Q010101';
            q.Quote_Status__c = 'Valid';
            q.Prepared_Date__c = System.today();
            q.Project__c = objpr.Id;
            q.Project_Unit__c = objPU1.Id;
            q.FloorNo__c = 11;
            q.Opportunity__c = objOpportunity.Id;
            q.Appartment_Configuration__c = '1 BHK';
            q.Carpet_Area_Sq_Ft__c = 1200;
            q.Token_Amount__c =110000;
            q.ST_Token_Amount__c = 1000;
            q.Agreement_Value__c = 60422880;
            q.Agreement_Value_ST__c = 2537761;
            insert q;
            
            Receipt__c r1 = new Receipt__c();
            r1.Cheque_DD_Amount_Rs__c = 200000;
            r1.Cheque_DD__c = '908888';
            r1.Cheque_DD_Date__c = system.today();
            r1.Project__c = objpr.Id;
            r1.Project_Unit__c = objPU1.Id;
            r1.Opportunity__c = objOpportunity.Id;
            r1.CheckReceipt__c = true;
            r1.Token_Amount_Receipt__c = true;
            r1.Physically_Cheque_Received__c = true;
            r1.Approval_Status__c = 'Approved';
            r1.Receipt_Date__c = system.today();
            r1.DraweeBank__c = 'Axis Bank';
            r1.Total_Amount__c = 200000;
            insert r1;
            
            Receipt__c r2 = new Receipt__c();
            r2.Cheque_DD_Amount_Rs__c = 8400;
            r2.Cheque_DD__c = '9088881';
            r2.Cheque_DD_Date__c = system.today();
            r2.Project__c = objpr.Id;
            r2.Project_Unit__c = objPU1.Id;
            r2.Opportunity__c = objOpportunity.Id;
            r2.CheckReceipt__c = true;
            r2.Physically_Cheque_Received__c = true;
            r2.Approval_Status__c = 'Approved';
            r2.Receipt_Date__c = system.today();
            r2.DraweeBank__c = 'CITI';
            r2.Total_Amount__c = 8400;
            insert r2;
            
            Booking__c objBooking;
            objBooking = new Booking__c();
            objBooking.Code__c='1234';
            objBooking.Reg_No__c='150224';
            objBooking.Project__c=objpr.id;
            objBooking.Direct__c=true;
            objBooking.Broker_Code__c='A-022';
            objBooking.Broker_Name__c=' Broker 1';
            objBooking.Customer_Name__c='Client';
            objBooking.Effective_From__c=system.today();
            objBooking.Application_No__c='Ap-01';
            objBooking.Status__c='Approved';
            objBooking.MG_Effect_Date__c=system.today();
            objBooking.MG_Per_Amt_Val__c=222;
            objBooking.Customer__c=objOpportunity.id;
            objBooking.UnitChange__c=true;
            objBooking.Area__c='Noida';
            objBooking.Remarks__c='Remarks';
            objBooking.Cretaed_On__c=system.today();
            objBooking.MG_Months_Year__c='jan-15';
            objBooking.MG_Mon_Year_Val__c=50;
            objBooking.Unit_No__c=objPU1.Id;
            objBooking.Advance_Registration_Reference_No__c='R-01';
            objBooking.Sharing_Per_Amt__c='1000.00';
            objBooking.MG_Per_Amt__c='2000.00';
            objBooking.Sharing_Per_Amt_Val__c=1400.00;
            objBooking.Quotation__c = q.Id;
            objBooking.Future_Correspondence_Contact__c = 'First Applicant';
            objBooking.Receipts__c = r1.Id;
            objBooking.ServiceReceipt__c = r2.Id;
            objBooking.Status__c = 'Booking In Process';
            objBooking.Opportunity__c = objOpportunity.id;
            insert objBooking;
            
            objPU1.Unit_Status__c = 'Sold';
            update objPU1;
            
            objOpportunity.Booking__c = objBooking.id;
            update objOpportunity;
            
            Customer_Pay_Plan_Header__c objCPPH = new Customer_Pay_Plan_Header__c();
              objCPPH.Amount__c=1000000.00;
              objCPPH.Customer__c=objopportunity.id; 
              objCPPH.Effect_From_Date__c=system.today(); 
              objCPPH.Global_Charges__c=ObjGloChrg.id; 
              objCPPH.Project__c=objpr.id; 
              objCPPH.Project_Unit__c=objPU1.id; 
              objCPPH.Standard_Pay_Plan_Header__c=objSPP.id;
              objCPPH.tower__c = t.ID;
              objCPPH.Quotation__c = q.id;
              objCPPH.PlanDt__c=system.today();
              objCPPH.Booking__c = objBooking.id;
              insert objCPPH;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdB1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdB1.Standard_Pay_Plan_Header__c = objSPP.id;
             scppdB1.Project__c=objpr.id;
             scppdB1.tower__c = t.ID;
             scppdB1.Is_to_be_Paid__c='From Dt. of Booking';
             scppdB1.Is_to_be__c = '0Day(s) from date of booking.';
             scppdB1.Days_Months__c='Day(s)';
             scppdB1.Days_Months_Value__c=0;
             scppdB1.Amount__c='Percentage';
             scppdB1.Installment__c=10000;
             scppdB1.Customer_Pay_Plan_Header__c = objCPPH.id;
             scppdB1.Due_Date__c = system.today();
             scppdB1.IsSendDemandLetter__c = false;
             scppdB1.Charge_Amount_Advance_Recd__c = 10000;
             scppdB1.Basic__c = 0;
             scppdB1.Development_Charges__c = 0;
             scppdB1.Floor_Rise__c = 0;
             scppdB1.Infrastructure_Charges__c = 0;
             scppdB1.Premium_1__c = 0;
             scppdB1.Premium_2__c = 0;
             scppdB1.Premium_3__c = 0;
             scppdB1.Premium_4__c = 0;
             scppdB1.Milestone_Percentage__c = 0;
             scppdB1.ST_On_Basic__c = 0;
             scppdB1.ST_On_Development_Charges__c = 0;
             scppdB1.ST_On_Floor_Rise__c = 0;
             scppdB1.ST_On_Infrastructure_Charges__c = 0;
             scppdB1.ST_on_Premium_1__c = 0;
             scppdB1.ST_on_Premium_2__c = 0;
             scppdB1.ST_on_Premium_3__c = 0;
             scppdB1.ST_on_Premium_4__c = 0;
             scppdB1.TDS__c = 0;
             scppdB1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdB1);
             
             
            Standard_Customer_Pay_Plan_Detail__c    scppdC1 = new Standard_Customer_Pay_Plan_Detail__c();
            scppdC1.Standard_Pay_Plan_Header__c = objSPP.id;
            scppdC1.Project__c=objpr.id;
            scppdC1.tower__c = t.ID;
            scppdC1.Is_to_be_Paid__c='Construction Stage';
            scppdC1.Days_Months__c='Day(s)';
            scppdC1.Project_Construction_Stages__c=objPCS1.id;
            scppdC1.Days_Months_Value__c=0;
            scppdC1.Amount__c='Percentage';
            scppdC1.Amount_Value__c=50;
            scppdC1.Installment__c = 103;
            scppdC1.Customer_Pay_Plan_Header__c = objCPPH.id;
            scppdC1.IsSendDemandLetter__c = false;
            scppdC1.Charge_Amount_Advance_Recd__c = 10000;
            scppdC1.Basic__c = 0;
             scppdC1.Development_Charges__c = 0;
             scppdC1.Floor_Rise__c = 0;
             scppdC1.Infrastructure_Charges__c = 0;
             scppdC1.Premium_1__c = 0;
             scppdC1.Premium_2__c = 0;
             scppdC1.Premium_3__c = 0;
             scppdC1.Premium_4__c = 0;
             scppdC1.Milestone_Percentage__c = 0;
             scppdC1.ST_On_Basic__c = 0;
             scppdC1.ST_On_Development_Charges__c = 0;
             scppdC1.ST_On_Floor_Rise__c = 0;
             scppdC1.ST_On_Infrastructure_Charges__c = 0;
             scppdC1.ST_on_Premium_1__c = 0;
             scppdC1.ST_on_Premium_2__c = 0;
             scppdC1.ST_on_Premium_3__c = 0;
             scppdC1.ST_on_Premium_4__c = 0;
             scppdC1.TDS__c = 0;
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
             
             // Legal
             Customer_Pay_Plan_Header__c objCPPH1 = new Customer_Pay_Plan_Header__c();
              objCPPH1.Amount__c=100000.00;
              objCPPH1.Customer__c=objopportunity.id; 
              objCPPH1.Effect_From_Date__c=system.today(); 
              objCPPH1.Global_Charges__c=ObjGloChrg3.id; 
              objCPPH1.Project__c=objpr.id; 
              objCPPH1.Project_Unit__c=objPU1.id; 
              objCPPH1.Standard_Pay_Plan_Header__c=objSPP2.id;
              objCPPH1.tower__c = t.ID;
              objCPPH1.Quotation__c = q.id;
              objCPPH1.PlanDt__c=system.today();
              objCPPH1.Booking__c = objBooking.id;
              insert objCPPH1;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdL1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdL1.Standard_Pay_Plan_Header__c = objSPP2.id;
             scppdL1.Project__c=objpr.id;
             scppdL1.tower__c = t.ID;
             scppdL1.Is_to_be_Paid__c='Registration';
             scppdL1.Is_to_be__c = 'At Registration';
             scppdL1.Days_Months__c='Day(s)';
             scppdL1.Days_Months_Value__c=0;
             scppdL1.Amount__c='Percentage';
             scppdL1.Installment__c=100000;
             scppdL1.Customer_Pay_Plan_Header__c = objCPPH1.id;
             scppdL1.Due_Date__c = system.today();
             scppdL1.IsSendDemandLetter__c = false;
             scppdL1.Charge_Amount_Advance_Recd__c = 10000;
             scppdL1.Basic__c = 0;
             scppdL1.Development_Charges__c = 0;
             scppdL1.Floor_Rise__c = 0;
             scppdL1.Infrastructure_Charges__c = 0;
             scppdL1.Premium_1__c = 0;
             scppdL1.Premium_2__c = 0;
             scppdL1.Premium_3__c = 0;
             scppdL1.Premium_4__c = 0;
             scppdL1.Milestone_Percentage__c = 0;
             scppdL1.ST_On_Basic__c = 0;
             scppdL1.ST_On_Development_Charges__c = 0;
             scppdL1.ST_On_Floor_Rise__c = 0;
             scppdL1.ST_On_Infrastructure_Charges__c = 0;
             scppdL1.ST_on_Premium_1__c = 0;
             scppdL1.ST_on_Premium_2__c = 0;
             scppdL1.ST_on_Premium_3__c = 0;
             scppdL1.ST_on_Premium_4__c = 0;
             scppdL1.TDS__c = 0;
             scppdL1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdL1);
             
             // Registration
             Customer_Pay_Plan_Header__c objCPPH2 = new Customer_Pay_Plan_Header__c();
              objCPPH2.Amount__c=30000.00;
              objCPPH2.Customer__c=objopportunity.id; 
              objCPPH2.Effect_From_Date__c=system.today(); 
              objCPPH2.Global_Charges__c=ObjGloChrg4.id; 
              objCPPH2.Project__c=objpr.id; 
              objCPPH2.Project_Unit__c=objPU1.id; 
              objCPPH2.Standard_Pay_Plan_Header__c=objSPP3.id;
              objCPPH2.tower__c = t.ID;
              objCPPH2.Quotation__c = q.id;
              objCPPH2.PlanDt__c=system.today();
              objCPPH2.Booking__c = objBooking.id;
              insert objCPPH2;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdR1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdR1.Standard_Pay_Plan_Header__c = objSPP3.id;
             scppdR1.Project__c=objpr.id;
             scppdR1.tower__c = t.ID;
             scppdR1.Is_to_be_Paid__c='Registration';
             scppdR1.Is_to_be__c = 'At Registration';
             scppdR1.Days_Months__c='Day(s)';
             scppdR1.Days_Months_Value__c=0;
             scppdR1.Amount__c='Percentage';
             scppdR1.Installment__c=30000;
             scppdR1.Customer_Pay_Plan_Header__c = objCPPH2.id;
             scppdR1.Due_Date__c = system.today();
             scppdR1.IsSendDemandLetter__c = false;
             scppdR1.Charge_Amount_Advance_Recd__c = 10000;
             scppdR1.Basic__c = 0;
             scppdR1.Development_Charges__c = 0;
             scppdR1.Floor_Rise__c = 0;
             scppdR1.Infrastructure_Charges__c = 0;
             scppdR1.Premium_1__c = 0;
             scppdR1.Premium_2__c = 0;
             scppdR1.Premium_3__c = 0;
             scppdR1.Premium_4__c = 0;
             scppdR1.Milestone_Percentage__c = 0;
             scppdR1.ST_On_Basic__c = 0;
             scppdR1.ST_On_Development_Charges__c = 0;
             scppdR1.ST_On_Floor_Rise__c = 0;
             scppdR1.ST_On_Infrastructure_Charges__c = 0;
             scppdR1.ST_on_Premium_1__c = 0;
             scppdR1.ST_on_Premium_2__c = 0;
             scppdR1.ST_on_Premium_3__c = 0;
             scppdR1.ST_on_Premium_4__c = 0;
             scppdR1.TDS__c = 0;
             scppdR1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdR1);
             
             // stamp duty
             Customer_Pay_Plan_Header__c objCPPH3 = new Customer_Pay_Plan_Header__c();
              objCPPH3.Amount__c=345000.00;
              objCPPH3.Customer__c=objopportunity.id; 
              objCPPH3.Effect_From_Date__c=system.today(); 
              objCPPH3.Global_Charges__c=ObjGloChrg5.id; 
              objCPPH3.Project__c=objpr.id; 
              objCPPH3.Project_Unit__c=objPU1.id; 
              objCPPH3.Standard_Pay_Plan_Header__c=objSPP4.id;
              objCPPH3.tower__c = t.ID;
              objCPPH3.Quotation__c = q.id;
              objCPPH3.PlanDt__c=system.today();
              objCPPH3.Booking__c = objBooking.id;
              insert objCPPH3;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdSD1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdSD1.Standard_Pay_Plan_Header__c = objSPP4.id;
             scppdSD1.Project__c=objpr.id;
             scppdSD1.tower__c = t.ID;
             scppdSD1.Is_to_be_Paid__c='Registration';
             scppdSD1.Is_to_be__c = 'At Registration';
             scppdSD1.Days_Months__c='Day(s)';
             scppdSD1.Days_Months_Value__c=0;
             scppdSD1.Amount__c='Percentage';
             scppdSD1.Installment__c=345000;
             scppdSD1.Customer_Pay_Plan_Header__c = objCPPH3.id;
             scppdSD1.Due_Date__c = system.today();
             scppdSD1.IsSendDemandLetter__c = false;
             scppdSD1.Charge_Amount_Advance_Recd__c = 10000;
             scppdSD1.Basic__c = 0;
             scppdSD1.Development_Charges__c = 0;
             scppdSD1.Floor_Rise__c = 0;
             scppdSD1.Infrastructure_Charges__c = 0;
             scppdSD1.Premium_1__c = 0;
             scppdSD1.Premium_2__c = 0;
             scppdSD1.Premium_3__c = 0;
             scppdSD1.Premium_4__c = 0;
             scppdSD1.Milestone_Percentage__c = 0;
             scppdSD1.ST_On_Basic__c = 0;
             scppdSD1.ST_On_Development_Charges__c = 0;
             scppdSD1.ST_On_Floor_Rise__c = 0;
             scppdSD1.ST_On_Infrastructure_Charges__c = 0;
             scppdSD1.ST_on_Premium_1__c = 0;
             scppdSD1.ST_on_Premium_2__c = 0;
             scppdSD1.ST_on_Premium_3__c = 0;
             scppdSD1.ST_on_Premium_4__c = 0;
             scppdSD1.TDS__c = 0;
             scppdSD1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdSD1);

             // mvat
             Customer_Pay_Plan_Header__c objCPPH4 = new Customer_Pay_Plan_Header__c();
              objCPPH4.Amount__c=150000.00;
              objCPPH4.Customer__c=objopportunity.id; 
              objCPPH4.Effect_From_Date__c=system.today(); 
              objCPPH4.Global_Charges__c=ObjGloChrg6.id; 
              objCPPH4.Project__c=objpr.id; 
              objCPPH4.Project_Unit__c=objPU1.id; 
              objCPPH4.Standard_Pay_Plan_Header__c=objSPP5.id;
              objCPPH4.tower__c = t.ID;
              objCPPH4.Quotation__c = q.id;
              objCPPH4.PlanDt__c=system.today();
              objCPPH4.Booking__c = objBooking.id;
              insert objCPPH4;
              
             Standard_Customer_Pay_Plan_Detail__c    scppdM1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdM1.Standard_Pay_Plan_Header__c = objSPP5.id;
             scppdM1.Project__c=objpr.id;
             scppdM1.tower__c = t.ID;
             scppdM1.Is_to_be_Paid__c='From Dt. of Registration';
             scppdM1.Is_to_be__c = 'From Dt. of Registration';
             scppdM1.Days_Months__c='Day(s)';
             scppdM1.Days_Months_Value__c=0;
             scppdM1.Amount__c='Percentage';
             scppdM1.Installment__c=345000;
             scppdM1.Customer_Pay_Plan_Header__c = objCPPH4.id;
             scppdM1.Due_Date__c = system.today();
             scppdM1.IsSendDemandLetter__c = false;
             scppdM1.Charge_Amount_Advance_Recd__c = 10000;
             scppdM1.Basic__c = 0;
             scppdM1.Development_Charges__c = 0;
             scppdM1.Floor_Rise__c = 0;
             scppdM1.Infrastructure_Charges__c = 0;
             scppdM1.Premium_1__c = 0;
             scppdM1.Premium_2__c = 0;
             scppdM1.Premium_3__c = 0;
             scppdM1.Premium_4__c = 0;
             scppdM1.Milestone_Percentage__c = 0;
             scppdM1.ST_On_Basic__c = 0;
             scppdM1.ST_On_Development_Charges__c = 0;
             scppdM1.ST_On_Floor_Rise__c = 0;
             scppdM1.ST_On_Infrastructure_Charges__c = 0;
             scppdM1.ST_on_Premium_1__c = 0;
             scppdM1.ST_on_Premium_2__c = 0;
             scppdM1.ST_on_Premium_3__c = 0;
             scppdM1.ST_on_Premium_4__c = 0;
             scppdM1.TDS__c = 0;
             scppdM1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdM1);
             
             Set < Id > consStageIdList = new Set < Id >();
             consStageIdList.add(objPCS.id);
             List < DemandManagementServices.wrpCustomers > searchCustomersBasedOnStage = DemandManagementServices.searchCustomersBasedOnStage(consStageIdList);
             List < DemandManagementServices.wrpCustomers > searchCustomersBasedOnDates = DemandManagementServices.searchCustomersBasedOnDates(system.today().addDays(-10),system.today(),objpr.id,t.id);
             Map<String,Decimal> getDemandSoFarSummaryOtherCharges = DemandManagementServices.getDemandSoFarSummaryOtherCharges(objopportunity.id);
             checkRecursion.resetFirstRun();
             checkRecursion.resetFirstRunA();
             checkRecursion.isFirstRunA();
             checkRecursion.isFirstRunA();
             checkRecursion.resetFirstRunCPPH();
             checkRecursion.isFirstRunCPPH();
             checkRecursion.isFirstRunCPPH();
    }
    
    
}