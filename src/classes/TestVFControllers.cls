@isTest
private  Class TestVFControllers {
@isTest
    private static void TaskRelatedListTest() {
      Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@radiustest.com', '9876544441', false);
      Project__c p = TestDataFactory.createProject('ONE BKC','111');
        //create Opportunity
      List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p.Id, 1);
      List<Lead> lList = TestDataFactory.createLead(1);
      
      Test.startTest();
      Opportunity o = oList[0];
      PageReference page = new PageReference(o.Id);
      System.test.setCurrentpage(page);
      ApexPages.StandardController sc = new ApexPages.StandardController(o);
      TaskRelatedListClass tExtn = new TaskRelatedListClass(sc);
      TaskRelatedListClass.getTasksByType('ALL',o.Id);
      TaskRelatedListClass.isRevisit(o.Id);
      TaskRelatedListClass.getButtonAccess('Site Visit');
      List<String> typeList = tExtn.taskType;
      
      Lead l = llist[0];
      PageReference page1 = new PageReference(l.Id);
      System.test.setCurrentpage(page1);
      ApexPages.StandardController sc1 = new ApexPages.StandardController(l);
      TaskRelatedListClass tExtn1 = new TaskRelatedListClass(sc1);
      TaskRelatedListClass.getTasksByType('ALL',l.Id);
      TaskRelatedListClass.isRevisit(l.Id);
      TaskRelatedListClass.getButtonAccess('Presales Call');
      List<String> typeList1 = tExtn1.taskType;
      Test.stopTest();   
      
    }
  
    @isTest
    private static void TaskPageTest() {
        
        Test.startTest();
      Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@radiustest.com', '9876544441', false);
        Project__c p = TestDataFactory.createProject('ONE BKC','111');
      List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p.Id, 1);
      
      List <Car_Parking_Charge__c>  ParkingListToUpdate = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TandemOPENParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleOPENParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleCOVEREDParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TandemCOVEREDParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  STACKParkingList = new List <Car_Parking_Charge__c>();
      
      
      
      
      
      Lead l = TestDataFactory.createLeadTemplate('BigLead', 'biglead@email.com', '1234567890', false);
      l.Date_Of_Visit__c = System.today();
      l.Unique_SVF_Number__c = 'SVF90900';
      l.leadSource = 'Direct';
      l.lead_Sub_Source__c = 'Hoarding';
      
      update l;
      lead cLead = TestDataFactory.convertLead(l);
      
      PageReference pRef = Page.CallAttemptEditPage2;
      Test.setCurrentPage(pRef);
      ApexPages.currentPage().getParameters().put('retURL',cLead.ConvertedOpportunityId);
      ApexPages.currentPage().getParameters().put('cancelURL',cLead.ConvertedOpportunityId);
      ApexPages.currentPage().getParameters().put('origin','New Call Attempt');
      ApexPages.currentPage().getParameters().put('who_id',cLead.Id);
      ApexPages.currentPage().getParameters().put('what_id',cLead.ConvertedOpportunityId);      
      Task t = new Task();
      ApexPages.StandardController sc = new ApexPages.StandardController(t);
      CustomTaskControllerClass tExtn = new CustomTaskControllerClass(sc);
      tExtn.save();
      
      List<Task> tList1 = TestDataFactory.createTasksForOpp(cLead.ConvertedOpportunityId, 1, 'Site Visit');
      PageReference pRef1 = Page.VisitFormEditPage;
      Test.setCurrentPage(pRef1);
      ApexPages.currentPage().getParameters().put('retURL',cLead.ConvertedOpportunityId);
      ApexPages.currentPage().getParameters().put('cancelURL',cLead.ConvertedOpportunityId);
      ApexPages.currentPage().getParameters().put('origin','New Call Attempt');
      ApexPages.currentPage().getParameters().put('id',tList1[0].id);
      Task t1 = tList1[0];
      ApexPages.StandardController sc1 = new ApexPages.StandardController(t1);
      CustomTaskControllerClass tExtn1 = new CustomTaskControllerClass(sc1);
      tExtn1.save();
      tExtn1.cancel();
      
      Test.stopTest();
      
      List<Task> tList2 = TestDataFactory.createTasksForOpp(oList[0].Id, 1, 'Site Visit');
      PageReference pRef2 = Page.VisitFormViewPage;
      Test.setCurrentPage(pRef);
      ApexPages.currentPage().getParameters().put('retURL',oList[0].Id);
      ApexPages.currentPage().getParameters().put('cancelURL',oList[0].Id);
      ApexPages.currentPage().getParameters().put('origin','New Call Attempt');
      ApexPages.currentPage().getParameters().put('who_id',acc.Id);
      ApexPages.currentPage().getParameters().put('what_id',oList[0].Id);      
      Task t2 = new Task();
      ApexPages.StandardController sc2 = new ApexPages.StandardController(t2);
      CustomTaskControllerClass tExtn2 = new CustomTaskControllerClass(sc2);
      
 }
 
 @isTest
    private static void TaskPageTest1() {
        
    Account objAcc;
    Project__c objpr;
    Project_Unit__c objPU;
    Opportunity objopp;
    Quotation__c q;
    booking__c objBooking;
    User a1;
    Customer_Pay_Plan_Header__c objCPPH;
    Standard_Customer_Pay_Plan_Detail__c objSPPD;
    Standard_Pay_Plan_Header__c objSPP;
    Global_Charges__c ObjGloChrg;
    Tower__c t; 
  
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
        objAcc = new Account(lastName='portal account', personEmail = 'standarduser@testorg.com', personMobilePhone= '908089900', RecordType = personAccountRecordType);
        insert objAcc;
        
        a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');

        objpr = new Project__c();
        objpr.Project_Code__c = 'T31';
        objpr.Name = 'TestProject';
        objpr.Start_Date__c = System.today().addDays(- 5);
        objpr.RDS_Interest_Rate__c = 12;
        objpr.Project_Stage__c = 'Launch';
        objpr.Address__c = 'My address';
        insert objpr;

        objPU = new Project_Unit__c();
        objPU.Name = 'TestanotherFive';
        objPU.Project__c = objpr.Id;
        objPU.Param1__c = '5';
        objPU.UnitNo__c = 'TestanotherFive';
        objPU.Unit_status__c = 'Vacant';
        objPU.Actual_Area_value__c = 200;
        objPU.Unit_Morgage_Status__c = 'Un-Mortgaged';
        insert objPU;

        objopp = new Opportunity();
        objopp.Name = 'TestOpp';
        objopp.Accountid = objAcc.id;
        objopp.CloseDate = System.today().addDays(30);
        objopp.StageName = 'Opportunity Identified';
        objopp.PAN_Card_Received__c = true;
        objopp.Passport_Received__c = true;
        objopp.Payment_Plan_Fixed__c = true;
        objopp.Cheque_Received__c = true;
        objopp.Special_Deviations__c = true;
        objopp.POI_Card_If_Required__c = false;
        objopp.PAN_Card_No__c = '987543ituy';
        objopp.Passport_No__c = '12345';
        objopp.Special_Deviations1__c = 'text';
        objopp.Special_Deviation_Charge__c = 55;
        objopp.RD_Special_Deviations__c = 'Architectural Change';
        objopp.Project__c = objpr.id;
        objopp.Project_Unit__c = objPU.id;
        objopp.status__c = 'Active';
        objopp.Relationship_manager__c = a1.id;
        insert objopp;
        System.debug('Opportunity Details:' + objOpp);
        
        Master__c m = new Master__c();
        m.Name = 'Master Config A';
        insert m;
        
        Project_Charges__c PCharge = new Project_Charges__c();
             objGloChrg = new Global_Charges__c();
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
             t = new Tower__c();
             t.Name = 'Tower X';
             t.ProjectName__c = objpr.Id;
             t = RDSCommon.CreateTower(t);
             
             
         // standard payment plan header creation
             objSPP = new Standard_Pay_Plan_Header__c();
             objSPP.Project__c = objpr.Id;
             objSPP.Charge_Code__c= PCharge.Id;
             objSPP.Name='Basic Header';
             objSPP.Plan_Code__c= '89';
             objSPP.tower__c = t.ID;
             objSPP.Effective_from__c = System.today();
             objSPP=RDSCommon.CreateStandardPayPlanHeader(objSPP);
          
          
        objCPPH = new Customer_Pay_Plan_Header__c();
        objCPPH.Project__c = objpr.id;
        objCPPH.Project_Unit__c = objPU.id;
        objCPPH.Customer__c = objopp.id;
        objCPPH.tower__c = t.ID;
        objCPPH.Standard_Pay_Plan_Header__c = objSPP.id;
        objCPPH.PlanDt__c = system.today();
        objCPPH.Effect_From_Date__c = system.today();
        insert objCPPH;
        
        objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
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
        q = new Quotation__c();
            q.Name = 'Q010101';
            q.Quote_Status__c = 'Valid';
            q.Prepared_Date__c = System.today();
            q.Project__c = objpr.Id;
            q.Project_Unit__c = objPU.Id;
            q.FloorNo__c = 11;
            q.Opportunity__c = objopp.Id;
            q.Appartment_Configuration__c = '1 BHK';
            q.Carpet_Area_Sq_Ft__c = 1200;
            q.Token_Amount__c =110000;
            q.ST_Token_Amount__c = 1000;
            q.Agreement_Value__c = 60422880;
            q.Agreement_Value_ST__c = 2537761;
            insert q;
            
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
            objBooking.Customer__c=objopp.id;
            objBooking.UnitChange__c=true;
            objBooking.Area__c='Noida';
            objBooking.Remarks__c='Remarks';
            objBooking.Cretaed_On__c=system.today();
            objBooking.MG_Months_Year__c='jan-15';
            objBooking.MG_Mon_Year_Val__c=50;
            objBooking.Unit_No__c=objPU.Id;
            objBooking.Advance_Registration_Reference_No__c='R-01';
            objBooking.Sharing_Per_Amt__c='1000.00';
            objBooking.MG_Per_Amt__c='2000.00';
            objBooking.Sharing_Per_Amt_Val__c=1400.00;
            objBooking.Quotation__c = q.Id;
            objBooking.Future_Correspondence_Contact__c = 'First Applicant';
            objBooking.Status__c = 'Booking In Process';
            objBooking.Opportunity__c = objopp.id;
            objBooking.ownerId = a1.id;
            insert objBooking;
            
            
            
            Applicant_Details__c ad1 = new Applicant_Details__c();
            ad1.Name = 'A One';
            ad1.Type_Of_Applicant__c = 'Individual Buyer';
            ad1.Subtype_Of_Applicant__c = 'Indian National';
            ad1.One_Passport_Size_Color_Photograph__c = true;
            ad1.Permanent_Address__c = 'Perma Addressia';
            ad1.Mailing_Address__c = 'Perma Addressia';
            ad1.Organization_Address__c = 'Perma Addressia';
            ad1.Organisation_Pincode__c = 123456;
            ad1.Organisation_Country__c = 'India';
            ad1.Email_Address__c = 'a1.one@gmail.com';
            ad1.Mobile_Number__c = '989898989';
            ad1.DOB__c = system.today().addMonths(-12);
            ad1.Booking__c = objBooking.Id;
            ad1.Applicant_Number__c = 'Primary Applicant';
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
    
            objPU.Unit_status__c = 'Sold';
            objPU.Customers__c = objopp.id;
            objPU.booking__C = objBooking.id;
            update objPU;
            objOpp.stageName = 'Booking confirmed';
            update objOpp;    
            objCPPH.Booking__c = objBooking.id;
            update objCPPH;
      List<Task> tList3 = TestDataFactory.createTasksForOpp(objopp.Id, 1, 'Home Loan');
     /* PageReference pRef3 = Page.HomeLoanEditPage;
      Test.setCurrentPage(pRef3);
      ApexPages.currentPage().getParameters().put('retURL',objopp.Id);
      ApexPages.currentPage().getParameters().put('cancelURL',objopp.Id);
      ApexPages.currentPage().getParameters().put('origin','Registration');
      ApexPages.currentPage().getParameters().put('id',tList3[0].id);
      Task t3 = tList3[0];
      ApexPages.StandardController sc3 = new ApexPages.StandardController(t3);
      CustomTaskControllerExtn tExtn3 = new CustomTaskControllerExtn(sc3);
      
      List<SelectOption> subOptions = tExtn3.Subjectlist;
      List<SelectOption> docOptions = tExtn3.NameofDoc;
      tExtn3.selectSubject = 'Home Loan';
      tExtn3.CheckUnitMortgageStatus();
      tExtn3.selectSubject = 'Home Loan Closure';
      tExtn3.CheckUnitMortgageStatus();
      
      tExtn3.UnitMortgageStatus = 'Mortgaged';
      tExtn3.selectSubject = 'Home Loan';
      tExtn3.CheckUnitMortgageStatus();
      
      tExtn3.UnitMortgageStatus = 'Un-Mortgaged';
      tExtn3.selectSubject = 'Home Loan';
      tExtn3.CheckUnitMortgageStatus();
      
       Attachment objattch = tExtn3.getMyFile();
      Blob bodyBlob=Blob.valueOf('test');
      objattch.body=bodyBlob;
      tExtn3.SaveDoc();
      tExtn3.HomeLoanCheck();
      tExtn3.save();
      tExtn3.SCPPDid = objSPPD.id;  
      tExtn3.t.Pick_up_address_category__c = 'Permanent';   
      tExtn3.getApplicantDetail();
     
      tExtn3.t.Pick_up_address_category__c = 'Correspondence';   
      tExtn3.getApplicantDetail();
      
      tExtn3.t.Pick_up_address_category__c = 'Office';   
      tExtn3.getApplicantDetail();
    
      PageReference pRef4 = Page.HomeLoanEditPage;
      Test.setCurrentPage(pRef4);
      ApexPages.currentPage().getParameters().put('retURL',objopp.Id);
      ApexPages.currentPage().getParameters().put('cancelURL',objopp.Id);
      ApexPages.currentPage().getParameters().put('origin','Home Loan');
      Task ht = new Task();      
      ApexPages.StandardController sc4 = new ApexPages.StandardController(ht);
      CustomTaskControllerExtn tExtn4 = new CustomTaskControllerExtn(sc4);
      */
} 

@isTest
   private static void InventoryViewTest() {
      Client__c cl = TestDataFactory.createClients('Client1');
     
      List<Project__c> p = TestDataFactory.createProjectWithClient(1,'888',cl.Id);
     
      //create Clusters
       List<Cluster__c> cList = TestDataFactory.createClusters(2, p[0].Id);
       
      //create Towers
      List<Tower__c> tList = TestDataFactory.createTowers(2, p[0].Id);
      
     //create Units
      List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, p[0].Id);
      
      Test.startTest();
      PageReference pRef = Page.S_InventoryMatrixview;
      Test.setCurrentPage(pRef);
      ApexPages.currentPage().getParameters().put('projectsent',p[0].Id);
      ApexPages.currentPage().getParameters().put('towersent',tList[0].Id);

      S_InventoryMatrix invController = new S_InventoryMatrix();
      invController.selectedVal = p[0].Id;
      invController.SelectedClusterId = cList[0].Id;
      invController.selectedTower = tList[0].Id;
      invController.selectedstatus = '';
      invController.selectedConf = uList[0].Id ;
      invController.sold = true;
      invController.open = true;
      invController.booked = true;
      invController.reserved = true;
      invController.blocked = true;
      
      invController.onebhk = true;
      invController.twobhk = true;
      invController.threebhk = true;
      invController.fourbhk = true;
      invController.fivebhk = true;

      //List<SelectOption> cli = invController.getClients;
      List<SelectOption> pl = invController.getProjects;
      //List<SelectOption> cul = invController.getClusterNames;
      List<SelectOption> tl = invController.getTowers;
       List<SelectOption> pu = invController.getProjectunittype;
      List<Decimal> floorSeq = invController.floorDescSeqList;
      Map<Decimal, List<Project_Unit__c>> UnitMap = invController.JMap;
      //verify towers, projects, units in one floor 
     // System.assertEquals(2,pl.size());
     // System.assertEquals(3,tl.size());
     // System.assertEquals(5, UnitMap.get(1).size());
      
      Test.stopTest();
    }
    
    @isTest
    private static void welcomeCallTest()
    {  
        User a1 = TestDataFactory.createUserSysAdmin('One','Galvatron', 'galvatron1@radius.com', 'galvatron1@radius.com');        
        
        Test.startTest();
        Opportunity objcustomer;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit_Type__c objPUT;
        profile pf;
        
        objpr = new Project__c();
        objpr.Project_Code__c = 'T31';
        objpr.Name = 'TestProject';
        objpr.RDS_Short_Name__c = 'T';
        objpr.Start_Date__c = System.today().addDays(-5);
        objpr.Project_CRM_Lead__c = a1.id;
        objpr.Project_Site_Head__c = a1.id;
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
        objPUU.Param2__c = '6';
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
        insert objcustomer;
          
        objPUU.Unit_Status__c= 'Welcome Call Pending';
        update objPUU;
        
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
        objBooking.Status__c = 'Booking In Process';
        objBooking.Opportunity__c = objCustomer.id;
        objBooking.Sales_manager__c = a1.id;
        objBooking.ownerId = a1.id;
        objBooking.primary_applicant_email__c = 'test@test.com';
        insert objBooking;
        system.debug('objBooking.id :::: ');
        //objPUU.Unit_Status__c= 'Welcome Call Pending';
        //update objPUU;
         
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
      
        PageReference pickwcPage = Page.S_PickWelcomeCall;
        Test.setCurrentPage(pickwcPage);
        
        S_WelcomeCallController objWCC = new S_WelcomeCallController();
        objWCC.ProcessRowNo='0';
        objWCC.ReleaseRowNo='0';
        objWCC.AssignRowNo='0';
        
        //objWCC.Assign();
       // objWCC.Release();
        //objWCC.Assign();
        objWCC.Process();
        
        PageReference wcPage = Page.S_WelcomeCallPage;
        Test.setCurrentPage(wcPage);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        S_WelcomeCallPageController wc = new S_WelcomeCallPageController();
        wc.objWCC1.Verify__c = true;
        wc.objWCC4.Verify__c = true;
        wc.objWCC6.Verify__c = true;
        wc.objWCC3.Verify__c = true;
        wc.objWCC5.Verify__c = true;
        wc.objWCC2.Verify__c = true;
        wc.objWCC36.Verify__c = true;
        wc.objWCC36.Verify__c = true;
        wc.objWCC38.Verify__c = true;
        wc.objWCC44.Verify__c = true;
        wc.objWCC45.Funding__c = 'Self Funded';
        wc.objWCC46.Delivery_of_Invoices_and_receipts__c = 'Printed via Courier';
        wc.objWCC52.Verify__c = true;
        wc.objWCC53.Verify__c = true;
        wc.objWCC54.Verify__c = true;
        wc.objTask.ActivityDate = system.today();
        wc.objTask.ReminderDateTime = system.now();
        wc.objWCC1.Verify__c = true;
        wc.objWCC2.Verify__c = true; 
        wc.objWCC3.Verify__c = true;
        wc.objWCC4.Verify__c = true;
        wc.objWCC5.Verify__c = true;
        wc.objWCC6.Verify__c = true;
        wc.objWCC7.Verify__c = true;
       
        wc.objWCC31.Verify__c = true;
        wc.objWCC32.Verify__c = true; 
        wc.objWCC34.Verify__c = true;
        wc.objWCC35.Verify__c = true;
        wc.objWCC36.Verify__c = true;
        wc.objWCC37.Verify__c = true;
        wc.objWCC38.Verify__c = true; 
        wc.objWCC39.Verify__c = true;
        wc.objWCC40.Verify__c = true;
        wc.objWCC42.Verify__c = true;
        wc.objWCC44.Verify__c = true; 
        wc.objWCC45.Verify__c = true;
        wc.objWCC46.Verify__c = true;
        wc.objWCC47.Verify__c = true;
        wc.objWCC48.Verify__c = true;
        wc.objWCC49.Verify__c = true;
        wc.objWCC50.Verify__c = true; 
        wc.objWCC51.Verify__c = true;
        wc.objWCC52.Verify__c = true;
        wc.objWCC53.Verify__c = true;
        wc.objWCC54.Verify__c = true;
        wc.objWCC56.Verify__c = true;
        wc.objWCD.Call_Disposion__c ='Call back request';
        wc.strcoOwner = '';
        wc.strcoOwner2 = '';
        wc.strcoOwner3 = '';
        wc.strcoOwner4 = '';
        //pf.name = 'Customer Community';
        //update pf;
        //wc.CreatePortalUser();
        
        wc.Submit(); 
        
        PageReference wcPage1 = Page.S_WelcomeCallPage;
        Test.setCurrentPage(wcPage1);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        S_WelcomeCallPageController wc1 = new S_WelcomeCallPageController();
        wc1.objWCC1.Verify__c = true;
        wc1.objWCC4.Verify__c = true;
        wc1.objWCC6.Verify__c = true;
        wc1.objWCC3.Verify__c = true;
        wc1.objWCC5.Verify__c = true;
        wc1.objWCC2.Verify__c = true;
        wc1.objWCC36.Verify__c = true;
        wc1.objWCC36.Verify__c = true;
        wc1.objWCC38.Verify__c = true;
        wc1.objWCC44.Verify__c = true;
        wc1.objWCC45.Funding__c = 'Self Funded';
        wc1.objWCC46.Delivery_of_Invoices_and_receipts__c = 'Printed via Courier';
        wc1.AgreementValue = 1000000;
        wc1.objWCC52.Verify__c = true;
        wc1.objWCC53.Verify__c = true;
        wc1.objWCC54.Verify__c = true;
        wc1.objTask.ActivityDate = system.today();
        wc1.objTask.ReminderDateTime = system.now();
        wc1.objWCC1.Verify__c = true;
        wc1.objWCC2.Verify__c = true; 
        wc1.objWCC3.Verify__c = true;
        wc1.objWCC4.Verify__c = true;
        wc1.objWCC5.Verify__c = true;
        wc1.objWCC6.Verify__c = true;
        wc1.objWCC7.Verify__c = true;

        wc1.objWCC31.Verify__c = true;
        wc1.objWCC32.Verify__c = true; 
        wc1.objWCC34.Verify__c = true;
        wc1.objWCC35.Verify__c = true;
        wc1.objWCC36.Verify__c = true;
        wc1.objWCC37.Verify__c = true;
        wc1.objWCC38.Verify__c = true; 
        wc1.objWCC39.Verify__c = true;
        wc1.objWCC40.Verify__c = true;
        wc1.objWCC42.Verify__c = true;
        wc1.objWCC44.Verify__c = true; 
        wc1.objWCC45.Verify__c = true;
        wc1.objWCC46.Verify__c = true;
        wc1.objWCC47.Verify__c = true;
        wc1.objWCC48.Verify__c = true;
        wc1.objWCC49.Verify__c = true;
        wc1.objWCC50.Verify__c = true; 
        wc1.objWCC51.Verify__c = true;
        wc1.objWCC52.Verify__c = true;
        wc1.objWCC53.Verify__c = true;
        wc1.objWCC54.Verify__c = true;
        wc.objWCC56.Verify__c = true;
        wc1.objWCD.Call_Disposion__c ='Wrong number/No Number';
        wc1.strcoOwner = 'abcd';
        wc1.strcoOwner2 = 'xyz';
        wc1.strcoOwner3 = 'pqr';
        wc1.strcoOwner4 = 'zsd';
        //wc1.CreatePortalUser();
        wc1.Submit();
        
        Test.stopTest();
         
        PageReference wcPage2 = Page.S_WelcomeCallPage;
        Test.setCurrentPage(wcPage2);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        S_WelcomeCallPageController wc2 = new S_WelcomeCallPageController();
        wc2.objWCC1.Verify__c = true;
        wc2.objWCC2.Verify__c = true;
        wc2.objWCC3.Verify__c = true;
        wc2.objWCC4.Verify__c = true;
        wc2.objWCC5.Verify__c = true;
        wc2.objWCC6.Verify__c = true;
        wc2.objWCC7.Verify__c = true;
        
        wc2.objWCC31.Verify__c = true;
        wc2.objWCC32.Verify__c = true; 
        wc2.objWCC34.Verify__c = true;
        wc2.objWCC35.Verify__c = true;
        wc2.objWCC36.Verify__c = true;
        wc2.objWCC37.Verify__c = true;
        wc2.objWCC38.Verify__c = true; 
        wc2.objWCC40.Verify__c = true;
        wc2.objWCC42.Verify__c = true;
        wc2.objWCC44.Verify__c = true; 
        wc2.objWCC45.Verify__c = true; 
        wc2.objWCC45.Funding__c = 'Bank Loan';
        wc2.objWCC45.Bank_Loan_Status__c = 'Need help to apply';
        wc2.objWCC46.Verify__c = true; 
        wc2.objWCC46.Delivery_of_Invoices_and_receipts__c = 'Soft copy via email and hardcopy';
        wc2.objWCC47.Verify__c = true;
        wc2.objWCC48.Verify__c = true;
        wc2.objWCC49.Verify__c = true;
        wc2.objWCC50.Verify__c = true; 
        wc2.objWCC51.Verify__c = true;
        wc2.objWCC52.Verify__c = true;
        wc2.objWCC53.Verify__c = true;
        wc2.objWCC54.Verify__c = true;
        wc2.objWCC56.Verify__c = true;
        wc2.AgreementValue = 0;
        wc2.objTask.ActivityDate = system.today();
        wc2.objTask.ReminderDateTime = system.now();
        
        
        
        wc2.objWCD.Remark__c = 'Call has been accepted';
        wc2.objWCD.Call_Disposion__c ='Welcome call accepted';
       // wc2.CreatePortalUser();
        wc2.Submit();
        
        objPUU.Unit_Status__c= 'Welcome Call Pending';
        update objPUU;
        
        Project_Unit__c pu = [Select Id, Name from Project_Unit__c where Id =: objPUU.Id];
        objBooking.Unit_No__c = pu.Id;
        objBooking.Call_Disposition__c = 'Call back request';
        update objBooking;
        
        Booking__c bk = [Select Id , Name from booking__c where Id =: objBooking.Id];
        
        S_WelcomeCallController objWCC1 = new S_WelcomeCallController();
        objWCC1.ProcessRowNo='0';
        objWCC1.ReleaseRowNo='0';
        objWCC1.AssignRowNo='0';
       // objWCC1.Assign();
       // objWCC1.Release();
       // objWCC1.Assign();
        objWCC1.Process();
        
        PageReference wcPage0 = Page.S_WelcomeCallPage;
        Test.setCurrentPage(wcPage0);
        ApexPages.currentPage().getParameters().put('id',bk.Id);
        S_WelcomeCallPageController wc0 = new S_WelcomeCallPageController();
        wc0.objWCC1.Verify__c = true;
        wc0.objWCC4.Verify__c = true;
        wc0.objWCC6.Verify__c = true;
        wc0.objWCC3.Verify__c = true;
        wc0.objWCC5.Verify__c = true;
        wc0.objWCC2.Verify__c = true;
        wc0.objWCC36.Verify__c = true;
        wc0.objWCC36.Verify__c = true;
        wc0.objWCC38.Verify__c = true;
        wc0.objWCC44.Verify__c = true;
        wc0.objWCC45.Funding__c = 'Self Funded';
        wc0.objWCC46.Delivery_of_Invoices_and_receipts__c = 'Printed via Courier';
        wc0.objWCC52.Verify__c = true;
        wc0.objWCC53.Verify__c = true;
        wc0.objWCC54.Verify__c = true;
        wc0.objTask.ActivityDate = system.today();
        wc0.objTask.ReminderDateTime = system.now();
        wc0.objWCC1.Verify__c = true;
        wc0.objWCC2.Verify__c = true; 
        wc0.objWCC3.Verify__c = true;
        wc0.objWCC4.Verify__c = true;
        wc0.objWCC5.Verify__c = true;
        wc0.objWCC6.Verify__c = true;
        wc0.objWCC7.Verify__c = true;       
        wc0.objWCC32.Verify__c = true; 
        wc0.objWCC34.Verify__c = true;
        wc0.objWCC35.Verify__c = true;
        wc0.objWCC36.Verify__c = true;
        wc0.objWCC37.Verify__c = true;
        wc0.objWCC38.Verify__c = true; 
        wc0.objWCC39.Verify__c = true;
        wc0.objWCC40.Verify__c = true;
        wc0.objWCC42.Verify__c = true;
        wc0.objWCC44.Verify__c = true; 
        wc0.objWCC45.Verify__c = true;
        wc0.objWCC46.Verify__c = true;
        wc0.objWCC47.Verify__c = true;
        wc0.objWCC48.Verify__c = true;
        wc0.objWCC49.Verify__c = true;
        wc0.objWCC50.Verify__c = true; 
        wc0.objWCC51.Verify__c = true;
        wc0.objWCC52.Verify__c = true;
        wc0.objWCC53.Verify__c = true;
        wc0.objWCC54.Verify__c = true;
        wc0.objWCC56.Verify__c = true;
        wc0.objWCD.Call_Disposion__c ='Welcome call rejected';
        wc0.objopp.Reason_For_Rejection__c = 'Not mine';
       //wc0.CreatePortalUser();
        wc0.Submit();
        wc0.Accept();
        wc0.showRejectReason();
        wc0.showPopup();
        wc0.closePopup();
        
       // tower__c tr = new tower__();
        
        Project_Construction_Stages__c pc = new Project_Construction_Stages__c();
        pc.Project__c = objpr.id;
        insert pc;
        Construction_Stage__c cs = new Construction_Stage__c();
        cs.Due_Date__c = system.today() - 12;
        cs.Project_Construction_Stages__c = pc.id;
        cs.Tower_Name__c = objPUU.Param2__c ;
        insert cs;
        UpdateStandardPayPlanDueDate.UpdateDueDate(objBooking.id);
        PageReference wcrPage = Page.WelcomeCallRejectedPage;
        Test.setCurrentPage(wcrPage);
        ApexPages.currentPage().getParameters().put('WCHid','a1JR0000000KWW7MAO');
        WelcomeCallRejectedPageController wcr = new WelcomeCallRejectedPageController();
       
    } 
    
    @isTest
    private static void documentCheckListRejectTest()
    {  
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
          
        objPUU.Unit_Status__c= 'BIP';
        update objPUU;
        
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
        objPUU.Unit_Status__c = 'BIP';
        update objPUU;
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
       
        /**
        PageReference processPage = Page.S_ProcessDocumentVerification;
        Test.setCurrentPage(processPage);
        S_ProcessDocumentVerification processController = new S_ProcessDocumentVerification();
        processController.processRowNo =string.valueOf(0);
        processController.BookingRowNo =string.valueOf(0);
        //processController.assignRowNo =string.valueOf(0);
        processController.Process();
        List<ContentDistribution> cd = processController.BookingForm;
         
        //processController.release();
        //processController.Assign();
        **/
        PageReference dcPage = Page.NewDocumentChecklistPage;
        Test.setCurrentPage(dcPage);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        DocumentChecklistPageController dcpC = new DocumentChecklistPageController();
        Document_Checklist_Header__c dch = new Document_Checklist_Header__c();
        dcpC.ArrayApplicant1String ='true,Name : Clearly written and matches with SFDC Booking,N/A,Mr.sdfdf,false,true,Permanent address : Clearly written and matches with SFDC Booking,N/A,fsdfsd Pincode :234234Country :Australia,false,true,Mailing/Correspondance address : If different - should be mentioned clearly and matches with SFDC,N/A, Pincode : Country :,true,true,Mobile No ( Should be mentioned with 10 digits),N/A,324324 ,true,true,Email Address (Should be mentioned),N/A,a@k.com ,true,true,PAN :Numbers on photocopy matches with: SFDC and Booking form Name on PAN matches with SFDC and Booking form completely,N/A,23432,false,true,Permanent Address : ( The following should match with SFDC data) Type of address proof document Address on photocopy Name on address proof matches with Name Address matches with permanent address.,Driving License,23432,false,true,One Passport Size Color Photograph.,N/A,N/A,false';
        dcpC.ArrayApplicant2String ='true,Name : Clearly written and matches with SFDC Booking,N/A,Mr.sdfdf,false,true,Permanent address : Clearly written and matches with SFDC Booking,N/A,fsdfsd Pincode :234234Country :Australia,false,true,Mailing/Correspondance address : If different - should be mentioned clearly and matches with SFDC,N/A, Pincode : Country :,true,true,Mobile No ( Should be mentioned with 10 digits),N/A,324324 ,true,true,Email Address (Should be mentioned),N/A,a@k.com ,true,true,PAN :Numbers on photocopy matches with: SFDC and Booking form Name on PAN matches with SFDC and Booking form completely,N/A,23432,false,true,Permanent Address : ( The following should match with SFDC data) Type of address proof document Address on photocopy Name on address proof matches with Name Address matches with permanent address.,Driving License,23432,false,true,One Passport Size Color Photograph.,N/A,N/A,false';
        dcpC.ArrayApplicant3String ='true,Name : Clearly written and matches with SFDC Booking,N/A,Mr.sdfdf,false,true,Permanent address : Clearly written and matches with SFDC Booking,N/A,fsdfsd Pincode :234234Country :Australia,false,true,Mailing/Correspondance address : If different - should be mentioned clearly and matches with SFDC,N/A, Pincode : Country :,true,true,Mobile No ( Should be mentioned with 10 digits),N/A,324324 ,true,true,Email Address (Should be mentioned),N/A,a@k.com ,true,true,PAN :Numbers on photocopy matches with: SFDC and Booking form Name on PAN matches with SFDC and Booking form completely,N/A,23432,false,true,Permanent Address : ( The following should match with SFDC data) Type of address proof document Address on photocopy Name on address proof matches with Name Address matches with permanent address.,Driving License,23432,false,true,One Passport Size Color Photograph.,N/A,N/A,false';
        dcpC.ArrayApplicant4String ='true,Name : Clearly written and matches with SFDC Booking,N/A,Mr.sdfdf,false,true,Permanent address : Clearly written and matches with SFDC Booking,N/A,fsdfsd Pincode :234234Country :Australia,false,true,Mailing/Correspondance address : If different - should be mentioned clearly and matches with SFDC,N/A, Pincode : Country :,true,true,Mobile No ( Should be mentioned with 10 digits),N/A,324324 ,true,true,Email Address (Should be mentioned),N/A,a@k.com ,true,true,PAN :Numbers on photocopy matches with: SFDC and Booking form Name on PAN matches with SFDC and Booking form completely,N/A,23432,false,true,Permanent Address : ( The following should match with SFDC data) Type of address proof document Address on photocopy Name on address proof matches with Name Address matches with permanent address.,Driving License,23432,false,true,One Passport Size Color Photograph.,N/A,N/A,false';
        dcpC.ArrayApplicant5String ='true,Name : Clearly written and matches with SFDC Booking,N/A,Mr.sdfdf,false,true,Permanent address : Clearly written and matches with SFDC Booking,N/A,fsdfsd Pincode :234234Country :Australia,false,true,Mailing/Correspondance address : If different - should be mentioned clearly and matches with SFDC,N/A, Pincode : Country :,true,true,Mobile No ( Should be mentioned with 10 digits),N/A,324324 ,true,true,Email Address (Should be mentioned),N/A,a@k.com ,true,true,PAN :Numbers on photocopy matches with: SFDC and Booking form Name on PAN matches with SFDC and Booking form completely,N/A,23432,false,true,Permanent Address : ( The following should match with SFDC data) Type of address proof document Address on photocopy Name on address proof matches with Name Address matches with permanent address.,Driving License,23432,false,true,One Passport Size Color Photograph.,N/A,N/A,false';
        dcpC.checklistHeader.Rejection_Remarks__c = 'testing ok';
        //dcpC.drow17 = '';
        //dcpC.drow18 = '';
        //dcpC.test2 = 'testing ok';
        // rejecting the documents 
        dcpC.saveArray();
        
        // calling the rejected documents page from here.
        PageReference rejPage = Page.RejectedDocumentsPage;
        Test.setCurrentPage(rejPage);
        ApexPages.currentPage().getParameters().put('DocumentHeaderId',dcpC.checklistHeader.Id);
        RejectedDocumentsController rejC = new RejectedDocumentsController();
        rejC.save();
        rejC.Accept();
        rejC.btnReject();
        Test.stopTest();
    }
    
    
     @isTest
    private static void documentCheckListRejected()
    {  
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
        PageReference dcPage = Page.NewDocumentChecklistPage;
        Test.setCurrentPage(dcPage);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        DocumentChecklistPageController dcpC = new DocumentChecklistPageController();
        dcPC.d1=False;
        dcPC.d2=False;
        dcPC.d3=False;
        dcPC.d4=False;
        dcPC.d5=False;
        dcPC.d6=False;
        dcPC.d7=False;
        dcPC.d8=False;
        dcPC.d9=False;
        dcPC.d10=False;
        dcPC.d11=False;
        dcPC.d12=False;
        dcPC.d13=False;
        dcPC.d14=False;
        dcPC.d15=False;
        dcPC.d16=False;
        dcPC.d17=False;
        dcPC.d18=False;
        dcPC.d19=False;
        dcPC.d20=False;
        dcPC.d21=False;
        dcPC.d22=False;
        dcPC.d23=False;
        dcPC.d24=False;
        dcPC.d25=False;
        dcPC.d26=False;
        dcPC.d27=False;
        dcPC.d28=False;
        dcPC.d29=False;
        dcPC.d30=False;
        dcPC.d31=False;
        
        
        dcpC.btnReject();
        
      //  PageReference pCancel = Page.ApplicantFormCancel;
    //    Test.setCurrentPage(pCancel);
     //   ApexPages.currentPage().getParameters().put('id',objBooking.Id);
     //   BookingClassForCancellation bCancelC = new BookingClassForCancellation();
     //   bcancelC.cancel();
        Test.stopTest();
      }
      
      
      @isTest
    private static void documentCheckListAcceptTest()
    {  
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
        PageReference dcPage = Page.NewDocumentChecklistPage;
        Test.setCurrentPage(dcPage);
        ApexPages.currentPage().getParameters().put('id',objBooking.Id);
        DocumentChecklistPageController dcpC = new DocumentChecklistPageController();
        dcpC.Accept();
        
    //    PageReference pCancel = Page.ApplicantFormCancel;
    //    Test.setCurrentPage(pCancel);
    //    ApexPages.currentPage().getParameters().put('id',objBooking.Id);
      //  BookingClassForCancellation bCancelC = new BookingClassForCancellation();
     //   bcancelC.cancel();
        Test.stopTest();
    }
    
     @isTest
    private static void BookingPageTest() {
        Opportunity objcustomer;
        Opportunity objcustomer1;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        
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
        
        objPUU1 = new Project_Unit__c();  
        objPUU1.Project_Unit_Type__c = objPUT.id;  
        objPUU1.Name = 'TestUnit1';      
        objPUU1.Project__c = objpr.Id;
        objPUU1.Param1__c = '5';
        objPUU1.UnitNo__c ='10';
        objPUU1.Unit_Status__c ='Vacant';
        insert objPUU1;
        
        objCP1 = new Car_Parking_Charge__c();
        objCP1.Status__c = 'Vacant';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c();
        objCP2.Status__c = 'Vacant';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Single';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        insert objcustomer1;
          
        
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
        q.Allow_booking_without_full_token__c = TRUE;
        q.Agreement_Value__c = 60422880;
        q.Agreement_Value_ST__c = 2537761;
        q.Tandem_car_park_Additional__c = 1;
        q.Single_car_park_Additional__c = 1;
        insert q;
        
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
        r2.Total_Amount__c = 8400;
        r1.Currency__c = 'Indian Rupee';
        r2.Token_Amount_ST__c = true;
        insert r2;
        
       // Test.startTest();
        PageReference pRef = Page.BookingPageForm2;
        Test.setCurrentPage(pRef);
        ApexPages.currentPage().getParameters().put('optyId',objCustomer.id);
        BookingClass bookC = new BookingClass();
        List < SelectOption > sq= bookC.getQuote;
     //   bookC.getQuoteStatus();
        bookC.selectedQuote = q.Id;
        bookC.getTokenAmount();
        bookC.getReceiptDetails();
        ////////////////////////////////////////////////////////////////
        //objBooking.Customer__c=objcustomer.id;
        //objBooking.Opportunity__c = objcustomer.id;
        ////////////////////////////////////////////////////////////////
        bookC.boookingObj.Application_No__c = '1234';
        bookC.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC.applicant.Salutation__c = 'Mr.';
        bookC.applicant.Name = 'New Man';
        bookC.applicant.DOB__c = system.today();
        bookC.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC.applicant.Nationality__c = 'Indian';
        bookC.applicant.Pincode__c = 898900;
        bookC.applicant.Country__c = 'India';
        bookC.applicant.Mobile_Number__c = '909090900';
        bookC.applicant.Email_Address__c = 'newman@justnow.com';
        bookC.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC.applicant.Pancard__c = true;
        bookC.ServiceTaxCheck = true;
        bookC.selectedVal = '';
        //bookC.quotationidparam = '';
        bookC.save();
         Test.startTest();
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        List < SelectOption > sq1= bookC1.getQuote;
      //  bookC1.getQuoteStatus();
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        
        // general required fields validation simulation
        //bookC1.save();  
        bookC1.selectedQuote = q.Id;
        bookC1.save();  
        bookC1.boookingObj.Application_No__c = '1234';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC1.save();
        
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC1.save();
        
        // applicant1 to required fields validation simulation
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.save();
        bookC1.applicant.Name = 'New Man';
        bookC1.save();   
        bookC1.applicant.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant.Pincode__c = 898900;
        bookC1.save();
        bookC1.applicant.Country__c = 'India';
        bookC1.save();
        bookC1.applicant.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheck = FALSE; 
        bookC1.save();        
        
        
        // applicant2 to required fields validation simulation
        bookC1.applicant2.Name = 'Second Man';
        bookC1.save(); 
        bookC1.applicant2.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant2.Pincode__c = 898900;
        bookC1.save();
        bookC1.applicant2.Country__c = 'India';
        bookC1.save();
        bookC1.applicant2.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant2.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant2.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant2.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheckApplicant2 = FALSE;
        bookC1.save();
        
       // applicant3 to required fields validation simulation
        bookC1.applicant3.Name = 'Second Man';
        bookC1.save(); 
        bookC1.applicant3.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant3.Pincode__c = 898900;
        bookC1.save();
        bookC1.applicant3.Country__c = 'India';
        bookC1.save();
        bookC1.applicant3.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant3.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        Test.stopTest();
        
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant3.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant3.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheckApplicant3 = FALSE;
        bookC1.save();
        
        // applicant4 to required fields validation simulation
        bookC1.applicant4.Name = 'Second Man';
        bookC1.save(); 
        bookC1.applicant4.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant4.Pincode__c = 898900;
        bookC1.save();
        bookC1.applicant4.Country__c = 'India';
        bookC1.save();
        bookC1.applicant4.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant4.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheckApplicant4 = FALSE;
        bookC1.save();
        
        
        // applicant5 to required fields validation simulation
        bookC1.applicant5.Name = 'Second Man';
        bookC1.save(); 
        bookC1.applicant5.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();        
        bookC1.applicant5.Pincode__c = 898900;
        bookC1.save();
        bookC1.applicant5.Country__c = 'India';
        bookC1.save();
        
        bookC1.applicant5.Mobile_Number__c = '909090900';
        bookC1.applicant5.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant5.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.addressCheckApplicant5 = FALSE;
        
        ////////////////////////////////////////////////////////////////////
        bookC1.boookingObj.Future_Correspondence_Contact__c = '1st Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
         ////////////////////////////////////////////////////////////////////
        
        
    }
    
    @isTest 
    private static void BookingPageTest1() {
        Opportunity objcustomer1;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        
        objpr = new Project__c();
        objpr.Project_Code__c = 'T31';
        objpr.Name = 'TestProject';
        objpr.RDS_Short_Name__c = 'T';
        objpr.Start_Date__c = System.today().addDays(-5);
        objpr.RDS_Interest_Rate__c = 12;
        objpr.Service_Tax_Required_On_Token_Amount__c = true;
        insert objpr;
          
        objPUT = new Project_Unit_Type__c();
        objPUT.RDS_Code__c = '101';
        objPUT.RDS_Project__c = objpr.id;
        insert objPUT;

        objPUU1 = new Project_Unit__c();  
        objPUU1.Project_Unit_Type__c = objPUT.id;  
        objPUU1.Name = 'TestUnit1';      
        objPUU1.Project__c = objpr.Id;
        objPUU1.Param1__c = '5';
        objPUU1.UnitNo__c ='10';
        objPUU1.Unit_Status__c ='Vacant';
        insert objPUU1;
      
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);

        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        insert objcustomer1;
          
        
        Quotation__c q = new Quotation__c();
        q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.Prepared_Date__c = System.today();
        q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU1.Id;
        q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer1.Id;
        q.Appartment_Configuration__c = '1 BHK';
        q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Agreement_Value__c = 60422880;
        q.Agreement_Value_ST__c = 2537761;
        insert q;
        
        Test.startTest();      
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer1.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU1.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
     //   bookC1.getQuoteStatus();
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        bookC1.ServiceTaxCheck = true;
       
        
        bookC1.boookingObj.Application_No__c = '1234';
        bookC1.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man';
        bookC1.applicant.DOB__c = system.today();
        bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant.Pincode__c = 898900;
        bookC1.applicant.Country__c = 'India';
        bookC1.applicant.Nationality__c = 'Indian';
        bookC1.applicant.Mobile_Number__c = '909090900';
        bookC1.applicant.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Partnership Firm';
    
        // simulating validation errors of token amount receipt
        bookC1.receiptObj.Mode__c = 'Cheque';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'Demand Draft';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'DD/Pay Order';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'EFT';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'NEFT';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'RTGS';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'TDS';
        bookC1.save();
        bookC1.receiptObj.Mode__c = 'Pay Order';
        bookC1.save();
        bookC1.receiptObj.Total_Amount__c = 0;
        bookC1.Save();
        bookC1.receiptObj.Total_Amount__c = 9000000;
        bookC1.Save();
        bookC1.receiptObj.Pay_Order__c = 'PO122';
        bookC1.save();
        bookC1.receiptObj.cheque_DD_Date__c = system.today();
        bookC1.save();
        bookC1.receiptObj.DraweeBank__c = 'ICICI';
        bookC1.save();
        bookC1.receiptObj.Branch__c = 'Mumbai';
        bookC1.save();
        
        // simulating service tax receipt capture validation errors
        bookC1.STreceiptObj.Mode__c = 'Cheque';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'DD/Pay Order';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'EFT';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'Demand Draft';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'NEFT';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'RTGS';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'TDS';
        bookC1.save();
        bookC1.STreceiptObj.Mode__c = 'Pay Order';
        bookC1.save();
        bookC1.STreceiptObj.Total_Amount__c = 0;
        bookC1.Save();
        bookC1.STreceiptObj.Total_Amount__c = 9000000;
        bookC1.Save();
        bookC1.STreceiptObj.cheque_DD_Date__c = system.today();
        bookC1.save();
        bookC1.STreceiptObj.Pay_Order__c = 'PO10122';
        bookC1.save();
        bookC1.STreceiptObj.DraweeBank__c = 'ICICI';
        bookC1.save();
        bookC1.STreceiptObj.Branch__c = 'Mumbai';
        
        bookC1.save();
        bookC1.selectedVal = '';
        //bookC1.quotationidparam = '';

      Test.stopTest();
        
    }  
      
    
    @isTest 
    private static void BookingPageTest2() {
        Opportunity objcustomer1;
        Booking__c objBooking;
        Project__c objpr;
        Project_Unit__c objPUU1;
        Project_Unit_Type__c objPUT;
        Car_Parking_Charge__c objCP1;
        Car_Parking_Charge__c objCP2;
        
        objpr = new Project__c();
        objpr.Project_Code__c = 'T31';
        objpr.Name = 'TestProject';
        objpr.RDS_Short_Name__c = 'T';
        objpr.Start_Date__c = System.today().addDays(-5);
        objpr.RDS_Interest_Rate__c = 12;
        objpr.Service_Tax_Required_On_Token_Amount__c = true;
        insert objpr;
          
        objPUT = new Project_Unit_Type__c();
        objPUT.RDS_Code__c = '101';
        objPUT.RDS_Project__c = objpr.id;
        insert objPUT;

        objPUU1 = new Project_Unit__c();  
        objPUU1.Project_Unit_Type__c = objPUT.id;  
        objPUU1.Name = 'TestUnit1';      
        objPUU1.Project__c = objpr.Id;
        objPUU1.Param1__c = '5';
        objPUU1.UnitNo__c ='10';
        objPUU1.Unit_Status__c ='Vacant';
        insert objPUU1;
      
        objCP1 = new Car_Parking_Charge__c();
        objCP1.Status__c = 'Vacant';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c();
        objCP2.Status__c = 'Vacant';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Single';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);

        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        insert objcustomer1;
          
        
        Quotation__c q = new Quotation__c();
        q.Name = 'Q010101';
        q.Quote_Status__c = 'Valid';
        q.Prepared_Date__c = System.today();
        q.Project__c = objpr.Id;
        q.Project_Unit__c = objPUU1.Id;
        q.FloorNo__c = 11;
        q.Opportunity__c = objcustomer1.Id;
        q.Appartment_Configuration__c = '1 BHK';
        q.Carpet_Area_Sq_Ft__c = 1200;
        q.Token_Amount__c =110000;
        q.ST_Token_Amount__c = 1000;
        q.Agreement_Value__c = 60422880;
        q.Agreement_Value_ST__c = 2537761;
        q.Tandem_car_park_Additional__c = 1;
        q.Single_car_park_Additional__c = 1;
        
        insert q;
        
        Test.startTest();      
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('optyId',objcustomer1.id);
        BookingClass bookC1 = new BookingClass();
        bookC1.boookingObj.Opportunity__c = objCustomer1.id;
        List < SelectOption > sq1= bookC1.getQuote;
        bookC1.selectedQuote = q.Id;
      //  bookC1.getQuoteStatus();
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        bookC1.getaddressstatus();
       
        bookC1.boookingObj.Application_No__c = '1234';
        bookC1.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC1.boookingObj.Future_Correspondence_Contact_Name__c = 'futureman';
        bookC1.boookingObj.Future_Correspondence_Contact_Relation__c = 'Friend';
        
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man';
        bookC1.applicant.DOB__c = system.today();
        bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant.Pincode__c = 898900;
        bookC1.applicant.Country__c = 'India';
        bookC1.applicant.Country__c = 'State';
        bookC1.applicant.City__c = 'Mumbai';
        bookC1.applicant.Nationality__c = 'Indian';
        bookC1.applicant.Mobile_Number__c = '909090900';
        bookC1.applicant.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant.PanCard__c = true;
        bookC1.applicant.address_proof__c = true;
        bookC1.applicant.address_proof_document__c = 'PAN Card';
        bookC1.applicant.address_proof_number__c = 'PA0001';
        bookC1.applicant.One_passport_size_color_photograph__c = true;
        
        bookC1.applicant3.Salutation__c = 'Mr.';
        bookC1.applicant3.Name = 'New Man';
        bookC1.applicant3.DOB__c = system.today();
        bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant3.Pincode__c = 898900;
        bookC1.applicant3.Country__c = 'India';
        bookC1.applicant3.Country__c = 'State';
        bookC1.applicant3.City__c = 'Mumbai';
        bookC1.applicant3.Nationality__c = 'Indian';
        bookC1.applicant3.Mobile_Number__c = '909090900';
        bookC1.applicant3.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant3.PanCard__c = true;
        bookC1.applicant3.address_proof__c = true;
        bookC1.applicant3.address_proof_document__c = 'PAN Card';
        bookC1.applicant3.address_proof_number__c = 'PA0001';
        bookC1.applicant3.One_passport_size_color_photograph__c = true;
        
        bookC1.applicant2.Salutation__c = 'Mr.';
        bookC1.applicant2.Name = 'New Man';
        bookC1.applicant2.DOB__c = system.today();
        bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant2.Pincode__c = 898900;
        bookC1.applicant2.Country__c = 'India';
        bookC1.applicant2.Country__c = 'State';
        bookC1.applicant2.City__c = 'Mumbai';
        bookC1.applicant2.Nationality__c = 'Indian';
        bookC1.applicant2.Mobile_Number__c = '909090900';
        bookC1.applicant2.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant2.PanCard__c = true;
        bookC1.applicant2.address_proof__c = true;
        bookC1.applicant2.address_proof_document__c = 'PAN Card';
        bookC1.applicant2.address_proof_number__c = 'PA0001';
        bookC1.applicant2.One_passport_size_color_photograph__c = true;
        
        bookC1.applicant4.Salutation__c = 'Mr.';
        bookC1.applicant4.Name = 'New Man';
        bookC1.applicant4.DOB__c = system.today();
        bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant4.Pincode__c = 898900;
        bookC1.applicant4.Country__c = 'India';
        bookC1.applicant4.Country__c = 'State';
        bookC1.applicant4.City__c = 'Mumbai';
        bookC1.applicant4.Nationality__c = 'Indian';
        bookC1.applicant4.Mobile_Number__c = '909090900';
        bookC1.applicant4.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant4.PanCard__c = true;
        bookC1.applicant4.address_proof__c = true;
        bookC1.applicant4.address_proof_document__c = 'PAN Card';
        bookC1.applicant4.address_proof_number__c = 'PA0001';
        bookC1.applicant4.One_passport_size_color_photograph__c = true;
        
        bookC1.applicant5.Salutation__c = 'Mr.';
        bookC1.applicant5.Name = 'New Man';
        bookC1.applicant5.DOB__c = system.today();
        bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant5.Pincode__c = 898900;
        bookC1.applicant5.Country__c = 'India';
        bookC1.applicant5.Country__c = 'State';
        bookC1.applicant5.City__c = 'Mumbai';
        bookC1.applicant5.Nationality__c = 'Indian';
        bookC1.applicant5.Mobile_Number__c = '909090900';
        bookC1.applicant5.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant5.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant5.PanCard__c = true;
        bookC1.applicant5.address_proof__c = true;
        bookC1.applicant5.address_proof_document__c = 'PAN Card';
        bookC1.applicant5.address_proof_number__c = 'PA0001';
        bookC1.applicant5.One_passport_size_color_photograph__c = true;
        
           
        bookC1.receiptObj.Mode__c = 'Pay Order';
        bookC1.receiptObj.Total_Amount__c = 9000000;
        bookC1.receiptObj.Pay_Order__c = 'PO122';
        bookC1.receiptObj.cheque_DD_Date__c = system.today();
        bookC1.receiptObj.DraweeBank__c = 'ICICI';
        bookC1.receiptObj.Branch__c = 'Mumbai';
                
        bookC1.STreceiptObj.Mode__c = 'Pay Order';
        bookC1.STreceiptObj.Total_Amount__c = 9000000;
        bookC1.STreceiptObj.cheque_DD_Date__c = system.today();
        bookC1.STreceiptObj.Pay_Order__c = 'PO10122';
        bookC1.STreceiptObj.DraweeBank__c = 'ICICI';
        bookC1.STreceiptObj.Branch__c = 'Mumbai';
        bookC1.save();

      Test.stopTest();
        
    }
        @isTest
    private static void BookingPageTest3() {
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
        
        objPUU1 = new Project_Unit__c();  
        objPUU1.Project_Unit_Type__c = objPUT.id;  
        objPUU1.Name = 'TestUnit1';      
        objPUU1.Project__c = objpr.Id;
        objPUU1.Param1__c = '5';
        objPUU1.UnitNo__c ='10';
        objPUU1.Unit_Status__c ='Vacant';
        insert objPUU1;
        
        objCP1 = new Car_Parking_Charge__c();
        objCP1.Status__c = 'Vacant';
        objCP1.Category__c = 'Additional';
        objCP1.Parking__c = 'Tandem Covered';
        objCP1.Project__c = objpr.Id;
        insert objCP1;
        
        objCP2 = new Car_Parking_Charge__c();
        objCP2.Status__c = 'Vacant';
        objCP2.Category__c = 'Additional';
        objCP2.Parking__c = 'Tandem Open';
        objCP2.Project__c = objpr.Id;
        insert objCP2;
        
        objCP3 = new Car_Parking_Charge__c();
        objCP3.Status__c = 'Vacant';
        objCP3.Category__c = 'Additional';
        objCP3.Parking__c = 'Single Covered';
        objCP3.Project__c = objpr.Id;
        insert objCP3;
        
        objCP4 = new Car_Parking_Charge__c();
        objCP4.Status__c = 'Vacant';
        objCP4.Category__c = 'Additional';
        objCP4.Parking__c = 'Single Open';
        objCP4.Project__c = objpr.Id;
        insert objCP4;
        
        objCP5 = new Car_Parking_Charge__c();
        objCP5.Status__c = 'Vacant';
        objCP5.Category__c = 'Additional';
        objCP5.Parking__c = 'Stack';
        objCP5.Project__c = objpr.Id;
        insert objCP5;
        
        Account a = TestDataFactory.createPATemplate('WC Account', 'wc@email.com','9098777',false);
        
        objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=objPUU.id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = a.Id;
        insert objcustomer;
        
        objcustomer1= new Opportunity();
        objcustomer1.Project__c=objpr.id;
        objcustomer1.name='Test 1';
        objcustomer1.StageName='Open';
        objcustomer1.Project_Unit__c=objPUU1.id;  
        objcustomer1.CloseDate=system.today();
        objcustomer1.Status__c ='Active';
        objcustomer1.AccountId = a.Id;
        insert objcustomer1;
          
        
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
        q.Allow_booking_without_full_token__c = TRUE;
        q.Agreement_Value__c = 60422880;
        q.Agreement_Value_ST__c = 2537761;
        q.Tandem_car_park_Additional__c = 1;
        q.Tandem_Open_Additional__c= 1;
        q.Single_car_park_Additional__c= 1;
        q.Single_Open_Additional__c = 1;
        q.Stack_Additional__c = 1;
        insert q;
        
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
        r2.Total_Amount__c = 8400;
        r1.Currency__c = 'Indian Rupee';
        r2.Token_Amount_ST__c = true;
        insert r2;
        
        
        PageReference pRef = Page.BookingPageForm2;
        Test.setCurrentPage(pRef);
        ApexPages.currentPage().getParameters().put('optyId',objCustomer.id);
        BookingClass bookC = new BookingClass();
        List < SelectOption > sq= bookC.getQuote;
     //   bookC.getQuoteStatus();
        bookC.selectedQuote = q.Id;
        bookC.getTokenAmount();
        bookC.getReceiptDetails();
        ////////////////////////////////////////////////////////////////
        //objBooking.Customer__c=objcustomer.id;
        //objBooking.Opportunity__c = objcustomer.id;
        ////////////////////////////////////////////////////////////////
        bookC.boookingObj.Application_No__c = '1234';
        bookC.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC.applicant.Salutation__c = 'Mr.';
        bookC.applicant.Name = 'New Man';
        bookC.applicant.DOB__c = system.today();
        bookC.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC.applicant.Nationality__c = 'Indian';
        bookC.applicant.Pincode__c = 898900;
        bookC.applicant.Country__c = 'India';
        bookC.applicant.Mobile_Number__c = '909090900';
        bookC.applicant.Email_Address__c = 'newman@justnow.com';
        bookC.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC.applicant.Pancard__c = true;
        bookC.ServiceTaxCheck = true;
        bookC.save();
        
        PageReference pRef1 = Page.BookingPageForm2;
        Test.setCurrentPage(pRef1);
        
        PageReference pRef2 = Page.cancel_page;
        Test.setCurrentPage(pRef2);
        
        ApexPages.currentPage().getParameters().put('optyId',objcustomer.id);
         ApexPages.currentPage().getParameters().put('unitId',objPUU.id);
        ApexPages.currentPage().getParameters().put('projectId',objpr.id);
        BookingClass bookC1 = new BookingClass();
        List < SelectOption > sq1= bookC1.getQuote;
      //  bookC1.getQuoteStatus();
        bookC1.getTokenAmount();
        bookC1.getReceiptDetails();
        
        // general required fields validation simulation
        //bookC1.save();  
        bookC1.selectedQuote = q.Id;
        bookC1.save();  
        bookC1.boookingObj.Application_No__c = '1234';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = 'Other';
        bookC1.save();
        
        bookC1.boookingObj.Future_Correspondence_Contact_Phone__c = '1234898989';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact_Email__c  = 'future@hereIcome.com';
        bookC1.save();
        
        // applicant1 to required fields validation simulation
        bookC1.applicant.Salutation__c = 'Mr.';
        bookC1.applicant.Name = 'New Man';
        bookC1.applicant.DOB__c = system.today();
        bookC1.applicant.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant.Pincode__c = 89890;
        bookC1.applicant.Country__c = 'India';
        bookC1.applicant.Mailing_Country__c= 'India';
        bookC1.applicant.Mobile_Number__c = '909090900';
        bookC1.applicant.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.addressCheck = FALSE; 
        
        
        // applicant2 to required fields validation simulation
        bookC1.applicant2.Name = 'Second Man';
        bookC1.applicant2.DOB__c = system.today();
        bookC1.applicant2.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant2.Pincode__c = 89890;
        bookC1.applicant2.Country__c = 'India';
        bookC1.applicant2.Mailing_Country__c= 'India';
        bookC1.applicant2.Mobile_Number__c = '909090900';
        bookC1.applicant2.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant2.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant2.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.addressCheckApplicant2 = FALSE;
       
       // applicant3 to required fields validation simulation
        bookC1.applicant3.Name = 'Second Man';
        bookC1.applicant3.DOB__c = system.today();
        bookC1.applicant3.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.applicant3.Pincode__c = 89890;
        bookC1.applicant3.Country__c = 'India';
        bookC1.applicant3.Mailing_Country__c= 'India';
        bookC1.applicant3.Mobile_Number__c = '909090900';
        bookC1.applicant3.Email_Address__c = 'newman@justnow.com';
        bookC1.applicant3.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'For Company';
        bookC1.applicant3.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.addressCheckApplicant3 = FALSE;
        
        Test.startTest();
        // applicant4 to required fields validation simulation
        bookC1.applicant4.Name = 'Second Man';
        bookC1.save(); 
        bookC1.applicant4.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant4.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant4.Pincode__c = 89890;
        bookC1.save();
        bookC1.applicant4.Country__c = 'India';
        bookC1.save();
        bookC1.applicant4.Mailing_Country__c= 'India';
        bookC1.save();
        bookC1.applicant4.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant4.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant4.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant4.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheckApplicant4 = FALSE;
        bookC1.save();
        
        
        // applicant5 to required fields validation simulation
        bookC1.applicant5.Name = 'Second Man';
        bookC1.save();
        bookC1.applicant5.DOB__c = system.today();
        bookC1.save();
        bookC1.applicant5.Permanent_Address__c = 'Pike Street, New World, 45000';
        bookC1.save();
        bookC1.applicant5.Pincode__c = 89890;
        bookC1.save();
        bookC1.applicant5.Country__c = 'India';
        bookC1.save();
        bookC1.applicant5.Mailing_Country__c = 'India';
        bookC1.save();
        bookC1.applicant5.Mobile_Number__c = '909090900';
        bookC1.save();
        bookC1.applicant5.Email_Address__c = 'newman@justnow.com';
        bookC1.save();
        bookC1.applicant5.Type_Of_Applicant__c  = 'Individual Buyer';
        bookC1.save();
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Indian National';
        bookC1.save();
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Foreign Nationals Of Indian Origin';
        bookC1.save();
        bookC1.applicant5.Subtype_Of_Applicant__c = 'For NRI';
        bookC1.save();
        bookC1.applicant5.Subtype_Of_Applicant__c = 'For Company';
        bookC1.save();
        bookC1.applicant5.Subtype_Of_Applicant__c = 'Partnership Firm';
        bookC1.save();
        bookC1.addressCheckApplicant5 = FALSE;
        bookC1.save();

        ////////////////////////////////////////////////////////////////////
        bookC1.boookingObj.Future_Correspondence_Contact__c = '1st Applicant';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '2nd Applicant';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '3rd Applicant';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '4th Applicant';
        bookC1.save();
        bookC1.boookingObj.Future_Correspondence_Contact__c = '5th Applicant';
        bookC1.save();
         ////////////////////////////////////////////////////////////////////
         Test.stopTest();
         }
         
             @isTest
    private static void BlockTest() {
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@twgtest.com', '9876544441', false);
        Project__c objpr = new Project__c();
        objpr = TestDataFactory.createProject('Xa_prj','111');
        //List<Project__c> p = TestDataFactory.createProject('Xa_prj','111');
        //create Clusters
        List<Cluster__c> cList = TestDataFactory.createClusters(2, objpr.Id);
        //create Tower
        List<Tower__c> tList = TestDataFactory.createTowers(2, objpr.Id);
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, objpr.Id);
        
        //create Opportunity
        Opportunity objcustomer= new Opportunity();
        objcustomer.Project__c=objpr.id;
        objcustomer.name='Test 1';
        objcustomer.StageName='Open';
        objcustomer.Project_Unit__c=uList[0].id;  
        objcustomer.CloseDate=system.today();
        objcustomer.Status__c ='Active';
        objCustomer.AccountId = acc.Id;
        objcustomer.Sales_Manager__c = 'SM2@g.com';
        insert objcustomer;
        Test.startTest();
        PageReference pRef = Page.BlockingPage;
        Test.setCurrentPage(pRef);
        ApexPages.currentPage().getParameters().put('optyid',objcustomer.Id);
        ApexPages.currentPage().getParameters().put('unitId',uList[0].Id);
        ApexPages.currentPage().getParameters().put('action', 'Blocked');
        Blocking_Detail__c block = new Blocking_Detail__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(block);
        BlockingExtension be = new BlockingExtension(sc);
        be.setAccDtls();
        be.save();
        Project_Unit__c blockedUnit = [Select Id, Customers__c,Unit_Status__c from Project_Unit__c where id= :uList[0].Id];
        //System.assertEquals(oList[0].Id, blockedUnit.Customers__c);
        
        Blocking_Detail__c blocked = TestDataFactory.createBlockRecord(objcustomer.Id, acc.Id, uList[1].Id, 'Blocked');
        PageReference pRef1 = Page.BlockingPage;
        Test.setCurrentPage(pRef1);
        ApexPages.currentPage().getParameters().put('unitId',uList[1].Id);
        ApexPages.currentPage().getParameters().put('action', 'Released');
        Blocking_Detail__c block1 = new Blocking_Detail__c();
        ApexPages.StandardController sc1 = new ApexPages.StandardController(block1);
        BlockingExtension be1 = new BlockingExtension(sc1);
        be1.setAccDtls();
        be1.save();
        Blocking_Detail__c updatedBlock = [Select Id, Status__c, Opportunity__c from Blocking_Detail__c where id= :blocked.Id];
        //blockedUnit.IsUnblockUnit__c = true;
        update blockedUnit;
        Test.stopTest();
       // System.assertEquals('Released', updatedBlock.Status__c);        
    }
               
         
 }