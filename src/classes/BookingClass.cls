public with sharing class BookingClass {
    public Applicant_Details__c applicant {
        get;
        set;
    }
    public Applicant_Details__c applicant2 {
        get;
        set;
    }
    public Applicant_Details__c applicant3 {
        get;
        set;
    }
    public Applicant_Details__c applicant4 {
        get;
        set;
    }
    public Applicant_Details__c applicant5 {
        get;
        set;
    }
    public Booking__c boookingObj {
        get;
        set;
    }
    public Receipt__c receiptObj {
        get;
        set;
    }
    public Receipt__c ChequeObj {
        get;
        set;
    }
    public Receipt__c DDObj {
        get;
        set;
    }
    public Receipt__c NEFTObj {
        get;
        set;
    }
    public Receipt__c RTGSObj {
        get;
        set;
    }
    public Receipt__c TDSObj {
        get;
        set;
    }
    public Receipt__c POObj {
        get;
        set;
    }
    public Receipt__c STreceiptObj {
        get;
        set;
    }
    public Receipt__c STChequeObj {
        get;
        set;
    }
    public Receipt__c STDDObj {
        get;
        set;
    }
    public Receipt__c STNEFTObj {
        get;
        set;
    }
    public Receipt__c STRTGSObj {
        get;
        set;
    }
    public Receipt__c STTDSObj {
        get;
        set;
    }
    public Receipt__c STPOObj {
        get;
        set;
    }
    public List <Opportunity> optyList {
        get;
        set;
    } 
   public List <Customer_Pay_Plan_Header__c> CPPHListToAdd {
        get;
        set;
    } 
   public List <Customer_Pay_Plan_Header__c> CPPHList {
        get;
        set;
    } 
    public List < Quotation__c > queryResult {
        get;
        set;
    }
    public List < Quotation__c > QuoteDetails {
        get;
        set;
    }
    public List < Receipt__c > ReceiptDetails {
        get;
        set;
    }
    public List < Receipt__c > STReceiptDetails {
        get;
        set;
    }
    public Quotation__c quotationObj {
        get;
        set;
    }
    Public Integer i {
        get;
        set;
    }
    public String selectedVal {
        get;
        set;
    }
    public String selectedQuote {
        get;
        set;
    }
    public Id quotationidparam {
        get;
        set;
    }
    public Id optyidparam {
        get;
        set;
    }
    public Id unitId {
        get;
        set;
    }
    public Id ProjectId {
        get;
        set;
    }
    public Id optyId {
        get;
        set;
    }
    public Boolean addressCheck {
        get;
        set;
    }
    public Boolean addressCheckReverse {
        get;
        set;
    }
    public Boolean addressCheckApplicant2 {
        get;
        set;
    }
    public Boolean addressCheckApplicant3 {
        get;
        set;
    }
    public Boolean addressCheckApplicant4 {
        get;
        set;
    }
    public Boolean addressCheckApplicant5 {
        get;
        set;
    }
    public Legal_Entity__c le {
        get;
        set;
    }
    
    //added by shailesh
     public Receipt__c reciept {
        get;
        set;
    }
    
     public List < Receipt__c >receiptlist {
        get;
        set;
    }
     public List < Receipt__c >deletereceiptlist {
        get;
        set;
    }
    public Decimal TotalServiceandToken{
         get;
         set;
    }  
     public Receipt__c del {
        get;
        set;
    }
     public Integer rowIndex 
     {
         get;
         set;
     }
    
    //////////
    public Boolean  ServiceTaxCheck {get;set;}
    public Decimal  TotalReceiptAmount {get;set;}
    public Decimal  STTotalReceiptAmount {get;set;}
    public Decimal  TotalToken {get;set;}
    public Decimal  TotalQuoteToken {get;set;}
    List <Car_Parking_Charge__c>  ParkingListToUpdate = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  StackParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleDepParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleIndepParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TandemCOVEREDParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  PuzzelParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TwoWheelerParkingList = new List <Car_Parking_Charge__c>();
    
    List < Applicant_Details__c > listApplicant = new list < Applicant_Details__c > ();
    List < Receipt_Details__c > listReceiptDetails = new list < Receipt_Details__c > ();
    Receipt_Details__c objReceiptDetails = new Receipt_Details__c();
    Receipt_Details__c objReceiptDetailsST = new Receipt_Details__c();
    List <Project_Charges__c> listglobalcharges = new List <Project_Charges__c>();
    public List < Receipt__c > ListOldReceipt {
        get;
        set;
    }
    public List<Receipt__c> ReceiptLstTobeUpdate
    {
         get;
         set;
    }
    
    //Anuja added on  29/12/15
    public String tokenamt {get;set;}
    public String STamt {get;set;}
    public BookingClass() {
    
    //added by shailesh
    reciept=new Receipt__c ();
    deletereceiptlist =new List < Receipt__c >();
    receiptlist =new List < Receipt__c >();
    receiptlist.add(reciept);
    
    TotalServiceandToken=0;
    rowIndex =0;
    
    /////
    
    
        i=0;
        TotalReceiptAmount=0;
        STTotalReceiptAmount=0;
        TotalToken =0;
        TotalQuoteToken =0;
        tokenamt ='';
        STamt = '';
        ParkingListToUpdate  = new List<Car_Parking_Charge__c>();
        PuzzelParkingList = new List <Car_Parking_Charge__c>();
        SingleDepParkingList = new List <Car_Parking_Charge__c>();
        SingleIndepParkingList = new List <Car_Parking_Charge__c>();
        TandemCOVEREDParkingList = new List <Car_Parking_Charge__c>();
        StackParkingList = new List <Car_Parking_Charge__c>();
        TwoWheelerParkingList = new List <Car_Parking_Charge__c>();
        
        
        ListOldReceipt = new List <Receipt__c>();
        STReceiptDetails = new List <Receipt__c>();
        ReceiptDetails = new List <Receipt__c>();
        QuoteDetails  = new List <Quotation__c>();
        queryResult = new List <Quotation__c>();
        CPPHList = new List <Customer_Pay_Plan_Header__c>();
        CPPHListToAdd = new List <Customer_Pay_Plan_Header__c>();
        optyList  = new List <Opportunity>();
        
        le = new Legal_Entity__c();
         addressCheck = true;
        addressCheckApplicant2 = true;
        addressCheckApplicant3 = true;
        addressCheckApplicant4 = true;
        addressCheckApplicant5 = true; 
        applicant = new Applicant_Details__c();
        applicant2 = new Applicant_Details__c();
        applicant3 = new Applicant_Details__c();
        applicant4 = new Applicant_Details__c();
        applicant5 = new Applicant_Details__c();
        boookingObj = new Booking__c();
        quotationObj = new Quotation__c();
        receiptObj = new Receipt__c();
        ChequeObj = new Receipt__c();
        DDObj = new Receipt__c();
        NEFTObj = new Receipt__c();
        RTGSObj = new Receipt__c();
        TDSObj = new Receipt__c();
        POObj = new Receipt__c();
        STreceiptObj = new Receipt__c();
        STChequeObj = new Receipt__c();
        STDDObj = new Receipt__c();
        STNEFTObj = new Receipt__c();
        STRTGSObj = new Receipt__c();
        STTDSObj = new Receipt__c();
        STPOObj = new Receipt__c();
        ReceiptLstTobeUpdate = new List<Receipt__c>();

        if (ApexPages.currentPage().getParameters().get('unitId') != null && ApexPages.currentPage().getParameters().get('unitId') != '') {

            unitId = ApexPages.currentPage().getParameters().get('unitId');
            system.debug('inside contructor unit is ' + unitId);
        }

        if (ApexPages.currentPage().getParameters().get('optyid') != null && ApexPages.currentPage().getParameters().get('optyid') != '') {
                        boookingObj.Opportunity__c = ApexPages.currentPage().getParameters().get('optyid');

            try {
                ReceiptDetails = [SELECT id,Project_Unit__c,Project__c, Name,Cheque_DD_Date__c, DraweeBank__c, CreatedDate, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Total_Amount__c,
                Receipt_Date__c FROM Receipt__c WHERE Opportunity__c = : boookingObj.Opportunity__c and Token_Amount_Receipt__c = true And (Project_Unit__c = null OR Project_Unit__c = : unitId )]; //and Token_Amount_Receipt__c = true
                if (ReceiptDetails.size() > 0) {
                    system.debug('Inside ReceiptDetails');
                    boookingObj.Booking_Date__c = ReceiptDetails[0].CreatedDate;
                    boookingObj.Receipts__c = ReceiptDetails[0].id;
                    for(Receipt__c rds : ReceiptDetails)
                    {
                        TotalReceiptAmount = TotalReceiptAmount + rds.Total_Amount__c;
                        if(rds.Project_Unit__c == null)
                            {
                                rds.Project_Unit__c = unitId;
                            } 
                    }
                    
                     
                    
                    
                }
                STReceiptDetails = [SELECT id, Name,Cheque_DD_Date__c, DraweeBank__c, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Total_Amount__c,
                Receipt_Date__c, Project_Unit__c FROM Receipt__c WHERE Opportunity__c = : boookingObj.Opportunity__c and Token_Amount_ST__c = true  And (Project_Unit__c = null OR Project_Unit__c = : unitId )];
                if (STReceiptDetails.size() > 0) {
                    system.debug('Inside STReceiptDetails');
                    boookingObj.ServiceReceipt__c = STReceiptDetails[0].id;
                    for(Receipt__c strds : STReceiptDetails)
                    {
                        STTotalReceiptAmount = STTotalReceiptAmount + strds.Total_Amount__c;
                        if(strds.Project_Unit__c == null)
                            {
                                strds.Project_Unit__c = unitId;
                            } 
                    }
                }
               
            } catch (DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());

            }
        }
        
        if (ApexPages.currentPage().getParameters().get('projectId') != null && ApexPages.currentPage().getParameters().get('projectId') != '') {

            ProjectId = ApexPages.currentPage().getParameters().get('projectId');
            system.debug('inside contructor ProjectId is ' + ProjectId);
        }
        getquotation();

    }

public PageReference getquotation() {
    if (boookingObj.Opportunity__c != null){
    optyList =  [SELECT id,Walk_in_Source__c,Source_Details__c,Walk_in_Sub_Source__c, Name,Project__c, Account.Birth_Date__c,Account.BillingAddress,
    Account.PersonMobilePhone, Account.PersonEmail, Account.BillingStreet,Skip_Site_Visit__c, Sourcing_Manager__c, Sales_Manager__c, Account.BillingCity,Account.BillingPostalCode,
    Account.BillingCountry,Account.Name,Account.Salutation,Account.Country__c,Account.Office_State_Province__c,Account.Office_City__c,Account.Residential_Street__c,Purpose__c ,
    Account.Mobile__c,Account.Alternate_number_1__c
     from Opportunity where id =: boookingObj.Opportunity__c];
              system.debug('optyList Project__c ' +optyList[0].Project__c);
              if(optyList.size() >0 ){
              if((optyList[0].Walk_in_Source__c == null) && (optyList[0].Skip_Site_Visit__c != True))
              {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Walk in Source for opportunity  <a style="color:blue;" href="/'+optyList[0].id+'" target="_blank">'+optyList[0].Name+'</a> is empty');
                  ApexPages.addMessage(myMsg);
                    i=1;
              }
              else{
                  boookingObj.Source_of_Booking__c = optyList[0].Walk_in_Source__c;
                  boookingObj.Booking_Source_Details__c = optyList[0].Source_Details__c;
                     
              }
              if((optyList[0].Walk_in_Sub_Source__c == null) && (optyList[0].Skip_Site_Visit__c != True))
              {
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Walk in Sub Source for opportunity  <a style="color:blue;" href="/'+optyList[0].id+'" target="_blank">'+optyList[0].Name+'</a> is empty');
                  ApexPages.addMessage(myMsg);
                    i=1;
              }
              else{
                      boookingObj.Sub_Source__c = optyList[0].Walk_in_Sub_Source__c;
                      boookingObj.Booking_Source_Details__c = optyList[0].Source_Details__c;
              }
               if((optyList[0].Purpose__c == null))
              {
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Purpose of Purchase for opportunity  <a style="color:blue;" href="/'+optyList[0].id+'" target="_blank">'+optyList[0].Name+'</a> is empty');
                  ApexPages.addMessage(myMsg);
                    i=1;
              }
              else{
              }
              
              if((optyList[0].Sourcing_Manager__c) == null && (optyList[0].Skip_Site_Visit__c != True))
              {
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Sourcing Manager for opportunity  <a style="color:blue;" href="/'+optyList[0].id+'" target="_blank">'+optyList[0].Name+'</a> is empty');
                  ApexPages.addMessage(myMsg);
                    i=1;
              }
              else
              {
                      boookingObj.Sourcing_Mananger__c = optyList[0].Sourcing_Manager__c;
              }
              if((optyList[0].Sales_Manager__c == null) && (optyList[0].Skip_Site_Visit__c != True))
              {
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Sales Manager for opportunity  <a style="color:blue;" href="/'+optyList[0].id+'" target="_blank">'+optyList[0].Name+'</a> is empty');
                  ApexPages.addMessage(myMsg);
                    i=1;
              }
              else
              {
                      boookingObj.Sales_Managers__c = optyList[0].Sales_Manager__c;
              }
              
              System.debug('Todayyyyyy ' +boookingObj.Booking_Source_Details__c);
                 //Assigning applicant1 details from account 
                    applicant.Salutation__c=optyList[0].Account.Salutation;
                    applicant.Name=optyList[0].Account.Name;
                    applicant.DOB__c = optyList[0].Account.Birth_Date__c;
                    applicant.Country__c=optyList[0].Account.Country__c;
                    applicant.State__c=optyList[0].Account.Office_State_Province__c;
                    applicant.City__c=optyList[0].Account.Office_City__c;
                    applicant.Permanent_Address__c = optyList[0].Account.Residential_Street__c;
                    applicant.Mobile_Number__c=optyList[0].Account.PersonMobilePhone;
                    applicant.Landline_Number__c= optyList[0].Account.Alternate_number_1__c;
                    applicant.Email_Address__c = optyList[0].Account.PersonEmail;
                   if(optyList[0].Account.BillingPostalCode != null)
                   {
                       applicant.Pincode__c = Decimal.valueof(optyList[0].Account.BillingPostalCode);
                   }
                   else{
                       applicant.Pincode__c = 0;
                   }
                   applicant.Country__c = optyList[0].Account.BillingCountry;
                   applicant.City__c = optyList[0].Account.BillingCity;
              }
              else{
              
              
              }
    }             
  if (boookingObj.Opportunity__c != null && unitId == null && ProjectId == null) {
                system.debug('get quote if only opty');
                queryResult = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c,Name,Booking__c,Allow_booking_without_full_token__c,Project_Unit__r.Project__c, Service_Tax_On_Token_Amount__c from Quotation__c where Opportunity__c = : boookingObj.Opportunity__c and Project_Unit__r.Project__c =: optyList[0].Project__c and Project_Unit__r.Unit_Status__c = 'Vacant' and Booking__c =: null];
                if(queryResult.size() >0)
                {
                    system.debug('Result only opty quotations' +queryResult);
                
                }else {
                    system.debug('Quotation Else if only opty');
                   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Either this opportunity does not have a Quotation or the unit associated with it is not vacant');
                   ApexPages.addMessage(myMsg);
                }

            } else if (boookingObj.Opportunity__c != null && unitId != null && ProjectId == null) {
                queryResult = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c, Name,Booking__c,Allow_booking_without_full_token__c, Service_Tax_On_Token_Amount__c,Project_Unit__r.Project__c,Project_Unit__c from Quotation__c where Opportunity__c = : boookingObj.Opportunity__c and Project_Unit__c = : unitId and Project_Unit__r.Project__c =: optyList[0].Project__c and  (Project_Unit__r.Unit_Status__c = 'Vacant' OR Project_Unit__r.Unit_Status__c = 'Hold') and Booking__c =: null ];
                system.debug('queryResult2' + queryResult);
                if(queryResult.size() >0)
                {
                    system.debug('Result only opty and unit quotations' +queryResult);
                }
                else {
                    system.debug('Quotation Else if opty  and unit is present but no quotation');
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Either this opportunity does not have a Quotation or the unit associated with the quotation is not vacant');
                    ApexPages.addMessage(myMsg);
                    i=1;
                }

            } else if (boookingObj.Opportunity__c != null && ProjectId != null && unitId == null ) {
                system.debug('get quote if opty and ProjectId ');
                system.debug('get quote if ProjectId  is not null and ProjectId  :-' + ProjectId);
                queryResult = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c,Name,Booking__c,Allow_booking_without_full_token__c,Project_Unit__r.Project__c, Service_Tax_On_Token_Amount__c, Project_Unit__c from Quotation__c where Opportunity__c = : boookingObj.Opportunity__c and Project__c = : ProjectId and Project_Unit__r.Unit_Status__c = 'Vacant' and Booking__c =: null];
                system.debug('queryResult' + queryResult);

                if(queryResult.size() >0)
                {
                    system.debug('Result only opty and ProjectId quotations' +queryResult);
                }
                else {
                    system.debug('Quotation Else if opty  and Project');
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Either the opportunity does not have a Quotation or the unit associated with it is not vacant');
                    ApexPages.addMessage(myMsg);
                    i=1;
                }
                
           }
            else if (boookingObj.Opportunity__c != null && ProjectId != null && unitId != null ) {
                system.debug('get quote if opty and ProjectId and unitId ');
                system.debug('get quote if ProjectId  is not null and ProjectId  :-' + ProjectId);
                system.debug('get quote if opty and unitId ' +unitId  );
                queryResult = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c,Name,Booking__c,Allow_booking_without_full_token__c,Project_Unit__r.Project__c, Service_Tax_On_Token_Amount__c, Project_Unit__c from Quotation__c where Opportunity__c = : boookingObj.Opportunity__c and Project__c = : ProjectId and (Project_Unit__r.Unit_Status__c = 'Vacant' OR Project_Unit__r.Unit_Status__c = 'Hold') and Project_Unit__c =: unitId   and Booking__c =: null];
                system.debug('queryResult' + queryResult);

                if(queryResult.size() >0)
                {
                    system.debug('Result only opty and ProjectId quotations' +queryResult);
                }
                else {
                    system.debug('Quotation Else if opty  and Project');
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Either the opportunity does not have a Quotation or the unit associated with it is not vacant or hold');
                    ApexPages.addMessage(myMsg);
                    i=1;
                }
                
           }
           
           else {
               system.debug('Inside getQuote No Opportunity');

            } 
    return null;
}

    //Create selectlist out of queryresult
    public List < SelectOption > getQuote {
        get {
        
            system.debug('Inside getQuote queryResult' +queryResult);
            List < SelectOption > optns = new List < Selectoption > ();
            optns.add(new SelectOption('', 'Select a Quotation'));
             if(queryResult.size() >0)
                {
                    for (Quotation__c obj: queryResult) {
                    optns.add(new SelectOption(obj.Id, obj.Name));
                    }
                
                }else {
                    system.debug('No quotations');
                   
                }
           return optns;
        }
        set;
    }
    
    //added by shailesh
    public void addReciept()
    {
     
     Receipt__c rec=new Receipt__c();
     receiptlist.add(rec);
     system.debug('receiptlist inside method::::'+receiptlist);
     system.debug('receiptlist inside method size::::'+receiptlist.size());
      
    }
    public void deleteReciept()
    {
       
      system.debug('receiptlist inside method size::::'+receiptlist.size());
      
      rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
      System.debug('row index be deleted ' + rowIndex );
      System.debug('rows to be deleted '+receiptlist[rowIndex]);
      del = receiptlist.remove(rowIndex);
      deletereceiptlist.add(del);
    }
   
   //Get Token from Quotation
    public PageReference getTokenAmount() {
        system.debug('inside getTokenAmount');
        system.debug('Selected Val' + selectedQuote);
        if (selectedQuote != null) {
            QuoteDetails = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c,Tandem_Open_Additional__c,Single_Open_Additional__c,Two_Wheeler_Additional__c, PaymentPlan__c,PaymentPlan__r.Sub_Vention__c,Stack_Additional__c,Name,Booking__c,Allow_booking_without_full_token__c,Agreement_Value__c,Carpet_Area_Sq_Ft__c,Appartment_Configuration__c, Project__c, Service_Tax_On_Token_Amount__c, 
            Project_Unit__c, Token_Amount__c, ST_Token_Amount__c, Zone__c, Wing__c, Flat_Typology__c, FloorNo__c,FloorNo1__c, Carpet_Area__c, No_of_parking__c, Parking_Type__c, 
            Allotment_Premium_Agreement_Value__c,Agreement_Value_D__c, FlatNo__c,Level_One_Approver__c,Level_Two_Approver__c,Level_Three_Approver__c
            FROM Quotation__c WHERE Id = : selectedQuote];
            if (QuoteDetails.size() > 0)
            {
                System.Debug('Inside QuoteDetails'+QuoteDetails );
                boookingObj.Token_Amount__c = QuoteDetails[0].Token_Amount__c;
                //Anuja added on 29/12/15
               tokenamt = QuotationManagementServices1.INFormat(QuoteDetails[0].Token_Amount__c);
                boookingObj.Zone__c = QuoteDetails[0].Zone__c;
                boookingObj.Wing__c = QuoteDetails[0].Wing__c;
                boookingObj.Flat_Typology__c = QuoteDetails[0].Appartment_Configuration__c;
                boookingObj.Floor__c = QuoteDetails[0].FloorNo__c;
                boookingObj.Floor1__c = QuoteDetails[0].FloorNo1__c;
                boookingObj.Carpet_Area__c = QuoteDetails[0].Carpet_Area_Sq_Ft__c;
                boookingObj.No_of_parking__c = QuoteDetails[0].No_of_parking__c;
                boookingObj.Parking_Type__c = QuoteDetails[0].Parking_Type__c;
                
                if(QuoteDetails[0].Agreement_Value_D__c == 0)
                {
                    boookingObj.Allotment_Premium__c = QuoteDetails[0].Agreement_Value__c;
                }
                else
                {
                    boookingObj.Allotment_Premium__c = QuoteDetails[0].Agreement_Value_D__c;
                }
                
                boookingObj.Flat_No__c = QuoteDetails[0].FlatNo__c;
                boookingObj.Project__c = QuoteDetails[0].Project__c;
                boookingObj.Unit_No__c = QuoteDetails[0].Project_Unit__c;
                System.Debug('Milestone1');             
                boookingObj.Level_One_Approver__c = QuoteDetails[0].Level_One_Approver__c;
                boookingObj.Level_Two_Approver__c = QuoteDetails[0].Level_Two_Approver__c;
                boookingObj.Level_Three_Approver__c = QuoteDetails[0].Level_Three_Approver__c;
              //-----------------------------------By Ashish-------------------------------------------------------
                if(QuoteDetails[0].PaymentPlan__r.Sub_Vention__c == True)
                {
                    boookingObj.Funding_Status__c = 'Subvention';
                    boookingObj.Bank_Loan_Status__c= 'Need help to apply';
                }
                else
                {
                    boookingObj.Funding_Status__c = 'Self Funded';
                    boookingObj.Bank_Loan_Status__c= '-';
                }
                //-------------------------------------------------------------------------------------------
               // boookingObj.Sales_Manager_Approver__c = QuoteDetails[0].Owner;
                System.Debug('Milestone2');
                if (QuoteDetails[0].Service_Tax_On_Token_Amount__c == true) {
                    boookingObj.ST_Token_Amount__c = QuoteDetails[0].ST_Token_Amount__c;
                    //Anuja added on 29/12/15
                    STamt = QuotationManagementServices1.INFormat(QuoteDetails[0].ST_Token_Amount__c);
                } else {

                    boookingObj.ST_Token_Amount__c = 0;
                }
                
                if(boookingObj.Opportunity__c != null && QuoteDetails[0].Project_Unit__c != null){
                    le = QuotationManagementServices1.getLegalEntityDetails(boookingObj.Unit_No__c, boookingObj.Project__c);
                    System.debug('leeeeeeee '+le);
                    if(le != null){
                    boookingObj.Stock__c = le.Account_Name_Flat_Cost__c;
                    boookingObj.Account_Number__c = String.valueOf(le.Account_Number_Flat_Cost__c);
                    boookingObj.Bank__c = le.Bank_Name_Flat_Cost__c;
                    boookingObj.IFSC_Code_Flat_Cost__c = le.IFSC_Code_Flat_Cost__c;
                    boookingObj.Account_Name_Service_Tax__c = le.Account_Name_Service_Tax__c;
                    boookingObj.Account_Number_Service_tax__c = String.ValueOf(le.Account_Number_Service_tax__c);
                    boookingObj.Bank_Name_Service_tax__c = le.Bank_Name_Service_tax__c;
                    boookingObj.IFSC_Code_Service_Tax__c = le.IFSC_Code_Service_Tax__c;
                    
                    }
                }
                
             //parking type changed
                if (QuoteDetails[0].Tandem_car_park_Additional__c != null) { ///tandem covered//comented
           
                        TandemCOVEREDParkingList = [Select id,Parking__c,Status__c,Category__c,Name From Car_Parking_Charge__c where Parking__c =: 'Dependable-Stack' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('TandemCOVEREDParkingList Size ..........)  ' +TandemCOVEREDParkingList.size());
                    
               }
               if (QuoteDetails[0].Tandem_Open_Additional__c != null) { ///tandem Open//Stack
           
                    StackParkingList = [Select id,Parking__c,Status__c,Category__c,Name From Car_Parking_Charge__c where Parking__c =: 'Stack' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('StackParkingList Size ..........)  ' +StackParkingList.size());
                    
               }
               
               if (QuoteDetails[0].Single_car_park_Additional__c != null) { // single covered//Single - Independent
           
                    SingleIndepParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Single - Independent' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('SingleIndepParkingList Size ..........)  ' +SingleIndepParkingList.size());
                    
               }
               
               if (QuoteDetails[0].Single_Open_Additional__c != null) { // single Open//Single- Dependent
           
                    SingleDepParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Single- Dependent' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('SingleDepParkingList Size ..........)  ' +SingleDepParkingList.size());
                    
               }
               if (QuoteDetails[0].Stack_Additional__c != null) { // Stack//Puzzle
           
                    PuzzelParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Puzzle' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('PuzzelParkingList Size ..........)  ' +PuzzelParkingList.size());
                    
               }
               if (QuoteDetails[0].Two_Wheeler_Additional__c != null) { //two wheeler
           
                    TwoWheelerParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Two Wheeler' and Status__c =: 'Vacant' and Category__c =: 'Additional' and Project__c =: boookingObj.Project__c];
                    System.debug('TwoWheelerParkingList Size ..........)  ' +TwoWheelerParkingList .size());
                    
               }
            }
            
            getReceiptDetails();
        } else {
            boookingObj.Token_Amount__c = 0;
            boookingObj.ST_Token_Amount__c = 0;
        }
        return null;
    }
    //Get Receipt Using OptyId
    public PageReference getReceiptDetails() {
        TotalReceiptAmount = 0;
        STTotalReceiptAmount = 0;
        system.debug('inside getReceiptDetails');
        try {
            ReceiptDetails = [SELECT id,Project_Unit__c,Project__c, Name,Cheque_DD_Date__c, DraweeBank__c, CreatedDate, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Total_Amount__c,
            Receipt_Date__c FROM Receipt__c WHERE Opportunity__c = : boookingObj.Opportunity__c and Token_Amount_Receipt__c = true And (Project_Unit__c = null OR Project_Unit__c = : unitId )]; //and Token_Amount_Receipt__c = true 
            if (ReceiptDetails.size() > 0) {
                system.debug('Inside ReceiptDetails outside constructor');
                boookingObj.Booking_Date__c = ReceiptDetails[0].CreatedDate;
                boookingObj.Receipts__c = ReceiptDetails[0].id;
                for(Receipt__c rds : ReceiptDetails)
                {
                        TotalReceiptAmount = TotalReceiptAmount + rds.Total_Amount__c;
                
                    if(rds.Project_Unit__c == null)
                    {
                        rds.Project_Unit__c = QuoteDetails[0].Project_Unit__c;
                    } 
                }
            }
            else{
                boookingObj.Booking_Date__c = System.Now();
                }
                
            // if Service tax is applicable for this project
            if (QuoteDetails.size() > 0 && QuoteDetails[0].Service_Tax_On_Token_Amount__c == true) {
                STReceiptDetails = [SELECT id, Project_Unit__c, Name,Cheque_DD_Date__c ,DraweeBank__c, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Total_Amount__c,
                Receipt_Date__c FROM Receipt__c WHERE Opportunity__c = : boookingObj.Opportunity__c and Token_Amount_ST__c = true And (Project_Unit__c = null OR Project_Unit__c = : unitId )];
                if (STReceiptDetails.size() > 0) {
                system.debug('Inside STReceiptDetails outside constructor');
                    boookingObj.ServiceReceipt__c = STReceiptDetails[0].id;
                    for(Receipt__c strds : STReceiptDetails)
                    {
                            STTotalReceiptAmount = STTotalReceiptAmount + strds.Total_Amount__c;
                            if(strds.Project_Unit__c == null)
                            {
                                strds.Project_Unit__c = QuoteDetails[0].Project_Unit__c;
                            } 
                    }    
                }
            }

        } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());

        }
             
        return null;
    }

    public PageReference getaddressstatus() {

        System.Debug('inside' + addressCheck);

        if (addressCheck == true) {
            addressCheckReverse = false;
        } else {
            addressCheckReverse = true;
        }
        return null;


    }


    public PageReference Save() {
    
    
    TotalServiceandToken=0;
        i = 0;
       ////Anuja added on 7/1/16 ////////////////
       ///Tandem Covered////
       if (QuoteDetails != null && QuoteDetails.size() > 0 && TandemCOVEREDParkingList.size() < QuoteDetails[0].Tandem_car_park_Additional__c) {
             system.debug('TandemCOVEREDParkingList error');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of Dependent-Stack parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       ///tandem Open////
       if (QuoteDetails != null && QuoteDetails.size() > 0 && StackParkingList.size() < QuoteDetails[0].Tandem_Open_Additional__c) {
             system.debug('StackParkingList error');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of Stack parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       ///Single Covered////
       if ( QuoteDetails != null && QuoteDetails.size() > 0 &&  SingleIndepParkingList.size() < QuoteDetails[0].Single_car_park_Additional__c) {
             system.debug('SingleIndepParkingList error');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of single Independent parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       ///Sigle Open////
       if (QuoteDetails != null && QuoteDetails.size() > 0 && SingleDepParkingList.size() < QuoteDetails[0].Single_Open_Additional__c) {
             system.debug('SingleDepParkingList error');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of single Dependent parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       ///Stack////
       if (QuoteDetails != null && QuoteDetails.size() > 0 && PuzzelParkingList.size() < QuoteDetails[0].Stack_Additional__c) {
             system.debug('PuzzelParkingList error');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of Puzzel  parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       //Two wheeler
       if (QuoteDetails != null && QuoteDetails.size() > 0 && TwoWheelerParkingList.size() < QuoteDetails[0].Two_Wheeler_Additional__c) {
             system.debug('TwoWheelerParkingListerror');
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required number of two wheeler parking is unavailable');
             ApexPages.addMessage(myMsg);
             i=1;
       
       }
       
       /////////////////////////////////////////////////////////////

            if(boookingObj.Opportunity__c == null){
        system.debug('Inside null selected quote' +selectedQuote );
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please select an Opportunity');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(selectedQuote == '' || selectedQuote == null ){
        system.debug('Inside null selected quote' +selectedQuote );
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please select a quotation');
             ApexPages.addMessage(myMsg);
                i=1;
        }
       // if(boookingObj.Application_No__c == '' || boookingObj.Application_No__c == null ){
         //    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Application No. Cannot Be Left Blank');
           //  ApexPages.addMessage(myMsg);
             //   i=1;
       // }
        
        if(boookingObj.Future_Correspondence_Contact__c == '' && boookingObj.Future_Correspondence_Contact__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Future Correspondence Contact Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(boookingObj.Future_Correspondence_Contact__c == 'Other' ){
            if(boookingObj.Future_Correspondence_Contact_Name__c ==  null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is Other Future Correspondence Name Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        
            if(boookingObj.Future_Correspondence_Contact_Phone__c == '' || boookingObj.Future_Correspondence_Contact_Phone__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is Other Future Correspondence Phone Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
            if(boookingObj.Future_Correspondence_Contact_Email__c == '' || boookingObj.Future_Correspondence_Contact_Email__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is Other Future Correspondence Email Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
            if(boookingObj.Future_Correspondence_Contact_Relation__c == '' || boookingObj.Future_Correspondence_Contact_Relation__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is Other Future Correspondence Relation Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
       }
       //////////////////Error Messages for Future Correspondence///////////////////////
       if(boookingObj.Future_Correspondence_Contact__c == '2nd Applicant' ){
        
            if(applicant2.Name == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is (2nd Applicant) Applicant 2 Details Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
       }
       if(boookingObj.Future_Correspondence_Contact__c == '3rd Applicant' ){
        
            if(applicant3.Name == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is (3rd Applicant) Applicant 3 Details Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
       }
       if(boookingObj.Future_Correspondence_Contact__c == '4th Applicant' ){ 
        
            if(applicant4.Name == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is (4th Applicant) Applicant 4 Details Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
       }
       if(boookingObj.Future_Correspondence_Contact__c == '5th Applicant' ){
        
            if(applicant5.Name == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Incase Future Correspondence Contact Is (5th Applicant) Applicant 5 Details Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
       }
      ////////////////////////// error messages for saales manager and sourcing manager  //////////////////////////
        if(boookingObj.Sales_Managers__c == '' || boookingObj.Sales_Managers__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Sales Mananger  Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(boookingObj.Sourcing_Mananger__c == '' && boookingObj.Sourcing_Mananger__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Sourcing Mananger Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        
       
      ////////////////////////// error messagess for applicant 1  //////////////////////////
        if(applicant.Salutation__c == '' || applicant.Salutation__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Salutation for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Name == '' || applicant.Name == null ){
        system.debug('Inside null selected quote' +selectedQuote );
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Name for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.DOB__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'DOB for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Permanent_Address__c == '' || applicant.Permanent_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Permanent address for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Country__c == 'India'){
            if(applicant.State__c == '' && applicant.State__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'State for Applicant 1 Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        }
        if(applicant.City__c == '' || applicant.City__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'City for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Pincode__c == null ||applicant.Pincode__c == 0 ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Country__c == '' || applicant.Country__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Country for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
         if(applicant.Country__c == 'India' && applicant.Pincode__c != null){
             if(String.valueOf(applicant.Pincode__c).length() != 6 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 1 Should Be Of 6 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }
        }
        if(applicant.Mobile_Number__c == '' || applicant.Mobile_Number__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Mobile_Number__c != null && (applicant.Mobile_Number__c).length() != 10){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 1 Should be of 10 digits');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Email_Address__c == '' || applicant.Email_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Email Address for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Nationality__c == '' || applicant.Nationality__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Nationality for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Type_Of_Applicant__c == '' || applicant.Type_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Type Of Applicant for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Subtype_Of_Applicant__c == '' || applicant.Subtype_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Residential Status for Applicant 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant.Subtype_Of_Applicant__c == 'Indian National'){
            if(applicant.Pancard__c == false || applicant.Address_Proof__c == false || applicant.Address_Proof_Document__c == '' || applicant.Address_Proof_Number__c == '' || applicant.One_Passport_Size_Color_Photograph__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant.PancardNo__c != null && (applicant.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 1 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        if(applicant.Subtype_Of_Applicant__c == 'Foreign Nationals Of Indian Origin'){
            if(applicant.One_Passport_Size_Color_Photograph__c == false || applicant.Funds_from_NRE_FCNR__c == false || applicant.Self_attested_copy_of_PIO_or_OCI_Card__c == false || applicant.Type_Of_Origin__c == '' || applicant.Origin_Details__c == '')
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                     i=1;
            }
                        
        }
        if(applicant.Subtype_Of_Applicant__c == 'For NRI'){
            if(applicant.Pancard__c == false || applicant.One_Passport_Size_Color_Photograph__c == false || applicant.PassportNumber__c == false || applicant.Funds_from_NRE_NRO__c == false || applicant.Copy_of_Workpermit_Employment_contract__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant.PancardNo__c != null && (applicant.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 1 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }               
        }
        if(applicant.Subtype_Of_Applicant__c == 'For Company'){
            if(applicant.Pancard__c == false || applicant.Copy_of_Memorandu_of_Association__c == false || applicant.Certified_copy_of_Article_of_Association__c  == false || applicant.Certified_copy_of_Board_Resolution__c == false || applicant.Certified_copy_of_ROC_Incorporation__c == false || applicant.Self_attested_List_of_Shareholders__c == false || applicant.Self_attested_List_of_Directors__c == false || applicant.PanCard_of_Authority_Signatory__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant.PancardNo__c != null && (applicant.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 1 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        if(applicant.Subtype_Of_Applicant__c == 'Partnership Firm'){
            if(applicant.Pancard__c == false || applicant.PanCard_of_Authority_Signatory__c == false || applicant.Certified_copy_of_Partnership_Deed__c == false || applicant.Certified_extract_of_Registration__c == false || applicant.Copy_of_Authorization_Letter_POA__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant.PancardNo__c != null && (applicant.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 1 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }           
        }
        
        //Ashish---> Bank detatils
                if(boookingObj.Bank_Name_1__c == '' || boookingObj.Bank_Name_1__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Bank Name 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
                }
                 if(boookingObj.Account_Number_1__c== '' || boookingObj.Account_Number_1__c== null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Account Number 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
                }
                 if(boookingObj.IFSC_Code_1__c== '' || boookingObj.IFSC_Code_1__c== null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'IFSC Code 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
                }
                 if(boookingObj.Branch_1__c== '' || boookingObj.Branch_1__c== null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Branch 1 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
                }
        //anuja added on 16 dec 
                if(addressCheck == False)
                {
                
                    if(applicant.Mailing_Address__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing address for Applicant 1 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant.Mailing_Pincode__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Pincode for Applicant 1 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant.Mailing_Country__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Country for Applicant 1 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant.Mailing_Country__c == 'India' && applicant.Mailing_Pincode__c != null){
                         if(String.valueOf(applicant.Mailing_Pincode__c).length() != 6 ){
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing Pincode for Applicant 1 Should Be Of 6 Digits' );
                             ApexPages.addMessage(myMsg);
                                i=1;
                         }
                    }
                    if(applicant.Mailing_Country__c == 'India'){
                        if(applicant.Mailing_State__c == null ){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing State for Applicant 1 Cannot Be Left Blank');
                         ApexPages.addMessage(myMsg);
                            i=1;
                        }
                    }
                    if(applicant.Mailing_City__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing City for Applicant 1 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                }
        //////////////////////////////error messages for Applicant 2///////////////////////////
    if(applicant2.Name != null )
    {
        
        if(applicant2.Salutation__c == '' && applicant2.Salutation__c == null){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Salutation for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.DOB__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'DOB for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Permanent_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Permanent address for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Country__c == 'India'){
            if(applicant2.State__c == '' && applicant2.State__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'State for Applicant 2 Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        }
        if(applicant2.City__c == '' || applicant2.City__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'City for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Pincode__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Country__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Country for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Country__c == 'India' && applicant2.Pincode__c != null){
             if(String.valueOf(applicant2.Pincode__c).length() != 6 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 2 Should Be Of 6 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }
        }
        if(applicant2.Mobile_Number__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Mobile_Number__c != null && (applicant2.Mobile_Number__c).length() != 10){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 2 Should be of 10 digits');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Email_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Email Address for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Nationality__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Nationality for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Type_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Type Of Applicant for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Subtype_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Residential Status for Applicant 2 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant2.Subtype_Of_Applicant__c == 'Indian National'){
            if(applicant2.Pancard__c == false || applicant2.Address_Proof__c == false || applicant2.Address_Proof_Document__c == '' || applicant2.Address_Proof_Number__c == '' || applicant2.One_Passport_Size_Color_Photograph__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant2.PancardNo__c != null && (applicant2.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 2 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }            
        }
        if(applicant2.Subtype_Of_Applicant__c == 'Foreign Nationals Of Indian Origin'){
            if(applicant2.One_Passport_Size_Color_Photograph__c == false || applicant2.Funds_from_NRE_FCNR__c == false || applicant2.Self_attested_copy_of_PIO_or_OCI_Card__c == false || applicant2.Type_Of_Origin__c == '' || applicant2.Origin_Details__c == '')
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
                        
        }
        if(applicant2.Subtype_Of_Applicant__c == 'For NRI'){
            if(applicant2.Pancard__c == false || applicant2.One_Passport_Size_Color_Photograph__c == false || applicant2.PassportNumber__c == false || applicant2.Funds_from_NRE_NRO__c == false || applicant2.Copy_of_Workpermit_Employment_contract__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant2.PancardNo__c != null && (applicant2.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 2 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }             
        }
        if(applicant2.Subtype_Of_Applicant__c == 'For Company'){
            if(applicant2.Pancard__c == false || applicant2.Copy_of_Memorandu_of_Association__c == false || applicant2.Certified_copy_of_Article_of_Association__c  == false || applicant2.Certified_copy_of_Board_Resolution__c == false || applicant2.Certified_copy_of_ROC_Incorporation__c == false || applicant2.Self_attested_List_of_Shareholders__c == false || applicant2.Self_attested_List_of_Directors__c == false || applicant2.PanCard_of_Authority_Signatory__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant2.PancardNo__c != null && (applicant2.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 2 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }            
        }
        if(applicant2.Subtype_Of_Applicant__c == 'Partnership Firm'){
            if(applicant2.Pancard__c == false || applicant2.PanCard_of_Authority_Signatory__c == false || applicant2.Certified_copy_of_Partnership_Deed__c == false || applicant2.Certified_extract_of_Registration__c == false || applicant2.Copy_of_Authorization_Letter_POA__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant2.PancardNo__c != null && (applicant2.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 2 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }        
        }
        //anuja added on 16 dec  
                if(addressCheckApplicant2 == False)
                {
                
                    if(applicant2.Mailing_Address__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing address for Applicant 2 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant2.Mailing_Pincode__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Pincode for Applicant 2 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant2.Mailing_Country__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Country for Applicant 2 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant2.Mailing_Country__c == 'India' && applicant2.Mailing_Pincode__c != null){
                         if(String.valueOf(applicant2.Mailing_Pincode__c).length() != 6 ){
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing Pincode for Applicant 2 Should Be Of 6 Digits' );
                             ApexPages.addMessage(myMsg);
                                i=1;
                         }
                    }
                    if(applicant2.Mailing_Country__c == 'India'){
                        if(applicant2.Mailing_State__c == null ){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing State for Applicant 2 Cannot Be Left Blank');
                         ApexPages.addMessage(myMsg);
                            i=1;
                        }
                    }
                    if(applicant2.Mailing_City__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing City for Applicant 2 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                }
        
    } 
    //////////////////////////////error messages for Applicant 3///////////////////////////
    if(applicant3.Name != null)
    {
        
        if(applicant3.Salutation__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Salutation for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.DOB__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'DOB for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Permanent_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Permanent address for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Country__c == 'India'){
            if(applicant3.State__c == '' || applicant3.State__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'State for Applicant 3 Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        }
        if(applicant3.City__c == '' || applicant3.City__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'City for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Pincode__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Country__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Country for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Country__c == 'India' && applicant3.Pincode__c != null ){
             if(String.valueOf(applicant3.Pincode__c).length() != 6 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 3 Should Be Of 6 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }
        }
        if(applicant3.Mobile_Number__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Mobile_Number__c != null && (applicant3.Mobile_Number__c).length() != 10){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 3 Should be of 10 digits');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Email_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Email Address for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Nationality__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Nationality for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Type_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Type Of Applicant for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Subtype_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Residential Status for Applicant 3 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant3.Subtype_Of_Applicant__c == 'Indian National'){
            if(applicant3.Pancard__c == false || applicant3.Address_Proof__c == false || applicant3.Address_Proof_Document__c == '' || applicant3.Address_Proof_Number__c == '' || applicant3.One_Passport_Size_Color_Photograph__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant3.PancardNo__c != null && (applicant3.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 3 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }          
        }
        if(applicant3.Subtype_Of_Applicant__c == 'Foreign Nationals Of Indian Origin'){
            if(applicant3.One_Passport_Size_Color_Photograph__c == false || applicant3.Funds_from_NRE_FCNR__c == false || applicant3.Self_attested_copy_of_PIO_or_OCI_Card__c == false || applicant3.Type_Of_Origin__c == '' || applicant3.Origin_Details__c == '')
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
                        
        }
        if(applicant3.Subtype_Of_Applicant__c == 'For NRI'){
            if(applicant3.Pancard__c == false || applicant3.One_Passport_Size_Color_Photograph__c == false || applicant3.PassportNumber__c == false || applicant3.Funds_from_NRE_NRO__c == false || applicant3.Copy_of_Workpermit_Employment_contract__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant3.PancardNo__c != null &&  (applicant3.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 3 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }           
        }
        if(applicant3.Subtype_Of_Applicant__c == 'For Company'){
            if(applicant3.Pancard__c == false || applicant3.Copy_of_Memorandu_of_Association__c == false || applicant3.Certified_copy_of_Article_of_Association__c  == false || applicant3.Certified_copy_of_Board_Resolution__c == false || applicant3.Certified_copy_of_ROC_Incorporation__c == false || applicant3.Self_attested_List_of_Shareholders__c == false || applicant3.Self_attested_List_of_Directors__c == false || applicant3.PanCard_of_Authority_Signatory__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant3.PancardNo__c != null &&  (applicant3.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 3 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }         
        }
        if(applicant3.Subtype_Of_Applicant__c == 'Partnership Firm'){
            if(applicant3.Pancard__c == false || applicant3.PanCard_of_Authority_Signatory__c == false || applicant3.Certified_copy_of_Partnership_Deed__c == false || applicant3.Certified_extract_of_Registration__c == false|| applicant3.Copy_of_Authorization_Letter_POA__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant3.PancardNo__c != null &&  (applicant3.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 3 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        
        //anuja added on 16 dec  
                if(addressCheckApplicant3 == False)
                {
                
                    if(applicant3.Mailing_Address__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing address for Applicant 3 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant3.Mailing_Pincode__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Pincode for Applicant 3 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant3.Mailing_Country__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Country for Applicant 3 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant3.Mailing_Country__c == 'India' && applicant3.Mailing_Pincode__c != null ){
                         if(String.valueOf(applicant3.Mailing_Pincode__c).length() != 6 ){
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing Pincode for Applicant 3 Should Be Of 6 Digits' );
                             ApexPages.addMessage(myMsg);
                                i=1;
                         }
                    }
                    if(applicant3.Mailing_Country__c == 'India'){
                        if(applicant3.Mailing_State__c == null ){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing State for Applicant 3 Cannot Be Left Blank');
                         ApexPages.addMessage(myMsg);
                            i=1;
                        }
                    }
                    if(applicant3.Mailing_City__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing City for Applicant 3 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                }
    }   
    //////////////////////////////error messages for Applicant 4///////////////////////////
    if(applicant4.Name != null)
    {
        
        if(applicant4.Salutation__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Salutation for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.DOB__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'DOB for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Permanent_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Permanent address for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Country__c == 'India'){
            if(applicant4.State__c == '' || applicant4.State__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'State for Applicant 4 Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        }
        if(applicant4.City__c == '' || applicant4.City__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'City for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Pincode__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Country__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Country for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Country__c == 'India' && applicant4.Pincode__c != null){
             if(String.valueOf(applicant4.Pincode__c).length() != 6 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 4 Should Be Of 6 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }
        }
        if(applicant4.Mobile_Number__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Mobile_Number__c != null && (applicant4.Mobile_Number__c).length() != 10){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 4 Should be of 10 digits');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Email_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Email Address for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Nationality__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Nationality for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Type_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Type Of Applicant for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Subtype_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Residential Status for Applicant 4 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant4.Subtype_Of_Applicant__c == 'Indian National'){
            if(applicant4.Pancard__c == false || applicant4.Address_Proof__c == false || applicant4.Address_Proof_Document__c == '' || applicant4.Address_Proof_Number__c == '' || applicant4.One_Passport_Size_Color_Photograph__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant4.PancardNo__c != null &&  (applicant4.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 4 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }          
        }
        if(applicant4.Subtype_Of_Applicant__c == 'Foreign Nationals Of Indian Origin'){
            if(applicant4.One_Passport_Size_Color_Photograph__c == false || applicant4.Funds_from_NRE_FCNR__c == false || applicant4.Self_attested_copy_of_PIO_or_OCI_Card__c == false || applicant4.Type_Of_Origin__c == '' || applicant4.Origin_Details__c == '')
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
                        
        }
        if(applicant4.Subtype_Of_Applicant__c == 'For NRI'){
            if(applicant4.Pancard__c == false || applicant4.One_Passport_Size_Color_Photograph__c == false || applicant4.PassportNumber__c == false || applicant4.Funds_from_NRE_NRO__c == false || applicant4.Copy_of_Workpermit_Employment_contract__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant4.PancardNo__c != null &&  (applicant4.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 4 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }           
        }
        if(applicant4.Subtype_Of_Applicant__c == 'For Company'){
            if(applicant4.Pancard__c == false || applicant4.Copy_of_Memorandu_of_Association__c == false || applicant4.Certified_copy_of_Article_of_Association__c  == false || applicant4.Certified_copy_of_Board_Resolution__c == false || applicant4.Certified_copy_of_ROC_Incorporation__c == false || applicant4.Self_attested_List_of_Shareholders__c == false || applicant4.Self_attested_List_of_Directors__c == false || applicant4.PanCard_of_Authority_Signatory__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant3.PancardNo__c != null &&  (applicant4.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 4 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }           
        }
        if(applicant4.Subtype_Of_Applicant__c == 'Partnership Firm'){
            if(applicant4.Pancard__c == false || applicant4.PanCard_of_Authority_Signatory__c == false || applicant4.Certified_copy_of_Partnership_Deed__c == false || applicant4.Certified_extract_of_Registration__c == false || applicant4.Copy_of_Authorization_Letter_POA__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant4.PancardNo__c != null && (applicant4.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 4 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }          
        }
        //anuja added on 16 dec  
                if(addressCheckApplicant4 == False)
                {
                
                    if(applicant4.Mailing_Address__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing address for Applicant 4 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant4.Mailing_Pincode__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Pincode for Applicant 4 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant4.Mailing_Country__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Country for Applicant 4 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant4.Mailing_Country__c == 'India' && applicant4.Mailing_Pincode__c != null ){
                         if(String.valueOf(applicant4.Mailing_Pincode__c).length() != 6 ){
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing Pincode for Applicant 4 Should Be Of 6 Digits' );
                             ApexPages.addMessage(myMsg);
                                i=1;
                         }
                    }
                    if(applicant4.Mailing_Country__c == 'India'){
                        if(applicant4.Mailing_State__c == null ){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing State for Applicant 4 Cannot Be Left Blank');
                         ApexPages.addMessage(myMsg);
                            i=1;
                        }
                    }
                    if(applicant4.Mailing_City__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing City for Applicant 4 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                }
    }     
    //////////////////////////////error messages for Applicant 5///////////////////////////
    if(applicant5.Name != null)
    {
        
        if(applicant5.Salutation__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Salutation for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.DOB__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'DOB for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Permanent_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Permanent address for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Country__c == 'India'){
            if(applicant5.State__c == '' || applicant5.State__c == null ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'State for Applicant 5 Cannot Be Left Blank');
                 ApexPages.addMessage(myMsg);
                    i=1;
            }
        }
        if(applicant5.City__c == '' || applicant5.City__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'City for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Pincode__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Country__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Country for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Country__c == 'India' && applicant5.Pincode__c != null){
             if(String.valueOf(applicant5.Pincode__c).length() != 6 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pincode for Applicant 5 Should Be Of 6 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }
        }
        if(applicant5.Mobile_Number__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Mobile_Number__c != null && (applicant5.Mobile_Number__c).length() != 10){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mobile Number for Applicant 5 Should be of 10 digits');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Email_Address__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Email Address for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Nationality__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Nationality for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Type_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Type Of Applicant for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Subtype_Of_Applicant__c == null ){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Residential Status for Applicant 5 Cannot Be Left Blank');
             ApexPages.addMessage(myMsg);
                i=1;
        }
        if(applicant5.Subtype_Of_Applicant__c == 'Indian National'){
            if(applicant5.Pancard__c == false || applicant5.Address_Proof__c == false || applicant5.Address_Proof_Document__c == '' || applicant5.Address_Proof_Number__c == '' || applicant5.One_Passport_Size_Color_Photograph__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant5.PancardNo__c != null &&  (applicant5.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 5 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        if(applicant5.Subtype_Of_Applicant__c == 'Foreign Nationals Of Indian Origin'){
            if(applicant5.One_Passport_Size_Color_Photograph__c == false || applicant5.Funds_from_NRE_FCNR__c == false || applicant5.Self_attested_copy_of_PIO_or_OCI_Card__c == false || applicant5.Type_Of_Origin__c == '' || applicant5.Origin_Details__c == '')
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
                        
        }
        if(applicant5.Subtype_Of_Applicant__c == 'For NRI'){
            if(applicant5.Pancard__c == false || applicant5.One_Passport_Size_Color_Photograph__c == false || applicant5.PassportNumber__c == false || applicant5.Funds_from_NRE_NRO__c == false || applicant5.Copy_of_Workpermit_Employment_contract__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant5.PancardNo__c != null &&  (applicant5.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 5 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        if(applicant5.Subtype_Of_Applicant__c == 'For Company'){
            if(applicant5.Pancard__c == false || applicant5.Copy_of_Memorandu_of_Association__c == false || applicant5.Certified_copy_of_Article_of_Association__c  == false || applicant5.Certified_copy_of_Board_Resolution__c == false || applicant5.Certified_copy_of_ROC_Incorporation__c == false || applicant5.Self_attested_List_of_Shareholders__c == false || applicant5.Self_attested_List_of_Directors__c == false || applicant5.PanCard_of_Authority_Signatory__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
            if(applicant5.PancardNo__c != null &&  (applicant5.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 5 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        if(applicant5.Subtype_Of_Applicant__c == 'Partnership Firm'){
            if(applicant5.Pancard__c == false || applicant5.PanCard_of_Authority_Signatory__c == false || applicant5.Certified_copy_of_Partnership_Deed__c == false || applicant5.Certified_extract_of_Registration__c == false|| applicant5.Copy_of_Authorization_Letter_POA__c == false)
            {            
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please ensure that all the document checkboxes are checked and document details are filled properly.');
                     ApexPages.addMessage(myMsg);
                        i=1;
            }
             if(applicant5.PancardNo__c != null &&  (applicant5.PancardNo__c).length() != 10 ){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Pancard for Applicant 5 Should Be Of 10 Digits' );
                 ApexPages.addMessage(myMsg);
                    i=1;
             }  
                        
        }
        //anuja added on 16 dec  
                if(addressCheckApplicant5 == False)
                {
                
                    if(applicant5.Mailing_Address__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing address for Applicant 5 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant5.Mailing_Pincode__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Pincode for Applicant 5 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant5.Mailing_Country__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing  Country for Applicant 5 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                    if(applicant5.Mailing_Country__c == 'India' && applicant5.Mailing_Pincode__c != null){
                         if(String.valueOf(applicant5.Mailing_Pincode__c).length() != 6 ){
                             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing Pincode for Applicant 5 Should Be Of 6 Digits' );
                             ApexPages.addMessage(myMsg);
                                i=1;
                         }
                    }
                    if(applicant5.Mailing_Country__c == 'India'){
                        if(applicant5.Mailing_State__c == null ){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing State for Applicant 5 Cannot Be Left Blank');
                         ApexPages.addMessage(myMsg);
                            i=1;
                        }
                    }
                    if(applicant5.Mailing_City__c == null ){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Mailing City for Applicant 5 Cannot Be Left Blank');
                     ApexPages.addMessage(myMsg);
                        i=1;
                    }
                }
    }   
    
    //////////////////////////////////////Receipt Mandatory Checks//////////////////////////////////////////
    system.debug('ReceiptDetails.size():::: '+ReceiptDetails.size());
    if (ReceiptDetails.size() == 0) {
            System.Debug('insert receipt ' + ReceiptObj);
            System.Debug('receiptlist.size() ' + receiptlist.size());

            for(Receipt__c rce : receiptlist)
            {
                 system.debug('inside for loop');
                  if (rce.Mode__c== null) //
                   {
               
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Instrument Number Of Receipt Cannot Be Left Blank');
                    ApexPages.addMessage(myMsg);
                    i = 1;
                   }
                 if (rce.Cheque_DD__c== null) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Instrument number Cannot Be Left Blank');
                    ApexPages.addMessage(myMsg);
                    i = 1;
                }
                  if (rce.Cheque_DD_Date__c == null) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Date Of Receipt Cannot Be Left Blank');
                    ApexPages.addMessage(myMsg);
                    i = 1;
                }
                if (rce.Total_Amount__c == null) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Amount Of Receipt Cannot Be Left Blank');
                    ApexPages.addMessage(myMsg);
                    i = 1;
                }
                else{
                    //TotalReceiptAmount = receiptlist[0].Total_Amount__c;
                    TotalServiceandToken= TotalServiceandToken + rce.Total_Amount__c;
                }
                if (rce.DraweeBank__c == null) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Bank Of Receipt Cannot Be Left Blank');
                    ApexPages.addMessage(myMsg);
                    i = 1;
                }
                else if(rce.DraweeBank__c =='Other')
                {
                   system.debug('other Bank is:::'+rce.DraweeBank__c);
                   if(rce.Drawee_Bank_If_Others__c == null)
                   {
                      system.debug('inside drawee bank is null:::'+rce.Drawee_Bank_If_Others__c);
                      //ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.Error, 'Please fill Other bank Name'));
                       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Please fill Other bank Name');
                      ApexPages.addMessage(myMsg);
                      i=1;
                   }
                }
              
          }
          
    
    
    
            System.debug('Step oneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            //Checking token amount for all //
            Map<String,Decimal> taxSlabMap = QuotationManagementServices1.getTaxSlabs();
            Decimal TDSAmount = 0;
            if(taxSlabMap.containsKey('TDS')) {
                    
                    TDSAMount = ((taxSlabMap.get('TDS') * boookingObj.Token_Amount__c)/100).setscale(0,RoundingMode.HALF_UP);
            }
            System.debug('TDS Amount:' + TDSAmount + 'on token Amount:' + boookingObj.Token_Amount__c);
            if(boookingObj.Token_Amount__c != null && boookingObj.ST_Token_Amount__c != null )
            {
                System.debug('Step Twoooo');
                TotalQuoteToken = boookingObj.ST_Token_Amount__c + (boookingObj.Token_Amount__c - TDSAmount);
                System.debug('TotalReceiptAmount ' +TotalReceiptAmount );
                System.debug('STTotalReceiptAmount' +STTotalReceiptAmount);
                TotalToken =TotalServiceandToken;
                System.debug('TotalToken ' +TotalToken );
                System.debug('TotalQuoteToken ' +TotalQuoteToken );
                
               if (QuoteDetails != null && QuoteDetails.size() > 0 && QuoteDetails[0].Allow_booking_without_full_token__c == False && TotalToken < TotalQuoteToken ) {
                    System.debug('Step threeeeeeeeee');
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Total  Token Amount cannot be less than ' + QuotationManagementServices1.Informat(TotalQuoteToken));
                        ApexPages.addMessage(myMsg);
                        i=1;
                    }
            } 
            
            }
             
     ///////////////////Inserting Future correspondance contact////////////////////  
     if(boookingObj.Future_Correspondence_Contact__c == '1st Applicant'){
            if(applicant.Name != null ){
                 boookingObj.Future_Correspondence_Contact_Name__c = applicant.Salutation__c+' '+ applicant.Name;
            }
            if(applicant.Mobile_Number__c != null ){
                 boookingObj.Future_Correspondence_Contact_Phone__c = applicant.Mobile_Number__c;
            }
            if(applicant.Email_Address__c != null ){
                 boookingObj.Future_Correspondence_Contact_Email__c = applicant.Email_Address__c;
            }
            boookingObj.Future_Correspondence_Contact_Relation__c = '1st Applicant';
           
       }
    if(boookingObj.Future_Correspondence_Contact__c == '2nd Applicant' ){
        if(applicant2.Name != null ){
             boookingObj.Future_Correspondence_Contact_Name__c =  applicant.Salutation__c + applicant2.Name;
        }
        if(applicant2.Mobile_Number__c != null ){
             boookingObj.Future_Correspondence_Contact_Phone__c = applicant2.Mobile_Number__c;
        }
        if(applicant2.Email_Address__c != null ){
             boookingObj.Future_Correspondence_Contact_Email__c = applicant2.Email_Address__c;
        }
        boookingObj.Future_Correspondence_Contact_Relation__c = '2nd Applicant';
   }
   if(boookingObj.Future_Correspondence_Contact__c == '3rd Applicant' ){
        if(applicant3.Name != null ){
             boookingObj.Future_Correspondence_Contact_Name__c = applicant.Salutation__c + applicant3.Name;
        }
        if(applicant3.Mobile_Number__c != null ){
             boookingObj.Future_Correspondence_Contact_Phone__c = applicant3.Mobile_Number__c;
        }
        if(applicant3.Email_Address__c != null ){
             boookingObj.Future_Correspondence_Contact_Email__c = applicant3.Email_Address__c;
        }
        boookingObj.Future_Correspondence_Contact_Relation__c = '3rd Applicant';
   }
   if(boookingObj.Future_Correspondence_Contact__c == '4th Applicant' ){
        if(applicant4.Name != null ){
             boookingObj.Future_Correspondence_Contact_Name__c = applicant.Salutation__c + applicant4.Name;
        }
        if(applicant4.Mobile_Number__c != null ){
             boookingObj.Future_Correspondence_Contact_Phone__c = applicant4.Mobile_Number__c;
        }
        if(applicant4.Email_Address__c != null ){
             boookingObj.Future_Correspondence_Contact_Email__c = applicant4.Email_Address__c;
        }
        boookingObj.Future_Correspondence_Contact_Relation__c = '4th Applicant';
   }
   if(boookingObj.Future_Correspondence_Contact__c == '5th Applicant' ){
        if(applicant5.Name != null ){
             boookingObj.Future_Correspondence_Contact_Name__c = applicant.Salutation__c + applicant5.Name;
        }
        if(applicant5.Mobile_Number__c != null ){
             boookingObj.Future_Correspondence_Contact_Phone__c = applicant5.Mobile_Number__c;
        }
        if(applicant5.Email_Address__c != null ){
             boookingObj.Future_Correspondence_Contact_Email__c = applicant5.Email_Address__c;
        }
        boookingObj.Future_Correspondence_Contact_Relation__c = '5th Applicant';
   }
    ///////////////////Inserting Future correspondance contact Endss here////////////////////     
        listglobalcharges = [SELECT Id, Name from Project_Charges__c where Name = 'Basic' and Project__c =:boookingObj.Project__c LIMIT 1]; 
        System.Debug('listglobalcharges'+listglobalcharges);   
       //inserting the receipt
        System.debug('iiiiiiiiiiiiiiiiiii TOKEN ' +i);
        boookingObj.Quotation__c = selectedQuote;
        
       
        
        //added by shailesh
        if (i == 0) {
              system.debug('receiptlist:::::::::'+receiptlist);
            system.debug('receiptlist.size():::'+receiptlist.size());
            
             for(Receipt__c ListRct : receiptlist)
             {
                Receipt__c receiptOBJTobeUpdate = new Receipt__c(); 
                receiptOBJTobeUpdate.Mode__c = ListRct.Mode__c;
                receiptOBJTobeUpdate.Cheque_DD__c = ListRct.Cheque_DD__c;
                receiptOBJTobeUpdate.Token_Amount_ST__c = ListRct.Token_Amount_ST__c;
                receiptOBJTobeUpdate.Cheque_DD_Date__c = ListRct.Cheque_DD_Date__c;
                receiptOBJTobeUpdate.Total_Amount__c = ListRct.Total_Amount__c;
                receiptOBJTobeUpdate.Currency__c = 'Indian Rupee';
                receiptOBJTobeUpdate.DraweeBank__c = ListRct.DraweeBank__c;
                receiptOBJTobeUpdate.Drawee_Bank_If_Others__c = ListRct.Drawee_Bank_If_Others__c;
                
                receiptOBJTobeUpdate.Opportunity__c = boookingObj.Opportunity__c;
                receiptOBJTobeUpdate.Project__c = boookingObj.Project__c;
                receiptOBJTobeUpdate.Project_Unit__c = boookingObj.Unit_No__c;
                receiptOBJTobeUpdate.Receipt_Date__c = system.today();
                receiptOBJTobeUpdate.Cheque_DD_Amount_Rs__c = ListRct.Total_Amount__c;
                receiptOBJTobeUpdate.On_Account_Money__c = ListRct.Total_Amount__c;
                receiptOBJTobeUpdate.Amount_Rs__c  =  ListRct.Total_Amount__c;
                receiptOBJTobeUpdate.Opportunity_Email_Id__c=applicant.Email_Address__c;
               
                    if(ListRct.Receipt_Against__c == 'GST')
                    {
                           //system.debug('inside service tax true' + receiptlist[i].Id);Token_Amount_ST__c
                            receiptOBJTobeUpdate.Receipt_Against__c = 'GST';
                            receiptOBJTobeUpdate.Token_Amount_ST__c= True;
                            receiptOBJTobeUpdate.Token_Amount_Receipt__c = False;
                            //receiptOBJTobeUpdate.Drawn_in_favour_of__c='Service Tax |'+boookingObj.Account_Name_Service_Tax__c +' | '+ boookingObj.Account_Number_Service_tax__c; 
                            
                    }
                    else if(ListRct.Receipt_Against__c == 'Flat Cost')
                    {
                            receiptOBJTobeUpdate.Token_Amount_ST__c= False;
                            receiptOBJTobeUpdate.Receipt_Against__c = 'Flat Cost';
                            receiptOBJTobeUpdate.Token_Amount_Receipt__c = True;
                            receiptOBJTobeUpdate.Drawn_in_favour_of__c ='Flat Cost |'+boookingObj.Stock__c +' | '+ boookingObj.Account_Number__c; 
                            
                    }
                    else if(ListRct.Receipt_Against__c == 'Stamp Duty And Registration')
                    {
                           receiptOBJTobeUpdate.Receipt_Against__c = 'Stamp Duty And Registration';
                           receiptOBJTobeUpdate.Drawn_in_favour_of__c ='Stamp Duty And Registration'; 
                            
                    }
                    
                    else
                    {
                           
                            receiptOBJTobeUpdate.Drawn_in_favour_of__c ='Not Specified' ; 
                            
                    }
                if(receiptOBJTobeUpdate.Total_Amount__c != null && receiptOBJTobeUpdate.Mode__c != null)
                 ReceiptLstTobeUpdate.add(receiptOBJTobeUpdate);
            }
                System.debug('ReceiptLstTobeUpdate:::: ' +ReceiptLstTobeUpdate);
                System.debug('ReceiptLstTobeUpdate Size:::: ' +ReceiptLstTobeUpdate.size());
                
                 try
                 {
                    if(!ReceiptLstTobeUpdate.isEmpty())
                    {
                        insert ReceiptLstTobeUpdate; 
                    } 
                 }
                 
                 catch (DmlException e) 
                 {
                    System.debug('An error has occured. Please contact your administrator. : ' + e.getMessage());

                 }
                 
                 for(Receipt__c rcd : ReceiptLstTobeUpdate)
                 {
                     if(rcd.Token_Amount_ST__c == True)
                    {
                            boookingObj.ServiceReceipt__c = rcd.id; 
                    }
                    else
                    {
                            boookingObj.Receipts__c = rcd.id;
                    }
                 }
            
            }
             
             
        
        //Service Tax is applicable for this project
        
           
        system.debug('i' + i);
        if (i == 0) {

            Opportunity insObj = new Opportunity();
            insObj.Id = boookingObj.Opportunity__c;
            insObj.Project__c = boookingObj.Project__c;
            insObj.Project_Unit__c = boookingObj.Unit_No__c;
            insObj.Reason_for_Reblocking__c = 'Booking';
            insObj.StageName= 'Token Amount Received - BIP';
             
            insObj.Future_Correspondence_Contact_Name__c=boookingObj.Future_Correspondence_Contact_Name__c;
            
            insObj.Future_Correspondence_Contact_Phone__c = boookingObj.Future_Correspondence_Contact_Phone__c;
            
            insObj.Future_Correspondence_Contact_Email__c = boookingObj.Future_Correspondence_Contact_Email__c;
            insObj.Future_Correspondence_Contact__c = boookingObj.Future_Correspondence_Contact__c;

            try
                 {
                     
                     boookingObj.Customer__c = boookingObj.Opportunity__c;
                     boookingObj.status__c = 'UnProcessed';
                     insert boookingObj;
                     update insObj;
                     
                 }                 
            catch (DmlException e) 
                 {
                    System.debug('An error has occured. Please contact your administrator. : ' + e.getMessage());

                 }  
             
                 
            //Updating Parkings/////
            
            ////Tandem Covered////
           if (QuoteDetails[0].Tandem_car_park_Additional__c > 0) {
                 system.debug('TandemCOVEREDParkingList requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Tandem_car_park_Additional__c ; j++)
                 {
                 
                     TandemCOVEREDParkingList[j].Status__c =  'Booked'; 
                     ParkingListToUpdate.add(TandemCOVEREDParkingList[j]);
                 }
                 
           }
           ////Tandem Open////
           if (QuoteDetails[0].Tandem_Open_Additional__c > 0) {
                 system.debug('StackParkingList requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Tandem_Open_Additional__c ; j++)
                 {
                 
                     StackParkingList[j].Status__c =  'Booked'; 
                     ParkingListToUpdate.add(StackParkingList[j]);
                 }
                 
           }
           ////Single Open////
           if (QuoteDetails[0].Single_Open_Additional__c > 0) {
                 system.debug('SingleDepParkingList requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Single_Open_Additional__c ; j++)
                 {
                 
                     SingleDepParkingList[j].Status__c =  'Booked'; 
                     ParkingListToUpdate.add(SingleDepParkingList[j]);
                 }
                 
           }
           ////Single Covered////
           if (QuoteDetails[0].Single_car_park_Additional__c > 0 ) {
                 system.debug('SingleIndepParkingList  Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Single_car_park_Additional__c ; j++)
                 {
                     SingleIndepParkingList[j].Status__c = 'Booked'; 
                     ParkingListToUpdate.add(SingleIndepParkingList[j]);
                 
                 }
                 
           }
           ////Stack ////
           if (QuoteDetails[0].Stack_Additional__c > 0 ) {
                 system.debug('PuzzelParkingList Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Two_Wheeler_Additional__c; j++)
                 {
                     PuzzelParkingList[j].Status__c = 'Booked'; 
                     ParkingListToUpdate.add(PuzzelParkingList[j]);
                 
                 }
                 
           }
           //two wheeler
           if (QuoteDetails[0].Two_Wheeler_Additional__c > 0 ) {
                 system.debug('TwoWheelerParkingList Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Stack_Additional__c ; j++)
                 {
                     TwoWheelerParkingList [j].Status__c = 'Booked'; 
                     ParkingListToUpdate.add(TwoWheelerParkingList [j]);
                 
                 }
           }          
            if(ParkingListToUpdate.size() > 0){
                update ParkingListToUpdate;
            }              
            //Updating  Customer Pay Plan Headers with new booking 
            if(boookingObj.id != null){
            
                try {
                    CPPHList =  [SELECT id, Name,Booking__c,Customer__c,Quotation__c FROM Customer_Pay_Plan_Header__c WHERE Quotation__c = : boookingObj.Quotation__c ];
                    if (CPPHList.size() > 0) {
                        for(Customer_Pay_Plan_Header__c cpph : CPPHList){
                            system.debug('Inside cpph for');
                            cpph.Customer__c =   boookingObj.Opportunity__c;
                            cpph.Booking__c = boookingObj.id;
                            CPPHListToAdd.add(cpph);
                         }
                    }
                   update  CPPHListToAdd;
                   
                } catch (DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
    
                }
                try {
                //Updating Quotation with new booking
                    if (QuoteDetails.size() > 0) {
                        QuoteDetails[0].Booking__c =  boookingObj.id;
                        update QuoteDetails;
                    }
                } catch (DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
    
                }
                 try {
                //Updating created receiptObj with new booking
                   for(Receipt__c rct : ReceiptLstTobeUpdate)
                   {
                   if (rct.id !=  null) 
                   {
                        rct.Booking__c =  boookingObj.id;
                        rct.Project_Unit__c = boookingObj.Unit_No__c;
                        update rct;
                   }
                 }
                } catch (DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
    
                }
              
                try {
                system.debug('this use vikas receipt:::: '+ReceiptDetails.size());
                //Updating ReceiptDetails  with new booking
                    if (ReceiptDetails.size() >0)
                    {
                      
                      for(Receipt__c r : ReceiptDetails){
                            r.Booking__c =  boookingObj.id;
                            r.Opportunity_Email_Id__c=applicant.Email_Address__c;
                            if(r.Project_Unit__c == null)
                            {
                                r.Project_Unit__c = boookingObj.Unit_No__c;
                            } 
                            if(boookingObj.Project__c != null)
                            {
                            
                                r.Project__c = boookingObj.Project__c;
                            }
                            ListOldReceipt.add(r);
                        } 
                        
                    }
                 //Updating ReceiptDetails  with new booking
                    if (STReceiptDetails.size() >0)
                    {
                      for(Receipt__c st : STReceiptDetails){
                            st.Booking__c =  boookingObj.id;
                            st.Opportunity_Email_Id__c=applicant.Email_Address__c;
                            if(st.Project_Unit__c == null)
                            {
                                st.Project_Unit__c = boookingObj.Unit_No__c;
                                
                            } 
                            if(boookingObj.Project__c != null)
                            {
                            
                                st.Project__c = boookingObj.Project__c;
                            }
                            ListOldReceipt.add(st);
                        } 
                        
                    }   
                    
                    update ListOldReceipt;
                } catch (DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
    
                }
                
           
            
           
            //inserting the Applicants
            if (applicant.Name != ''&& applicant.Name != null) {
                if (addressCheck == true) {
                    applicant.Mailing_Address_same_as_PermanentAddress__c = true;
                    applicant.Mailing_Address__c = applicant.Permanent_Address__c;
                    applicant.Mailing_Pincode__c = applicant.Pincode__c;
                    applicant.Mailing_Country__c = applicant.Country__c;
                    applicant.Mailing_State__c = applicant.State__c;
                    applicant.Mailing_City__c = applicant.City__c;
                }
                
                applicant.Applicant_Number__c = 'Primary Applicant';
                applicant.Booking__c = boookingObj.id;
                applicant.Opportunity__c = boookingObj.Opportunity__c;
                listApplicant.add(applicant);
            }
            if (applicant2.Name != '' && applicant2.Name != null) {
                if (addressCheckApplicant2 == true) {
                    applicant2.Mailing_Address_same_as_PermanentAddress__c = true;
                    applicant2.Mailing_Address__c = applicant2.Permanent_Address__c;
                    applicant2.Mailing_Pincode__c = applicant2.Pincode__c;
                    applicant2.Mailing_Country__c = applicant2.Country__c;
                    applicant2.Mailing_State__c = applicant2.State__c;
                    applicant2.Mailing_City__c = applicant2.City__c;

                }

                applicant2.Applicant_Number__c = 'Second Applicant';
                applicant2.Booking__c = boookingObj.id;
                applicant2.Opportunity__c = boookingObj.Opportunity__c;
                listApplicant.add(applicant2);
            }
            if (applicant3.Name != '' && applicant3.Name != null) {
                if (addressCheckApplicant3 == true) {
                    applicant3.Mailing_Address_same_as_PermanentAddress__c = true;
                    applicant3.Mailing_Address__c = applicant3.Permanent_Address__c;
                    
                    
                    
                    
                    
                    
                    applicant3.Mailing_Pincode__c = applicant3.Pincode__c;
                    applicant3.Mailing_Country__c = applicant3.Country__c;
                    applicant3.Mailing_State__c = applicant3.State__c;
                    applicant3.Mailing_City__c = applicant3.City__c;
                }
                applicant3.Applicant_Number__c = 'Third Applicant';
                applicant3.Booking__c = boookingObj.id;
                applicant3.Opportunity__c = boookingObj.Opportunity__c;
                listApplicant.add(applicant3);
            }
            if (applicant4.Name != null) {
                if (addressCheckApplicant4 == true) {
                    applicant4.Mailing_Address_same_as_PermanentAddress__c = true;
                    applicant4.Mailing_Address__c = applicant4.Permanent_Address__c;
                    applicant4.Mailing_Pincode__c = applicant4.Pincode__c;
                    applicant4.Mailing_Country__c = applicant4.Country__c;
                    applicant4.Mailing_State__c = applicant4.State__c;
                    applicant4.Mailing_City__c = applicant4.City__c;
                }
                applicant4.Applicant_Number__c = 'Fourth Applicant';
                applicant4.Booking__c = boookingObj.id;
                applicant4.Opportunity__c = boookingObj.Opportunity__c;
                listApplicant.add(applicant4);
            }
            if (applicant5.Name != null) {
                if (addressCheckApplicant5 == true) {
                    applicant5.Mailing_Address_same_as_PermanentAddress__c = true;
                    applicant5.Mailing_Address__c = applicant5.Permanent_Address__c;
                    applicant5.Mailing_Pincode__c = applicant5.Pincode__c;
                    applicant5.Mailing_Country__c = applicant5.Country__c;
                    applicant5.Mailing_State__c = applicant5.State__c;
                    applicant5.Mailing_City__c = applicant5.City__c;
                }
                applicant5.Applicant_Number__c = 'Fifth Applicant';
                applicant5.Booking__c = boookingObj.id;
                applicant5.Opportunity__c = boookingObj.Opportunity__c;
                listApplicant.add(applicant5);
            }
            system.debug('listApplicant' + listApplicant);
             try
                 {
                     if(listApplicant.size() >0){
                        insert listApplicant;
                     }
                   /*  if(listReceiptDetails.size() > 0){
                       insert listReceiptDetails; 
                     } */
                     
                     //system.debug('listReceiptDetails::::'+listReceiptDetails);
                 }                 
            catch (DmlException e) 
                 {
                    System.debug('An error has occured. Please contact your administrator. : ' + e.getMessage());
                 }   
            }
            //System.Debug('ReceiptObj'+ReceiptObj);
            System.Debug('Booking Obj' + boookingObj);
            if (boookingObj.id != null) {
                PageReference newpage = new Pagereference('/' + boookingObj.id);
                newpage.setRedirect(true);
                return newpage;
            }

        }
        return null;
    }
    public PageReference Cancel() {
        if (boookingObj.Opportunity__c != null) {
                PageReference newpage = new Pagereference('/' + boookingObj.Opportunity__c);
                newpage.setRedirect(true);
                return newpage;
            }
        return null;
    }
}