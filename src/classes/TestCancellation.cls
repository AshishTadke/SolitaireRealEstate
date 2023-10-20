@isTest
private  class TestCancellation {
    // test method for Default on Token cancellation
    @isTest
    private static void DoT() {
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
             
            // project charges creation
             // one basic
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
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
             
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
            
             Rate_List_Detail__c objRld = new Rate_List_Detail__c();
             objRld.Name = 'Basic RL Detail';
             objRld.Charge_Based_On__c = 'Rate';
             objRld.Percent__c = 23600;
             objRld.Project__c = objpr.Id;
             objRld = RDSCommon.CreateRateListHeader(objRld);
             
             Rate_List__c objRL = new Rate_List__c();
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
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
            
            objOpportunity.stageName = 'Booking Confirmed';
            objOPportunity.status__c = 'Active';
            objOpportunity.Booking__c = objBooking.Id;
            update objOpportunity;
            
             r1.Receipt_Status__c = 'Dishonored';
             r1.Banking__c = 'Payment Failed - Insufficient Funds';
             r1.Opportunity_Email_Id__c = 'lb@mmail.com';
             update r1;
             
             cancellation.markForCancellation();
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(1);
             update objOpportunity;
             cancellation.createCancellationRecords();
 
             S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
             sd1.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd1.getCustomersTowerWiseCan();
            sd1.tabName = 'pendingCancellations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListCan[0].selected = true;
            sd1.sendMail();
            
            objOpportunity.unit_release_date__c = system.today().addDays(1);
            update objOpportunity;
            
            cancellation.unitRelease();
            
    }
    
     // test method for Default on Token cancellation
    @isTest
    private static void cancellationL2L3() {
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
             
            // project charges creation
             // one basic
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
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
             
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
            
             Rate_List_Detail__c objRld = new Rate_List_Detail__c();
             objRld.Name = 'Basic RL Detail';
             objRld.Charge_Based_On__c = 'Rate';
             objRld.Percent__c = 23600;
             objRld.Project__c = objpr.Id;
             objRld = RDSCommon.CreateRateListHeader(objRld);
             
             Rate_List__c objRL = new Rate_List__c();
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
              objCPPH.Amount_Demanded_Till_Date__c = 500000;
              objCPPH.Amount_Recd_Till_Date__c = 100000;
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
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
            
            objOpportunity.stageName = 'Booking confirmed';
            objOPportunity.status__c = 'Active';
            objOpportunity.Booking__c = objBooking.Id;
            update objOpportunity;
            
            Demand_Invoice__c di = new Demand_Invoice__c();
            di.Customer__c = objOpportunity.Id;
            di.Invoice_Date__c = system.today().addDays(-15);
            di.Due_Date__c = system.today().addDays(-10);
            di.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            di.Project__c =   objpr.Id;
            di.Email__c = 'lb@mmmail.com';
            di.Current_Demand_Installment__c = 10000;
            di.Current_Demand_Service_Tax__c = 5000;
            insert di;
            
            scppdC1.IsSendDemandLetter__c = true;
            scppdC1.Invoice_Raised_Date__c = system.today().addDays(-15);
            scppdC1.Payment_Due_Date__c = system.today().addDays(-10);
            scppdC1.Milestone_Demand_Id__c = di.Id;
            scppdC1.Total_Interest_Amount__c = 72;
            scppdC1.Is_Milestone_Achieved__c = true;
            scppdC1.Charge_Amount_Billed__c = 10000;
            scppdC1.Service_Tax_Amount_Billed__c = 5000;
            scppdC1.Charge_Amount_Paid__c = 5;
            scppdC1.Service_Tax_Amount_Paid__c = 5;
            update scppdC1;
            
            System.debug('SCPPDC1:' + scppdc1);
            
            Standard_Customer_Pay_Plan_Detail__c updatedSCCPD = [Select IsPaymentOverdue__c, Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c, 
                                         Milestone_Demand_Id__c, Charge_Amount_Due__c, Service_Tax_Amount_Due__c,
                                        Customer_Pay_Plan_Header__r.Customer__r.Status__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.Cancellation_In_Progress__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.StageName 
                                        from Standard_Customer_Pay_Plan_Detail__c where id = :scppdC1.id];
            System.debug('Updated scppd:' + updatedSCCPD);
            
             cancellation.markForCancellation();
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(1);
             update objOpportunity;
             cancellation.createCancellationRecords();
 
             S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
             sd1.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd1.getCustomersTowerWiseCan();
            sd1.tabName = 'pendingCancellations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListCan[0].selected = true;
            sd1.sendMail();
            
            cancellation_intimation__c cL2 = [select Id from cancellation_intimation__c where Customer__c = : objOpportunity.id and Letter_category__c = 'L2'];
            S_cancellationLetter sCan = new S_cancellationLetter();
            scan.getCancellationDemandDetailsDB(cL2.Id);
            sCan.strCancelId = cL2.Id;
            sCan.getCancellationLetter();
            sCan.getChequeDetails(r1.Id);
            
            objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            
            S_sendDemandInvoice2 sd2 = new S_SendDemandInvoice2();
             sd2.selectedTowerId = t.Id; 
            sd2.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd2.getCustomersTowerWiseCan();
            sd2.tabName = 'pendingCancellations';
            sd2.rowIndex = 0;
            sd2.ShowPreview();
            sd2.CustomerTowerListCan[0].selected = true;
            sd2.sendMail();
            
            cancellation_intimation__c c = [select Id from cancellation_intimation__c where Customer__c = : objOpportunity.id and Letter_category__c = 'L3'];
           
            PageReference pref = Page.S_CancellationPage;
            Test.setCurrentPage(pref);
            Apexpages.currentPage().getParameters().put('cancelId', 'c.Id');
            Apexpages.currentPage().getParameters().put('mode', 'view');
            Apexpages.currentPage().getParameters().put('letterHead', 'true');
            S_CancellationPage canPage = new S_CancellationPage();
            
    }
    
    
     // test method for Default on Token cancellation
    @isTest
    private static void cancellationL4L5L6L7() {
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
             
            // project charges creation
             // one basic
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
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
             
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
            
             Rate_List_Detail__c objRld = new Rate_List_Detail__c();
             objRld.Name = 'Basic RL Detail';
             objRld.Charge_Based_On__c = 'Rate';
             objRld.Percent__c = 23600;
             objRld.Project__c = objpr.Id;
             objRld = RDSCommon.CreateRateListHeader(objRld);
             
             Rate_List__c objRL = new Rate_List__c();
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
              objCPPH.Amount_Demanded_Till_Date__c = 500000;
              objCPPH.Amount_Recd_Till_Date__c = 500000;
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
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
            
            objOpportunity.stageName = 'Booking confirmed';
            objOPportunity.status__c = 'Active';
            objOpportunity.Booking__c = objBooking.Id;
            update objOpportunity;
            
            Demand_Invoice__c di = new Demand_Invoice__c();
            di.Customer__c = objOpportunity.Id;
            di.Invoice_Date__c = system.today().addDays(-15);
            di.Due_Date__c = system.today().addDays(-10);
            di.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            di.Project__c =   objpr.Id;
            di.Email__c = 'lb@mmmail.com';
            di.Current_Demand_Installment__c = 10000;
            di.Current_Demand_Service_Tax__c = 5000;
            insert di;
            
            scppdC1.IsSendDemandLetter__c = true;
            scppdC1.Invoice_Raised_Date__c = system.today().addDays(-15);
            scppdC1.Payment_Due_Date__c = system.today().addDays(-10);
            scppdC1.Milestone_Demand_Id__c = di.Id;
            scppdC1.Total_Interest_Amount__c = 72;
            scppdC1.Is_Milestone_Achieved__c = true;
            scppdC1.Charge_Amount_Billed__c = 10000;
            scppdC1.Service_Tax_Amount_Billed__c = 5000;
            scppdC1.Charge_Amount_Paid__c = 5;
            scppdC1.Service_Tax_Amount_Paid__c = 5;
            update scppdC1;
            
            System.debug('SCPPDC1:' + scppdc1);
            
            Standard_Customer_Pay_Plan_Detail__c updatedSCCPD = [Select IsPaymentOverdue__c, Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c, 
                                         Milestone_Demand_Id__c, Charge_Amount_Due__c, Service_Tax_Amount_Due__c,
                                        Customer_Pay_Plan_Header__r.Customer__r.Status__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.Cancellation_In_Progress__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.StageName 
                                        from Standard_Customer_Pay_Plan_Detail__c where id = :scppdC1.id];
            System.debug('Updated scppd:' + updatedSCCPD);
            
             cancellation.markForCancellation();
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(1);
             update objOpportunity;
             cancellation.createCancellationRecords();
 
             S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
             sd1.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd1.getCustomersTowerWiseCan();
            sd1.tabName = 'pendingCancellations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListCan[0].selected = true;
            sd1.sendMail();
            
            Demand_Invoice__c di2 = new Demand_Invoice__c();
            di2.Customer__c = objOpportunity.Id;
            di2.Invoice_Date__c = system.today().addDays(-15);
            di2.Due_Date__c = system.today().addDays(-10);
            di2.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            di2.Project__c =   objpr.Id;
            di2.Email__c = 'lb@mmmail.com';
            di2.Current_Demand_Installment__c = 30000;
            di2.Current_Demand_Service_Tax__c = 2100;
            insert di2;
            
            scppdB1.IsSendDemandLetter__c = true;
            scppdB1.Invoice_Raised_Date__c = system.today().addDays(-15);
            scppdB1.Payment_Due_Date__c = system.today().addDays(-10);
            scppdB1.Milestone_Demand_Id__c = di2.Id;
            scppdB1.Total_Interest_Amount__c = 150;
            scppdB1.Is_Milestone_Achieved__c = true;
            scppdB1.Charge_Amount_Billed__c = 30000;
            scppdB1.Service_Tax_Amount_Billed__c = 2100;
            scppdB1.Charge_Amount_Paid__c = 5;
            scppdB1.Service_Tax_Amount_Paid__c = 5;
            update scppdC1;
            
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            
            S_sendDemandInvoice2 sd2 = new S_SendDemandInvoice2();
             sd2.selectedTowerId = t.Id; 
            sd2.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd2.getCustomersTowerWiseCan();
            sd2.tabName = 'pendingCancellations';
            sd2.rowIndex = 0;
            sd2.ShowPreview();
            sd2.CustomerTowerListCan[0].selected = true;
            sd2.sendMail();
            
            List<cancellation_intimation__c> cL5 = [select Id from cancellation_intimation__c where Customer__c = : objOpportunity.id and Letter_category__c = 'L5'];
            System.debug('CL5 :' + cl5);
            S_cancellationLetter sCan = new S_cancellationLetter();
            scan.getOutstandingDemandDetailsDB(cL5[0].Id);
            
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L3_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L4_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            
          scppdC1.Charge_Amount_Paid__c = 10000;
            scppdC1.Service_Tax_Amount_Paid__c = 5000;
            update scppdC1;
            
            scppdB1.Charge_Amount_Paid__c = 30000;
            scppdB1.Service_Tax_Amount_Paid__c = 2100;
            update scppdB1;
            
            cancellation.removeFromCancellationProcess();
            
    }
    
        
     // test method for cancellation post registration 
    @isTest
    private static void cancellationL8L9L10L11() {
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
             
            // project charges creation
             // one basic
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
             User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');
             User a2 = TestDataFactory.createUserSysAdmin('Two','Galvatron', 'galvatron2@radius.com', 'galvatron2@radius.com');
             User a3 = TestDataFactory.createUserSysAdmin('Three','Galvatron', 'galvatron3@radius.com', 'galvatron3@radius.com');
             
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
            
             Rate_List_Detail__c objRld = new Rate_List_Detail__c();
             objRld.Name = 'Basic RL Detail';
             objRld.Charge_Based_On__c = 'Rate';
             objRld.Percent__c = 23600;
             objRld.Project__c = objpr.Id;
             objRld = RDSCommon.CreateRateListHeader(objRld);
             
             Rate_List__c objRL = new Rate_List__c();
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
              objCPPH.Amount_Demanded_Till_Date__c = 500000;
              objCPPH.Amount_Recd_Till_Date__c = 500000;
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
            scppdC1= RDSCommon.CreateCustomerPayPlanHeaderDetail(scppdC1);
            
            objOpportunity.stageName = 'Booking confirmed';
            objOPportunity.status__c = 'Active';
            objOpportunity.registration_status__c = 'Agreement Registered';
            objOpportunity.Date_of_Agreement__c = system.today();
            objOpportunity.Agreement_Serial_Number__c = 'ARGE0011';
            objOpportunity.Booking__c = objBooking.Id;
            update objOpportunity;
            
            Demand_Invoice__c di = new Demand_Invoice__c();
            di.Customer__c = objOpportunity.Id;
            di.Invoice_Date__c = system.today().addDays(-15);
            di.Due_Date__c = system.today().addDays(-10);
            di.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            di.Project__c =   objpr.Id;
            di.Email__c = 'lb@mmmail.com';
            di.Current_Demand_Installment__c = 10000;
            di.Current_Demand_Service_Tax__c = 5000;
            insert di;
            
            scppdC1.IsSendDemandLetter__c = true;
            scppdC1.Invoice_Raised_Date__c = system.today().addDays(-15);
            scppdC1.Payment_Due_Date__c = system.today().addDays(-10);
            scppdC1.Milestone_Demand_Id__c = di.Id;
            scppdC1.Total_Interest_Amount__c = 72;
            scppdC1.Is_Milestone_Achieved__c = true;
            scppdC1.Charge_Amount_Billed__c = 10000;
            scppdC1.Service_Tax_Amount_Billed__c = 5000;
            scppdC1.Charge_Amount_Paid__c = 5;
            scppdC1.Service_Tax_Amount_Paid__c = 5;
            update scppdC1;
            
            System.debug('SCPPDC1:' + scppdc1);
            
            Standard_Customer_Pay_Plan_Detail__c updatedSCCPD = [Select IsPaymentOverdue__c, Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c, 
                                         Milestone_Demand_Id__c, Charge_Amount_Due__c, Service_Tax_Amount_Due__c,
                                        Customer_Pay_Plan_Header__r.Customer__r.Status__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.Cancellation_In_Progress__c, 
                                        Customer_Pay_Plan_Header__r.Customer__r.StageName 
                                        from Standard_Customer_Pay_Plan_Detail__c where id = :scppdC1.id];
            System.debug('Updated scppd:' + updatedSCCPD);
            
             cancellation.markForCancellation();
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(1);
             update objOpportunity;
             cancellation.createCancellationRecords();
 
             S_sendDemandInvoice2 sd1 = new S_SendDemandInvoice2();
             sd1.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd1.getCustomersTowerWiseCan();
            sd1.tabName = 'pendingCancellations';
            sd1.rowIndex = 0;
            sd1.ShowPreview();
            sd1.CustomerTowerListCan[0].selected = true;
            sd1.sendMail();
            
            Demand_Invoice__c di2 = new Demand_Invoice__c();
            di2.Customer__c = objOpportunity.Id;
            di2.Invoice_Date__c = system.today().addDays(-15);
            di2.Due_Date__c = system.today().addDays(-10);
            di2.Standard_Customer_Pay_Plan_Detail__c = scppdC1.Id;
            di2.Project__c =   objpr.Id;
            di2.Email__c = 'lb@mmmail.com';
            di2.Current_Demand_Installment__c = 30000;
            di2.Current_Demand_Service_Tax__c = 2100;
            insert di2;
            
            scppdB1.IsSendDemandLetter__c = true;
            scppdB1.Invoice_Raised_Date__c = system.today().addDays(-15);
            scppdB1.Payment_Due_Date__c = system.today().addDays(-10);
            scppdB1.Milestone_Demand_Id__c = di2.Id;
            scppdB1.Total_Interest_Amount__c = 150;
            scppdB1.Is_Milestone_Achieved__c = true;
            scppdB1.Charge_Amount_Billed__c = 30000;
            scppdB1.Service_Tax_Amount_Billed__c = 2100;
            scppdB1.Charge_Amount_Paid__c = 5;
            scppdB1.Service_Tax_Amount_Paid__c = 5;
            update scppdC1;
            
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            
            S_sendDemandInvoice2 sd2 = new S_SendDemandInvoice2();
             sd2.selectedTowerId = t.Id; 
            sd2.selectedTowerId = t.Id;
            Apexpages.currentPage().getParameters().put('towerNameCan', 'SOS-Tower X');
            sd2.getCustomersTowerWiseCan();
            sd2.tabName = 'pendingCancellations';
            sd2.rowIndex = 0;
            sd2.ShowPreview();
            sd2.CustomerTowerListCan[0].selected = true;
            sd2.sendMail();
            
            objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L3_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            cancellation_intimation__c c1 = [select Id from cancellation_intimation__c where Customer__c = : objOpportunity.id and Letter_category__c = 'L10'];
            
             objOpportunity.L1_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L2_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L3_to_be_sent_on__c = system.today().addDays(-5);
            objOpportunity.L4_to_be_sent_on__c = system.today().addDays(1);
            update objOpportunity;
            cancellation.createCancellationRecords();
            
            cancellation_intimation__c c2 = [select Id from cancellation_intimation__c where Customer__c = : objOpportunity.id and Letter_category__c = 'L11']; 
            c2.previous_letter__c = c1.id;
            update c2;
            PageReference pref = Page.S_CancellationPage;
            Test.setCurrentPage(pref);
            Apexpages.currentPage().getParameters().put('cancelId', 'c2.Id');
            Apexpages.currentPage().getParameters().put('mode', 'view');
            Apexpages.currentPage().getParameters().put('letterHead', 'true');
            S_CancellationPage canPage = new S_CancellationPage();
           
            
    }
}