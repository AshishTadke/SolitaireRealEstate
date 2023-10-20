@isTest
private  Class TestDiscountQuotationView1{
@isTest
    private static void discountQuotationView1Method() {

        Opportunity objcustomer;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit_Type__c objPUT;
        
        objpr = new Project__c();
        objpr.Project_Code__c = 'T31';
        objpr.Name = 'TestProject';
        objpr.RDS_Short_Name__c = 'T';
        objpr.Start_Date__c = System.today().addDays(-5);
        objpr.RDS_Interest_Rate__c = 12;
        insert objpr;
          
        objPUT = new Project_Unit_Type__c();
        objPUT.RDS_Code__c = '101';
        objPUT.RDS_Project__c = objpr.id;
        insert objPUT;
          
        objPUU = new Project_Unit__c();  
        objPUU.Project_Unit_Type__c = objPUT.id;  
        objPUU.Name = 'TestUnit';      
        objPUU.Project__c = objpr.Id;
        objPUU.Param1__c = '5';
        objPUU.UnitNo__c ='9';
        objPUU.Unit_Status__c ='Vacant';
        insert objPUU;
      
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        objCustomer.Physical_document_received__c = true;
        insert objcustomer;
          
        objPUU.Unit_Status__c= 'BIP - RM Verification';
        update objPUU;
       
         Master__c m = new Master__c();
        m.Name = 'Master Config A';
        insert m;
       
        Project_Charges__c PCharge = new Project_Charges__c();
          Global_Charges__c objGloChrg = new Global_Charges__c();
             ObjGloChrg.Name = 'Basic';
             ObjGloChrg.Code__c = '011';
             ObjGloChrg.Description__c = 'Basic';
             ObjGloChrg.Sequence_No__c = 99;
             ObjGloChrg.Charge_Type__c = 'Basic';
             ObjGloChrg.Nature_of_Charge__c = 'Debtors';
             ObjGloChrg.Master_Config__c = m.Id;
             ObjGloChrg=RDSCommon.CreateGlobalCharges(ObjGloChrg);
             
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
             
            
         // tower creation 
           Tower__c t = new Tower__c();
             t.Name = 'Tower X';
             t.ProjectName__c = objpr.Id;
             t = RDSCommon.CreateTower(t);
             
             
         // standard payment plan header creation
            Standard_Pay_Plan_Header__c objSPP = new Standard_Pay_Plan_Header__c();
             objSPP.Project__c = objpr.Id;
             objSPP.Charge_Code__c= PCharge.Id;
             objSPP.Name='Basic Header';
             objSPP.Plan_Code__c= '89';
             objSPP.tower__c = t.ID;
             objSPP.Effective_from__c = System.today();
             objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
          
          
       
        
        Quotation__c q = new Quotation__c();
        q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.Prepared_Date__c = System.today();
        q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU.Id;
        q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer.Id;
        q.Appartment_Configuration__c = '1 BHK';
        q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Agreement_Value__c = 60422880;
        q.Agreement_Value_ST__c = 2537761;
        insert q;
        
        Customer_Pay_Plan_Header__c objCPPH = new Customer_Pay_Plan_Header__c();
        objCPPH.Project__c = objpr.id;
        objCPPH.Project_Unit__c = objPUU.id;
        objCPPH.Customer__c = objcustomer.id;
        objCPPH.tower__c = t.ID;
        objCPPH.Quotation__C = q.id; 
        objCPPH.Standard_Pay_Plan_Header__c = objSPP.id;
        objCPPH.PlanDt__c = system.today();
        objCPPH.Effect_From_Date__c = system.today();
        objCPPH.Global_Charges__c = ObjGloChrg.id;
        insert objCPPH;
        
       Standard_Customer_Pay_Plan_Detail__c objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
        objSPPD.Customer_Pay_Plan_Header__c = objCPPH.id;
        objSPPD.Standard_Pay_Plan_Header__c = objSPP.id;
        objSPPD.Project__c = objpr.id;
        objSPPD.tower__c = t.ID;
        objSPPD.Is_to_be_Paid__c = 'From Dt. of Booking';
        objSPPD.Days_Months__c = 'Day(s)';
        objSPPD.Days_Months_Value__c = 5;
        objSPPD.Amount__c = 'Amount';
        objSPPD.Amount_Value__c = 30;
        objSPPD.Due_Date__c = system.today().addDays(-1);
        insert objSPPD;
        
        Receipt__c r1 = new Receipt__c();
        r1.Cheque_DD_Amount_Rs__c = 200000;
        r1.Cheque_DD__c = '908888';
        r1.Cheque_DD_Date__c = system.today();
        r1.Project__c = objpr.Id;
        r1.Project_Unit__c = objPUU.Id;
        r1.Opportunity__c = objcustomer.Id;
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
        r2.Project_Unit__c = objPUU.Id;
        r2.Opportunity__c = objcustomer.Id;
        r2.CheckReceipt__c = true;
        r2.Physically_Cheque_Received__c = true;
        r2.Approval_Status__c = 'Approved';
        r2.Receipt_Date__c = system.today();
        r2.DraweeBank__c = 'CITI';
        r2.Token_Amount_ST__c = true;
        r2.Total_Amount__c = 8400;
        insert r2;
        
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
        objBooking.Customer__c=objcustomer.id;
        objBooking.Opportunity__c = objcustomer.id;
        objBooking.UnitChange__c=true;
        objBooking.Area__c='Noida';
        objBooking.Remarks__c='Remarks';
        objBooking.Cretaed_On__c=system.today();
        objBooking.MG_Months_Year__c='jan-15';
        objBooking.MG_Mon_Year_Val__c=50;
        objBooking.Unit_No__c=objPUU.Id;
        objBooking.Advance_Registration_Reference_No__c='R-01';
        objBooking.Sharing_Per_Amt__c='1000.00';
        objBooking.MG_Per_Amt__c='2000.00';
        objBooking.Sharing_Per_Amt_Val__c=1400.00;
        objBooking.Quotation__c = q.Id;
        objBooking.Future_Correspondence_Contact__c = 'First Applicant';
        objBooking.Receipts__c = r1.Id;
        objBooking.ServiceReceipt__c = r2.Id;
        insert objBooking;
 
        Applicant_Details__c ad1 = new Applicant_Details__c();
        ad1.Name = 'A One';
        ad1.Type_Of_Applicant__c = 'Individual Buyer';
        ad1.Subtype_Of_Applicant__c = 'Indian National';
        ad1.One_Passport_Size_Color_Photograph__c = true;
        ad1.Permanent_Address__c = 'Perma Addressia';
        ad1.Email_Address__c = 'a1.one@gmail.com';
        ad1.Mobile_Number__c = '989898989';
        ad1.DOB__c = system.today().addMonths(-12);
        ad1.Booking__c = objBooking.Id;
        insert ad1;
        
        Applicant_Details__c ad2 = new Applicant_Details__c();
        ad2.Name = 'A Four';
        ad2.Type_Of_Applicant__c = 'Individual Buyer';
        ad2.Subtype_Of_Applicant__c = 'Indian National';
        ad2.One_Passport_Size_Color_Photograph__c = true;
        ad2.Permanent_Address__c = 'Perma Addressia';
        ad2.Email_Address__c = 'a2.one@gmail.com';
        ad2.Mobile_Number__c = '8080808080';
        ad2.DOB__c = system.today().addMonths(-12);
        ad2.Booking__c = objBooking.Id;
        insert ad2;
        
        Applicant_Details__c ad3 = new Applicant_Details__c();
        ad3.Name = 'A Three';
        ad3.Type_Of_Applicant__c = 'Individual Buyer';
        ad3.Subtype_Of_Applicant__c = 'Indian National';
        ad3.One_Passport_Size_Color_Photograph__c = true;
        ad3.Permanent_Address__c = 'Perma Addressia';
        ad3.Email_Address__c = 'a3.one@gmail.com';
        ad3.Mobile_Number__c = '9090909090';
        ad3.DOB__c = system.today().addMonths(-12);
        ad3.Booking__c = objBooking.Id;
        insert ad3;
        
        Applicant_Details__c ad4 = new Applicant_Details__c();
        ad4.Name = 'A Four';
        ad4.Type_Of_Applicant__c = 'Individual Buyer';
        ad4.Subtype_Of_Applicant__c = 'Indian National';
        ad4.One_Passport_Size_Color_Photograph__c = true;
        ad4.Permanent_Address__c = 'Perma Addressia';
        ad4.Email_Address__c = 'a3.one@gmail.com';
        ad4.Mobile_Number__c = '9090909090';
        ad4.DOB__c = system.today().addMonths(-12);
        ad4.Booking__c = objBooking.Id;
        insert ad4;
        
        Applicant_Details__c ad5 = new Applicant_Details__c();
        ad5.Name = 'A Five';
        ad5.Type_Of_Applicant__c = 'Individual Buyer';
        ad5.Subtype_Of_Applicant__c = 'Indian National';
        ad5.One_Passport_Size_Color_Photograph__c = true;
        ad5.Permanent_Address__c = 'Perma Addressia';
        ad5.Email_Address__c = 'a3.one@gmail.com';
        ad5.Mobile_Number__c = '9090909090';
        ad5.DOB__c = system.today().addMonths(-12);
        ad5.Applicant_Number__c = 'Primary Applicant';
        ad5.PancardNo__c = 'PA101010';
        ad5.Address_Proof_Document__c = 'Driving License';
        ad5.Address_Proof_Number__c = 'addkdljf';
        ad5.Booking__c = objBooking.Id;
        insert ad5;
        Test.startTest();
        PageReference dcPage = Page.CustomerPaymentPlanView;
        Test.setCurrentPage(dcPage);
        ApexPages.currentPage().getParameters().put('qId',q.Id);
        QuotationDiscountView1 dcpC = new QuotationDiscountView1();
        dcpC.discountPSF = 0;
        dcpC.discountLumpsum = 0;
        dcpC.agreementValue = 0;
        dcpC.agreementValue = 0;
        dcpC.selectedPlan = null;
        dcpC.editSchedule = false;
        dcpC.scheduleEdited = false;
        dcpC.discountPageMode = '';
        dcpC.disableDiscount = false;
        dcpC.OrignalPlanNPV = 0;
        dcpC.OriginalPlanNPV = 0;
        dcpC.UpdatedPlanNPV = 0;
        dcpC.NPVDiffLumpsum = 0;
        dcpC.NPVDiffPSF = 0;
        dcpC.rowNumber = 0;
        dcpC.addType = '';
        dcpC.quoteValidity = '';
        dcpC.quoteDate = '';
        dcpC.quoteFor = '';
        dcpC.unitId = null;
        dcpC.status = '';
        dcpC.dType5L = '';
        dcpC.advanceMaintenance2yrsTotal = '';
        dcpC.shareMoneyTotal = '';
        dcpC.societyFormationTotal = '';
        dcpC.pinstid = '';
        dcpC.myDateTime1 = system.today();
        dcpC.ApproverOneDate = '';
        dcpC.ApproverOneStatus = '';
        dcpC.myDateTime2 = system.today();
        dcpC.ApproverTwoDate = '';
        dcpC.ApproverTwoTime = '';
        dcpC.ApproverTwoStatus = '';
        dcpC.myDateTime3 = system.today();
        dcpC.ApproverThreeDate = '';
        dcpC.ApproverThreeTime = '';
        dcpC.ApproverThreeStatus = '';
        dcpC.letterhead = '';
        
        
        Test.stopTest();
      }
  }