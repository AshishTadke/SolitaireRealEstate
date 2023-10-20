@isTest
private  Class TestBookingClass {
 
 
 @isTest
    private static void BookingTest() {
        Opportunity objcustomer;
        Opportunity objcustomer1;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        Car_Parking_Charge__c objCP3;
        Car_Parking_Charge__c objCP4;
        Car_Parking_Charge__c objCP5;
        
        
        objpr = new Project__c();
        objpr = createProject('Xa_prj','111');
        List<Cluster__c> cList = TestDataFactory.createClusters(2, objpr.Id);
       
      //create Towers
        List<Tower__c> tList = TestDataFactory.createTowers(2, objpr.Id);
        
        Project_Charges__c projchrg1 = new Project_Charges__c ();
        projchrg1.name = 'Basic';
        projchrg1.Active__c = true;
        projchrg1.Project__c = objpr.id;
        projchrg1.S_Charge_Calculated_As__c = 'Rate list at Unit level';
        projchrg1.S_Charge_Bucket__c = 'Agreement Value';
        //projchrg1.Taxable__c = 67.0;
        //projchrg1.SGST__c = 9.0;
        //projchrg1.CGST__c = 9.0;
        //projchrg1.IGST__c = 0.0;
        insert projchrg1; 
        
        Payment_Plan__c pl = new  Payment_Plan__c();
        pl.name = 'Standard Plan';
        //pl.Plan_Code__c = '003';
        pl.Tower__c = tList[0].id;
        pl.Project__c = objpr.id; 
        //pl.NoofMilestones__c = 25;
        //pl.Charge1Name__c = 'Basic';
        //pl.Charge_1_Total__c = 100;
        insert pl;
        
        
        
        /*objPUT = new Project_Unit_Type__c();
        objPUT.RDS_Code__c = '101';
        objPUT.RDS_Project__c = objpr.id;
        insert objPUT;*/
          
        objPUU = new Project_Unit__c();  
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, objpr.Id);
        objPUU = uList[0];
        /*objPUU.Project_Unit_Type__c = objPUT.id;  
        objPUU.Name = 'TestUnit';      
        objPUU.Project__c = objpr.Id;
        objPUU.Param1__c = '5';
        objPUU.UnitNo__c ='9';
        objPUU.Unit_Status__c ='Vacant';
        insert objPUU;*/
        
        objPUU1 = new Project_Unit__c();  
        objPUU1 = uList[1];
        /*objPUU1.Project_Unit_Type__c = objPUT.id;  
        objPUU1.Name = 'TestUnit1';      
        objPUU1.Project__c = objpr.Id;
        objPUU1.Param1__c = '5';
        objPUU1.UnitNo__c ='10';
        objPUU1.Unit_Status__c ='Vacant';
        insert objPUU1;*/
        
        objCP1 = new Car_Parking_Charge__c ();
        objCP1.Status__c = 'Available';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c ();
        objCP2.Status__c = 'Available';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Stack';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
        
        objCP3 = new Car_Parking_Charge__c ();
        objCP3.Status__c = 'Available';
        objCP3.Category__c = 'Additional';
        objCP3.Parking__c = 'Open';
        objCP3.Project__c = objpr.Id;
        insert objCP3;
        
        objCP4 = new Car_Parking_Charge__c ();
        objCP4.Status__c = 'Available';
        objCP4.Category__c = 'Additional';
        objCP4.Parking__c = 'Stack';
        objCP4.Project__c = objpr.Id;
        insert objCP4;
        
        objCP5 = new Car_Parking_Charge__c ();
        objCP5.Status__c = 'Available';
        objCP5.Category__c = 'Additional';
        objCP5.Parking__c = 'Stack';
        objCP5.Project__c = objpr.Id;
        insert objCP5;
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU1.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        objcustomer.Sales_Manager__c = 'SM2@g.com';
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        objcustomer1.Duplicate_Project_Unit_Request__c = false;
        objcustomer1.Release_Unit__c = false;
        insert objcustomer1;
      
        Quotation__c q = new Quotation__c();
        //q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.PaymentPlan__c = pl.id;
        //q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU.Id;
        //q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer.Id;
        //q.Appartment_Configuration__c = '1 BHK';
        //q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Allow_booking_without_full_token__c = TRUE;
        //q.Total_Agreement_Value_Bucket__c = 60422880;
       // q.SGST_on_Total_Agreement_Value_Bucket__c = 2537761;
        //q.CGST_on_Total_Agreement_Value_Bucket__c = 100000;
        //q.IGST_on_Total_Agreement_Value_Bucket_del__c = 0;
        //q.Car_Park_Type_1__c = 'Tandem';
        //q.Car_Park_Type_2__c = 'Open';
        //q.Car_Park_Type_3__c = 'Stack';
        //q.Car_Park_Count_1__c = 1;
        //q.Car_Park_Count_2__c = 1;
        //q.Car_Park_Count_3__c = 1;
        insert q;
        
        /*Quotation__c q2 = new Quotation__c();
        q2.Name = 'Q020202';
        q2.Quote_Status__c = 'Approval Pending';
        q2.Prepared_Date__c = System.today();
        q2.Project__c = objpr.Id;
        q2.Project_Unit__c = objPUU1.Id;
        q2.FloorNo__c = 11;
        q2.Opportunity__c = objcustomer1.Id;
        q2.Appartment_Configuration__c = '1 BHK';
        q2.Carpet_Area_Sq_Ft__c = 1200;
        q2.Token_Amount__c =110000;
        q2.ST_Token_Amount__c = 1000;
        q2.Allow_booking_without_full_token__c = TRUE;
        q2.Agreement_Value__c = 60422880;
        q2.Agreement_Value_ST__c = 2537761;
        q2.Tandem_car_park_Additional__c = 0;
        q2.Tandem_Open_Additional__c= 0;
        q2.Single_car_park_Additional__c= 0;
        q2.Single_Open_Additional__c = 0;
        q2.Stack_Additional__c = 0;
        //q2.Service_Tax_On_Token_Amount__c = true;
        insert q2;*/
        
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
        r1.Currency__c = 'Indian Rupee';
        //insert r1;
        
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
        r2.Total_Amount__c = 8400;
        r1.Currency__c = 'Indian Rupee';
        r2.Token_Amount_ST__c = true;
        //insert r2;

       
        
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        bookC1.i = 0;
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
        bookC1.receiptlist.add(r1);
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        bookC1.addReciept();
        //bookC1.deleteReciept();
        bookC1.boookingObj.Application_No__c = '1234';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';    
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
     
        // applicant1 to required fields validation simulation
        //bookC1.applicant.first_Name__c = 'test';
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man';
        //bookC1.applicant.DOB__c = system.today();
        //bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant.Pincode__c = 444444;
        //bookC1.applicant.Country__c = 'India';
        //bookC1.applicant.City__c = 'Nagpur';
        //bookC1.applicant.Mailing_Country__c= 'India';
        //bookC1.applicant.Mobile_Number__c = '909090900';
        //bookC1.applicant.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant.Nationality__c = 'Indian';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant.Pancard__c = false;
        //bookC1.applicant.PancardNo__c = 'BHGV12VGFD';
        bookC1.applicant.Address_Proof__c = false;
        bookC1.applicant.Address_Proof_Document__c = '';
        bookC1.applicant.Address_Proof_Number__c = '';
        bookC1.applicant.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheck = true; 
        
        
        // applicant2 to required fields validation simulation
        //bookC1.applicant2.first_Name__c = 'test';
        bookC1.applicant2.Name = 'Second Man';
        bookC1.applicant2.Applicant_Number__c = 'Second Applicant';
        //bookC1.applicant2.DOB__c = system.today();
        //bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant2.Pincode__c = 444444;
        //bookC1.applicant2.Country__c = 'India';
        //bookC1.applicant2.City__c = 'Nagpur';
        bookC1.applicant2.Mailing_Country__c= null;
        bookC1.applicant2.Mailing_Pincode__c= null;
        //bookC1.applicant2.Mobile_Number__c = '909090900';
        //bookC1.applicant2.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant2.Nationality__c = 'Indian';
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'For NRI'; //Indian National
        bookC1.applicant2.Pancard__c = true;
        bookC1.applicant2.Address_Proof__c = true;
        bookC1.applicant2.Address_Proof_Document__c = 'xyz';
        bookC1.applicant2.Address_Proof_Number__c = 'pqr';
        bookC1.applicant2.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheckApplicant2 = true;
        bookC1.save();
        /*bookC1.applicant3.Name ='Third Man';
        bookC1.save();
        bookC1.addressCheckApplicant3 = true;
        bookC1.save();*/
        
        // applicant3 to required fields validation simulation
        //bookC1.applicant3.first_Name__c = 'test';
        bookC1.applicant3.Name = 'Third Man';
        bookC1.applicant3.Applicant_Number__c = 'Third Applicant';
        //bookC1.applicant3.DOB__c = system.today();
        //bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant3.Pincode__c = 44444489;
        //bookC1.applicant3.Country__c = 'India';
        //bookC1.applicant3.City__c = 'Nagpur';
        //bookC1.applicant3.Mailing_Country__c= 'India';
        //bookC1.applicant3.Mobile_Number__c = '909090900';
        //bookC1.applicant3.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant3.Nationality__c = 'Indian';
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Partnership Firm';//
        bookC1.applicant3.Pancard__c = false;
        bookC1.applicant3.PassportNumber__c = false;
        bookC1.applicant3.Funds_from_NRE_NRO__c = false;
        bookC1.applicant3.Address_Proof__c = true;
        bookC1.applicant3.Copy_of_Workpermit_Employment_contract__c = false;
        bookC1.applicant3.PancardNo__c = '123456789102';
        bookC1.applicant3.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant3 = false;
        bookC1.save();
        
        //bookC1.applicant4.first_Name__c = 'test';
        bookC1.applicant4.Name ='Fourth Man';
        bookC1.applicant4.Applicant_Number__c = 'Fourth Applicant';
        //bookC1.applicant4.DOB__c = system.today();
        //bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant4.Pincode__c = 44444478;
        bookC1.applicant4.Country__c = 'India';
        //bookC1.applicant4.City__c = 'Nagpur';
        bookC1.applicant4.Mailing_Country__c= 'India';
        //bookC1.applicant4.Mobile_Number__c = '909090900';
        //bookC1.applicant4.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant4.Nationality__c = 'Indian';
        bookC1.applicant4.Type_Of_Applicant__c  = 'Corporate Buyer';
        bookC1.applicant4.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant4.Pancard__c = true;
        bookC1.applicant4.PassportNumber__c = true;
        bookC1.applicant4.Funds_from_NRE_FCNR__c= false;
        bookC1.applicant4.Self_attested_copy_of_PIO_or_OCI_Card__c = false;
        bookC1.applicant4.Address_Proof__c = true;
        bookC1.applicant4.Copy_of_Workpermit_Employment_contract__c = true;
        bookC1.applicant4.PancardNo__c = '1234567891';
        bookC1.applicant4.One_Passport_Size_Color_Photograph__c = false;
        bookC1.applicant4.Type_Of_Origin__c = '';
        bookC1.applicant4.Origin_Details__c = '';
        bookC1.addressCheckApplicant4 = false;
        bookC1.save();
        
        //bookC1.applicant5.first_Name__c = 'test';
        bookC1.applicant5.Name ='Fifth Man';
        bookC1.applicant5.Applicant_Number__c = 'Fifth Applicant';
        //bookC1.applicant5.DOB__c = system.today();
        //bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant5.Pincode__c = 44444454;
        bookC1.applicant5.Country__c = 'India';
        //bookC1.applicant5.City__c = 'Nagpur';
        bookC1.applicant5.Mailing_Country__c= 'India';
        //bookC1.applicant5.Mobile_Number__c = '909090900';
        //bookC1.applicant5.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant5.Nationality__c = 'Indian';
        bookC1.applicant5.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant5.Pancard__c = false;
        bookC1.applicant5.PassportNumber__c = true;
        bookC1.applicant5.Funds_from_NRE_FCNR__c= true;
        bookC1.applicant5.Self_attested_copy_of_PIO_or_OCI_Card__c = true;
        bookC1.applicant5.Address_Proof__c = false;
        bookC1.applicant5.Copy_of_Workpermit_Employment_contract__c = true;
        bookC1.applicant5.PancardNo__c = '';
        bookC1.applicant5.One_Passport_Size_Color_Photograph__c = false;
        bookC1.applicant5.Address_Proof_Document__c = '';
        bookC1.applicant5.Address_Proof_Number__c  = '';
        bookC1.addressCheckApplicant5 = false;
        bookC1.save();
        
      
        Test.startTest();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '1st Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'New Man';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Second Man';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Second Man';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Third Man';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Fourth Man';
        bookC1.save();
        Test.stopTest();
        
    }
    
    @isTest
    private static void BookingTest2222() {
        Opportunity objcustomer;
        Opportunity objcustomer1;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        Car_Parking_Charge__c objCP3;
        Car_Parking_Charge__c objCP4;
        Car_Parking_Charge__c objCP5;
        
        
        objpr = new Project__c();
        objpr = createProject('Xa_prj2','1111');
        List<Cluster__c> cList = TestDataFactory.createClusters(2, objpr.Id);
       
      //create Towers
        List<Tower__c> tList = TestDataFactory.createTowers(2, objpr.Id);
        
        Project_Charges__c projchrg1 = new Project_Charges__c ();
        projchrg1.name = 'Basic';
        projchrg1.Active__c = true;
        projchrg1.Project__c = objpr.id;
        projchrg1.S_Charge_Calculated_As__c = 'Rate list at Unit level';
        projchrg1.S_Charge_Bucket__c = 'Agreement Value';
        //projchrg1.Taxable__c = 67.0;
        //projchrg1.SGST__c = 9.0;
        //projchrg1.CGST__c = 9.0;
        //projchrg1.IGST__c = 0.0;
        insert projchrg1; 
        
        Payment_Plan__c pl = new  Payment_Plan__c();
        pl.name = 'Standard Plan';
        //pl.Plan_Code__c = '003';
        pl.Tower__c = tList[0].id;
        pl.Project__c = objpr.id; 
       // pl.NoofMilestones__c = 25;
        //pl.Charge1Name__c = 'Basic';
        //pl.Charge_1_Total__c = 100;
        insert pl;
        
        
        objPUU = new Project_Unit__c();  
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, objpr.Id);
        objPUU = uList[0];
        
        
        objPUU1 = new Project_Unit__c();  
        objPUU1 = uList[1];
        
        
        objCP1 = new Car_Parking_Charge__c ();
        objCP1.Status__c = 'Available';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c ();
        objCP2.Status__c = 'Available';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Open';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
       
        
        objCP4 = new Car_Parking_Charge__c ();
        objCP4.Status__c = 'Available';
        objCP4.Category__c = 'Additional';
        objCP4.Parking__c = 'Stack';
        objCP4.Project__c = objpr.Id;
        insert objCP4;
       
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU1.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        objcustomer.Sales_Manager__c = 'SM2@g.com';
        objCustomer.Walk_in_Source__c = 'Channel Partner';
        objCustomer.Walk_in_Sub_Source__c = 'test';
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        objcustomer1.Duplicate_Project_Unit_Request__c = false;
        objcustomer1.Release_Unit__c = false;
        objCustomer1.Walk_in_Source__c = 'Channel Partner';
        objCustomer1.Walk_in_Sub_Source__c = 'test';
        insert objcustomer1;
        
        Opportunity objcustomer11 = new Opportunity();
        objcustomer11.Project__c=objpr.id;
        objcustomer11.name='Test 11';
        objcustomer11.StageName='Open';
        objcustomer11.Project_Unit__c=objPUU1.id;  
        objcustomer11.CloseDate=system.today();
        objcustomer11.Status__c ='Active';
        objcustomer11.AccountId = a.Id;
        objcustomer11.Duplicate_Project_Unit_Request__c = false;
        objcustomer11.Release_Unit__c = false;
        objCustomer11.Walk_in_Source__c = 'Channel Partner';
        objCustomer11.Walk_in_Sub_Source__c = 'test';
        insert objcustomer11;
        
        
        Quotation__c q = new Quotation__c();
        //q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.PaymentPlan__c = pl.id;
        //q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU.Id;
        //q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer.Id;
        //q.Appartment_Configuration__c = '1 BHK';
        //q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Allow_booking_without_full_token__c = TRUE;
        //q.Total_Agreement_Value_Bucket__c = 60422880;
        //q.SGST_on_Total_Agreement_Value_Bucket__c = 2537761;
        //q.CGST_on_Total_Agreement_Value_Bucket__c = 100000;
        //q.IGST_on_Total_Agreement_Value_Bucket_del__c = 0;
        //q.Car_Park_Type_1__c = '';
        ///q.Car_Park_Type_2__c = '';
        //q.Car_Park_Type_3__c = '';
        //q.Car_Park_Count_1__c = 0;
        //q.Car_Park_Count_2__c = 0;
        //q.Car_Park_Count_3__c = 0;
        insert q;
        
        Booking__c bks = new Booking__C();
        bks.Opportunity__c = objcustomer11.Id;
        bks.Quotation__c = q.Id;
        bks.Booking_Date__c = System.Today();
        bks.Funding_Status__c= 'self';
        insert bks;
        
        objcustomer11.Registration_Status__c = 'Registration Complete';
        objcustomer11.Booking__c = bks.Id;
        update objcustomer11;
        
        
        Project_Construction_Stages__c pgs = new Project_Construction_Stages__c();
        pgs.Planned_date_of_completion__c = System.today().addDays(30);
        pgs.Project__c = objpr.id;
        pgs.Tower__c = tList[0].id;
        pgs.Name = 'On Plinth';
        insert pgs;
        
        /*Payment_Milestones__c pm = new Payment_Milestones__c();
        pm.Milestone_Type_edit__c = 'Date Linked';
        pm.Milestone_Name__c = 'Application Money1';
        pm.Number_Of_Days__c = 0;
        pm.Milestone_Due_Date__c = System.Today().addDays(10);
        pm.Quotation__c = q.Id;
        insert pm;
        
        Payment_Milestones__c pm1 = new Payment_Milestones__c();
        pm1.Milestone_Type_edit__c = 'Construction Linked';
        pm1.Milestone_Name__c = 'On Plinth';
        pm1.Project_Construction_Stages__c = pgs.Id;
        pm1.Number_Of_Days__c = 0;
        pm1.Milestone_Due_Date__c = System.Today().addDays(10);
        pm1.Quotation__c = q.Id;
        insert pm1;
        
        Payment_Milestones__c pm11 = new Payment_Milestones__c();
        pm11.Milestone_Type_edit__c = 'On Registration';
        pm11.Milestone_Name__c = 'On Registration';
        pm11.Number_Of_Days__c = 0;
        pm11.Milestone_Due_Date__c = System.Today().addDays(10);
        pm11.Quotation__c = q.Id;
        insert pm11;*/
        
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        bookC1.i = 0;
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
        //bookC1.receiptlist.add(r1);
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        //bookC1.addReciept();
        //bookC1.deleteReciept();
        bookC1.boookingObj.Application_No__c = '1234';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';    
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC1.boookingObj.Funding_Status__c= 'Self';
        //bookC1.dateOfOfferPossesion = system.today().addDays(2);
        //bookC1.receiptlist[0].Mode__c = 'Cheque';
        //bookC1.receiptlist[0].Cheque_DD__c = '908888';
        //bookC1.receiptlist[0].Cheque_DD_Date__c = system.today();
        //bookC1.receiptlist[0].Total_Amount__c = 1000000;
        bookC1.receiptlist[0].Currency__c = 'Indian Rupee';
        //bookC1.receiptlist[0].DraweeBank__c = 'Akola Urban Co-operative Bank';
        //bookC1.receiptlist[0].Mode__c = 'Cheque';
     
        // applicant1 to required fields validation simulation
        //bookC1.applicant.first_Name__c = 'test';
        //bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man1';
        //bookC1.applicant.DOB__c = system.today();
        //bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant.Pincode__c = 444444;
        //bookC1.applicant.Country__c = 'India';
        //bookC1.applicant.City__c = 'Nagpur';
        //bookC1.applicant.Mailing_Country__c= 'India';
        //bookC1.applicant.Mobile_Number__c = '909090901';
        //bookC1.applicant.Email_Address__c = 'newman@justnow1.com';
        //bookC1.applicant.Nationality__c = 'Indian';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Partnership Firm'; // Indian National
        bookC1.applicant.Pancard__c = true;
        bookC1.applicant.PancardNo__c = '12346545768';
        bookC1.applicant.Address_Proof__c = true;
        bookC1.applicant.Address_Proof_Document__c = 'abc';
        bookC1.applicant.Address_Proof_Number__c = 'pqr';
        bookC1.applicant.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheck = false; 
        //bookC1.firstApplicantDOB = system.today().addDays(-2);
        //bookC1.applicant.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.applicant.Zone__c = 'South Mumbai (So Bo)';
        bookC1.getaddressstatus();
        
        // applicant2 to required fields validation simulation
        //bookC1.applicant2.first_Name__c = 'test';
        bookC1.applicant2.Name = 'Second Man1';
        bookC1.applicant2.Applicant_Number__c = 'Second Applicant';
        //bookC1.applicant2.DOB__c = system.today();
        //bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant2.Pincode__c = 444444;
        //bookC1.applicant2.Country__c = 'India';
        //bookC1.applicant2.City__c = 'Nagpur';
        bookC1.applicant2.Mailing_Country__c= 'India';
        bookC1.applicant2.Mailing_Pincode__c= null;
        //bookC1.applicant2.Mobile_Number__c = '909090902';
        //bookC1.applicant2.Email_Address__c = 'newman@justnow2.com';
        //bookC1.applicant2.Nationality__c = 'Indian';
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin'; // Indian National
        bookC1.applicant2.Pancard__c = true;
        bookC1.applicant2.PancardNo__c = '123465457681';
        bookC1.applicant2.Address_Proof__c = true;
        bookC1.applicant2.Address_Proof_Document__c = 'xyz';
        bookC1.applicant2.Address_Proof_Number__c = 'pqr';
        bookC1.applicant2.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheckApplicant2 = false;
        bookC1.getaddressstatus();
        //bookC1.save();
        /*bookC1.applicant3.Name ='Third Man';
        bookC1.save();
        bookC1.addressCheckApplicant3 = true;
        bookC1.save();*/
        
        // applicant3 to required fields validation simulation
        //bookC1.applicant3.first_Name__c = 'test';
        bookC1.applicant3.Name = 'Third Man2';
        bookC1.applicant3.Applicant_Number__c = 'Third Applicant';
        //bookC1.applicant3.DOB__c = system.today();
        //bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant3.Pincode__c = 44444489;
        //bookC1.applicant3.Country__c = 'India';
        //bookC1.applicant3.City__c = 'Nagpur';
        //bookC1.applicant3.Mailing_Country__c= 'India';
        //bookC1.applicant3.Mobile_Number__c = '909090900';
        //bookC1.applicant3.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant3.Nationality__c = 'Indian';
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant3.Pancard__c = true;
        bookC1.applicant3.PancardNo__c = '123465457681';
        bookC1.applicant3.PassportNumber__c = false;
        bookC1.applicant3.Funds_from_NRE_NRO__c = false;
        bookC1.applicant3.Address_Proof__c = true;
        bookC1.applicant3.Copy_of_Workpermit_Employment_contract__c = false;
        bookC1.applicant3.PancardNo__c = '123456789102';
        bookC1.applicant3.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant3 = false;
        //bookC1.getaddressstatus();
       // bookC1.save();
        
        //bookC1.applicant4.first_Name__c = 'test';
        bookC1.applicant4.Name ='Fourth Man2';
        bookC1.applicant4.Applicant_Number__c = 'Fourth Applicant';
        //bookC1.applicant4.DOB__c = system.today();
        //bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant4.Pincode__c = 44444478;
        //bookC1.applicant4.Country__c = 'India';
        //bookC1.applicant4.City__c = 'Nagpur';
        //bookC1.applicant4.Mailing_Country__c= 'India';
        //bookC1.applicant4.Mobile_Number__c = '909090900';
        //bookC1.applicant4.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant4.Nationality__c = 'Indian';
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Partnership Firm'; //Foreign Nationals Of Indian Origin
        bookC1.applicant4.Pancard__c = false;
        bookC1.applicant4.PancardNo__c = '12346545768';
        bookC1.applicant4.PassportNumber__c = true;
        bookC1.applicant4.Funds_from_NRE_FCNR__c= false;
        bookC1.applicant4.Self_attested_copy_of_PIO_or_OCI_Card__c = false;
        bookC1.applicant4.Address_Proof__c = true;
        bookC1.applicant4.Copy_of_Workpermit_Employment_contract__c = true;
        bookC1.applicant4.PancardNo__c = '1234567891';
        bookC1.applicant4.One_Passport_Size_Color_Photograph__c = false;
        bookC1.applicant4.Type_Of_Origin__c = '';
        bookC1.applicant4.Origin_Details__c = '';
        bookC1.addressCheckApplicant4 = false;
       // bookC1.save();
        
        //bookC1.applicant5.first_Name__c = 'test';
        bookC1.applicant5.Name ='Fifth Man2';
        bookC1.applicant5.Applicant_Number__c = 'Fifth Applicant';
        //bookC1.applicant5.DOB__c = system.today();
        //bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant5.Pincode__c = 44444454;
        //bookC1.applicant5.Country__c = 'India';
        //bookC1.applicant5.City__c = 'Nagpur';
        //bookC1.applicant5.Mailing_Country__c= 'India';
        //bookC1.applicant5.Mobile_Number__c = '909090900';
        //bookC1.applicant5.Email_Address__c = 'newman@justnow.com';
        //bookC1.applicant5.Nationality__c = 'Indian';
        bookC1.applicant5.Type_Of_Applicant__c  = 'Corporate Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.applicant5.Pancard__c = false;
        //bookC1.applicant5.PancardNo__c = '12346545768';
        bookC1.applicant5.PassportNumber__c = true;
        bookC1.applicant5.Funds_from_NRE_FCNR__c= true;
        bookC1.applicant5.Self_attested_copy_of_PIO_or_OCI_Card__c = true;
        bookC1.applicant5.Address_Proof__c = false;
        bookC1.applicant5.Copy_of_Workpermit_Employment_contract__c = true;
        bookC1.applicant5.PancardNo__c = '';
        bookC1.applicant5.One_Passport_Size_Color_Photograph__c = false;
        bookC1.applicant5.Address_Proof_Document__c = '';
        bookC1.applicant5.Address_Proof_Number__c  = '';
        bookC1.addressCheckApplicant5 = false;
        bookC1.save();
        
      
        Test.startTest();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '1st Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'New Man';
        //bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Second Man';
       // bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Second Man';
       // bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Third Man';
       // bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Fourth Man';
        //bookC1.save();
        Test.stopTest();
        
    }
    
     @isTest
    private static void BookingTest3333() {
        Opportunity objcustomer;
        Opportunity objcustomer1;
        Booking__c objBooking;
        //Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        Car_Parking_Charge__c objCP3;
        Car_Parking_Charge__c objCP4;
        Car_Parking_Charge__c objCP5;
        
        Project__c objpr = new Project__c(Name = 'Xa_prj2', Project_Code__c = '2222');
        insert objpr;
        
        
      //create Towers
        List<Tower__c> tList = TestDataFactory.createTowers(2, objpr.Id);
        
        Project_Charges__c projchrg1 = new Project_Charges__c ();
        projchrg1.name = 'Basic';
        projchrg1.Active__c = true;
        projchrg1.Project__c = objpr.id;
        projchrg1.S_Charge_Calculated_As__c = 'Rate list at Unit level';
        projchrg1.S_Charge_Bucket__c = 'Agreement Value';
        //projchrg1.Taxable__c = 67.0;
        //projchrg1.SGST__c = 9.0;
        //projchrg1.CGST__c = 9.0;
        //projchrg1.IGST__c = 0.0;
        insert projchrg1; 
        
        Payment_Plan__c pl = new  Payment_Plan__c();
        pl.name = 'Standard Plan';
        //pl.Plan_Code__c = '003';
        pl.Tower__c = tList[0].id;
        pl.Project__c = objpr.id; 
        //pl.NoofMilestones__c = 25;
        //pl.Charge1Name__c = 'Basic';
        //pl.Charge_1_Total__c = 100;
        insert pl;
        
        
        objPUU = new Project_Unit__c();  
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, objpr.Id);
        objPUU = uList[0];
        
        
        objPUU1 = new Project_Unit__c();  
        objPUU1 = uList[1];
        
        
        objCP1 = new Car_Parking_Charge__c ();
        objCP1.Status__c = 'Available';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c ();
        objCP2.Status__c = 'Available';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Open';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
       
        
        objCP4 = new Car_Parking_Charge__c ();
        objCP4.Status__c = 'Available';
        objCP4.Category__c = 'Additional';
        objCP4.Parking__c = 'Stack';
        objCP4.Project__c = objpr.Id;
        insert objCP4;
       
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU1.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        objcustomer.Sales_Manager__c = 'SM2@g.com';
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        objcustomer1.Duplicate_Project_Unit_Request__c = false;
        objcustomer1.Release_Unit__c = false;
        insert objcustomer1;
      
        Quotation__c q = new Quotation__c();
        //q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.PaymentPlan__c = pl.id;
        //q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU.Id;
        //q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer.Id;
        //q.Appartment_Configuration__c = '1 BHK';
        //q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Allow_booking_without_full_token__c = TRUE;
        //q.Total_Agreement_Value_Bucket__c = 60422880;
        //q.SGST_on_Total_Agreement_Value_Bucket__c = 2537761;
        //q.CGST_on_Total_Agreement_Value_Bucket__c = 100000;
        //q.IGST_on_Total_Agreement_Value_Bucket_del__c = 0;
        //q.Car_Park_Type_1__c = '';
        //q.Car_Park_Type_2__c = '';
        //q.Car_Park_Type_3__c = '';
       // q.Car_Park_Count_1__c = 0;
        //q.Car_Park_Count_2__c = 0;
        //q.Car_Park_Count_3__c = 0;
        insert q;
        
        
        
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        bookC1.i = 0;
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
        //bookC1.receiptlist.add(r1);
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        //bookC1.addReciept();
        bookC1.boookingObj.Application_No__c = '';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = 'Other';    
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = '';
        bookC1.boookingObj.Funding_Status__c= 'Self';
       // bookC1.dateOfOfferPossesion = system.today().addDays(2);
        bookC1.receiptlist[0].DraweeBank__c ='Other';
        bookC1.save();
        bookC1.receiptlist[0].Mode__c = 'Cheque';
        bookC1.receiptlist[0].Cheque_DD__c = '908888';
        bookC1.receiptlist[0].Cheque_DD_Date__c = system.today();
        bookC1.receiptlist[0].Total_Amount__c = 1000000;
        bookC1.receiptlist[0].Currency__c = 'Indian Rupee';
        bookC1.receiptlist[0].DraweeBank__c = 'Akola Urban Co-operative Bank';
        //bookC1.receiptlist[0].Mode__c = 'Cheque';
        bookC1.addressCheck = False;
        bookC1.save();
        bookC1.applicant.Mailing_Country__c = 'India';
        bookC1.applicant.Mailing_Pincode__c = 444;
        bookC1.save();
        bookC1.boookingObj.Application_No__c = '';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';    
        bookC1.save();
        bookC1.boookingObj.Application_No__c = '';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';
        bookC1.save();
        bookC1.boookingObj.Application_No__c = '';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
        bookC1.save();
        bookC1.boookingObj.Application_No__c = '';   
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        bookC1.save();
        
        bookC1.applicant.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        
        
        
        // applicant1 to required fields validation simulation
        //bookC1.applicant.first_Name__c = 'test';
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man1';
       // bookC1.applicant.DOB__c = system.today();
        //bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant.Pincode__c = 444444;
       // bookC1.applicant.Country__c = 'India';
        //bookC1.applicant.City__c = 'Nagpur';
        //bookC1.applicant.Mailing_Country__c= 'India';
        //bookC1.applicant.Mobile_Number__c = '909090901';
        //bookC1.applicant.Email_Address__c = 'newman@justnow1.com';
        bookC1.applicant.Nationality__c = 'Indian';
        //bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        //bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        //bookC1.applicant.Pancard__c = true;
        //bookC1.applicant.Address_Proof__c = true;
        //bookC1.applicant.Address_Proof_Document__c = 'abc';
        //bookC1.applicant.Address_Proof_Number__c = 'pqr';
        bookC1.applicant.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheck = false; 
        //bookC1.firstApplicantDOB = system.today().addDays(-2);
        bookC1.applicant.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.applicant.Zone__c = 'South Mumbai (So Bo)';
        bookC1.getaddressstatus(); 
        
        // applicant2 to required fields validation simulation
        //bookC1.applicant2.first_Name__c = 'test';
        bookC1.applicant2.Name = 'Second Man1';
        bookC1.applicant2.Applicant_Number__c = 'Second Applicant';
        //bookC1.applicant2.DOB__c = system.today();
        //bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant2.Pincode__c = 444444;
        bookC1.applicant2.Country__c = 'India';
        //bookC1.applicant2.City__c = 'Nagpur';
        //bookC1.applicant2.Mailing_Country__c= null;
        //bookC1.applicant2.Mailing_Pincode__c= null;
        //bookC1.applicant2.Mobile_Number__c = '909090902';
        //bookC1.applicant2.Email_Address__c = 'newman@justnow2.com';
        //bookC1.applicant2.Nationality__c = 'Indian';
        //bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Partnership Firm';
        //bookC1.applicant2.Pancard__c = true;
        //bookC1.applicant2.Address_Proof__c = true;
        //bookC1.applicant2.Address_Proof_Document__c = 'xyz';
        //bookC1.applicant2.Address_Proof_Number__c = 'pqr';
        bookC1.applicant2.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant2 = false;
        bookC1.getaddressstatus();
        
        bookC1.applicant3.Name = 'Third Man1';
        bookC1.applicant4.Name = 'Fourth Man1';
        bookC1.applicant5.Name = 'Fifth Man1';
        bookC1.addressCheckApplicant3 = false;
        bookC1.getaddressstatus();
        bookC1.addressCheckApplicant4 = false;
        bookC1.getaddressstatus();
        bookC1.addressCheckApplicant5 = false;
        bookC1.getaddressstatus();
        //bookC1.save();
        
        //bookC1.applicant3.first_Name__c = 'test';
        bookC1.applicant3.Name = 'Third Man1';
        bookC1.applicant3.Applicant_Number__c = 'Third Applicant';
        //bookC1.applicant3.DOB__c = system.today();
        //bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant3.Pincode__c = 444444;
        //bookC1.applicant3.Country__c = 'India';
        //bookC1.applicant3.City__c = 'Nagpur';
        bookC1.applicant3.Mailing_Country__c= null;
        bookC1.applicant3.Mailing_Pincode__c= null;
        //bookC1.applicant3.Mobile_Number__c = '909090903';
        //bookC1.applicant3.Email_Address__c = 'newman@justnow3.com';
        //bookC1.applicant3.Nationality__c = 'Indian';
        //bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Indian National';
        //bookC1.applicant3.Pancard__c = true;
        //bookC1.applicant3.Address_Proof__c = true;
        //bookC1.applicant3.Address_Proof_Document__c = 'xyz';
        //bookC1.applicant3.Address_Proof_Number__c = 'pqr';
        bookC1.applicant3.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant3 = false;
        bookC1.getaddressstatus();
        
        //bookC1.applicant4.first_Name__c = 'test';
        bookC1.applicant4.Name = 'Third Man1';
        bookC1.applicant4.Applicant_Number__c = 'Third Applicant';
        //bookC1.applicant4.DOB__c = system.today();
        //bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant4.Pincode__c = 444444;
        //bookC1.applicant4.Country__c = 'India';
        //bookC1.applicant4.City__c = 'Nagpur';
        bookC1.applicant4.Mailing_Country__c= null;
        bookC1.applicant4.Mailing_Pincode__c= null;
        //bookC1.applicant4.Mobile_Number__c = '909090903';
        //bookC1.applicant4.Email_Address__c = 'newman@justnow3.com';
        //bookC1.applicant4.Nationality__c = 'Indian';
        //bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Partnership Firm';
        //bookC1.applicant4.Pancard__c = true;
        //bookC1.applicant4.Address_Proof__c = true;
        //bookC1.applicant4.Address_Proof_Document__c = 'xyz';
        //bookC1.applicant4.Address_Proof_Number__c = 'pqr';
        bookC1.applicant4.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant3 = false;
        bookC1.getaddressstatus();
        
        //bookC1.applicant5.first_Name__c = 'test';
        bookC1.applicant5.Name = 'Third Man1';
        bookC1.applicant5.Applicant_Number__c = 'Third Applicant';
        //bookC1.applicant5.DOB__c = system.today();
        //bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        //bookC1.applicant5.Pincode__c = 444444;
        //bookC1.applicant5.Country__c = 'India';
        //bookC1.applicant5.City__c = 'Nagpur';
        bookC1.applicant5.Mailing_Country__c= 'India';
        bookC1.applicant5.Mailing_Pincode__c= null;
        //bookC1.applicant5.Mobile_Number__c = '909090903';
        //bookC1.applicant5.Email_Address__c = 'newman@justnow3.com';
        //bookC1.applicant5.Nationality__c = 'Indian';
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'For NRI';
        //bookC1.applicant5.Pancard__c = true;
        //bookC1.applicant5.Address_Proof__c = true;
        //bookC1.applicant5.Address_Proof_Document__c = 'xyz';
        //bookC1.applicant5.Address_Proof_Number__c = 'pqr';
        bookC1.applicant5.One_Passport_Size_Color_Photograph__c = false;
        bookC1.addressCheckApplicant3 = false;
        bookC1.getaddressstatus();
        bookC1.save();
       
        
       // Test.stopTest();
        
    }    
    
    @isTest
    private static void BookingTest4444() {
        Opportunity objcustomer;
        Opportunity objcustomer1;
        Booking__c objBooking;
        //Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        Car_Parking_Charge__c objCP3;
        Car_Parking_Charge__c objCP4;
        Car_Parking_Charge__c objCP5;
        
        Legal_Entity__c le = new Legal_Entity__c();
        le.Name = 'XYZ';
        le.RDS_Service_Tax_No__c = '342356789876565';
        insert le;
        
        Project__c objpr = new Project__c(Name = 'Xa_prj2', Project_Code__c = '2222');
        insert objpr;
        
        objpr.RDS_Company_Code__c = le.Id;
        update objpr;
        
      //create Towers
        List<Tower__c> tList = TestDataFactory.createTowers(2, objpr.Id);
        
        Project_Charges__c projchrg1 = new Project_Charges__c ();
        projchrg1.Name= 'Basic';
        projchrg1.Active__c = true;
        projchrg1.Project__c = objpr.id;
        //projchrg1.Tower__c = tList[0].id;
        projchrg1.S_Charge_Calculated_As__c = 'Rate list at Unit level';
        projchrg1.S_Charge_Bucket__c = 'Agreement Value';
        //projchrg1.Taxable__c = 67.0;
        //projchrg1.SGST__c = 9.0;
        //projchrg1.CGST__c = 9.0;
        //projchrg1.IGST__c = 0.0;
        insert projchrg1; 
        
        Payment_Plan__c pl = new  Payment_Plan__c();
        pl.name = 'Standard Plan';
        //pl.Plan_Code__c = '003';
        pl.Tower__c = tList[0].id;
        pl.Project__c = objpr.id; 
        //pl.NoofMilestones__c = 25;
        //pl.Charge1Name__c = 'Basic';
        //pl.Charge_1_Total__c = 100;
        insert pl;
        
        
        objPUU = new Project_Unit__c();  
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, objpr.Id);
        objPUU = uList[0];
        
        
        objPUU1 = new Project_Unit__c();  
        objPUU1 = uList[1];
        
        
        objCP1 = new Car_Parking_Charge__c ();
        objCP1.Status__c = 'Booked';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Dependable-Stack';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c ();
        objCP2.Status__c = 'Booked';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Stack';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
        
        objCP3 = new Car_Parking_Charge__c ();
        objCP3.Status__c = 'Booked';
        objCP3.Category__c = 'Additional';
        objCP3.Parking__c = 'Single - Independent';
        objCP3.Project__c = objpr.Id;
        insert objCP3;
       
        
        objCP4 = new Car_Parking_Charge__c ();
        objCP4.Status__c = 'Booked';
        objCP4.Category__c = 'Additional';
        objCP4.Parking__c = 'Single- Dependent';
        objCP4.Project__c = objpr.Id;
        insert objCP4;
       
        
        objCP5 = new Car_Parking_Charge__c ();
        objCP5.Status__c = 'Booked';
        objCP5.Category__c = 'Additional';
        objCP5.Parking__c = 'Puzzle';
        objCP5.Project__c = objpr.Id;
        insert objCP5;
       
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU1.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        objcustomer.Sales_Manager__c = 'SM2@g.com';
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        objcustomer1.Duplicate_Project_Unit_Request__c = false;
        objcustomer1.Release_Unit__c = false;
        insert objcustomer1;
      
        Quotation__c q = new Quotation__c();
        //q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.PaymentPlan__c = pl.id;
        //q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU.Id;
        //q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer.Id;
        //q.Appartment_Configuration__c = '1 BHK';
        //q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Allow_booking_without_full_token__c = TRUE;
        //q.Total_Agreement_Value_Bucket__c = 60422880;
        //q.SGST_on_Total_Agreement_Value_Bucket__c = 2537761;
        //q.CGST_on_Total_Agreement_Value_Bucket__c = 100000;
        //q.IGST_on_Total_Agreement_Value_Bucket_del__c = 0;
        q.Tandem_car_park_Additional__c= 1;
        q.Tandem_Open_Additional__c= 1;
        q.Single_car_park_Additional__c = 1;
        q.Single_Open_Additional__c= 1;
        q.Stack_Additional__c= 1;
        
        insert q;
        
        
        
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        bookC1.i = 0;
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
        //bookC1.receiptlist.add(r1);
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        //bookC1.addReciept();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';    
        bookC1.boookingObj.Future_Correspondence_Contact_Relation__c = 'test';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'Test';
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234567890';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'test@test.in';
        bookC1.boookingObj.Referred_By__c = 'test refrence';
                    
        bookC1.boookingObj.Application_No__c = '11111';   
        bookC1.boookingObj.Funding_Status__c= 'Self';
       // bookC1.dateOfOfferPossesion = system.today().addDays(2);
        //bookC1.receiptlist[0].DraweeBank__c ='Other';
        //bookC1.save();
        bookC1.receiptlist[0].Mode__c = 'Cheque';
        bookC1.receiptlist[0].Cheque_DD__c = '908888';
        bookC1.receiptlist[0].Cheque_DD_Date__c = system.today();
        bookC1.receiptlist[0].Total_Amount__c = 1000000;
        bookC1.receiptlist[0].Currency__c = 'Indian Rupee';
        bookC1.receiptlist[0].DraweeBank__c = 'Akola Urban Co-operative Bank';
        //bookC1.receiptlist[0].Mode__c = 'Cheque';
        
        
        // applicant1 to required fields validation simulation
        //bookC1.applicant.first_Name__c = 'test';
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man1';
        bookC1.applicant.DOB__c = system.today();
       //bookC1.firstApplicantDOB = system.today();
        bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant.Pincode__c = 444444;
        bookC1.applicant.Country__c = 'India';
        bookC1.applicant.City__c = 'Nagpur';
        bookC1.applicant.Mailing_Country__c= 'India';
        bookC1.applicant.Mobile_Number__c = '909090901';
        bookC1.applicant.Email_Address__c = 'newman@justnow1.com';
        bookC1.applicant.Nationality__c = 'Indian';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant.Pancard__c = true;
        bookC1.applicant.PancardNo__c = '1234567891';
        bookC1.applicant.Address_Proof__c = true;
        bookC1.applicant.Address_Proof_Document__c = 'abc';
        bookC1.applicant.Address_Proof_Number__c = 'pqr';
        bookC1.applicant.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheck = true; 
        bookC1.applicant.PancardNo__c = '12345Asdf1';
        //bookC1.firstApplicantDOB = system.today().addDays(-2);
        bookC1.applicant.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.applicant.Zone__c = 'South Mumbai (So Bo)';
        
        //bookC1.applicant.Street1__c = 'test';
        bookC1.getaddressstatus(); 
        
        // applicant2 to required fields validation simulation
        //bookC1.applicant2.first_Name__c = 'test';
        bookC1.applicant2.Salutation__c = 'Mr.';
        bookC1.applicant2.Name = 'Second Man1';
        bookC1.applicant2.Applicant_Number__c = 'Second Applicant';
        bookC1.applicant2.DOB__c = system.today();
        //bookC1.secondApplicantDOB = system.today();
        bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant2.Pincode__c = 444444;
        bookC1.applicant2.Country__c = 'India';
        bookC1.applicant2.City__c = 'Nagpur';
        bookC1.applicant2.Mailing_Country__c= null;
        bookC1.applicant2.Mailing_Pincode__c= null;
        bookC1.applicant2.Mobile_Number__c = '909090902';
        bookC1.applicant2.Email_Address__c = 'newman@justnow2.com';
        bookC1.applicant2.Nationality__c = 'Indian';
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant2.Pancard__c = true;
        bookC1.applicant2.PancardNo__c = '1234567891';
        bookC1.applicant2.Address_Proof__c = true;
        bookC1.applicant2.Address_Proof_Document__c = 'xyz';
        bookC1.applicant2.Address_Proof_Number__c = 'pqr';
        bookC1.applicant2.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheckApplicant2 = false;
        //bookC1.copyAddress = true;
        bookC1.addressCheckApplicant2 = true;
        
        
        //bookC1.applicant2.Street1__c = 'test';
        bookC1.applicant2.Preferred_address_for_all_correspondence__c = 'test';
        bookC1.getaddressstatus();
        
        //bookC1.applicant3.first_Name__c = 'test';
        bookC1.applicant3.Salutation__c = 'Mr.';
        bookC1.applicant3.Name = 'Third Man1';
        bookC1.applicant3.Applicant_Number__c = 'Third Applicant';
        bookC1.applicant3.DOB__c = system.today();
        //bookC1.thirdApplicantDOB = system.today();
        bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant3.Pincode__c = 444444;
        bookC1.applicant3.Country__c = 'India';
        bookC1.applicant3.City__c = 'Nagpur';
        bookC1.applicant3.Mailing_Country__c= null;
        bookC1.applicant3.Mailing_Pincode__c= null;
        bookC1.applicant3.Mobile_Number__c = '909090903';
        bookC1.applicant3.Email_Address__c = 'newman@justnow3.com';
        bookC1.applicant3.Nationality__c = 'Indian';
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant3.Pancard__c = true;
        bookC1.applicant3.PancardNo__c = '1234567891';
        bookC1.applicant3.Address_Proof__c = true;
        bookC1.applicant3.Address_Proof_Document__c = 'xyz';
        bookC1.applicant3.Address_Proof_Number__c = 'pqr';
        bookC1.applicant3.One_Passport_Size_Color_Photograph__c = true;
        bookC1.addressCheckApplicant3 = true;
        
       // bookC1.applicant3.Street1__c = 'test';
        bookC1.applicant3.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.getaddressstatus();
        
        
        
        
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
       //bookC1.applicant4.first_Name__c = 'test';
        bookC1.applicant4.Salutation__c = 'Mr.';
        bookC1.applicant4.Name = 'Third Man412';
        bookC1.applicant4.Applicant_Number__c = 'Fourth Applicant';
        bookC1.applicant4.DOB__c = system.today();
       //bookC1.fourthApplicantDOB = system.today();
        bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant4.Pincode__c = 444494;
        bookC1.applicant4.Country__c = 'India';
        bookC1.applicant4.City__c = 'Nagpur';
        bookC1.applicant4.Mailing_Country__c= null;
        bookC1.applicant4.Mailing_Pincode__c= null;
        bookC1.applicant4.Mobile_Number__c = '909090403';
        bookC1.applicant4.Email_Address__c = 'newman@justnow41.com';
        bookC1.applicant4.Nationality__c = 'Indian';
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant4.Pancard__c = true;
        bookC1.applicant4.PancardNo__c = '1234567891';
        bookC1.applicant4.Address_Proof__c = true;
        bookC1.applicant4.Address_Proof_Document__c = 'xyz';
        bookC1.applicant4.Address_Proof_Number__c = 'pqr';
        bookC1.applicant4.One_Passport_Size_Color_Photograph__c = true;
        
        //bookC1.applicant4.Street1__c = 'test';
        bookC1.addressCheckApplicant4 = true;
        bookC1.applicant4.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.getaddressstatus();
        //bookC1.save();
        
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        //bookC1.applicant5.first_Name__c = 'test';
        bookC1.applicant5.Salutation__c = 'Mr.';
        bookC1.applicant5.Name = 'Third Man512';
        bookC1.applicant5.Applicant_Number__c = 'Fift Applicant';
        bookC1.applicant5.DOB__c = system.today();
        //bookC1.fifthApplicantDOB = system.today();
        bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant5.Pincode__c = 444494;
        bookC1.applicant5.Country__c = 'India';
        bookC1.applicant5.City__c = 'Nagpur';
        bookC1.applicant5.Mailing_Country__c= null;
        bookC1.applicant5.Mailing_Pincode__c= null;
        bookC1.applicant5.Mobile_Number__c = '919090403';
        bookC1.applicant5.Email_Address__c = 'newman@justnow41.com';
        bookC1.applicant5.Nationality__c = 'Indian';
        bookC1.applicant5.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant5.Pancard__c = true;
        bookC1.applicant5.PancardNo__c = '1234567891';
        bookC1.applicant5.Address_Proof__c = true;
        bookC1.applicant5.Address_Proof_Document__c = 'xyz';
        bookC1.applicant5.Address_Proof_Number__c = 'pqr';
        bookC1.applicant5.One_Passport_Size_Color_Photograph__c = true;
        
        //bookC1.applicant5.Street1__c = 'test';
        bookC1.addressCheckApplicant5 = true;
        bookC1.applicant5.Preferred_address_for_all_correspondence__c = 'Permanent';
        bookC1.getaddressstatus();
        
        InventoryCostServices.getLegalEntityDetails(objPUU.Id, objpr.id);
        bookC1.save();
        bookC1.Cancel();
        
        Booking__c bk = new Booking__c();
        ApexPages.currentPage().getParameters().put('id',bk.id);
        BookingClassForCancellation bcc = new BookingClassForCancellation();
        bcc.Cancel();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        bookC1.applicant4.Name = 'Third Man5';
        bookC1.save();
        
       // Test.stopTest();
        
    }
     
     
      public static Project__c createProject(String ProjName, String ProjectCode)
    {
        Project__c objProject = new Project__c(Name = ProjName, Project_Code__c = projectCode);
        insert objProject;
        return objProject;
    }
              
}