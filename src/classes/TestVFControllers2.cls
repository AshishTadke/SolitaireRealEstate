@isTest
private  Class TestVFControllers2 {
@isTest
    private static void receipts() {
    
      
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
          List<Id> oppId = new List<Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);
            
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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'Service Tax 1';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 4.20;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'Service Tax 2';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 14;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
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
             pCharge.Service_Tax_Percentage__c = 'Service Tax 1';
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
             PCharge1.Service_Tax_Percentage__c = 'Service Tax 2';
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
             PCharge5.Service_Tax_Percentage__c = 'Service Tax 2';
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
             recordIdMap.put('UNIT',objPU1.Id);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             recordIdMap.put('ACCOUNT',objac.Id);
             
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
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
             oppId.add(objOpportunity.Id);
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
             recordIdMap.put('PAYPLAN',objPaymentPlan.Id);
             
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
             recordIdMap.put('APPROVER1',tm1.Id);
             
             Team_Members__c tm2 = new Team_Members__c();
             tm2.Team__c = objTeam.Id;
             tm2.User_Active__c = true;
             tm2.Approver_Type__c = 'Second Level';
             tm2.User__c = a2.id;
             insert tm2;
             recordIdMap.put('APPROVER2',tm2.Id);
             
             Team_Members__c tm3 = new Team_Members__c();
             tm3.Team__c = objTeam.Id;
             tm3.User_Active__c = true;
             tm3.Approver_Type__c = 'Third Level';
             tm3.User__c = a3.id;
             insert tm3;
            recordIdMap.put('APPROVER3',tm3.Id);

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
             scppdM1.Is_to_be_Paid__c='Registration';
             scppdM1.Is_to_be__c = 'At Registration';
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
             
             PageReference upsPage = Page.updateConsStageNew;
             Test.setCurrentPage(upsPage);
             Apexpages.currentPage().getParameters().put('Pid',objPr.id);
             updateConsStageNew ups = new updateConsStageNew();
          PaymentManagementServices.getChequeDishonours(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoney(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyFlatcost(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyGST(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneySDR(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyFlatcost4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyGST4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneySDR4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoney(oppId);
      
      
      
      /*       
             List < SelectOption > tList = ups.getTowerSelectList();
             //ups.towerID = t.Id;
             //List < SelectOption > stageList = ups.getConstructionSelectList();
             //list<SelectOption> options = ups.updateOptions;
             //ups.updateType = 'plannedDate';
             //ups.plannedDate = system.today().addDays(50);
             //ups.stageId = objPCS1.id;
             ups.save();
             Attachment objattch = ups.objattachment;
             objattch.name='test';
             objattch.ParentId=objPCS1.id;
             Blob bodyBlob=Blob.valueOf('test');
             objattch.body=bodyBlob;
             ups.upload();
            
             ups.towerID = t.Id;
             ups.updateType = 'completionDate';
             ups.dueDate = system.today();
             ups.stageId = objPCS1.id;
             ups.save();
             ups.dummy();
             ups.refresh();
             ups.cancel();
             
    */
            
            
            PageReference demandRef = Page.S_sendDemandInvoice2;
            Test.setCurrentPage(demandRef);
            ApexPages.currentPage().getParameters().put('bookingId',objBooking.Id);
            
            S_sendDemandInvoice2 sd = new S_SendDemandInvoice2();
            sd.selectedProjectId =objpr.Id;
            list<SelectOption> sopt = sd.searchOptions;
            list<SelectOption> lp = sd.lstProjects;
            list<SelectOption> cons = sd.lstStructionStages;
            sd.selectedTowerId = t.Id;
            sd.tabName = 'search';
            sd.rowIndex = 0;
            sd.ShowPreview();
            Test.startTest();    
            Apexpages.currentPage().getParameters().put('towerName', 'Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd.getCustomersTowerWise();
            sd.tabName = 'pendingDemands';
            sd.rowIndex = 0;
            sd.ShowPreview();
            sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
            
             Demand_Invoice__c DemandInv11 = new Demand_Invoice__c();
             DemandInv11.Customer__c = objOpportunity.Id;
             DemandInv11.Invoice_Date__c = System.Today();
             DemandInv11.Due_Date__c = System.Today().addDays(10);
             DemandInv11.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv11.Total_Demanded_Installment__c = 10000;
             DemandInv11.Total_Demanded_Service_Tax__c = 4350;
             DemandInv11.Total_Recd_Installment__c = 10000;
             DemandInv11.Total_Recd_Service_Tax__c = 4350;
             DemandInv11.Outstanding_Installment__c = 0;
             DemandInv11.Outstanding_Service_Tax__c = 0;
             DemandInv11.Current_Demand_Installment__c = 10000;
             DemandInv11.Current_Demand_Service_Tax__c = 4350;
             DemandInv11.Is_Advanced_Demand__c = true;
             DemandInv11.Registration_Demand_Generation__c = false;
             DemandInv11.Legal_Charges_Service_Tax__c = 1000;
             DemandInv11.Legal_Charges_Amount__c = 5000;
             DemandInv11.MVAT_Amount__c = 4000;
             DemandInv11.Stamp__c = 1000;
             //DemandInv.Registration_Charges_Amount__c = 4000;
             DemandInv11.Ready_Reckoner_Value__c = 4000;
             DemandInv11.Agreement_Value__c = 20000;
             DemandInv11.Interest_Amount__c = 5000; 
             DemandInv11.Service_Tax_on_Interest__c = 1000;
             insert DemandInv11;
             
             Demand_Invoice__c DemandInv1 = new Demand_Invoice__c();
             DemandInv1.Customer__c = objOpportunity.Id;
             DemandInv1.Invoice_Date__c = System.Today();
             DemandInv1.Due_Date__c = System.Today().addDays(10);
             DemandInv1.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv1.Total_Demanded_Installment__c = 10000;
             DemandInv1.Total_Demanded_Service_Tax__c = 4350;
             DemandInv1.Total_Recd_Installment__c = 10000;
             DemandInv1.Total_Recd_Service_Tax__c = 4350;
             DemandInv1.Outstanding_Installment__c = 0;
             DemandInv1.Outstanding_Service_Tax__c = 0;
             DemandInv1.Current_Demand_Installment__c = 10000;
             DemandInv1.Current_Demand_Service_Tax__c = 4350;
             DemandInv1.Is_Advanced_Demand__c = false;
             DemandInv1.Registration_Demand_Generation__c = true;
             DemandInv1.Legal_Charges_Service_Tax__c = 1000;
             DemandInv1.Legal_Charges_Amount__c = 5000;
             DemandInv1.MVAT_Amount__c = 4000;
             DemandInv1.Stamp__c = 1000;
             DemandInv1.Registration_Charges_Amount__c = 4000;
             DemandInv1.Ready_Reckoner_Value__c = 4000;
             DemandInv1.Agreement_Value__c = 20000;
             DemandInv1.Interest_Amount__c = 5000; 
             DemandInv1.Service_Tax_on_Interest__c = 1000;
             insert DemandInv1;
             
              S_DemandLetter sdl11  = new S_DemandLetter();
            sdl11.strDemandInvId = DemandInv1.id;
            sdl11.getDemandLetter();
            sdl11.chargeAmountMap.put('Ready Reckoner',1000);
            sdl11.chargeAmountMap.put('Stamp Duty',1000);
            sdl11.chargeAmountMap.put('Registration Charges',1000);
            sdl11.chargeAmountMap.put('Legal Charges',1000);
            sdl11.chargeAmountMap.put('Legal Charges TAX',1000);
            sdl11.chargeAmountMap.put('MVAT',1000);
            sdl11.chargeAmountMap.put('Basic TOTAL',1000);
            sdl11.prepareDemandUIMapforRegPreview();
            
            Tax_Breakup__c tx = new Tax_Breakup__c();
            tx.Tax_Slab__c = taxS.Id;
            tx.Taxable_Percentage__c = 4;
            tx.Tax_Code__c = 'ST3FP';
            tx.Tax_Percentage__c = 100;
            tx.Tax_Type__c = 'Service Tax';
            tx.Tax_Split_Type__c = 'Basic';
            insert tx;
            
            Tax_Breakup__c tx1 = new Tax_Breakup__c();
            tx1.Tax_Slab__c = taxS.Id;
            tx1.Taxable_Percentage__c = 0.5;
            tx1.Tax_Code__c = 'SBFB';
            tx1.Tax_Percentage__c = 100;
            tx1.Tax_Type__c = 'Service Tax';
            tx1.Tax_Split_Type__c = 'SBC';
            insert tx1;
            
            Tax_Breakup__c tx11 = new Tax_Breakup__c();
            tx11.Tax_Slab__c = taxS.Id;
            tx11.Taxable_Percentage__c = 0.5;
            tx11.Tax_Code__c = 'KKCFB';
            tx11.Tax_Percentage__c = 100;
            tx11.Tax_Type__c = 'Service Tax';
            tx11.Tax_Split_Type__c = 'KKC';
            insert tx11;
            
            PageReference dPage = Page.DemandLetterTemplate;
            Test.setCurrentPage(dPage);
            ApexPages.currentPage().getParameters().put('demandType','Flat Cost');
            ApexPages.currentPage().getParameters().put('mileStoneList',scppdB1.Id);
            ApexPages.currentPage().getParameters().put('mode','preview');
            ApexPages.currentPage().getParameters().put('DemandInvId',DemandInv11.Id);
            ApexPages.currentPage().getParameters().put('letterHead','true');
            ApexPages.currentPage().getParameters().put('advanceAmt','1000');
            ApexPages.currentPage().getParameters().put('stAmt','400');
            DemandLetterTemplate dt = new DemandLetterTemplate();
            S_DemandLetter sdl  = new S_DemandLetter();
            sdl.strMode = 'preview';
            sdl.strMileStoneList = scppdB1.id;
            sdl.strDemandType = 'Flat Cost';
            sdl.strDemandInvId = DemandInv11.Id;
        	sdl.DemandNumber = DemandInv11.Name;
            sdl.getDemandLetter();
            /**
            PageReference dPage = Page.DemandLetterTemplate;
            Test.setCurrentPage(dPage);
            ApexPages.currentPage().getParameters().put('demandType','Flat Cost');
            ApexPages.currentPage().getParameters().put('mileStoneList',scppdB1.Id);
            ApexPages.currentPage().getParameters().put('mode','preview');
            DemandLetterTemplate dt = new DemandLetterTemplate();
            S_DemandLetter sdl  = new S_DemandLetter();
            sdl.strMode = 'preview';
            sdl.strMileStoneList = scppdB1.id;
            sdl.strDemandType = 'Flat Cost';
            
            sdl.getDemandLetter();**/
            sdl.wrpDemand.ChargeTaxMapD.put('Basic TAXABLE VALUE D',10000);
            sdl.wrpDemand.ChargeTaxMapD.put('TOTAL TAX AMT D',10000);
            sdl.DemandInv.Total_Demanded_Installment__c = 100000;
            sdl.DemandInv.Total_Demanded_Service_Tax__c = 100000;
            sdl.DemandInv.Total_Demanded_Service_Tax_KKC__c = 100000;
            sdl.DemandInv.Total_Demanded_Service_Tax_SBC__c = 100000;
            sdl.DemandInv.Total_Demanded_Service_Tax_Basic__c = 100000;
            sdl.DemandInv.Total_Demanded_Installment__c  = 100000;
            sdl.DemandInv.Total_Demanded_Service_Tax__c = 100000;
            
            sdl.DemandInv.Total_Recd_Installment__c = 100000;
            sdl.DemandInv.Total_Recd_Service_Tax__c = 100000;
            sdl.DemandInv.Total_Recd_Service_Tax_KKC__c = 100000;
            sdl.DemandInv.Total_Recd_Service_Tax_SBC__c = 100000;
            sdl.DemandInv.Total_Recd_Service_Tax_Basic__c = 100000;
            sdl.DemandInv.Outstanding_Installment__c = 100000;
            sdl.DemandInv.Outstanding_Service_Tax__c = 100000;
            
            sdl.DemandInv.Outstanding_Service_Tax_KKC__c = 100000;
            sdl.DemandInv.Outstanding_Service_Tax_SBC__c = 100000;
            sdl.DemandInv.Outstanding_Service_Tax_Basic__c = 100000;
            sdl.DemandInv.Interest_Amount__c = 100000;
            sdl.DemandInv.Service_Tax_on_Interest__c = 100000;
            sdl.DemandInv.Current_Demand_Installment__c = 100000;
            sdl.DemandInv.Current_Demand_Service_Tax__c = 100000;
            
            sdl.DemandInv.Current_Demand_Service_Tax_KKC__c = 100000;
            sdl.DemandInv.Current_Demand_Service_Tax_SBC__c = 100000;
            sdl.DemandInv.Current_Demand_Service_Tax_Basic__c = 100000;
            
            sdl.DemandInv.Total_Payable_Installment__c = 100000;
            sdl.DemandInv.Total_Payable_Service_Tax__c = 100000;
            sdl.DemandInv.Total_Payable_Overall__c = 100000;
            sdl.prepareDemandUIMapforshowInvoice();
            sdl.prepareDemandUIMapForshowInvoiceAdvance();
            sdl.prepareDemandUIMapforShowNew(DemandInv11.Id);
            //sd.CustomerTowerList[0].selected = true;
           // sd.sendMail();
           
            
            objCPPH.Amount_Demanded_Till_Date__c = 1000000;
            objCPPH.Amount_Recd_Till_Date__c = 900000;
            objCPPH.Registration_Intimation_Sent__c = true;
            objCPPH.show_registration_demand__c = true;
            update objCPPH;
           
            
            S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
            sd1.selectedProjectId =objpr.Id;
            list<SelectOption> sopt1 = sd1.searchOptions;
            list<SelectOption> lp1 = sd1.lstProjects;
            list<SelectOption> cons1 = sd1.lstStructionStages;
            sd1.selectedTowerId = t.Id;
            list<SelectOption> lp2t = sd1.lstTower;
            Apexpages.currentPage().getParameters().put('towerNameReg', 'SOS-Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd1.getCustomersTowerWiseReg();
            sd1.tabName = 'pendingRegistrations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListReg[0].selected = true;
            sd1.sendMail(); 
            
           
            PageReference pRef = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef);
            S_ReceiptModuleController rmc = new S_ReceiptModuleController();
            rmc.rmw.r.Project_Unit__c  = objPU1.id;
            rmc.rmw.r.Project__c  = objpr.id;
            
            rmc.UnitSelectionValidation();
        
            rmc.rmw.r.mode__c = 'Cheque';
            rmc.rmw.r.Receipt_Date__c = system.today();
            rmc.rmw.r.Cheque_DD_Date__c = system.today();
            rmc.rmw.r.DraweeBank__c = 'AXIS';
            rmc.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc.rmw.r.Currency__c = 'Indian Rupee';
            rmc.rmw.r.Amount_Rs__c = 2000000;
            rmc.entitySelected = 'VISHWAROOP';
            rmc.ApplyReceipt();
            
            objOpportunity.stageName = 'Booking Confirmed';
            update objOpportunity;
            Test.stoptest();  
            S_ReceiptModuleController rmc1 = new S_ReceiptModuleController();
            receipt__c rc = new receipt__c();
            rc.Receipt_Date__c = system.today();
            rc.Cheque_DD_Date__c = system.today();
            rc.DraweeBank__c = 'AXIS';
            rc.Amount_Rs__c = 2000000;
            rc.mode__c = 'Cheque';
            insert rc;
            
            receipt__c rc2 = new receipt__c();
            rc2.Receipt_Date__c = system.today();
            rc2.Cheque_DD_Date__c = system.today();
            rc2.DraweeBank__c = 'Other';
            rc2.Drawee_Bank_If_Others__c = 'ABC';
            rc2.Amount_Rs__c = 2000000;
            rc2.mode__c = 'Cheque';
            insert rc2;
            
            rmc1.rmw.r.Project_Unit__c  = objPU1.id;
            rmc1.rmw.r.Project__c  = objpr.id;
            rmc1.UnitSelectionValidation();
            rmc1.rmw.r.mode__c = 'Cheque';
            rmc1.rmw.r.Receipt_Date__c = system.today();
            rmc1.rmw.r.Cheque_DD_Date__c = system.today();
            rmc1.rmw.r.DraweeBank__c = 'AXIS';
            rmc1.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc1.rmw.r.Currency__c = 'Indian Rupee';
            rmc1.rmw.r.Amount_Rs__c = 2000000;
            rmc1.entitySelected = 'VISHWAROOP';
            rmc1.ApplyReceipt();
            //rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 2000000;
            //rmc1.applyAdvance();
            //rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            //rmc1.applyAdvance();
            rmc1.rowIndex = 0;
            rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            rmc1.pw1List[0].upcomingInstallment = 100000;
            rmc1.raiseDemand();
            
            S_ReceiptModuleController rmc11 = new S_ReceiptModuleController();
            rmc11.rmw.r.Project_Unit__c  = objPU1.id;
            rmc11.rmw.r.Project__c  = objpr.id;
            
            rmc11.UnitSelectionValidation();
        
            rmc11.rmw.r.mode__c = 'Cheque';
            rmc11.rmw.r.Receipt_Date__c = system.today();
            rmc11.rmw.r.Cheque_DD_Date__c = system.today();
            rmc11.rmw.r.DraweeBank__c = 'AXIS';
            rmc11.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc11.rmw.r.Currency__c = 'Indian Rupee';
            rmc11.rmw.r.Amount_Rs__c = 2000000;
            rmc11.entitySelected = 'VISHWAROOP';
            rmc11.checkDupeList();
            rmc11.ApplyReceipt();
            
            S_ReceiptModuleController rmc12 = new S_ReceiptModuleController();
            rmc12.rmw.r.Project_Unit__c  = objPU1.id;
            rmc12.rmw.r.Project__c  = objpr.id;
            
            rmc12.UnitSelectionValidation();
        
            rmc12.rmw.r.mode__c = 'Cheque';
            rmc12.rmw.r.Receipt_Date__c = system.today();
            rmc12.rmw.r.Cheque_DD_Date__c = system.today();
            rmc12.rmw.r.DraweeBank__c = 'Other';
            rmc12.rmw.r.Drawee_Bank_If_Others__c = null;
            rmc12.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc12.rmw.r.Currency__c = 'Indian Rupee';
            rmc12.rmw.r.Amount_Rs__c = 2000000;
            rmc12.entitySelected = 'VISHWAROOP';
            rmc12.checkDupeList();
            rmc12.ApplyReceipt();
            rmc12.rmw.r.Drawee_Bank_If_Others__c = 'ABC';
            rmc12.checkDupeList();
            rmc12.ApplyReceipt();
            
            S_ReceiptModuleController rmc13 = new S_ReceiptModuleController();
            rmc13.rmw.r.Project_Unit__c  = objPU1.id;
            rmc13.rmw.r.Project__c  = objpr.id;
            
            //rmc13.UnitSelectionValidation();
        
            rmc13.rmw.r.mode__c = 'DD/Pay Order';
            rmc13.rmw.r.Receipt_Date__c = system.today();
            rmc13.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc13.rmw.r.DraweeBank__c = 'AXIS';
            rmc13.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc13.rmw.r.Currency__c = 'Indian Rupee';
            rmc13.rmw.r.Amount_Rs__c = 2000000;
            rmc13.entitySelected = 'VISHWAROOP';
            //rmc13.checkDupeList();
            rmc13.ApplyReceipt();
            
            S_ReceiptModuleController rmc14 = new S_ReceiptModuleController();
            rmc14.rmw.r.Project_Unit__c  = objPU1.id;
            rmc14.rmw.r.Project__c  = objpr.id;
            
            //rmc14.UnitSelectionValidation();
        
            rmc14.rmw.r.mode__c = 'TDS';
            rmc14.rmw.r.Receipt_Date__c = system.today();
            rmc14.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc14.rmw.r.DraweeBank__c = 'AXIS';
            rmc14.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc14.rmw.r.Currency__c = 'Indian Rupee';
            rmc14.rmw.r.Amount_Rs__c = 2000000;
            rmc14.entitySelected = 'VISHWAROOP';
            //rmc14.checkDupeList();
            rmc14.ApplyReceipt();
            
            S_ReceiptModuleController rmc15 = new S_ReceiptModuleController();
            rmc15.rmw.r.Project_Unit__c  = objPU1.id;
            rmc15.rmw.r.Project__c  = objpr.id;
            
            //rmc15.UnitSelectionValidation();
        
            rmc15.rmw.r.mode__c = 'TDS';
            rmc15.rmw.r.Receipt_Date__c = system.today();
            rmc15.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc15.rmw.r.DraweeBank__c = 'AXIS';
            rmc15.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc15.rmw.r.Currency__c = 'Indian Rupee';
            rmc15.rmw.r.Amount_Rs__c = 2000000;
            rmc15.rmw.r.Receipt_status__c = 'Cleared';
            rmc15.entitySelected = 'VISHWAROOP';
            //rmc15.checkDupeList();
            rmc15.adjustmentFlow = true;
            //rmc15.foreignCurrency = true;
            //rmc15.penalties = true;
            rmc15.ApplyReceipt();
            
            S_ReceiptModuleController rmc16 = new S_ReceiptModuleController();
            rmc16.rmw.r.Project_Unit__c  = objPU1.id;
            rmc16.rmw.r.Project__c  = objpr.id;
            
            //rmc15.UnitSelectionValidation();
        
            rmc16.rmw.r.mode__c = 'Cheque';
            rmc16.rmw.r.Receipt_Date__c = system.today();
            rmc16.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc16.rmw.r.DraweeBank__c = 'AXIS';
            rmc16.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc16.rmw.r.Currency__c = 'US Dollar';
            rmc16.rmw.r.Amount_Rs__c = 2000000;
            //rmc16.rmw.r.Receipt_status__c = 'Cleared';
            rmc16.entitySelected = 'VISHWAROOP';
            //rmc15.checkDupeList();
            rmc16.adjustmentFlow = false;
            rmc16.foreignCurrency = true;
            rmc16.penalties = true;
            rmc16.ApplyReceipt();
            //rmc16.Save();
             
            PageReference pRef1 = Page.S_ReceiptDashboard;
            Test.setCurrentPage(pRef1);
            S_ReceiptDashboardClass rdb = new S_ReceiptDashboardClass();
             trgReceiptHandler trgrc = new trgReceiptHandler();
            Receipt_Details__c rd = new Receipt_Details__c();
            //rd.Charges__r.Charge_Code__c = 
           // rd.Charges__r.Charge_Code__r.Id =
            rd.Amount__c = 10000;
            rd.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            rd.Is_Cheque_Dishonour__c = true;
            rd.Is_Interest_Settlement__c = true;
            rd.Is_Advanced_Demand__c = true;
            rd.Project__c = objpr.Id;
           // rd.Demand_Invoice__c = 
            rd.Receipts__c = r1.Id;
            rd.Is_Interest_Settlement_ST__c = true;
            //insert rd;          
            
            Ledger__c ldr = new Ledger__c();
            ldr.Debit_Credit__c = 'Credit';
            ldr.Amount__c = 10000;
            ldr.Customer_Pay_Plan_Header__c = objCPPH1.Id;
            ldr.Global_Charges__c = ObjGloChrg1.id;
            ldr.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            //ldr.Receipt_Details__c = rd.Id;
            ldr.Customer_Pay_Plan_Header__c = objCPPH.Id;
            ldr.Opportunity__c = objOpportunity.Id;
            //ldr.Demand_Invoice__C = 
            ldr.Reciepts__c = r1.Id;
            insert ldr;
                   
            //trgrc.dishonour(r1.Id);         
            trgrc.verificationRejection(r1.Id);
            
            S_PaymentReceiptComponentController paymentc = new S_PaymentReceiptComponentController();
            Receipt__c ric = new Receipt__c();
            ric.Cheque_DD_Amount_Rs__c = 200000;
            ric.Cheque_DD__c = '908888';
            ric.Cheque_DD_Date__c = system.today();
            ric.Project__c = objpr.Id;
            ric.Project_Unit__c = objPU1.Id;
            ric.Opportunity__c = objOpportunity.Id;
            ric.CheckReceipt__c = true;
            ric.Token_Amount_Receipt__c = true;
            ric.Physically_Cheque_Received__c = true;
            ric.Approval_Status__c = 'Approved';
            ric.Receipt_Date__c = system.today();
            ric.DraweeBank__c = 'Axis Bank';
            ric.Total_Amount__c = 200000;
            ric.On_Account_Money__c = 200000;
            ric.Currency__c = 'Indian Rupee';
            ric.Booking__c = objBooking.Id;
            insert ric;
            
             Demand_Invoice__c DemandInv = new Demand_Invoice__c();
             DemandInv.Customer__c = objOpportunity.Id;
             DemandInv.Invoice_Date__c = System.Today();
             DemandInv.Due_Date__c = System.Today().addDays(10);
             DemandInv.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv.Total_Demanded_Installment__c = 10000;
             DemandInv.Total_Demanded_Service_Tax__c = 4350;
             DemandInv.Total_Recd_Installment__c = 10000;
             DemandInv.Total_Recd_Service_Tax__c = 4350;
             DemandInv.Outstanding_Installment__c = 0;
             DemandInv.Outstanding_Service_Tax__c = 0;
             DemandInv.Current_Demand_Installment__c = 10000;
             DemandInv.Current_Demand_Service_Tax__c = 4350;
             DemandInv.Is_Advanced_Demand__c = false;
             //DemandInv.Registration_Demand_Generation__c
             DemandInv.Legal_Charges_Service_Tax__c = 1000;
             DemandInv.Legal_Charges_Amount__c = 5000;
             DemandInv.MVAT_Amount__c = 4000;
             DemandInv.Stamp__c = 1000;
             DemandInv.Registration_Charges_Amount__c = 4000;
             DemandInv.Ready_Reckoner_Value__c = 4000;
             DemandInv.Agreement_Value__c = 20000;
             DemandInv.Interest_Amount__c = 5000; 
             DemandInv.Service_Tax_on_Interest__c = 1000;
             insert DemandInv;
            
            Receipt_Details__c rd11 = new Receipt_Details__c();
            rd11.Demand_Invoice__c = DemandInv.Id; 
            rd11.For_Service_Tax__c = false;
            rd11.Amount__c = 100000;
            rd11.Receipts__c = ric.Id;
            rd11.Charges__c = PCharge.Id;
            rd11.Is_Cheque_Dishonour__c = false;
            rd11.Is_Interest_Settlement__c = true;
            //insert rd11;       
             
            paymentc.strReceiptId = ric.Id;
            paymentc.Customer = new Opportunity();
            paymentc.letterhead = 'Test';
            paymentc.bookingId = objBooking.Id;
            paymentc.ownerName = 'stetig';
            paymentc.ownerPhone = '111111';
            paymentc.ownerEmail = 'test@test.in';
            paymentc.ownerSalutation = 'Mr.';
            paymentc.legalAddress = 'test';
            paymentc.legalCity = 'test';
            paymentc.legalPinCode = 'test';
            
            paymentc.getReceiptDetails();
            S_PaymentReceiptComponentController.wrapperclass w = new S_PaymentReceiptComponentController.wrapperclass(rd11,'Basic',True);
    }
@isTest 
    private static void receipts4() {
    
      
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
          List<Id> oppId = new List<Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);
            
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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'Service Tax 1';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 4.20;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'Service Tax 2';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 14;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
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
             pCharge.Service_Tax_Percentage__c = 'Service Tax 1';
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
             PCharge1.Service_Tax_Percentage__c = 'Service Tax 2';
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
             PCharge5.Service_Tax_Percentage__c = 'Service Tax 2';
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
             recordIdMap.put('UNIT',objPU1.Id);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             recordIdMap.put('ACCOUNT',objac.Id);
             
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
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
             oppId.add(objOpportunity.Id);
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
             recordIdMap.put('PAYPLAN',objPaymentPlan.Id);
             
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
             recordIdMap.put('APPROVER1',tm1.Id);
             
             Team_Members__c tm2 = new Team_Members__c();
             tm2.Team__c = objTeam.Id;
             tm2.User_Active__c = true;
             tm2.Approver_Type__c = 'Second Level';
             tm2.User__c = a2.id;
             insert tm2;
             recordIdMap.put('APPROVER2',tm2.Id);
             
             Team_Members__c tm3 = new Team_Members__c();
             tm3.Team__c = objTeam.Id;
             tm3.User_Active__c = true;
             tm3.Approver_Type__c = 'Third Level';
             tm3.User__c = a3.id;
             insert tm3;
            recordIdMap.put('APPROVER3',tm3.Id);

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
             scppdM1.Is_to_be_Paid__c='Registration';
             scppdM1.Is_to_be__c = 'At Registration';
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
             
             PageReference upsPage = Page.updateConsStageNew;
             Test.setCurrentPage(upsPage);
             Apexpages.currentPage().getParameters().put('Pid',objPr.id);
             updateConsStageNew ups = new updateConsStageNew();
          PaymentManagementServices.getChequeDishonours(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoney(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyFlatcost(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyGST(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneySDR(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyFlatcost4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneyGST4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoneySDR4R(objOpportunity.Id);
PaymentManagementServices.getOnAccountMoney(oppId);
      
      
      
      /*       
             List < SelectOption > tList = ups.getTowerSelectList();
             //ups.towerID = t.Id;
             //List < SelectOption > stageList = ups.getConstructionSelectList();
             //list<SelectOption> options = ups.updateOptions;
             //ups.updateType = 'plannedDate';
             //ups.plannedDate = system.today().addDays(50);
             //ups.stageId = objPCS1.id;
             ups.save();
             Attachment objattch = ups.objattachment;
             objattch.name='test';
             objattch.ParentId=objPCS1.id;
             Blob bodyBlob=Blob.valueOf('test');
             objattch.body=bodyBlob;
             ups.upload();
            
             ups.towerID = t.Id;
             ups.updateType = 'completionDate';
             ups.dueDate = system.today();
             ups.stageId = objPCS1.id;
             ups.save();
             ups.dummy();
             ups.refresh();
             ups.cancel();
             
    */
            
            
            PageReference demandRef = Page.S_sendDemandInvoice2;
            Test.setCurrentPage(demandRef);
            ApexPages.currentPage().getParameters().put('bookingId',objBooking.Id);
            
            S_sendDemandInvoice2 sd = new S_SendDemandInvoice2();
            sd.selectedProjectId =objpr.Id;
            list<SelectOption> sopt = sd.searchOptions;
            list<SelectOption> lp = sd.lstProjects;
            list<SelectOption> cons = sd.lstStructionStages;
            sd.selectedTowerId = t.Id;
            sd.tabName = 'search';
            sd.rowIndex = 0;
            sd.ShowPreview();
            Test.startTest();    
            Apexpages.currentPage().getParameters().put('towerName', 'Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd.getCustomersTowerWise();
            sd.tabName = 'pendingDemands';
            sd.rowIndex = 0;
            sd.ShowPreview();
            sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
            
               Demand_Invoice__c DemandInv12 = new Demand_Invoice__c();
             DemandInv12.Customer__c = objOpportunity.Id;
             DemandInv12.Invoice_Date__c = System.Today();
             DemandInv12.Due_Date__c = System.Today().addDays(10);
             DemandInv12.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv12.Total_Demanded_Installment__c = 10000;
             DemandInv12.Total_Demanded_Service_Tax__c = 4350;
             DemandInv12.Total_Recd_Installment__c = 10000;
             DemandInv12.Total_Recd_Service_Tax__c = 4350;
             DemandInv12.Outstanding_Installment__c = 0;
             DemandInv12.Outstanding_Service_Tax__c = 0;
             DemandInv12.Current_Demand_Installment__c = 10000;
             DemandInv12.Current_Demand_Service_Tax__c = 4350;
             DemandInv12.Is_Advanced_Demand__c = true;
             DemandInv12.Registration_Demand_Generation__c = false;
             DemandInv12.Legal_Charges_Service_Tax__c = 1000;
             DemandInv12.Legal_Charges_Amount__c = 5000;
             DemandInv12.MVAT_Amount__c = 4000;
             DemandInv12.Stamp__c = 1000;
             //DemandInv.Registration_Charges_Amount__c = 4000;
             DemandInv12.Ready_Reckoner_Value__c = 4000;
             DemandInv12.Agreement_Value__c = 20000;
             DemandInv12.Interest_Amount__c = 5000; 
             DemandInv12.Service_Tax_on_Interest__c = 1000;
             insert DemandInv12;
             
              Demand_Detail__c  dd = new Demand_Detail__c();
            dd.Demand_Invoice__c = DemandInv12.id;
            dd.scppd_1__c = scppdL1.id;
            insert dd;
             
             Demand_Invoice__c DemandInv1 = new Demand_Invoice__c();
             DemandInv1.Customer__c = objOpportunity.Id;
             DemandInv1.Invoice_Date__c = System.Today();
             DemandInv1.Due_Date__c = System.Today().addDays(10);
             DemandInv1.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv1.Total_Demanded_Installment__c = 10000;
             DemandInv1.Total_Demanded_Service_Tax__c = 4350;
             DemandInv1.Total_Recd_Installment__c = 10000;
             DemandInv1.Total_Recd_Service_Tax__c = 4350;
             DemandInv1.Outstanding_Installment__c = 0;
             DemandInv1.Outstanding_Service_Tax__c = 0;
             DemandInv1.Current_Demand_Installment__c = 10000;
             DemandInv1.Current_Demand_Service_Tax__c = 4350;
             DemandInv1.Is_Advanced_Demand__c = false;
             DemandInv1.Registration_Demand_Generation__c = true;
             DemandInv1.Legal_Charges_Service_Tax__c = 1000;
             DemandInv1.Legal_Charges_Amount__c = 5000;
             DemandInv1.MVAT_Amount__c = 4000;
             DemandInv1.Stamp__c = 1000;
             DemandInv1.Registration_Charges_Amount__c = 4000;
             DemandInv1.Ready_Reckoner_Value__c = 4000;
             DemandInv1.Agreement_Value__c = 20000;
             DemandInv1.Interest_Amount__c = 5000; 
             DemandInv1.Service_Tax_on_Interest__c = 1000;
             DemandInv1.Interest_Amount__c = 5000;
             insert DemandInv1;
             
              Demand_Detail__c  dd1 = new Demand_Detail__c();
            dd1.Demand_Invoice__c = DemandInv1.id;
            dd1.scppd_1__c = scppdL1.id;
            insert dd1;
             
             
              S_DemandReminder sdl12  = new S_DemandReminder();
            sdl12.strDemandInvId = DemandInv1.id;
            sdl12.getDemandLetter();
            sdl12.chargeAmountMap.put('Ready Reckoner',1000);
            sdl12.chargeAmountMap.put('Stamp Duty',1000);
            sdl12.chargeAmountMap.put('Registration Charges',1000);
            sdl12.chargeAmountMap.put('Legal Charges',1000);
            sdl12.chargeAmountMap.put('Legal Charges TAX',1000);
            sdl12.chargeAmountMap.put('MVAT',1000);
            sdl12.chargeAmountMap.put('Basic TOTAL',1000);
           // sdl12.prepareDemandUIMapforRegPreview();
            
            Tax_Breakup__c tx = new Tax_Breakup__c();
            tx.Tax_Slab__c = taxS.Id;
            tx.Taxable_Percentage__c = 4;
            tx.Tax_Code__c = 'ST3FP';
            tx.Tax_Percentage__c = 100;
            tx.Tax_Type__c = 'Service Tax';
            tx.Tax_Split_Type__c = 'Basic';
            insert tx;
            
            Tax_Breakup__c tx1 = new Tax_Breakup__c();
            tx1.Tax_Slab__c = taxS.Id;
            tx1.Taxable_Percentage__c = 0.5;
            tx1.Tax_Code__c = 'SBFB';
            tx1.Tax_Percentage__c = 100;
            tx1.Tax_Type__c = 'Service Tax';
            tx1.Tax_Split_Type__c = 'SBC';
            insert tx1;
            
            Tax_Breakup__c tx11 = new Tax_Breakup__c();
            tx11.Tax_Slab__c = taxS.Id;
            tx11.Taxable_Percentage__c = 0.5;
            tx11.Tax_Code__c = 'KKCFB';
            tx11.Tax_Percentage__c = 100;
            tx11.Tax_Type__c = 'Service Tax';
            tx11.Tax_Split_Type__c = 'KKC';
            insert tx11;
            
            PageReference dPage = Page.DemandLetterTemplate;
            Test.setCurrentPage(dPage);
            ApexPages.currentPage().getParameters().put('demandType','Flat Cost');
            ApexPages.currentPage().getParameters().put('mileStoneList',scppdB1.Id);
            ApexPages.currentPage().getParameters().put('mode','preview');
            ApexPages.currentPage().getParameters().put('DemandInvId',DemandInv12.Id);
            ApexPages.currentPage().getParameters().put('letterHead','true');
            ApexPages.currentPage().getParameters().put('advanceAmt','1000');
            ApexPages.currentPage().getParameters().put('stAmt','400');
            DemandLetterTemplate dt = new DemandLetterTemplate();
            S_DemandReminder sd2  = new S_DemandReminder();
            sd2.strMode = 'preview';
            sd2.strMileStoneList = scppdB1.id;
            sd2.strDemandType = 'Flat Cost';
            sd2.strDemandInvId = DemandInv12.Id;
            sd2.getDemandLetter();
            sd2.wrpDemand.ChargeTaxMapD.put('Basic TAXABLE VALUE D',10000);
            sd2.wrpDemand.ChargeTaxMapD.put('TOTAL TAX AMT D',10000);
            sd2.DemandInv.Total_Demanded_Installment__c = 100000;
            sd2.DemandInv.Total_Demanded_Service_Tax__c = 100000;
            sd2.DemandInv.Total_Demanded_Service_Tax_KKC__c = 100000;
            sd2.DemandInv.Total_Demanded_Service_Tax_SBC__c = 100000;
            sd2.DemandInv.Total_Demanded_Service_Tax_Basic__c = 100000;
            sd2.DemandInv.Total_Demanded_Installment__c  = 100000;
            sd2.DemandInv.Total_Demanded_Service_Tax__c = 100000;
            
            sd2.DemandInv.Total_Recd_Installment__c = 100000;
            sd2.DemandInv.Total_Recd_Service_Tax__c = 100000;
            sd2.DemandInv.Total_Recd_Service_Tax_KKC__c = 100000;
            sd2.DemandInv.Total_Recd_Service_Tax_SBC__c = 100000;
            sd2.DemandInv.Total_Recd_Service_Tax_Basic__c = 100000;
            sd2.DemandInv.Outstanding_Installment__c = 100000;
            sd2.DemandInv.Outstanding_Service_Tax__c = 100000;
           
            sd2.DemandInv.Outstanding_Service_Tax_KKC__c = 100000;
            sd2.DemandInv.Outstanding_Service_Tax_SBC__c = 100000;
            sd2.DemandInv.Outstanding_Service_Tax_Basic__c = 100000;
            sd2.DemandInv.Interest_Amount__c = 100000;
            sd2.DemandInv.Service_Tax_on_Interest__c = 100000;
            sd2.DemandInv.Current_Demand_Installment__c = 100000;
            sd2.DemandInv.Current_Demand_Service_Tax__c = 100000;
            
            sd2.DemandInv.Current_Demand_Service_Tax_KKC__c = 100000;
            sd2.DemandInv.Current_Demand_Service_Tax_SBC__c = 100000;
            sd2.DemandInv.Current_Demand_Service_Tax_Basic__c = 100000;
           
            sd2.DemandInv.Total_Payable_Installment__c = 100000;
            sd2.DemandInv.Total_Payable_Service_Tax__c = 100000;
            sd2.DemandInv.Total_Payable_Overall__c = 100000;
            sd2.prepareDemandUIMapforshowInvoice();
            sd2.prepareDemandUIMapForshowInvoiceAdvance();
            sd2.prepareDemandUIMapforShowNew(DemandInv12.Id);
            
            objCPPH.Amount_Demanded_Till_Date__c = 1000000;
            objCPPH.Amount_Recd_Till_Date__c = 900000;
            objCPPH.Registration_Intimation_Sent__c = true;
            objCPPH.show_registration_demand__c = true;
            update objCPPH;
           
            
            S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
            sd1.selectedProjectId =objpr.Id;
            list<SelectOption> sopt1 = sd1.searchOptions;
            list<SelectOption> lp1 = sd1.lstProjects;
            list<SelectOption> cons1 = sd1.lstStructionStages;
            sd1.selectedTowerId = t.Id;
            list<SelectOption> lp2t = sd1.lstTower;
            Apexpages.currentPage().getParameters().put('towerNameReg', 'SOS-Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd1.getCustomersTowerWiseReg();
            sd1.tabName = 'pendingRegistrations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListReg[0].selected = true;
            sd1.sendMail(); 
            
           
            PageReference pRef = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef);
            S_ReceiptModuleController rmc = new S_ReceiptModuleController();
            rmc.rmw.r.Project_Unit__c  = objPU1.id;
            rmc.rmw.r.Project__c  = objpr.id;
            
            rmc.UnitSelectionValidation();
        
            rmc.rmw.r.mode__c = 'Cheque';
            rmc.rmw.r.Receipt_Date__c = system.today();
            rmc.rmw.r.Cheque_DD_Date__c = system.today();
            rmc.rmw.r.DraweeBank__c = 'AXIS';
            rmc.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc.rmw.r.Currency__c = 'Indian Rupee';
            rmc.rmw.r.Amount_Rs__c = 2000000;
            rmc.entitySelected = 'VISHWAROOP';
            rmc.ApplyReceipt();
            
            objOpportunity.stageName = 'Booking Confirmed';
            update objOpportunity;
            Test.stoptest();  
            S_ReceiptModuleController rmc1 = new S_ReceiptModuleController();
            receipt__c rc = new receipt__c();
            rc.Receipt_Date__c = system.today();
            rc.Cheque_DD_Date__c = system.today();
            rc.DraweeBank__c = 'AXIS';
            rc.Amount_Rs__c = 2000000;
            rc.mode__c = 'Cheque';
            insert rc;
            
            receipt__c rc2 = new receipt__c();
            rc2.Receipt_Date__c = system.today();
            rc2.Cheque_DD_Date__c = system.today();
            rc2.DraweeBank__c = 'Other';
            rc2.Drawee_Bank_If_Others__c = 'ABC';
            rc2.Amount_Rs__c = 2000000;
            rc2.mode__c = 'Cheque';
            insert rc2;
            
            rmc1.rmw.r.Project_Unit__c  = objPU1.id;
            rmc1.rmw.r.Project__c  = objpr.id;
            rmc1.UnitSelectionValidation();
            rmc1.rmw.r.mode__c = 'Cheque';
            rmc1.rmw.r.Receipt_Date__c = system.today();
            rmc1.rmw.r.Cheque_DD_Date__c = system.today();
            rmc1.rmw.r.DraweeBank__c = 'AXIS';
            rmc1.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc1.rmw.r.Currency__c = 'Indian Rupee';
            rmc1.rmw.r.Amount_Rs__c = 2000000;
            rmc1.entitySelected = 'VISHWAROOP';
            rmc1.ApplyReceipt();
            //rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 2000000;
            //rmc1.applyAdvance();
            //rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            //rmc1.applyAdvance();
            rmc1.rowIndex = 0;
            rmc1.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            rmc1.pw1List[0].upcomingInstallment = 100000;
            rmc1.raiseDemand();
            
            S_ReceiptModuleController rmc11 = new S_ReceiptModuleController();
            rmc11.rmw.r.Project_Unit__c  = objPU1.id;
            rmc11.rmw.r.Project__c  = objpr.id;
            
            rmc11.UnitSelectionValidation();
        
            rmc11.rmw.r.mode__c = 'Cheque';
            rmc11.rmw.r.Receipt_Date__c = system.today();
            rmc11.rmw.r.Cheque_DD_Date__c = system.today();
            rmc11.rmw.r.DraweeBank__c = 'AXIS';
            rmc11.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc11.rmw.r.Currency__c = 'Indian Rupee';
            rmc11.rmw.r.Amount_Rs__c = 2000000;
            rmc11.entitySelected = 'VISHWAROOP';
            rmc11.checkDupeList();
            rmc11.ApplyReceipt();
            
            S_ReceiptModuleController rmc12 = new S_ReceiptModuleController();
            rmc12.rmw.r.Project_Unit__c  = objPU1.id;
            rmc12.rmw.r.Project__c  = objpr.id;
            
            rmc12.UnitSelectionValidation();
        
            rmc12.rmw.r.mode__c = 'Cheque';
            rmc12.rmw.r.Receipt_Date__c = system.today();
            rmc12.rmw.r.Cheque_DD_Date__c = system.today();
            rmc12.rmw.r.DraweeBank__c = 'Other';
            rmc12.rmw.r.Drawee_Bank_If_Others__c = null;
            rmc12.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc12.rmw.r.Currency__c = 'Indian Rupee';
            rmc12.rmw.r.Amount_Rs__c = 2000000;
            rmc12.entitySelected = 'VISHWAROOP';
            rmc12.checkDupeList();
            rmc12.ApplyReceipt();
            rmc12.rmw.r.Drawee_Bank_If_Others__c = 'ABC';
            rmc12.checkDupeList();
            rmc12.ApplyReceipt();
            
            S_ReceiptModuleController rmc13 = new S_ReceiptModuleController();
            rmc13.rmw.r.Project_Unit__c  = objPU1.id;
            rmc13.rmw.r.Project__c  = objpr.id;
            
            //rmc13.UnitSelectionValidation();
        
            rmc13.rmw.r.mode__c = 'DD/Pay Order';
            rmc13.rmw.r.Receipt_Date__c = system.today();
            rmc13.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc13.rmw.r.DraweeBank__c = 'AXIS';
            rmc13.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc13.rmw.r.Currency__c = 'Indian Rupee';
            rmc13.rmw.r.Amount_Rs__c = 2000000;
            rmc13.entitySelected = 'VISHWAROOP';
            //rmc13.checkDupeList();
            rmc13.ApplyReceipt();
            
            S_ReceiptModuleController rmc14 = new S_ReceiptModuleController();
            rmc14.rmw.r.Project_Unit__c  = objPU1.id;
            rmc14.rmw.r.Project__c  = objpr.id;
            
            //rmc14.UnitSelectionValidation();
        
            rmc14.rmw.r.mode__c = 'TDS';
            rmc14.rmw.r.Receipt_Date__c = system.today();
            rmc14.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc14.rmw.r.DraweeBank__c = 'AXIS';
            rmc14.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc14.rmw.r.Currency__c = 'Indian Rupee';
            rmc14.rmw.r.Amount_Rs__c = 2000000;
            rmc14.entitySelected = 'VISHWAROOP';
            //rmc14.checkDupeList();
            rmc14.ApplyReceipt();
            
            S_ReceiptModuleController rmc15 = new S_ReceiptModuleController();
            rmc15.rmw.r.Project_Unit__c  = objPU1.id;
            rmc15.rmw.r.Project__c  = objpr.id;
            
            //rmc15.UnitSelectionValidation();
        
            rmc15.rmw.r.mode__c = 'TDS';
            rmc15.rmw.r.Receipt_Date__c = system.today();
            rmc15.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc15.rmw.r.DraweeBank__c = 'AXIS';
            rmc15.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc15.rmw.r.Currency__c = 'Indian Rupee';
            rmc15.rmw.r.Amount_Rs__c = 2000000;
            rmc15.rmw.r.Receipt_status__c = 'Cleared';
            rmc15.entitySelected = 'VISHWAROOP';
            //rmc15.checkDupeList();
            rmc15.adjustmentFlow = true;
            //rmc15.foreignCurrency = true;
            //rmc15.penalties = true;
            rmc15.ApplyReceipt();
            
            S_ReceiptModuleController rmc16 = new S_ReceiptModuleController();
            rmc16.rmw.r.Project_Unit__c  = objPU1.id;
            rmc16.rmw.r.Project__c  = objpr.id;
            
            //rmc15.UnitSelectionValidation();
        
            rmc16.rmw.r.mode__c = 'Cheque';
            rmc16.rmw.r.Receipt_Date__c = system.today();
            rmc16.rmw.r.Cheque_DD_Date__c = system.today().addDays(5);
            rmc16.rmw.r.DraweeBank__c = 'AXIS';
            rmc16.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc16.rmw.r.Currency__c = 'US Dollar';
            rmc16.rmw.r.Amount_Rs__c = 2000000;
            //rmc16.rmw.r.Receipt_status__c = 'Cleared';
            rmc16.entitySelected = 'VISHWAROOP';
            //rmc15.checkDupeList();
            rmc16.adjustmentFlow = false;
            rmc16.foreignCurrency = true;
            rmc16.penalties = true;
            rmc16.ApplyReceipt();
            //rmc16.Save();
             
            PageReference pRef1 = Page.S_ReceiptDashboard;
            Test.setCurrentPage(pRef1);
            S_ReceiptDashboardClass rdb = new S_ReceiptDashboardClass();
             trgReceiptHandler trgrc = new trgReceiptHandler();
            Receipt_Details__c rd = new Receipt_Details__c();
            //rd.Charges__r.Charge_Code__c = 
           // rd.Charges__r.Charge_Code__r.Id =
            rd.Amount__c = 10000;
            rd.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            rd.Is_Cheque_Dishonour__c = true;
            rd.Is_Interest_Settlement__c = true;
            rd.Is_Advanced_Demand__c = true;
            rd.Project__c = objpr.Id;
           // rd.Demand_Invoice__c = 
            rd.Receipts__c = r1.Id;
            rd.Is_Interest_Settlement_ST__c = true;
            //insert rd;          
            
            Ledger__c ldr = new Ledger__c();
            ldr.Debit_Credit__c = 'Credit';
            ldr.Amount__c = 10000;
            ldr.Customer_Pay_Plan_Header__c = objCPPH1.Id;
            ldr.Global_Charges__c = ObjGloChrg1.id;
            ldr.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            //ldr.Receipt_Details__c = rd.Id;
            ldr.Customer_Pay_Plan_Header__c = objCPPH.Id;
            ldr.Opportunity__c = objOpportunity.Id;
            //ldr.Demand_Invoice__C = 
            ldr.Reciepts__c = r1.Id;
            insert ldr;
                   
            //trgrc.dishonour(r1.Id);         
            trgrc.verificationRejection(r1.Id);
            
            S_PaymentReceiptComponentController paymentc = new S_PaymentReceiptComponentController();
            Receipt__c ric = new Receipt__c();
            ric.Cheque_DD_Amount_Rs__c = 200000;
            ric.Cheque_DD__c = '908888';
            ric.Cheque_DD_Date__c = system.today();
            ric.Project__c = objpr.Id;
            ric.Project_Unit__c = objPU1.Id;
            ric.Opportunity__c = objOpportunity.Id;
            ric.CheckReceipt__c = true;
            ric.Token_Amount_Receipt__c = true;
            ric.Physically_Cheque_Received__c = true;
            ric.Approval_Status__c = 'Approved';
            ric.Receipt_Date__c = system.today();
            ric.DraweeBank__c = 'Axis Bank';
            ric.Total_Amount__c = 200000;
            ric.On_Account_Money__c = 200000;
            ric.Currency__c = 'Indian Rupee';
            ric.Booking__c = objBooking.Id;
            insert ric;
            
             Demand_Invoice__c DemandInv = new Demand_Invoice__c();
             DemandInv.Customer__c = objOpportunity.Id;
             DemandInv.Invoice_Date__c = System.Today();
             DemandInv.Due_Date__c = System.Today().addDays(10);
             DemandInv.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
             DemandInv.Total_Demanded_Installment__c = 10000;
             DemandInv.Total_Demanded_Service_Tax__c = 4350;
             DemandInv.Total_Recd_Installment__c = 10000;
             DemandInv.Total_Recd_Service_Tax__c = 4350;
             DemandInv.Outstanding_Installment__c = 0;
             DemandInv.Outstanding_Service_Tax__c = 0;
             DemandInv.Current_Demand_Installment__c = 10000;
             DemandInv.Current_Demand_Service_Tax__c = 4350;
             DemandInv.Is_Advanced_Demand__c = false;
             //DemandInv.Registration_Demand_Generation__c
             DemandInv.Legal_Charges_Service_Tax__c = 1000;
             DemandInv.Legal_Charges_Amount__c = 5000;
             DemandInv.MVAT_Amount__c = 4000;
             DemandInv.Stamp__c = 1000;
             DemandInv.Registration_Charges_Amount__c = 4000;
             DemandInv.Ready_Reckoner_Value__c = 4000;
             DemandInv.Agreement_Value__c = 20000;
             DemandInv.Interest_Amount__c = 5000; 
             DemandInv.Service_Tax_on_Interest__c = 1000;
             insert DemandInv;
            
            Receipt_Details__c rd11 = new Receipt_Details__c();
            rd11.Demand_Invoice__c = DemandInv.Id; 
            rd11.For_Service_Tax__c = false;
            rd11.Amount__c = 100000;
            rd11.Receipts__c = ric.Id;
            rd11.Charges__c = PCharge.Id;
            rd11.Is_Cheque_Dishonour__c = false;
            rd11.Is_Interest_Settlement__c = true;
            //insert rd11;       
             
            paymentc.strReceiptId = ric.Id;
            paymentc.Customer = new Opportunity();
            paymentc.letterhead = 'Test';
            paymentc.bookingId = objBooking.Id;
            paymentc.ownerName = 'stetig';
            paymentc.ownerPhone = '111111';
            paymentc.ownerEmail = 'test@test.in';
            paymentc.ownerSalutation = 'Mr.';
            paymentc.legalAddress = 'test';
            paymentc.legalCity = 'test';
            paymentc.legalPinCode = 'test';
            
            paymentc.getReceiptDetails();
            S_PaymentReceiptComponentController.wrapperclass w = new S_PaymentReceiptComponentController.wrapperclass(rd11,'Basic',True);
    }
    
@isTest
    private static void TokenReceipts() {
    
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);
            
            
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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
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
             recordIdMap.put('UNIT',objPU1.Id);
             
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
             recordIdMap.put('ACCOUNT',objac.Id);
             
             // opportunity creation              
             Opportunity objOpportunity = new Opportunity();
             objOpportunity.Name = 'Test';
             objOpportunity.CloseDate = System.today();
             objOpportunity.AccountId = objac.Id; 
             objOpportunity.Status__c = 'Active'; 
             objOpportunity.StageName = 'Opportunity Identified'; 
             objOpportunity.Project__c = objpr.Id; 
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
            
            Test.startTest();      
            PageReference pRef = Page.S_TokenReceipt;
            Test.setCurrentPage(pRef);
            Apexpages.currentPage().getParameters().put('id', objOpportunity.id);
            S_TokenReceiptController rc = new S_TokenReceiptController();
            rc.validate();
            rc.r.mode__c = 'TDS';
            rc.selectInstrument();
            rc.r.mode__c = 'Cheque';
            rc.selectInstrument();
            rc.getEntityDetails();
            List<SelectOption> sl = rc.holdOptions;
      rc.unitHeld = 'YES';
      rc.r.Project_Unit__c = objPU1.id;
      rc.unitHoldAction();
            rc.r.mode__c = 'Cheque';
            rc.r.Receipt_Date__c = system.today();
            rc.r.Cheque_DD_Date__c = system.today();
            rc.r.DraweeBank__c = 'AXIS';
            rc.r.Cheque_DD__c = 'CQ0001';
            rc.r.Currency__c = 'Indian Rupee';
            rc.r.Amount_Rs__c = 2000000;
            rc.entitySelected = 'FLAT COST | VISHWAROOP';
            rc.saveReceipt();
            
            PageReference pRef1 = Page.S_TokenReceipt;
            Test.setCurrentPage(pRef1);
            Apexpages.currentPage().getParameters().put('id', objOpportunity.id);
            S_TokenReceiptController rc1 = new S_TokenReceiptController();
            rc1.validate();
            rc1.r.mode__c = 'Cheque';
            rc1.r.Receipt_Date__c = system.today();
            rc1.r.Cheque_DD_Date__c = system.today();
            rc1.r.DraweeBank__c = 'AXIS';
            rc1.r.Cheque_DD__c = 'CQ0001';
            rc1.r.Currency__c = 'Indian Rupee';
            rc1.r.Amount_Rs__c = 2000000;
            rc1.entitySelected = 'SERVICE TAX | VISHWAROOP';
            rc1.saveReceipt();
            Test.stopTest(); 
            
    }
    
    @isTest
    private static void receiptsAdjustment() {
         
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);

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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'Service Tax 1';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 4.20;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'Service Tax 2';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 14;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
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
             
             Global_Charges__c ObjGloChrgI = new Global_Charges__c();
             ObjGloChrgI.Name = 'Interest';
             ObjGloChrgI.Code__c = '007';
             ObjGloChrgI.Description__c = 'Interest';
             ObjGloChrgI.Sequence_No__c = 007;
             ObjGloChrgI.Charge_Type__c = 'Interest';
             ObjGloChrgI.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgI=RDSCommon.CreateGlobalCharges(ObjGloChrgI);
             
             
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
             
             Global_Charges__c ObjGloChrgCH = new Global_Charges__c();
             ObjGloChrgCH.Name = 'Cheque Dishonor';
             ObjGloChrgCH.Code__c = '219';
             ObjGloChrgCH.Description__c = 'Cheque Dishonor';
             ObjGloChrgCH.Sequence_No__c = 219;
             ObjGloChrgCH.Charge_Type__c = 'MVAT';
             ObjGloChrgCH.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgCH=RDSCommon.CreateGlobalCharges(ObjGloChrgCH);
             
             
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
             pCharge.Service_Tax_Percentage__c = 'Service Tax 1';
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
             PCharge1.Service_Tax_Percentage__c = 'Service Tax 2';
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
             PCharge5.Service_Tax_Percentage__c = 'Service Tax 2';
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
             recordIdMap.put('UNIT',objPU1.Id);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             recordIdMap.put('ACCOUNT',objac.Id);
             
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
             objOpportunity.Primary_Phone__c = '8178176699';
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
            
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
             recordIdMap.put('PAYPLAN',objPaymentPlan.Id);
             
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
             recordIdMap.put('APPROVER1',tm1.Id);
             
             Team_Members__c tm2 = new Team_Members__c();
             tm2.Team__c = objTeam.Id;
             tm2.User_Active__c = true;
             tm2.Approver_Type__c = 'Second Level';
             tm2.User__c = a2.id;
             insert tm2;
             recordIdMap.put('APPROVER2',tm2.Id);
             
             Team_Members__c tm3 = new Team_Members__c();
             tm3.Team__c = objTeam.Id;
             tm3.User_Active__c = true;
             tm3.Approver_Type__c = 'Third Level';
             tm3.User__c = a3.id;
             insert tm3;
            recordIdMap.put('APPROVER3',tm3.Id);

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
            r1.Receipt_Date__c = system.today();
            r1.DraweeBank__c = 'Axis Bank';
            r1.Total_Amount__c = 200000;
            r1.Receipt_Status__c = 'UnProcessed';
            insert r1;
            
            Receipt__c r2 = new Receipt__c();
            r2.Cheque_DD_Amount_Rs__c = 8400;
            r2.Cheque_DD__c = '9088881';
            r2.Cheque_DD_Date__c = system.today();
            r2.Project__c = objpr.Id;
            r2.Project_Unit__c = objPU1.Id;
            r2.Opportunity__c = objOpportunity.Id;
            r2.CheckReceipt__c = true;
            r2.Receipt_Date__c = system.today();
            r2.DraweeBank__c = 'CITI';
            r2.Total_Amount__c = 8400;
            r2.Receipt_Status__c = 'UnProcessed';
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
             scppdM1.Is_to_be_Paid__c='Registration';
             scppdM1.Is_to_be__c = 'At Registration';
             scppdM1.Days_Months__c='Day(s)';
             scppdM1.Days_Months_Value__c=0;
             scppdM1.Amount__c='Percentage';
             scppdM1.Installment__c=345000;
             scppdM1.Customer_Pay_Plan_Header__c = objCPPH4.id;
             scppdM1.Due_Date__c = system.today();
             scppdM1.IsSendDemandLetter__c = false;
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
           
             Test.startTest();
             PageReference upsPage = Page.updateConsStageNew;
             Test.setCurrentPage(upsPage);
             Apexpages.currentPage().getParameters().put('Pid',objPr.id);
             updateConsStageNew ups = new updateConsStageNew();
             
             List < SelectOption > tList = ups.getTowerSelectList();
             ups.towerID = t.Id;
             List < SelectOption > stageList = ups.getConstructionSelectList();
             list<SelectOption> options = ups.updateOptions;
             ups.updateType = 'plannedDate';
             ups.plannedDate = system.today().addDays(50);
             ups.stageId = objPCS1.id;
             ups.save();
             Attachment objattch = ups.objattachment;
             objattch.name='test';
             objattch.ParentId=objPCS1.id;
             Blob bodyBlob=Blob.valueOf('test');
             objattch.body=bodyBlob;
             ups.upload();
            
             ups.towerID = t.Id;
             ups.updateType = 'completionDate';
             ups.dueDate = system.today();
             ups.stageId = objPCS1.id;
             ups.save();
             ups.dummy();
             ups.refresh();
             ups.cancel();
             
               Tax_Breakup__c tx = new Tax_Breakup__c();
            tx.Tax_Slab__c = taxS.Id;
            tx.Taxable_Percentage__c = 4;
            tx.Tax_Code__c = 'ST3FP';
            tx.Tax_Percentage__c = 100;
            tx.Tax_Type__c = 'Service Tax';
            tx.Tax_Split_Type__c = 'Basic';
            insert tx;
            
            Tax_Breakup__c tx1 = new Tax_Breakup__c();
            tx1.Tax_Slab__c = taxS.Id;
            tx1.Taxable_Percentage__c = 0.5;
            tx1.Tax_Code__c = 'SBFB';
            tx1.Tax_Percentage__c = 100;
            tx1.Tax_Type__c = 'Service Tax';
            tx1.Tax_Split_Type__c = 'SBC';
            insert tx1;
            
            Tax_Breakup__c tx11 = new Tax_Breakup__c();
            tx11.Tax_Slab__c = taxS.Id;
            tx11.Taxable_Percentage__c = 0.5;
            tx11.Tax_Code__c = 'KKCFB';
            tx11.Tax_Percentage__c = 100;
            tx11.Tax_Type__c = 'Service Tax';
            tx11.Tax_Split_Type__c = 'KKC';
            insert tx11;
            
            PageReference demandRef = Page.S_sendDemandInvoice2;
            Test.setCurrentPage(demandRef);
            ApexPages.currentPage().getParameters().put('bookingId',objBooking.Id);
            
            S_sendDemandInvoice2 sd = new S_SendDemandInvoice2();
            sd.selectedProjectId =objpr.Id;
            list<SelectOption> sopt = sd.searchOptions;
            list<SelectOption> lp = sd.lstProjects;
            list<SelectOption> cons = sd.lstStructionStages;
            sd.selectedTowerId = t.Id;
            sd.tabName = 'search';
            sd.rowIndex = 0;
            sd.ShowPreview();
            
            Apexpages.currentPage().getParameters().put('towerName', 'Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            Apexpages.currentPage().getParameters().put('pageName', 'Page1');
            sd.getCustomersTowerWise();
            sd.tabName = 'pendingDemands';
            sd.rowIndex = 0;
            sd.ShowPreview();
            sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
            sd.Beginning();
            sd.Next();
             Apexpages.currentPage().getParameters().put('towerNameCan', 'Tower X');
            sd.getCustomersTowerWiseCan();
            sd.getTowerwiseDemandSummary();
            sd.getCustomersTowerWiseReg();
            sd.tabName = 'pendingRegistrations';
            sd.rowIndex = 0;
            //sd.ShowPreview();
            //sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
            
            sd.tabName = 'pendingCancellations';
            sd.rowIndex = 0;
            //sd.ShowPreview();
            //sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
            
            sd.Previous();
            //sd.End();
            sd.getDisablePrevious();
            sd.getDisableNext();
            sd.getTotal_size();
            sd.getPageNumber();
            //sd.getTotalPages();
            
            objCPPH.Amount_Demanded_Till_Date__c = 1000000;
            objCPPH.Amount_Recd_Till_Date__c = 900000;
            objCPPH.Registration_Intimation_Sent__c = true;
            objCPPH.show_registration_demand__c = true;
            update objCPPH;
        
        
            S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
            sd1.selectedProjectId =objpr.Id;
            list<SelectOption> sopt1 = sd1.searchOptions;
            list<SelectOption> lp1 = sd1.lstProjects;
            list<SelectOption> cons1 = sd1.lstStructionStages;
            sd1.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameReg', 'SOS-Tower X');
            sd1.getCustomersTowerWiseReg();
            sd1.tabName = 'pendingRegistrations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListReg[0].selected = true;
            sd1.sendMail();
          
            
          
            objOpportunity.Total_Interest__c = 100000;
            objOpportunity.Total_Interest_Settled__c = 5000;
            objOpportunity.Total_Waiver__c = 5000;
            objOpportunity.stageName = 'Booking Confirmed';
            update objOpportunity;
            
         
            
            PageReference pRef = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef);
            S_ReceiptModuleController rmc = new S_ReceiptModuleController();
            rmc.rmw.r.Project_Unit__c  = objPU1.id;
            rmc.rmw.r.Project__c  = objpr.id;
            
            rmc.UnitSelectionValidation();
            rmc.rmw.r.mode__c = 'Cheque';
            rmc.rmw.r.Receipt_Date__c = system.today();
            rmc.rmw.r.Cheque_DD_Date__c = system.today();
            rmc.rmw.r.DraweeBank__c = 'AXIS';
            rmc.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc.rmw.r.Currency__c = 'Indian Rupee';
            rmc.rmw.r.Amount_Rs__c = 2000000;
            rmc.entitySelected = 'VISHWAROOP';
            rmc.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc.ApplyReceipt();
         Test.stopTest();    
            rmc.pwList[0].s1.Charge_Amount_Paid__c  = 100000;
            rmc.applyDues();
            rmc.pwList[0].s1.Service_Tax_Amount_Paid__c  = 30000;
            rmc.applyDues();
            rmc.save();
            
       
            PageReference pRefr1 = Page.S_ReceiptModule;
            Test.setCurrentPage(pRefr1);
            S_ReceiptModuleController rmc1 = new S_ReceiptModuleController();
            rmc1.rmw.r.Project_Unit__c  = objPU1.id;
            rmc1.rmw.r.Project__c  = objpr.id;
            rmc1.UnitSelectionValidation();
            rmc1.rmw.r.mode__c = 'Cheque';
            rmc1.rmw.r.Receipt_Date__c = system.today();
            rmc1.rmw.r.Cheque_DD_Date__c = system.today();
            rmc1.rmw.r.DraweeBank__c = 'AXIS';
            rmc1.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc1.rmw.r.Currency__c = 'Indian Rupee';
            rmc1.rmw.r.Amount_Rs__c = 2000000;
            rmc1.entitySelected = 'VISHWAROOP';
            rmc1.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc1.ApplyReceipt();
            rmc1.close();
            
            Test.setCurrentPage(pRef);
            Apexpages.currentPage().getParameters().put('id', rmc1.rmw.r.id);
            S_ReceiptModuleController rmc2 = new S_ReceiptModuleController();
            
            rmc2.oppList[0].Total_Interest_Settled__c = 50000000;
            rmc2.applyDues();
            rmc2.pwList[0].s1.Charge_Amount_Paid__c = 5000000;
            rmc2.applyDues();
            rmc2.oppList[0].Total_Interest_Settled__c = 2000;
            rmc2.applyDues();
            rmc2.pwList[0].s1.Charge_Amount_Paid__c = 1000;
            rmc2.applyDues();
            rmc2.save();
            
            rmc2.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 2000000;
            rmc2.applyAdvance();
            rmc2.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            rmc2.applyAdvance();
            rmc2.rowIndex = 0;
            rmc2.showPreview();
            
            PageReference dPage = Page.DemandLetterTemplate;
            Test.setCurrentPage(dPage);
            ApexPages.currentPage().getParameters().put('demandType','advance');
            ApexPages.currentPage().getParameters().put('mileStoneList',rmc2.pw1List[0].s1.Id);
            ApexPages.currentPage().getParameters().put('mode','preview');
            DemandLetterTemplate dt = new DemandLetterTemplate();
            S_DemandLetter sdl  = new S_DemandLetter();
            sdl.strMode = 'preview';
            sdl.strMileStoneList = rmc2.pw1List[0].s1.Id;
            sdl.strDemandType = 'advance';
            sdl.advanceAmtD = 1000;
            sdl.stAmtD = 100;
            sdl.getDemandLetter();
            rmc2.raiseDemand();
            
          /*  DemandManagementServices dms = new DemandManagementServices();
            DemandManagementServices.getDemandSoFarSummaryOtherCharges(objOpportunity.Id);
            Set<Id> oppSet = new Set<Id>();
            oppset.add(objOpportunity.Id);
            DemandManagementServices.createRegistrationDetails(oppSet);
            DemandManagementServices.clearMVATLedgers(objOpportunity.Id);
            DemandManagementServices.isMVATPaid(objOpportunity.Id);
            DemandManagementServices.getDemandDetailsRegistration(objOpportunity.Id);
            DemandManagementServices.getChargesForRegistration(objOpportunity.Id);
            List<Id> ScppdSet = new List<Id>();
            ScppdSet.add(scppdB1.Id);
            Decimal amt = 10000;
            Decimal stamt = 5000;
            DemandManagementServices.getAdvanceDemandDetails(ScppdSet,'advance',amt,stamt);*/
            
            /** 
            
            Global_Charges__c  gh2 = new Global_Charges__c();
            gh2.name = 'Interest Installment Waived';
            gh2.Code__c = '102';
            gh2.Description__c = 'Interest Installment Waived';
            gh2.Short_Name__c = 'INTWAIVE';
            gh2.Sequence_No__c = 21;
            gh2.Charge_Type__c = 'Interest Rcvd';
            insert gh2;
            
            
            Global_Charges__c  gh4 = new Global_Charges__c();
            gh4.name = 'Interest Servicetax Waived';
            gh4.Code__c = '104';
            gh4.Description__c = 'Interest Servicetax Waived';
            gh4.Short_Name__c = 'INTSTWAI';
            gh4.Sequence_No__c = 23;
            gh4.Charge_Type__c = 'Interest Rcvd';
            insert gh4;
            **/
            
            Global_Charges__c  gh1 = new Global_Charges__c();
            gh1.name = 'Interest Installment';
            gh1.Code__c = '101';
            gh1.Description__c = 'Interest';
            gh1.Short_Name__c = 'INT';
            gh1.Sequence_No__c = 20;
            gh1.Charge_Type__c = 'Interest Rcvd';
            insert gh1;
            
            Global_Charges__c  gh3 = new Global_Charges__c();
            gh3.name = 'Interest Servicetax';
            gh3.Code__c = '103';
            gh3.Description__c = 'Interest Servicetax';
            gh3.Short_Name__c = 'INTST';
            gh3.Sequence_No__c = 22;
            gh3.Charge_Type__c = 'Interest Rcvd';
            insert gh3;
            
            trgReceiptHandler trgrc = new trgReceiptHandler();
            Receipt_Details__c rd = new Receipt_Details__c();
             //rd.Charges__r.Charge_Code__c = 
           // rd.Charges__r.Charge_Code__r.Id =
            rd.Amount__c = 10000;
            rd.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            rd.Is_Cheque_Dishonour__c = true;
            rd.Is_Interest_Settlement__c = true;
            rd.Is_Advanced_Demand__c = true;
            rd.Project__c = objpr.Id;
           // rd.Demand_Invoice__c = 
            rd.Receipts__c = r1.Id;
            rd.Is_Interest_Settlement_ST__c = true;
            insert rd;          
            
            Ledger__c ldr = new Ledger__c();
            ldr.Debit_Credit__c = 'Credit';
            ldr.Amount__c = 10000;
            ldr.Customer_Pay_Plan_Header__c = objCPPH1.Id;
            ldr.Global_Charges__c = ObjGloChrg1.id;
            ldr.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            ldr.Receipt_Details__c = rd.Id;
            ldr.Customer_Pay_Plan_Header__c = objCPPH.Id;
            ldr.Opportunity__c = objOpportunity.Id;
            //ldr.Demand_Invoice__C = 
            ldr.Reciepts__c = r1.Id;
            insert ldr;
            
            
            //trgrc.dishonour(r1.Id);         
            //trgrc.verificationRejection(r1.Id);
    }
    
        @isTest
    private static void receiptsAdjustment1() {
        
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);

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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'Service Tax 1';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 4.20;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'Service Tax 2';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 14;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
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
             
             Global_Charges__c ObjGloChrgI = new Global_Charges__c();
             ObjGloChrgI.Name = 'Interest';
             ObjGloChrgI.Code__c = '007';
             ObjGloChrgI.Description__c = 'Interest';
             ObjGloChrgI.Sequence_No__c = 007;
             ObjGloChrgI.Charge_Type__c = 'Interest';
             ObjGloChrgI.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgI=RDSCommon.CreateGlobalCharges(ObjGloChrgI);
             
             
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
             
             Global_Charges__c ObjGloChrgCH = new Global_Charges__c();
             ObjGloChrgCH.Name = 'Cheque Dishonor';
             ObjGloChrgCH.Code__c = '219';
             ObjGloChrgCH.Description__c = 'Cheque Dishonor';
             ObjGloChrgCH.Sequence_No__c = 219;
             ObjGloChrgCH.Charge_Type__c = 'MVAT';
             ObjGloChrgCH.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgCH=RDSCommon.CreateGlobalCharges(ObjGloChrgCH);
             
             
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
             pCharge.Service_Tax_Percentage__c = 'Service Tax 1';
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
             PCharge1.Service_Tax_Percentage__c = 'Service Tax 2';
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
             PCharge5.Service_Tax_Percentage__c = 'Service Tax 2';
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
             recordIdMap.put('UNIT',objPU1.Id);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             recordIdMap.put('ACCOUNT',objac.Id);
             
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
             objOpportunity.Primary_Phone__c = '8178176699';
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
            
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
             recordIdMap.put('PAYPLAN',objPaymentPlan.Id);
             
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
             recordIdMap.put('APPROVER1',tm1.Id);
             
             Team_Members__c tm2 = new Team_Members__c();
             tm2.Team__c = objTeam.Id;
             tm2.User_Active__c = true;
             tm2.Approver_Type__c = 'Second Level';
             tm2.User__c = a2.id;
             insert tm2;
             recordIdMap.put('APPROVER2',tm2.Id);
             
             Team_Members__c tm3 = new Team_Members__c();
             tm3.Team__c = objTeam.Id;
             tm3.User_Active__c = true;
             tm3.Approver_Type__c = 'Third Level';
             tm3.User__c = a3.id;
             insert tm3;
            recordIdMap.put('APPROVER3',tm3.Id);

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
            objBooking.Status__c = 'Booking In Process';
            objBooking.Opportunity__c = objOpportunity.id;
            insert objBooking;
            
            objPU1.Unit_Status__c = 'Sold';
            update objPU1;
            
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
             scppdB1.Is_Milestone_Achieved__c = true;
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
            scppdC1.Due_Date__c = system.today();
            scppdC1.Is_Milestone_Achieved__c = true;
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
             
              Tax_Breakup__c tx = new Tax_Breakup__c();
            tx.Tax_Slab__c = taxS.Id;
            tx.Taxable_Percentage__c = 4;
            tx.Tax_Code__c = 'ST3FP';
            tx.Tax_Percentage__c = 100;
            tx.Tax_Type__c = 'Service Tax';
            tx.Tax_Split_Type__c = 'Basic';
            insert tx;
            
            Tax_Breakup__c tx1 = new Tax_Breakup__c();
            tx1.Tax_Slab__c = taxS.Id;
            tx1.Taxable_Percentage__c = 0.5;
            tx1.Tax_Code__c = 'SBFB';
            tx1.Tax_Percentage__c = 100;
            tx1.Tax_Type__c = 'Service Tax';
            tx1.Tax_Split_Type__c = 'SBC';
            insert tx1;
            
            Tax_Breakup__c tx11 = new Tax_Breakup__c();
            tx11.Tax_Slab__c = taxS.Id;
            tx11.Taxable_Percentage__c = 0.5;
            tx11.Tax_Code__c = 'KKCFB';
            tx11.Tax_Percentage__c = 100;
            tx11.Tax_Type__c = 'Service Tax';
            tx11.Tax_Split_Type__c = 'KKC';
            insert tx11;
            
            PageReference demandRef = Page.S_sendDemandInvoice2;
            Test.setCurrentPage(demandRef);
            ApexPages.currentPage().getParameters().put('bookingId',objBooking.Id);
            
            S_sendDemandInvoice2 sd = new S_SendDemandInvoice2();
            sd.selectedProjectId =objpr.Id;
            list<SelectOption> sopt = sd.searchOptions;
            list<SelectOption> lp = sd.lstProjects;
            list<SelectOption> cons = sd.lstStructionStages;
            sd.selectedTowerId = t.Id;
            sd.tabName = 'search';
            sd.rowIndex = 0;
            sd.ShowPreview();
        Test.startTest();    
            Apexpages.currentPage().getParameters().put('towerName', 'Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd.getCustomersTowerWise();
            sd.tabName = 'pendingDemands';
            sd.rowIndex = 0;
            sd.ShowPreview();
            sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
           
           // for interest calculation
           scppdC1.Payment_Due_Date__c = system.today().addDays(-10);
           update scppdC1;
           scppdB1.Payment_Due_Date__c = system.today().addDays(-10);
           update scppdB1;
          // calculateInterestSchedular sh1 = new calculateInterestSchedular();
     // String sch = '0 0 23 * * ?'; 
     // system.schedule('Test Calculate Interest', sch, sh1); 

            objOpportunity.Total_Interest__c = 100000;
            objOpportunity.Total_Interest_Settled__c = 5000;
            objOpportunity.Total_Waiver__c = 5000;
            objOpportunity.stageName = 'Booking Confirmed';
            update objOpportunity;
          
            
            PageReference pRef = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef);
            S_ReceiptModuleController rmc = new S_ReceiptModuleController();
            rmc.rmw.r.Project_Unit__c  = objPU1.id;
            rmc.rmw.r.Project__c  = objpr.id;
            
            rmc.UnitSelectionValidation();
            rmc.rmw.r.mode__c = 'Cheque';
            rmc.rmw.r.Receipt_Date__c = system.today();
            rmc.rmw.r.Cheque_DD_Date__c = system.today();
            rmc.rmw.r.DraweeBank__c = 'AXIS';
            rmc.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc.rmw.r.Currency__c = 'Indian Rupee';
            rmc.rmw.r.Amount_Rs__c = 2000000;
            rmc.entitySelected = 'VISHWAROOP';
            rmc.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc.ApplyReceipt();
            
            rmc.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 2000000;
            rmc.applyAdvance();
            rmc.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            rmc.applyAdvance();
            rmc.rowIndex = 0;
            rmc.raiseDemand();
            
            PageReference pRef1 = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef1);
            S_ReceiptModuleController rmc1 = new S_ReceiptModuleController();
            rmc1.rmw.r.Project_Unit__c  = objPU1.id;
            rmc1.rmw.r.Project__c  = objpr.id;
            
            rmc1.UnitSelectionValidation();
            rmc1.rmw.r.mode__c = 'Cheque';
            rmc1.rmw.r.Receipt_Date__c = system.today();
            rmc1.rmw.r.Cheque_DD_Date__c = system.today();
            rmc1.rmw.r.DraweeBank__c = 'AXIS';
            rmc1.rmw.r.Cheque_DD__c = 'CQ0002';
            rmc1.rmw.r.Currency__c = 'Indian Rupee';
            rmc1.rmw.r.Amount_Rs__c = 2000000;
            rmc1.entitySelected = 'VISHWAROOP';
            rmc1.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc1.ApplyReceipt();
           // rmc1.pwList[0].s1.Charge_Amount_Paid__c  = 1000;
            rmc1.applyDues();
            //rmc1.pwList[0].s1.Service_Tax_Amount_Paid__c  = 210;
            //rmc1.applyDues();
            //rmc1.save();

           PageReference cPage = Page.ChequeReceiving;
            Test.setCurrentPage(cPage);
            S_ChequeReceiving recv = new S_ChequeReceiving();
            recv.getlist();

            recv.rwList[0].rCloned.Physically_Cheque_Received__c = true;
            recv.rwList[0].rCloned.Reason_for_rejection_new__c = 'Rejected-Over writing';
            recv.save();

            Id receiptId = recv.rwList[0].r.Id;

       Test.stopTest();   
            Receipt__c r1 = new Receipt__c();
        r1.Cheque_DD_Amount_Rs__c = 200000;
        r1.Cheque_DD__c = '908888';
        r1.Cheque_DD_Date__c = system.today();
        //r1.Project__c = objpr.Id;
        //r1.Project_Unit__c = objPU1.Id;
        //r1.Opportunity__c = objOpportunity.Id;
        r1.CheckReceipt__c = true;
        r1.Token_Amount_Receipt__c = true;
        r1.Physically_Cheque_Received__c = true;
        r1.Approval_Status__c = 'Approved';
        r1.Receipt_Date__c = system.today();
        r1.DraweeBank__c = 'Axis Bank';
        r1.Total_Amount__c = 200000;
        r1.Currency__c = 'Indian Rupee';
        r1.Receipt_Status__c = 'UnProcessed';
        r1.Mode__c = 'TDS';
        //r1.
        insert r1;
            System.debug('receipt id:'  + r1.id);
            PageReference rPage = Page.S_PrintReceipt;
            Test.setCurrentPage(rPage);
            
            ApexPages.currentPage().getParameters().put('id', r1.id);
            ApexPages.currentPage().getParameters().put('letterHead', 'true');
            PrintReceipt pr = new PrintReceipt(); 
            Receipt_Details__c rd = new Receipt_Details__c();
            Project_Charges__c pc = new Project_Charges__c();
            pc.Name = 'pc1';
            pc.External_Id__c ='';
            pc.Active__c = true;
            pc.Applied_This_Charge_To_FA__c = true;
            insert pc;
            //rd.Name = 'RD001';
            rd.Amount__c = null;
            rd.Receipts__c = r1.id;
            //rd.Cheque_number_for_integration__c = '1256';
            system.debug('pc.id::: '+pc.id);
            rd.Charges__c = pc.id;
            rd.For_Service_Tax__c = false;
            insert rd;
            new PrintReceipt.wrapperclass(rd,rd.Charges__r.Name,rd.For_Service_Tax__c);
            pr.ownerName = '';
            pr.ownerPhone= '';
            pr.ownerEmail= '';
            pr.ownerSalutation= '';
            pr.legalAddress= '';
            pr.legalCity= '';
            pr.legalPinCode= '';
            pr.legalEntityName= '';
            
            PageReference cbPage = Page.S_ChequeBouncePrint;
            Test.setCurrentPage(cbPage);
            
            ApexPages.currentPage().getParameters().put('receptId', r1.id);
            ApexPages.currentPage().getParameters().put('letterHead', 'true');
            showReceiptsForPrint s = new showReceiptsForPrint(); 
            
            Ledger__c ldr = new Ledger__c();
            ldr.Debit_Credit__c = 'Credit';
            ldr.Amount__c = 10000;
            ldr.Customer_Pay_Plan_Header__c = objCPPH.Id;
            ldr.Global_Charges__c = ObjGloChrg1.id;
            ldr.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            ldr.Customer_Pay_Plan_Header__c = objCPPH.Id;
            ldr.Opportunity__c = objOpportunity.Id;
            ldr.Reciepts__c = r1.Id;
            ldr.Transaction_Date__c = system.today(); 
            insert ldr;
              
            PageReference lPage = Page.S_PrintLedger;
            Test.setCurrentPage(lPage);
            
            ApexPages.currentPage().getParameters().put('id', objOpportunity.id);
            S_PrintLedgerController lprint = new S_PrintLedgerController();
            
            PageReference ppRef = Page.S_PaymentsPaidPage;
            S_PaymentsPaidClass spp  = new S_PaymentsPaidClass();
            Test.setCurrentPage(ppRef);
            Apexpages.CurrentPage().getParameters().put('Bookingid', objBooking.id);
            
            DemandManagementServices dms = new DemandManagementServices();
            DemandManagementServices.getDemandSoFarSummaryOtherCharges(objOpportunity.Id);
            Set<Id> oppSet = new Set<Id>();
            oppset.add(objOpportunity.Id);
            DemandManagementServices.createRegistrationDetails(oppSet);
            DemandManagementServices.clearMVATLedgers(objOpportunity.Id);
            DemandManagementServices.isMVATPaid(objOpportunity.Id);
            DemandManagementServices.getDemandDetailsRegistration(objOpportunity.Id);
            DemandManagementServices.getChargesForRegistration(objOpportunity.Id);
            List<Id> ScppdSet = new List<Id>();
            ScppdSet.add(scppdB1.Id);
            Decimal amt = 10000;
            Decimal stamt = 5000;
            DemandManagementServices.getAdvanceDemandDetails(ScppdSet,'advance',amt,stamt);
           
            
            
    }
    
      @isTest
    private static void receiptsAdjustment2() {
        
            // creating the complete structure of a project 
            // with project charges, legal entities, towers
            // construction stages, payment plan
            Map<String,Id> recordIdMap = new Map<String,Id>();
            // Legal Entity Creation
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
            recordIdMap.put('LEGAL ENTITY',objlglentity.Id);

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
            recordIdMap.put('PROJECT',objpr.Id);
            
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
             recordIdMap.put('TOWER',t.Id);
             
             // tax slabs creation
             Tax_Slab__c taxS = new Tax_Slab__C();
             taxS.name = 'Service Tax 1';
             taxS.From_Date__c = System.today().addDays(-10);
             taxS.Percentage__c = 4.20;
             taxS = RDSCommon.CreateTaxSlab(taxS);
             
             Tax_Slab__c taxS1 = new Tax_Slab__C();
             taxS1.name = 'Service Tax 2';
             taxS1.From_Date__c = System.today().addDays(-10);
             taxS1.Percentage__c = 14;
             taxS1 = RDSCommon.CreateTaxSlab(taxS1);
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
             
             Global_Charges__c ObjGloChrgI = new Global_Charges__c();
             ObjGloChrgI.Name = 'Interest';
             ObjGloChrgI.Code__c = '007';
             ObjGloChrgI.Description__c = 'Interest';
             ObjGloChrgI.Sequence_No__c = 007;
             ObjGloChrgI.Charge_Type__c = 'Interest';
             ObjGloChrgI.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgI=RDSCommon.CreateGlobalCharges(ObjGloChrgI);
             
             
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
             
             Global_Charges__c ObjGloChrgCH = new Global_Charges__c();
             ObjGloChrgCH.Name = 'Cheque Dishonor';
             ObjGloChrgCH.Code__c = '219';
             ObjGloChrgCH.Description__c = 'Cheque Dishonor';
             ObjGloChrgCH.Sequence_No__c = 219;
             ObjGloChrgCH.Charge_Type__c = 'MVAT';
             ObjGloChrgCH.Nature_of_Charge__c = 'Debtors';
             ObjGloChrgCH=RDSCommon.CreateGlobalCharges(ObjGloChrgCH);
             
             
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
             pCharge.Service_Tax_Percentage__c = 'Service Tax 1';
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
             PCharge1.Service_Tax_Percentage__c = 'Service Tax 2';
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
             PCharge5.Service_Tax_Percentage__c = 'Service Tax 2';
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
             recordIdMap.put('UNIT',objPU1.Id);
             
             // account creation 
             Account objac = new Account();
             objac.FirstName = 'Shock';
             objac.LastName = 'Wave';
             objac.Project__c = objpr.Id;
             objac.Correspondence_Address__c = 'Delhi';
             objac.Category__c = 'General';
             objac.Unit__c = objPU1.Id;
             objac=RDSCommon.CreateAccount(objac);
             recordIdMap.put('ACCOUNT',objac.Id);
             
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
             objOpportunity.Primary_Phone__c = '8178176699';
             objOpportunity=RDSCommon.CreateOpportunity(objOpportunity);
             recordIdMap.put('OPPORTUNITY',objOpportunity.Id);
            
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
             recordIdMap.put('PAYPLAN',objPaymentPlan.Id);
             
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
             recordIdMap.put('APPROVER1',tm1.Id);
             
             Team_Members__c tm2 = new Team_Members__c();
             tm2.Team__c = objTeam.Id;
             tm2.User_Active__c = true;
             tm2.Approver_Type__c = 'Second Level';
             tm2.User__c = a2.id;
             insert tm2;
             recordIdMap.put('APPROVER2',tm2.Id);
             
             Team_Members__c tm3 = new Team_Members__c();
             tm3.Team__c = objTeam.Id;
             tm3.User_Active__c = true;
             tm3.Approver_Type__c = 'Third Level';
             tm3.User__c = a3.id;
             insert tm3;
            recordIdMap.put('APPROVER3',tm3.Id);

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
            objBooking.Status__c = 'Booking In Process';
            objBooking.Opportunity__c = objOpportunity.id;
            insert objBooking;
            
            objPU1.Unit_Status__c = 'Sold';
            update objPU1;
            
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
              
              Customer_Pay_Plan_Header__c objCPPH2 = new Customer_Pay_Plan_Header__c();
              objCPPH2.Amount__c=10000.00;
              objCPPH2.Customer__c=objopportunity.id; 
              objCPPH2.Effect_From_Date__c=system.today(); 
              objCPPH2.Global_Charges__c=ObjGloChrg3.id; 
              objCPPH2.Project__c=objpr.id; 
              objCPPH2.Project_Unit__c=objPU1.id; 
              objCPPH2.Standard_Pay_Plan_Header__c=objSPP2.id;
              objCPPH2.tower__c = t.ID;
              objCPPH2.Quotation__c = q.id;
              objCPPH2.PlanDt__c=system.today();
              objCPPH2.Booking__c = objBooking.id;
              insert objCPPH2;
              
              Customer_Pay_Plan_Header__c objCPPH3 = new Customer_Pay_Plan_Header__c();
              objCPPH3.Amount__c=10000.00;
              objCPPH3.Customer__c=objopportunity.id; 
              objCPPH3.Effect_From_Date__c=system.today(); 
              objCPPH3.Global_Charges__c=ObjGloChrg6.id; 
              objCPPH3.Project__c=objpr.id; 
              objCPPH3.Project_Unit__c=objPU1.id; 
              objCPPH3.Standard_Pay_Plan_Header__c=objSPP5.id;
              objCPPH3.tower__c = t.ID;
              objCPPH3.Quotation__c = q.id;
              objCPPH3.PlanDt__c=system.today();
              objCPPH3.Booking__c = objBooking.id;
              insert objCPPH3;
              
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
             scppdB1.Is_Milestone_Achieved__c = true;
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
             scppdB1.Charge_Amount_Billed__c = 0;
             scppdB1.Charge_Amount_Paid__c= 0;
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
            scppdC1.Due_Date__c = system.today();
            scppdC1.Is_Milestone_Achieved__c = true;
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
             set<id> scppdId = new set<id>();
             scppdId.add(scppdB1.id);
             scppdId.add(scppdC1.id);
             
             Standard_Customer_Pay_Plan_Detail__c    scppdD1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdD1.Standard_Pay_Plan_Header__c = objSPP2.id;
             scppdD1.Project__c=objpr.id;
             scppdD1.tower__c = t.ID;
             scppdD1.Is_to_be_Paid__c='From Dt. of Booking';
             scppdD1.Is_to_be__c = '0Day(s) from date of booking.';
             scppdD1.Days_Months__c='Day(s)';
             scppdD1.Days_Months_Value__c=0;
             scppdD1.Amount__c='Percentage';
             scppdD1.Installment__c=10000;
             scppdD1.Customer_Pay_Plan_Header__c = objCPPH2.id;
             scppdD1.Due_Date__c = system.today();
             scppdD1.IsSendDemandLetter__c = false;
             scppdD1.Is_Milestone_Achieved__c = true;
             scppdD1.Basic__c = 0;
             scppdD1.Development_Charges__c = 0;
             scppdD1.Floor_Rise__c = 0;
             scppdD1.Infrastructure_Charges__c = 0;
             scppdD1.Premium_1__c = 0;
             scppdD1.Premium_2__c = 0;
             scppdD1.Premium_3__c = 0;
             scppdD1.Premium_4__c = 0;
             scppdD1.Milestone_Percentage__c = 0;
             scppdD1.ST_On_Basic__c = 0;
             scppdD1.ST_On_Development_Charges__c = 0;
             scppdD1.ST_On_Floor_Rise__c = 0;
             scppdD1.ST_On_Infrastructure_Charges__c = 0;
             scppdD1.ST_on_Premium_1__c = 0;
             scppdD1.ST_on_Premium_2__c = 0;
             scppdD1.ST_on_Premium_3__c = 0;
             scppdD1.ST_on_Premium_4__c = 0;
             scppdD1.TDS__c = 0;
             scppdD1.Service_Tax_Amount_Billed__c = 20000;
             scppdD1.marked_for_interest__c = false;
             scppdD1.Payment_Due_Date__c = system.today().addDays(-5);
             //scppdD1.Service_Tax_Amount_Due__c = 10000;
             scppdD1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdD1);
             
             Standard_Customer_Pay_Plan_Detail__c    scppdE1 = new Standard_Customer_Pay_Plan_Detail__c();
             scppdE1.Standard_Pay_Plan_Header__c = objSPP5.id;
             scppdE1.Project__c=objpr.id;
             scppdE1.tower__c = t.ID;
             scppdE1.Is_to_be_Paid__c='From Dt. of Booking';
             scppdE1.Is_to_be__c = '0Day(s) from date of booking.';
             scppdE1.Days_Months__c='Day(s)';
             scppdE1.Days_Months_Value__c=0;
             scppdE1.Amount__c='Percentage';
             scppdE1.Installment__c=10000;
             scppdE1.Customer_Pay_Plan_Header__c = objCPPH3.id;
             scppdE1.Due_Date__c = system.today();
             scppdE1.IsSendDemandLetter__c = false;
             scppdE1.Is_Milestone_Achieved__c = true;
             scppdE1.Payment_Due_Date__c = system.today().addDays(-5);
            // scppdE1.Charge_Amount_Due__c = 1000;
             scppdE1.Basic__c = 0;
             scppdE1.Development_Charges__c = 0;
             scppdE1.Floor_Rise__c = 0;
             scppdE1.Infrastructure_Charges__c = 0;
             scppdE1.Premium_1__c = 0;
             scppdE1.Premium_2__c = 0;
             scppdE1.Premium_3__c = 0;
             scppdE1.Premium_4__c = 0;
             scppdE1.Milestone_Percentage__c = 0;
             scppdE1.ST_On_Basic__c = 0;
             scppdE1.ST_On_Development_Charges__c = 0;
             scppdE1.ST_On_Floor_Rise__c = 0;
             scppdE1.ST_On_Infrastructure_Charges__c = 0;
             scppdE1.ST_on_Premium_1__c = 0;
             scppdE1.ST_on_Premium_2__c = 0;
             scppdE1.ST_on_Premium_3__c = 0;
             scppdE1.ST_on_Premium_4__c = 0;
             scppdE1.TDS__c = 0;
             scppdE1.Service_Tax_Amount_Billed__c = 20000;
             scppdE1.marked_for_interest__c = false;
             
             
             scppdE1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdE1);
             set<id> cpphid = new set<id>();
             cpphid.add(objopportunity.id);
            
                Tax_Breakup__c tx = new Tax_Breakup__c();
            tx.Tax_Slab__c = taxS.Id;
            tx.Taxable_Percentage__c = 4;
            tx.Tax_Code__c = 'ST3FP';
            tx.Tax_Percentage__c = 100;
            tx.Tax_Type__c = 'Service Tax';
            tx.Tax_Split_Type__c = 'Basic';
            insert tx;
            
            Tax_Breakup__c tx1 = new Tax_Breakup__c();
            tx1.Tax_Slab__c = taxS.Id;
            tx1.Taxable_Percentage__c = 0.5;
            tx1.Tax_Code__c = 'SBFB';
            tx1.Tax_Percentage__c = 100;
            tx1.Tax_Type__c = 'Service Tax';
            tx1.Tax_Split_Type__c = 'SBC';
            insert tx1;
            
            Tax_Breakup__c tx11 = new Tax_Breakup__c();
            tx11.Tax_Slab__c = taxS.Id;
            tx11.Taxable_Percentage__c = 0.5;
            tx11.Tax_Code__c = 'KKCFB';
            tx11.Tax_Percentage__c = 100;
            tx11.Tax_Type__c = 'Service Tax';
            tx11.Tax_Split_Type__c = 'KKC';
            insert tx11;
            
            PageReference demandRef = Page.S_sendDemandInvoice2;
            Test.setCurrentPage(demandRef);
            ApexPages.currentPage().getParameters().put('bookingId',objBooking.Id);
            
            S_sendDemandInvoice2 sd = new S_SendDemandInvoice2();
            sd.selectedProjectId =objpr.Id;
            list<SelectOption> sopt = sd.searchOptions;
            list<SelectOption> lp = sd.lstProjects;
            list<SelectOption> cons = sd.lstStructionStages;
            sd.selectedTowerId = t.Id;
            sd.tabName = 'search';
            sd.rowIndex = 0;
            sd.ShowPreview();
            Test.startTest();
            Apexpages.currentPage().getParameters().put('towerName', 'Tower X');
            Apexpages.currentPage().getParameters().put('projectName', 'SOS');
            sd.getCustomersTowerWise();
            sd.tabName = 'pendingDemands';
            sd.rowIndex = 0;
            sd.ShowPreview();
            sd.CustomerTowerList[0].selected = true;
            sd.sendMail();
       
            objOpportunity.Total_Interest__c = 100000;
            objOpportunity.Total_Interest_Settled__c = 5000;
            objOpportunity.Total_Waiver__c = 5000;
            objOpportunity.stageName = 'Booking Confirmed';
            update objOpportunity;
            
            
            
            PageReference pRef = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef);
            S_ReceiptModuleController rmc = new S_ReceiptModuleController();
            rmc.rmw.r.Project_Unit__c  = objPU1.id;
            rmc.rmw.r.Project__c  = objpr.id;
            
            rmc.UnitSelectionValidation();
            rmc.rmw.r.mode__c = 'Cheque';
            rmc.rmw.r.Receipt_Date__c = system.today();
            rmc.rmw.r.Cheque_DD_Date__c = system.today();
            rmc.rmw.r.DraweeBank__c = 'AXIS';
            rmc.rmw.r.Cheque_DD__c = 'CQ0001';
            rmc.rmw.r.Currency__c = 'Indian Rupee';
            rmc.rmw.r.Amount_Rs__c = 2000000;
            rmc.entitySelected = 'VISHWAROOP';
            rmc.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc.ApplyReceipt();
            
            rmc.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 2000000;
            rmc.applyAdvance();
            rmc.pw1List[0].s1.Charge_Amount_Advance_Recd__c  = 5000;
            rmc.applyAdvance();
            rmc.rowIndex = 0;
            rmc.raiseDemand();
            
            PageReference pRef1 = Page.S_ReceiptModule;
            Test.setCurrentPage(pRef1);
            S_ReceiptModuleController rmc1 = new S_ReceiptModuleController();
            rmc1.rmw.r.Project_Unit__c  = objPU1.id;
            rmc1.rmw.r.Project__c  = objpr.id;
            
            rmc1.UnitSelectionValidation();
            rmc1.rmw.r.mode__c = 'Cheque';
            rmc1.rmw.r.Receipt_Date__c = system.today();
            rmc1.rmw.r.Cheque_DD_Date__c = system.today();
            rmc1.rmw.r.DraweeBank__c = 'AXIS';
            rmc1.rmw.r.Cheque_DD__c = 'CQ0002';
            rmc1.rmw.r.Currency__c = 'Indian Rupee';
            rmc1.rmw.r.Amount_Rs__c = 2000000;
            rmc1.entitySelected = 'VISHWAROOP';
            rmc1.rmw.r.Opportunity_Email_Id__c = 'test@email.com';
            rmc1.selectInstrument();
            rmc1.checkDupeList();
            rmc1.ApplyReceipt();
            rmc1.pwList[0].s1.Charge_Amount_Paid__c  = 1000;
            rmc1.applyDues();
            rmc1.pwList[0].s1.Service_Tax_Amount_Paid__c  = 210;
            rmc1.applyDues();
            rmc1.save();
            
           PageReference cPage = Page.ChequeReceiving;
            Test.setCurrentPage(cPage);
            S_ChequeReceiving recv = new S_ChequeReceiving();
            recv.getlist();

            recv.rwList[0].rCloned.Physically_Cheque_Received__c = true;
            recv.rwList[0].rCloned.Reason_for_rejection_new__c = 'Accepted';
            recv.save();
            recv.getDisableNext();
            recv.Beginning();
           // recv.Previous();
            recv.Next();
            recv.End();
            recv.rwList[0].rCloned.Physically_Cheque_Received__c = true;
            recv.rwList[0].rCloned.Banking__c = 'Insufficient Funds';
            
            recv.save();
            
            Test.stopTest(); 
            PageReference lPage = Page.S_PrintLedger;
            Test.setCurrentPage(lPage);
            
            ApexPages.currentPage().getParameters().put('id', objOpportunity.id);
            S_PrintLedgerController lprint = new S_PrintLedgerController();
            
            
             Receipt__c r1 = new Receipt__c();
        r1.Cheque_DD_Amount_Rs__c = 200000;
        r1.Cheque_DD__c = '908888';
        r1.Cheque_DD_Date__c = system.today().addDays(-10);
        //r1.Project__c = objpr.Id;
        //r1.Project_Unit__c = objPUU.Id;
        //r1.Opportunity__c = objcustomer.Id;
        r1.CheckReceipt__c = true;
        r1.Token_Amount_ST__c = true;
        r1.Physically_Cheque_Received__c = true;
        r1.Approval_Status__c = 'Approved';
        r1.Receipt_Date__c = system.today();
        r1.DraweeBank__c = 'Axis Bank';
        r1.Total_Amount__c = 200000;
        r1.Currency__c = 'Indian Rupee';
        r1.Receipt_Status__c = 'UnProcessed';
        insert r1;
            System.debug('receipt id:'  + r1.id);
            PageReference rPage = Page.S_PrintReceipt;
            Test.setCurrentPage(rPage);
            
            ApexPages.currentPage().getParameters().put('id', r1.id);
            ApexPages.currentPage().getParameters().put('letterHead', 'true');
            PrintReceipt pr = new PrintReceipt(); 
            Receipt_Details__c rd = new Receipt_Details__c();
            Project_Charges__c pc = new Project_Charges__c();
            pc.Name = 'pc1';
            pc.External_Id__c ='';
            pc.Active__c = true;
            pc.Applied_This_Charge_To_FA__c = true;
            insert pc;
            //rd.Name = 'RD001';
            rd.Amount__c = 10000000;
            rd.Receipts__c = r1.id;
           // rd.Is_Interest_Settlement__c = true;
            //rd.Cheque_number_for_integration__c = '1256';
            system.debug('pc.id::: '+pc.id);
            rd.Charges__c = pc.id;
            rd.For_Service_Tax__c = false;
            //rd.Standard_Customer_Pay_Plan_Detail__c = scppdB1.id;
            insert rd;
            
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
            
            Receipt__c r2 = new Receipt__c();
            r2.Cheque_DD_Amount_Rs__c = 200000;
            r2.Cheque_DD__c = '908888';
            r2.Cheque_DD_Date__c = system.today().addDays(-10); 
            r2.Project__c = objpr.Id;
            r2.Project_Unit__c = objPU1.Id;
            r2.Opportunity__c = objOpportunity.id;
            r2.Booking__c = objBooking.id;
            r2.CheckReceipt__c = true;
            r2.Token_Amount_ST__c = true;
            r2.Physically_Cheque_Received__c = true;
            r2.Approval_Status__c = 'Approved';
            r2.Receipt_Date__c = system.today();
            r2.DraweeBank__c = 'Axis Bank';
            r2.Total_Amount__c = 200000;
            r2.On_Account_Money__c = 200000;
            r2.Currency__c = 'Indian Rupee';
            r2.Receipt_Status__c = 'Cleared';
            insert r2;
            
            Receipt_Details__c rd2 = new Receipt_Details__c();
            rd2.Charges__c = PCharge.id;
            rd2.Receipts__c = r2.id;
            rd2.Amount__c = 100000;
            rd2.Standard_Customer_Pay_Plan_Detail__c = scppdC1.id;
            rd2.For_Service_Tax__c = false;
            rd2.Interest_flatcost_waived__c = 1000000;
            rd2.Interest_servicetax_waived__c = 50000;
            rd2.On_Account_Money__c = true;
            insert rd2;
            rd2.Is_Interest_Settlement__c = true;
            update rd2;
            List<Id> ids = new list<id>();
            ids.add(rd2.id);
            LedgerManagementServices.createCreditLedgersForInterest(ids);
            LedgerManagementServices.GetLedgerMap(scppdId);
            LedgerManagementServices.createRegistrationLedgers(cpphid);
            List<Standard_Customer_Pay_Plan_Detail__c> scd = new List<Standard_Customer_Pay_Plan_Detail__c>();
            scd.add(scppdB1);
            objpr.RDS_Interest_Rate__c = 100;
            update objpr;
            Interest_Details__c idl = new Interest_Details__c();
            idl.Installment_Amount__c = 0;
            idl.Service_Tax_Amount__c = scppdB1.Service_Tax_Amount_Due__c;
            idl.Milestone__c = scppdB1.Id;
            idl.Start_Date__c = scppdB1.Payment_Due_Date__c;
            idl.project__c = scppdB1.project__c;
            idl.sequence__c = 1;
            idl.corrected_age__c = 30;
            idl.Interest_On_Flatcost__c =10;
            insert idl;
            //InterestManagementServices.markForInterestCalculation(scd);
            List<Interest_Details__c> idList = new List<Interest_Details__c>();
            idList.add(idl);
            InterestManagementServices.calculateInterest(idList);
            InterestManagementServices.reverseInterestDetails(r2.id);
            ids.clear();
            //ids.add(rd.id);
            //InterestManagementServices.deductInterestForEFT(ids);
            Set<Id> idSet = new Set<Id>();
            idSet.add(scppdB1.Id);
            //InterestManagementServices.recalculateInterest(idSet);
            
            PrintReceipt.wrapperclass wr = new PrintReceipt.wrapperclass(rd,rd.Charges__r.Name,rd.For_Service_Tax__c);
            wr.basicChargeswrap = '';
            pr.ownerName = '';
            pr.ownerPhone= '';
            pr.ownerEmail= '';
            pr.ownerSalutation= '';
            pr.legalAddress= '';
            pr.legalCity= '';
            pr.legalPinCode= '';
            pr.legalEntityName= '';
            pr.totalAmt = 3212565;
            pr.tamt = '796541';
            pr.accMoney = '78452';
            PageReference ppRef = Page.S_PaymentsPaidPage;
            S_PaymentsPaidClass spp  = new S_PaymentsPaidClass();
            Test.setCurrentPage(ppRef);
            Apexpages.CurrentPage().getParameters().put('Bookingid', objBooking.id);
            
    }
    
}