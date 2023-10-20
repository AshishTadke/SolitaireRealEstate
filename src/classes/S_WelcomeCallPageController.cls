public class S_WelcomeCallPageController {
    public Welcome_Call_Header__c objWCH {
        get;
        set;
    }
    public Receipt__c ReceiptToken {
        get;
        set;
    }
    public List < Welcome_Call_Header__c > WCHList {
        get;
        set;
    }
    public List < Receipt__c > ReceiptTokenList {
        get;
        set;
    }
    public List < Applicant_Details__c > applicantList {
        get;
        set;
    }
    List < Welcome_Call_Checklist__c > ListWCCToInsert = new list < Welcome_Call_Checklist__c > ();
    List < User > LstUsersProjectCRMLead {
        get;
        set;
    }
    List < User > LstUsersProjectSalesHead {
        get;
        set;
    }
    public Integer i;
    public Welcome_Call_Checklist__c objWCC1 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC2 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC3 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC4 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC5 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC6 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC7 {
        get;
        set;
    }

    ////////////Welcome call checklist for Generic Details////////////
    public Welcome_Call_Checklist__c objWCC31 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC32 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC34 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC35 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC36 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC37 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC38 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC39 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC40 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC42 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC44 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC45 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC46 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC47 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC48 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC49 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC50 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC51 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC52 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC53 {
        get;
        set;
    }
    public Welcome_Call_Checklist__c objWCC54 {
        get;
        set;
    }
    //Added on 29/12/15
    public Welcome_Call_Checklist__c objWCC56 {
        get;
        set;
    }
    public String alotment {
        get;
        set;
    }
    //Specific to process method
    public list < Booking__c > lstbookingToMapMilstone;
    public string oppidforreciept;
    public string Coowners {
        get;
        set;
    }
    public list < Receipt__c > lstReceipt;
    public Project_Unit__c objProjUnit {
        get;
        set;
    }
    public Unit_Event_History__c objUnitEventHistory {
        get;
        set;
    }

    //old declarations
    public Welcome_Call_Details__c objWCD {
        get;
        set;
    }
    public Task objTask {
        get;
        set;
    }
    public Booking__c objBooking {
        get;
        set;
    }
    public list < User > lstusers {
        get;
        set;
    }
    public list < Booking__c > lstBooking {
        get;
        set;
    }
    public opportunity objopp {
        get;
        set;
    }
    public Account objAcc {
        get;
        set;
    }
    public Opportunity objOpportunity {
        get;
        set;
    }
    public boolean ShowHidePopUp {
        get;
        set;
    }
    public date tokenReceiptDate {
        get;
        set;
    }

    public boolean IsRejected {
        get;
        set;
    }
    public boolean ReceiptProcessed {
        get;
        set;
    }

    public decimal AgreementValue {
        get;
        set;
    }
    public decimal BookingAmount {
        get;
        set;
    }
    public String baseUrl {
        get;
        set;
    }
    public string bookingId {
        get;
        set;
    }
    public Date tokenDate {
        get;
        set;
    }
    public string strbroker {
        get;
        set;
    }
    public string strcoOwner {
        get;
        set;
    }
    public string strcoOwner2 {
        get;
        set;
    }
    public string strcoOwner3 {
        get;
        set;
    }
    public string strcoOwner4 {
        get;
        set;
    }
    public boolean forcoCowner1 {
        get;
        set;
    }
    public boolean forcoCowner2 {
        get;
        set;
    }
    public boolean forcoCowner3 {
        get;
        set;
    }
    public boolean forcoCowner4 {
        get;
        set;
    }
    public string strExpect {
        get;
        set;
    }
    public string fundingdetail {
        get;
        set;
    }
    public string deliverydetail {
        get;
        set;
    }
    public Boolean BooExpect {
        get;
        set;
    }
    public Boolean BooSuccess {
        get;
        set;
    }
    public String ermsg {
        get;
        set;
    }
    public S_WelcomeCallPageController() {

        //old constructor
        baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        fundingdetail = '';
        alotment = '';
        deliverydetail = '';
        Coowners = '';
        BooSuccess = true;
        IsRejected = false;
        objWCD = New Welcome_Call_Details__c();
        objBooking = New Booking__c();
        objTask = new Task();
        objopp = new opportunity();
        WCHList = new List < Welcome_Call_Header__c > ();
        objWCH = new Welcome_Call_Header__c();
        LstUsersProjectCRMLead = new List < User > ();
        LstUsersProjectSalesHead = new List < User > ();
        ReceiptProcessed = false;
        ermsg = 'no';

        if (ApexPages.currentPage().getParameters().get('id') != null && ApexPages.currentPage().getParameters().get('id') != '')
            bookingId = ApexPages.currentPage().getParameters().get('id');
        string UserId = UserInfo.getUserId();
        if (bookingId != null && bookingId != '') {
            lstBooking = New list < Booking__c > ([select id, Owner.Id, Owner.Phone, Sales_Manager__c, Project__r.Project_CRM_Lead__c, Project__r.Project_Site_Head__c, Name, Direct__c, Customer__c, Customer__r.Salutation__c, Customer__r.Existing_Customer__c, Customer__r.Adhoc_Exception_Comments__c, Customer__r.I_I_A_Comments__c, Customer__r.Architectural_Change_Comments__c, customer__r.Payment_Plan_Comments__c, Customer__r.name, Customer__r.PAN_Card_No__c, Customer__r.Email__c, Customer__r.Project_Unit__r.name, Unit_No__r.name, Customer__r.Broker__r.name,
                Unit_No__r.Unit_Status__c, Unit_No__r.Reason_For_CRM_returns_to_sales__c, Call_Disposition__c, Status__c, Source_of_Booking__c, Sub_Source__c, Source_Details__c, Wing__c, Flat_Typology__c, Zone__c, Floor__c,Floor1__c, Flat_No__c, Carpet_Area__c, No_of_Parking__c, Parking_Type__c, Allotment_Premium__c, Unit_No__c, Unit_No__r.Param2__c, Call_Centre_Rep__c, Customer__r.Bank_Loan_Self_Funded__c, /**Customer__r.Account.personemail, **/ Customer__r.Account.Name, Customer__r.Rate_Comments__c,
                Customer__r.Account.Code__c, Opportunity__c,Send_Welcome_Email__c, Opportunity__r.Account.Id, Customer__r.Account.Correspondence_Address__c, Project__r.Name, Customer__r.Architectural_Change__c, Customer__r.Payment_Plan_Fixed__c, Customer__r.Rate__c,Unit_No__r.Exclusive_Area__c,
                Customer__r.Account.Birth_Date__c, OwnerId, Customer__r.Account.Do_Not_Call__c, Owner.Name, Project__r.Token_Amount__c, Customer__r.Account.OwnerId, Customer__r.Booking_Channel_Partner__c, Customer__r.Booking_Channel_Partner__r.name,
                /**Customer__r.Account.PersonMobilePhone,**/ Customer__r.Account.Id, Customer__r.Adhoc_Exception__c, Customer__r.Interior_Internal_Amenities_of_the_Unt__c, Customer__r.owner.email,
                Customer__r.Account.Phone, Customer__r.RD_Special_Deviations__c, Customer__r.Special_Deviations__c, Project__r.Forefeiting__c, owner.Email, Quotation__r.Id, Funding_Status__c,Quotation__r.Total_Stack__c,Quotation__r.Total_New_Stack__c,Quotation__r.Total_Independent__c,Quotation__r.Total_Dependent__c,Quotation__r.Total_Puzzle__c,Quotation__r.Total_Dependable_Stack__c,Quotation__r.Two_Wheeler_Additional__c,
                Customer__r.Co_Owner1__r.name, Customer__r.Co_Owner2__r.name, Customer__r.Co_Owner3__r.name, Customer__r.Co_Owner4__r.name, Customer__r.POI_Card_No__c,
                Customer__r.Co_Owner1__r.Pan__c, Customer__r.Co_Owner2__r.Pan__c, Customer__r.Co_Owner3__r.Pan__c, Customer__r.Co_Owner4__r.Pan__c, Receipts__r.Receipt_Date__c, Receipts__c, (Select id, Net_Cost__c, Amount__c, Charge__r.Name from SABookingDetails__r), (select id, name, Car_Parking_Charge__r.name, Car_Parking_Charge__r.Parking_Slot_No__c, Car_Parking_Charge__r.Car_Type__c, Car_Parking_Charge__r.Parking__c from Booked_Car_Parking__r)
                from Booking__c where id = : bookingId AND(Unit_No__r.Unit_Status__c = 'Welcome Call Pending'
                    OR(Unit_No__r.Unit_Status__c = 'CRM Returned To Sales'
                        AND Unit_No__r.Reason_For_CRM_returns_to_sales__c = 'Welcome Call Rejected')) AND Status__c = 'Booking In Process'
            ]); //AND OwnerId =: UserId commented by vikas
            system.debug('UserId::: ' + bookingId);
            system.debug('UserId::: ' + UserId);
            system.debug('lstBooking :- ' + lstBooking.size());

            if (lstBooking != null && lstBooking.size() > 0) {
                //Anuja added on 29/12/15
                if (alotment != null && lstBooking[0].Allotment_Premium__c != null)
                    alotment = QuotationManagementServices1.INFormat(lstBooking[0].Allotment_Premium__c);


                if (lstBooking[0].Status__c == 'Cancelled') {
                    ermsg = 'yes';
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Welcome call for this booking cannot be processed because the booking has been cancelled. Please contact your administrator for further information.'));
                } else {
                    if (lstBooking[0].Call_Disposition__c != 'Welcome call accepted' && (lstBooking[0].Unit_No__r.Unit_Status__c == 'Welcome Call Pending' || (lstBooking[0].Unit_No__r.Unit_Status__c == 'CRM Returned To Sales' && lstBooking[0].Unit_No__r.Reason_For_CRM_returns_to_sales__c == 'Welcome Call Rejected'))) {
                        lstusers = [select id, Name, Mobilephone, Email from user where id = : lstBooking[0].OwnerId];
                        system.debug('lstusers' + lstusers);
                        objBooking = lstBooking[0];
                        if (objBooking.Receipts__c != null && objBooking.Receipts__r.Receipt_Date__c != null)
                            tokenDate = objBooking.Receipts__r.Receipt_Date__c;
                        system.debug('objBooking' + objBooking);
                        if (objBooking.Customer__c != null) {
                            System.Debug('there is a customer on the booking');
                            if (objBooking.Customer__r.Co_Owner1__c != null && objBooking.Customer__r.Co_Owner1__r.name != null) {
                                strcoOwner = objBooking.Customer__r.Co_Owner1__r.name;
                                forcoCowner1 = true;
                            } else
                                forcoCowner1 = false;

                            if (objBooking.Customer__r.Co_Owner2__c != null && objBooking.Customer__r.Co_Owner2__r.name != null) {
                                forcoCowner2 = true;
                                strcoOwner2 = objBooking.Customer__r.Co_Owner2__r.name;
                            } else
                                forcoCowner2 = false;

                            if (objBooking.Customer__r.Co_Owner3__c != null && objBooking.Customer__r.Co_Owner3__r.name != null) {
                                strcoOwner3 = objBooking.Customer__r.Co_Owner3__r.name;
                                forcoCowner3 = true;
                            } else
                                forcoCowner3 = false;

                            if (objBooking.Customer__r.Co_Owner4__c != null && objBooking.Customer__r.Co_Owner4__r.name != null) {
                                strcoOwner4 = objBooking.Customer__r.Co_Owner4__r.name;
                                forcoCowner4 = true;
                            } else
                                forcoCowner4 = false;

                            if (objBooking.Customer__r.Booking_Channel_Partner__c != null) {
                                if (objBooking.Customer__r.Booking_Channel_Partner__r.name != null && objBooking.Customer__r.Booking_Channel_Partner__r.name != '')
                                    strbroker = objBooking.Customer__r.Booking_Channel_Partner__r.name;
                            } else if (objBooking.Direct__c == true)
                                strbroker = 'Direct';

                            if (objBooking.Customer__r.Adhoc_Exception__c == false && objBooking.Customer__r.Interior_Internal_Amenities_of_the_Unt__c == false && objBooking.Customer__r.Architectural_Change__c == false && objBooking.Customer__r.Payment_Plan_Fixed__c == false && objBooking.Customer__r.Rate__c == false) {
                                strExpect = 'No special deviation applied';
                                BooExpect = true;
                            } else
                                BooExpect = false;
                            System.Debug('All the way through with the customer on the booking');
                        }

                        list < Receipt__c > lstReceipt = [select id, name, Total_Amount__c, Cheque_DD_Date__c, Token_Amount_Receipt__c, Receipt_Status__c, Receipt_Date__c, Physically_Cheque_Received__c, mode__c from Receipt__c where Opportunity__c = : objBooking.Customer__c AND Project_Unit__c = : objBooking.Unit_No__c];
                        System.Debug('And here is the receipt' + lstReceipt);
                        if (lstReceipt != null && lstReceipt.size() > 0) {
                            BookingAmount = 0;
                            for (Receipt__c objRec: lstReceipt) {
                                if (objRec.Token_Amount_Receipt__c == true) {
                                    System.Debug('Receipt' + objRec.id);
                                    System.Debug('Inside the receipt block' + objRec.Total_Amount__c);
                                    System.Debug('Inside the receipt block' + objRec.Receipt_Date__c);
                                    BookingAmount += objRec.Total_Amount__c;
                                    tokenReceiptDate = objRec.Receipt_Date__c;
                                }
                            }
                        }
                        System.debug('Just before the SABooking condition');
                        if (objBooking.SABookingDetails__r != null && objBooking.SABookingDetails__r.size() > 0) {
                            System.debug('Inside SABooking condition');
                            AgreementValue = 0;
                            for (Booking_Details__c objBD: objBooking.SABookingDetails__r) {
                                if (objBD.Charge__r.name != null && objBD.Charge__r.name.toLowerCase() == 'basic' && objBD.Amount__c != null)
                                    AgreementValue += objBD.Amount__c;
                            }
                        }
                        System.debug('Outside SABooking condition');


                        // anuja's constructor
                        // Anuja quering welcome call header for this booking 
                        WCHList = [SELECT ID, Name, Owner.Name, Call_Disposition__c, Call_Date__c, Remarks__c FROM Welcome_Call_Header__c Where Booking__c = : lstBooking[0].id ORDER BY CreatedDate DESC];
                        System.Debug('lstBooking[0].id ' + lstBooking[0].id);
                        // WCC object declarations
                        objWCC1 = New Welcome_Call_Checklist__c();
                        objWCC2 = New Welcome_Call_Checklist__c();
                        objWCC3 = New Welcome_Call_Checklist__c();
                        objWCC4 = New Welcome_Call_Checklist__c();
                        objWCC5 = New Welcome_Call_Checklist__c();
                        objWCC6 = New Welcome_Call_Checklist__c();

                        if (lstBooking[0].Customer__c != null) {
                            // Anuja quering token receipt for the opportunity of booking 
                            System.Debug('WCHList ' + WCHList);
                            ReceiptTokenList = [SELECT ID, Cheque_DD__c, Cheque_DD_Date__c, Cheque_DD_Amount_Rs__c, DraweeBank__c, Branch__c, NEFT__c, RTGS__c, Challan_No__c, Pay_Order__c FROM Receipt__c Where Opportunity__c = : lstBooking[0].Customer__c and Token_Amount_Receipt__c = true];
                        }
                        if (ReceiptTokenList.size() > 0)
                            ReceiptToken = ReceiptTokenList[0];
                        System.Debug('ReceiptTokenList' + ReceiptTokenList);

                        //Fetch the list of applications for the bookingid provided in the URL
                        applicantList = [Select Id, OwnerId, IsDeleted, Name, Salutation__c, DOB__c, BookingDetails__c, Type_Of_Applicant__c, Pancard__c, PancardNo__c,
                            Landline_Number__c, Permanent_Address__c, Mailing_Address__c, Mailing_Country__c, Mailing_Pincode__c, Country__c, Pincode__c, Email_Address__c, Mobile_Number__c, Address_Proof_Document__c, Subtype_Of_Applicant__c, PassportNumber__c, Funds_from_NRE_FCNR__c, Self_attested_copy_of_PIO_or_OCI_Card__c, PassportNoDetails__c,
                            Funds_from_NRE_NRO__c, Copy_of_Workpermit_Employment_contract__c, Copy_of_Memorandu_of_Association__c, Certified_copy_of_Article_of_Association__c, Certified_copy_of_Board_Resolution__c, Certified_copy_of_ROC_Incorporation__c, Self_attested_List_of_Shareholders__c,
                            Self_attested_List_of_Directors__c, PanCard_of_Authority_Signatory__c, Certified_copy_of_Partnership_Deed__c, Pan_Card_Number_of_Authority_Signatory__c, Certified_extract_of_Registration__c, Copy_of_Authorization_Letter_POA__c, Address_Proof__c, Address_Proof_Number__c, One_Passport_Size_Color_Photograph__c, Type_Of_Origin__c, Origin_Details__c, Booking__c, Applicant_Number__c FROM Applicant_Details__c WHERE Booking__c = : bookingId
                        ];


                        /////////////////////////////Applicant 1 /////////////////////////////// 
                        if (applicantList.size() > 0) {

                            //Name of welcome call checklists
                            objWCC1.Name = 'Applicant 1 Name';
                            objWCC2.Name = 'Applicant 1 Email';
                            objWCC3.Name = 'Applicant 1 Mobile No.';

                            objWCC6.Name = 'Applicant 1 Permanent Address';

                            //Detail of welcome call checklists
                            objWCC1.Detail__c = applicantList[0].Name;
                            objWCC2.Detail__c = applicantList[0].Email_Address__c;
                            objWCC3.Detail__c = applicantList[0].Mobile_Number__c;
                            String applicantDOB1 = String.valueOf(applicantList[0].DOB__c);

                            objWCC6.Detail__c = applicantList[0].Permanent_Address__c + ',' + applicantList[0].Country__c + ',' + applicantList[0].Pincode__c;
                        }
                        /////////////////////////////Applicant 2 ///////////////////////////////
                        if (applicantList.size() > 1) {
                            objWCC7 = New Welcome_Call_Checklist__c();

                            //Name of welcome call checklists
                            objWCC7.Name = 'Name(s) of Co-Owners';

                            //Detail of welcome call checklists
                            if (applicantList[1].Salutation__c != null && applicantList[1].Salutation__c != ' ')
                                Coowners = applicantList[1].Salutation__c + ' ' + applicantList[1].Name; /// commented by vikas
                            else
                                Coowners = applicantList[1].Name;

                        }
                        /////////////////////////////Applicant 3 ///////////////////////////////
                        if (applicantList.size() > 2) {
                            if (applicantList[2].Salutation__c != null && applicantList[2].Salutation__c != ' ')
                                Coowners = Coowners + ' , ' + applicantList[2].Salutation__c + ' ' + applicantList[2].Name;
                            else
                                Coowners = applicantList[2].Name;

                        }
                        /////////////////////////////Applicant 4 ///////////////////////////////
                        if (applicantList.size() > 3) {



                            //Detail of welcome call checklists
                            if (applicantList[3].Salutation__c != null && applicantList[3].Salutation__c != ' ')
                                Coowners = Coowners + ' , ' + applicantList[3].Salutation__c + ' ' + applicantList[3].Name;
                            else
                                Coowners = applicantList[3].Name;
                        }
                        /////////////////////////////Applicant 5 ///////////////////////////////
                        if (applicantList.size() > 4) {


                            //Detail of welcome call checklists
                            if (applicantList[4].Salutation__c != null && applicantList[4].Salutation__c != ' ')
                                Coowners = Coowners + ' , ' + applicantList[4].Salutation__c + ' ' + applicantList[4].Name;
                            else
                                Coowners = applicantList[4].Name;

                        }

                        /////////////////////////////Generic Details ///////////////////////////////
                        objWCC31 = New Welcome_Call_Checklist__c();
                        objWCC31.Name = 'Project';
                        objWCC31.Detail__c = lstBooking[0].Project__r.Name;
                        /////////////////////////////
                        objWCC32 = New Welcome_Call_Checklist__c();
                        objWCC32.Name = 'Flat Typology';
                        objWCC32.Detail__c = lstBooking[0].Flat_Typology__c;
                        ///////////////ZONE///////////////

                        /////////////////////////////
                        objWCC34 = New Welcome_Call_Checklist__c();
                        objWCC34.Name = 'Wing';
                        objWCC34.Detail__c = lstBooking[0].Wing__c;
                        /////////////////////////////
                        objWCC35 = New Welcome_Call_Checklist__c();
                        objWCC35.Name = 'Floor';
                        objWCC35.Detail__c = lstBooking[0].Floor1__c;
                        /////////////////////////////
                        objWCC36 = New Welcome_Call_Checklist__c();
                        objWCC36.Name = 'Flat No';
                        objWCC36.Detail__c = lstBooking[0].Flat_No__c;
                        /////////////////////////////
                        objWCC37 = New Welcome_Call_Checklist__c();
                        objWCC37.Name = 'Carpet Area';
                        objWCC37.Detail__c = String.valueOf(lstBooking[0].Carpet_Area__c);
                        /////////////////////////////
                        objWCC38 = New Welcome_Call_Checklist__c();
                        objWCC38.Name = 'No Of Parkings';
                        objWCC38.Detail__c = String.valueOf(lstBooking[0].No_of_Parking__c);
                        /////////////////////////////
                        objWCC39 = New Welcome_Call_Checklist__c();
                        objWCC39.Name = 'Parkings Type';
                        objWCC39.Detail__c = lstBooking[0].Parking_Type__c;
                        /////////////////////////////
                        objWCC40 = New Welcome_Call_Checklist__c();
                        objWCC40.Name = 'Allotment Premium(Agreement value)';
                        objWCC40.Detail__c = String.valueOf(lstBooking[0].Allotment_Premium__c);
                        /////////////BOOKING TOKEN AMOUNT////////////////

                        /////////////////////////////
                        objWCC42 = New Welcome_Call_Checklist__c();
                        objWCC42.Name = 'Payment Plan';
                        objWCC42.Detail__c = '';
                        /////////////////////////////

                        /////////////////////////////
                        objWCC44 = New Welcome_Call_Checklist__c();
                        objWCC44.Name = 'Source Of Booking';
                        objWCC44.Detail__c = lstBooking[0].Source_of_Booking__c + '-' + lstBooking[0].Sub_Source__c + lstBooking[0].Source_Details__c;
                        /////////////////////////////Payment Options/////////////////////////////
                        objWCC45 = New Welcome_Call_Checklist__c();
                        objWCC45.Name = 'How would you want to pay for the unit';
                        fundingdetail = objWCC45.Funding__c;
                        objWCC45.Detail__c = fundingdetail;
                        /////////////////////////////
                        objWCC46 = New Welcome_Call_Checklist__c();
                        objWCC46.Name = 'How would you prefer your invoices and receipts going forward';
                        deliverydetail = objWCC46.Delivery_of_Invoices_and_receipts__c;
                        objWCC46.Detail__c = deliverydetail;
                        /////////////////////////////RM Details /////////////////////////////
                        objWCC47 = New Welcome_Call_Checklist__c();
                        objWCC47.Name = 'RM Name';
                        objWCC47.Detail__c = lstusers[0].Name;
                        /////////////////////////////
                        objWCC48 = New Welcome_Call_Checklist__c();
                        objWCC48.Name = 'RM Contact Number';
                        objWCC48.Detail__c = lstusers[0].Mobilephone;
                        /////////////////////////////
                        objWCC49 = New Welcome_Call_Checklist__c();
                        objWCC49.Name = 'RMs Work Hours';
                        objWCC49.Detail__c = '9:30 to 7:30,Mon to Sat';
                        /////////////////////////////
                        objWCC50 = New Welcome_Call_Checklist__c();
                        objWCC50.Name = 'RMs Email';
                        objWCC50.Detail__c = lstusers[0].Email;
                        /////////////////////////////
                        objWCC51 = New Welcome_Call_Checklist__c();
                        objWCC51.Name = 'RMs Care Desk Number';
                        objWCC51.Detail__c = '18001219090';
                        /////////////////////////////
                        objWCC52 = New Welcome_Call_Checklist__c();
                        objWCC52.Name = 'RMs Care Desk Work Hours';
                        objWCC52.Detail__c = '9:30 to 7:30,Mon to Sat';
                        /////////////////////////////
                        objWCC53 = New Welcome_Call_Checklist__c();
                        objWCC53.Name = 'Desclaimers for DND';
                        objWCC53.Detail__c = 'Dear' + objbooking.Customer__r.Salutation__c + objbooking.Customer__r.Name + ', I would also want to take this opportunity to seek your permission for sharing updates regarding our projects and promotions in future. Also, I want to ensure that you do not miss out on any of the important communications, hence going forward we shall send Emails and SMSs to you as and when we wish to update you with and important piece of information. May I confirm your agreement on the same.';
                        /////////////////////////////
                        objWCC54 = New Welcome_Call_Checklist__c();
                        objWCC54.Name = 'Desclaimers for Forfeiture';
                        objWCC54.Detail__c = 'Dear ' + objbooking.Customer__r.Salutation__c + objbooking.Customer__r.Name + ' as a process we are supposed to inform you that incase you cancel thesaid application,without any default at our end,there shall be a forfeiture charge which is ' + objbooking.Project__r.Forefeiting__c + '% of the agreement value';
                        /////////////////////////////
                        //Added on 29/12/15
                        objWCC56 = New Welcome_Call_Checklist__c();
                        objWCC56.Name = 'Payments Made';
                        objWCC56.Detail__c = 'Payment Made Details';
                        // anuja's constructor ends here 

                    } else {
                        ermsg = 'yes';
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Welcome call for this booking has already been processed. Please contact your administrator for further information.');
                        ApexPages.addMessage(myMsg);
                    }
                }
            } else {
                System.Debug('Inside Error Message Block');
                ermsg = 'yes';
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Welcome call for this booking cannot be processed. Either the unit is not in (Welcome Call Pending) status or you do not have the necessary authorization.');
                ApexPages.addMessage(myMsg);
            }

        }
        system.debug('eeeeeeeeeerr' + ermsg);
    }
    public pageReference OpenPejectedPage() {

        return null;

    }
    public PageReference Reject() {
        if (objopp.Reason_For_Rejection__c != null) {
            if (objBooking != null && objBooking.Unit_No__c != null) {
                project_unit__c objPrjUnit = New project_unit__c();
                objPrjUnit.id = objBooking.Unit_No__c;
                objPrjUnit.Unit_Status__c = 'CRM Returned To Sales';
                objPrjUnit.Reason_For_CRM_returns_to_sales__c = 'Welcome Call Rejected';
                update objPrjUnit;

                objopp.id = objBooking.Customer__c;
                update objopp;
                if (objBooking != null) {
                    objBooking.Call_Disposition__c = objWCD.Call_Disposion__c;
                    objBooking.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                    objBooking.Welcome_Call_Done_By__c = UserInfo.getUserId();
                    objBooking.Last_Call_Date__c = system.now();
                    objBooking.Call_Back_Date__c = null;
                    system.debug('Before Updating  objBooking : ' + objBooking);

                    update objBooking;
                    system.debug('Updated  objBooking : ' + objBooking);
                }
                BooSuccess = false;
                ApexPages.PageReference page = new ApexPages.PageReference('/' + objBooking.id);
                return page;
            } else {
                BooSuccess = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning, 'No unit found against this booking.'));
                return null;
            }

        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'You must enter the Remarks'));
            return null;
        }
    }


    public void closePopup() {
        ShowHidePopUp = false;
    }
    public void showPopup() {
        ShowHidePopUp = true;
    }

    public pagereference Accept() {
        try {
            System.debug('Inside Accept Method');
            objWCD.Customer__c = objBooking.Customer__c;
            upsert objWCD;
            system.debug('Upserted objWCD : ' + objWCD);
            system.debug('1.objBooking xxxxx ' + objBooking);
            if (objBooking != null) {
                system.debug('2.inside objBooking xxxxx ' + objBooking);
                objBooking.Call_Disposition__c = objWCD.Call_Disposion__c;
                objBooking.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                objBooking.Welcome_Call_Done_By__c = UserInfo.getUserId();
                objBooking.Last_Call_Date__c = system.now();
                objBooking.Call_Back_Date__c = null;
                objBooking.Funding_Status__c = objWCC45.Funding__c;
                objBooking.Bank_Loan_Status__c = objWCC45.Bank_Loan_Status__c;
                objBooking.Dispatch_Mode__c = objWCC46.Delivery_of_Invoices_and_receipts__c;
                objBooking.Status__c = 'Processed';
                system.debug('Before Updating  objBooking : ' + objBooking);
                update objBooking;
                system.debug('Updated  objBooking : ' + objBooking);
            }
            system.debug('3.lstBooking.size() xxxxx ' + lstBooking.size());
            if (lstBooking != null && lstBooking.size() > 0) {
                system.debug('4.inside  lstBooking.size() xxxxx ' + lstBooking.size());
                //////////////////////////Updating Opty/////////////////////////////                     
                objOpportunity = new opportunity();
                objOpportunity.Id = lstBooking[0].Customer__c;
                objOpportunity.Bank_Loan_Self_Funded__c = objWCC45.Funding__c;
                objOpportunity.Bank_Loan_Stage__c = objWCC45.Bank_Loan_Status__c;
                objOpportunity.Dispatch_Mode__c = objWCC46.Delivery_of_Invoices_and_receipts__c;
                objOpportunity.Existing_Customer__c = true;
                objOpportunity.StageName = 'Booking confirmed';
                System.debug('Before Updating  objOpportunity : ' + objOpportunity);
                update objOpportunity;
                system.debug('Updated  objOpportunity : ' + objOpportunity);

                //////////////////////////Updating Project Unit/////////////////////////////
                objProjUnit = new Project_Unit__c(id = lstBooking[0].Unit_No__c);
                objProjUnit.Unit_Status__c = 'Sold';
                objProjUnit.Customers__c = lstBooking[0].Customer__c;
                objProjUnit.Booking__c = lstBooking[0].Id;
                System.debug('Before Updating  objProjUnit : ' + objProjUnit);
                update objProjUnit;
                System.debug('Updated  objProjUnit : ' + objProjUnit);

                /////////////////////////////Updating Unit History//////////////////////////
                //Insert in UnitEventHistory    
                objUnitEventHistory = new Unit_Event_History__c();
                objUnitEventHistory.Booking__c = lstBooking[0].Id;
                objUnitEventHistory.Customer__c = lstBooking[0].Customer__c;
                objUnitEventHistory.Date_Unit__c = lstBooking[0].Unit_No__c;
                string Remark = '';
                Remark = 'Unit has been Booked by [' + lstBooking[0].Customer__r.Account.Code__c + ']-[' + lstBooking[0].Customer__r.Name + ']';
                System.Debug('Unit Event History' + objUnitEventHistory);
                objUnitEventHistory.Remarks__c = Remark;
                objUnitEventHistory.Event__c = 'Sold';
                System.debug('Before Updating  objUnitEventHistory : ' + objUnitEventHistory);
                insert objUnitEventHistory;
                System.debug('Updated  objUnitEventHistory : ' + objUnitEventHistory);



                //////////////////////////Sending Email//////////////////////////////////////                
                System.Debug('Inside the email logic');
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List < String > sendTo = new List < String > ();
                if (lstBooking[0].owner.email != null && lstBooking[0].owner.email != '')
                    sendTo.add(lstBooking[0].owner.email);
                system.debug('6.sendTo.size() xxxx' + sendTo.size());
                if (sendTo != null && sendTo.size() > 0) {
                    mail.setToAddresses(sendTo);
                    string subject = 'Demand Invoice for Project Unit ' + lstBooking[0].Unit_No__r.name;
                    mail.setSubject(subject);

                    String body = 'Hi ' + lstBooking[0].Owner.Name + ',<br/><br/>';
                    body += 'A unit has been Sold. A link has been sent to you to generate On booking Demand Generation. <br/> Find the details below:<br/><br/>';
                    body += 'Customer - ' + lstBooking[0].Customer__r.Name + '<br/>';
                    body += 'Project - ' + lstBooking[0].Project__r.Name + '<br/>';
                    body += 'Project Unit - ' + lstBooking[0].Unit_No__r.name + '<br/><br/>';
                    body += 'Please find the link below to generate the on booking demand letter.<br/><br/><br/>';
                    body += '' + baseUrl + '/apex/S_sendDemandInvoice2?bookingId=' + objBooking.id + '<br/><br/><br/>';
                    body += 'Thanks & Regards,<br/>Solitaire Team';

                    mail.setHtmlBody(body);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                        mail
                    });
                    System.Debug('Sent email to ' + sendTo);
                    System.Debug('Email body ' + body);

                }
            }

            //Added to sent mail in case of booking ///

            /////To project CRM Lead ///
            if (lstBooking[0].Project__r.Project_CRM_Lead__c != null) {
                system.debug('7.xxxxxxxxx');
                LstUsersProjectCRMLead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_CRM_Lead__c];
            }
            /////To project site head ///       
            if (lstBooking[0].Project__r.Project_Site_Head__c != null) {
                system.debug('8.xxxxxxxxx');
                LstUsersProjectSalesHead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_Site_Head__c];
            }

            ////For sales manager and Rm //////////   
            if (lstBooking[0].Sales_Manager__c != null && lstBooking[0].Ownerid != null) {
                system.debug('9.xxxxxxxxx');
                System.debug('Inside mailing code');
                list < User > LstUsers = [select id, name, email from user where id = : lstBooking[0].Sales_Manager__c];
                list < User > LstUsersRm = [select id, name, email from user where id = : lstBooking[0].Ownerid];
                string strBookingHtmlBody = 'Dear ' + LstUsers[0].Name + ',<br></br>' +

                'Booking is confirmed - welcome call successful. <br></br><br></br>' +

                'Regards <br></br>' +
                    'Solitaire Care Desk';

                Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                mail.setHtmlBody(strBookingHtmlBody);
                list < string > lststringtoaddress = new list < string > ();
                if (LstUsers.size() > 0) {
                    system.debug('10.xxxxxxxxx');
                    System.debug('inside LstUsers');
                    lststringtoaddress.add(LstUsers[0].Email);


                }
                if (LstUsersRm.size() > 0) {
                    system.debug('11.xxxxxxxxx');
                    System.debug('inside LstUsersRm ');
                    lststringtoaddress.add(LstUsersRm[0].Email);


                }
                if (LstUsersProjectSalesHead.size() > 0) {
                    system.debug('12.xxxxxxxxx');
                    System.debug('inside LstUsersProjectSalesHead  ');
                    lststringtoaddress.add(LstUsersProjectSalesHead[0].Email);

                }
                if (LstUsersProjectCRMLead.size() > 0) {
                    system.debug('13.xxxxxxxxx');
                    System.debug('inside LstUsersProjectCRMLead  ');
                    lststringtoaddress.add(LstUsersProjectCRMLead[0].Email);

                }

                System.debug('lststringtoaddress' + lststringtoaddress);
                mail.setToAddresses(lststringtoaddress);
                mail.setSubject('Booking Accept Notification |  Welcome Call Stage');
                Messaging.sendEmail(new Messaging.Singleemailmessage[] {
                    mail
                });
                System.debug('After Mail Sent on acceptt of welcome call ');

            }
            //mail sending ends here  ///

            system.debug('13.xxxxxxxxx');
            BooSuccess = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info, 'Welcome Call Processed Successfully'));
            //Commenting the part which creates a customer portal user.

            //-----Updating Construction Stage Due Date----------//
            system.debug('lstBooking[0].Id zzzzzzz ' + lstBooking[0].Id);
            UpdateStandardPayPlanDueDate.UpdateDueDate(lstBooking[0].Id);             
            system.debug('14.xxxxxxxxx');
            BooSuccess = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info, 'Welcome Call Processed Successfully'));
            return null;


        } catch (exception ex) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Some Internal error encountered while proessing you request.' + ex));
            System.debug('Exception in updating booking:' + ex.getMessage());
            return null;
        }

        return null;
    }

    public pagereference ShowRejectReason() {
        if (IsRejected == false)
            IsRejected = true;
        else if (IsRejected == true)
            IsRejected = false;
        return null;

    }

    //////////////////Anuja Changed the savemethod to Submit//////////////////////
    public pagereference Submit() {
        //////////////////Anuja is setting field values for old obj of welcome call detail//////////////////////
        objWCD.Main_Applicant_Name__c = objWCC1.Verify__c;
        objWCD.DOB__c = objWCC4.Verify__c;
        objWCD.Address__c = objWCC6.Verify__c;
        objWCD.Mobile__c = objWCC3.Verify__c;
        objWCD.Landline__c = objWCC5.Verify__c;
        objWCD.Email__c = objWCC2.Verify__c;
        objWCD.Flat_No__c = objWCC36.Verify__c;
        objWCD.Car_Parks__c = objWCC38.Verify__c;


        objWCD.Source_of_Booking_broker_name__c = objWCC44.Verify__c;
        objWCD.Funding_Self_Funding_or_Bank_Funding__c = objWCC45.Funding__c;
        objWCD.Our_office_hours__c = objWCC52.Verify__c;
        objWCD.DNC_Disclaimer__c = objWCC53.Verify__c;
        objWCD.Forefeiture_Disclaimer__c = objWCC54.Verify__c;


        if (objWCD.Call_Disposion__c == 'Call back request') {
            if (objTask.Call_Back_Date__c != null && objTask.Call_Back_Date__c != null) {
                objTask.ActivityDate = objTask.Call_Back_Date__c.date();
            }
            if (objTask.ActivityDate != null && objTask.ReminderDateTime != null) {
                // Anuja inserted call disposition for booking and updated booking

                objBooking.Call_Disposition__c = objWCD.Call_Disposion__c;
                objBooking.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                objBooking.Welcome_Call_Done_By__c = UserInfo.getUserId();
                objBooking.Last_Call_Date__c = system.now();
                objBooking.Call_Back_Date__c = objTask.Call_Back_Date__c;
                update objBooking;
                //////////////
                //Anuja inserting welcome call header and call disposition for booking

                objWCH.Call_Disposition__c = objWCD.Call_Disposion__c;
                objWCH.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                objWCH.Booking__c = lstBooking[0].id;
                objWCH.Opportunity__c = lstBooking[0].Customer__c;
                insert objWCH;
                //////////////

                objTask.id = null;
                objTask.WhatId = objBooking.Customer__c;
                objTask.IsReminderSet = true;
                objTask.Subject = 'Call Back Task';
                objTask.Description = 'Please click this link to process welcome call : https://c.cs5.visual.force.com/apex/S_WelcomeCallPage?id=' + lstBooking[0].id;
                Insert objTask;
                objWCD.Call_Disposion__c = '';
                objWCD.Call_Disposition_L2__c = '';
                objTask.ActivityDate = null;
                objTask.ReminderDateTime = null;
                objTask.IsReminderSet = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm, 'Your task has been created.'));
                BooSuccess = false;
            } else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning, 'You must enter the call back date.'));
                return null;
            }
        }
        //Anuja inserted this to call accept method because we have removed accept button from ui
        else if (objWCD.Call_Disposion__c == 'Welcome call accepted') {
            System.debug('INSIDE Accept if');
            if (applicantList.size() > 0) {
                if (objWCC1.Verify__c == False || objWCC2.Verify__c == False || objWCC3.Verify__c == False || objWCC6.Verify__c == False) { 
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please check all the checkboxes to proceed.'));
                    return null;
                } else if (objopp.Reason_For_Rejection__c == null) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'You must enter the Remarks'));
                    return null;
                }
            }
            if (applicantList.size() > 1) {
                if (objWCC7.Verify__c == False) { 
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please check all the checkboxes to proceed.'));
                    return null;
                } else if (objopp.Reason_For_Rejection__c == null) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'You must enter the Remarks'));
                    return null;
                }
            }
            if (lstBooking[0].Funding_Status__c != null) {
                if (objWCC45.Verify__c == False) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please check all the checkboxes to proceed.'));
                    return null;
                }
            }
            if (objWCC31.Verify__c == False || objWCC32.Verify__c == False || objWCC34.Verify__c == False || objWCC35.Verify__c == False || objWCC36.Verify__c == False || objWCC37.Verify__c == False || objWCC38.Verify__c == False || objWCC40.Verify__c == False || objWCC42.Verify__c == False || objWCC56.Verify__c == False /*||objWCC43.Verify__c == False */ || objWCC44.Verify__c == False || objWCC47.Verify__c == False || objWCC48.Verify__c == False || objWCC49.Verify__c == False || objWCC50.Verify__c == False ////|| objWCC46.Verify__c == False || objWCC51.Verify__c == False || objWCC53.Verify__c == False || objWCC54.Verify__c == False
                 || objWCC52.Verify__c == False ) { 

                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please check all the checkboxes to proceed.'));
                return null;
            } else if (objopp.Reason_For_Rejection__c == null) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'You must enter the Remarks'));
                return null;
            } else {
                //Welcome header 
                objWCH.Call_Disposition__c = objWCD.Call_Disposion__c;
                objWCH.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                objWCH.Booking__c = lstBooking[0].id;
                objWCH.Opportunity__c = lstBooking[0].Customer__c;
                objWCH.Remarks__c = objopp.Reason_For_Rejection__c;
                insert objWCH;

                //Creating two records for dispatch and bank loan
                ListWCCToInsert.add(objWCC45);
                ListWCCToInsert.add(objWCC46);
                for (i = 0; i < ListWCCToInsert.size(); i++) {
                    ListWCCToInsert[i].Welcome_Call_Header__c = objWCH.id;

                }
                insert ListWCCToInsert;

                //Anuja added this to create task for home loan//
                if (objWCC45.Funding__c == 'Bank Loan') {
                    Task t = new Task();
                    t.Subject = 'Home Loan';
                    t.Task_Type__c = 'Home Loan';
                    t.Status = 'Scheduled';
                    t.priority = 'Normal';
                    t.whatId = lstBooking[0].Customer__c;
                    t.ActivityDate = System.Today();
                    t.Description = objWCC45.Bank_Loan_Status__c;
                    t.ownerId = lstusers[0].id;
                    insert t;
                }
                Accept();
            }
        } else if (objWCD.Call_Disposion__c == 'Welcome call rejected') {
            if (objopp.Reason_For_Rejection__c != null) {
                System.debug('INSIDE reject if');
                //Anuja testing for inserting funding in detail
                System.debug('objWCC45.Funding__c ' + objWCC45.Funding__c);
                System.debug('objWCC45.Bank_Loan_Status__c ' + objWCC45.Bank_Loan_Status__c);
                if (objWCC45.Funding__c == null) {
                    fundingdetail = '';
                }
                if (objWCC45.Funding__c != null && objWCC45.Bank_Loan_Status__c == null) {
                    fundingdetail = objWCC45.Funding__c;
                }
                if (objWCC45.Funding__c != null && objWCC45.Bank_Loan_Status__c != null) {
                    fundingdetail = objWCC45.Funding__c + '-' + objWCC45.Bank_Loan_Status__c;
                }
                objWCC45.Detail__c = fundingdetail;
                System.debug('objWCC45.Detail__cccc' + objWCC45.Detail__c);
                ///delivery medium
                deliverydetail = objWCC46.Delivery_of_Invoices_and_receipts__c;
                objWCC46.Detail__c = deliverydetail;
                System.debug('objWCC46.Detail__cccc ' + objWCC46.Detail__c);
                //Anuja inserting welcome call header 
                objWCH.Call_Disposition__c = objWCD.Call_Disposion__c;
                objWCH.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
                objWCH.Booking__c = lstBooking[0].id;
                objWCH.Opportunity__c = lstBooking[0].Customer__c;
                objWCH.Remarks__c = objopp.Reason_For_Rejection__c;
                insert objWCH;
                system.debug('objWCH : ' + objWCH);
                system.debug('objWCC1 : ' + objWCC1);
                //Anuja inserting records if rejected in Welcome call Checklist object
                if (applicantList.size() > 0) {
                    ListWCCToInsert.add(objWCC1);
                    ListWCCToInsert.add(objWCC2);
                    ListWCCToInsert.add(objWCC3);
                    ListWCCToInsert.add(objWCC6);
                }
                if (applicantList.size() > 1) {
                    objWCC7.Detail__c = Coowners;
                    ListWCCToInsert.add(objWCC7);

                }

                ListWCCToInsert.add(objWCC31);
                ListWCCToInsert.add(objWCC32);
                ListWCCToInsert.add(objWCC34);
                ListWCCToInsert.add(objWCC35);
                ListWCCToInsert.add(objWCC36);
                ListWCCToInsert.add(objWCC37);
                ListWCCToInsert.add(objWCC38);
                ListWCCToInsert.add(objWCC40);
                ListWCCToInsert.add(objWCC42);
                ListWCCToInsert.add(objWCC56);
                ListWCCToInsert.add(objWCC44);
                ListWCCToInsert.add(objWCC45);
                ListWCCToInsert.add(objWCC46);
                ListWCCToInsert.add(objWCC47);
                ListWCCToInsert.add(objWCC48);
                ListWCCToInsert.add(objWCC49);
                ListWCCToInsert.add(objWCC50);
                ListWCCToInsert.add(objWCC51);
                ListWCCToInsert.add(objWCC52);
                ListWCCToInsert.add(objWCC53);
                ListWCCToInsert.add(objWCC54);
                System.Debug('Size of the list and its value : ' + ListWCCToInsert.size() + 'Values :' + ListWCCToInsert);
                for (i = 0; i < ListWCCToInsert.size(); i++) {
                    ListWCCToInsert[i].Welcome_Call_Header__c = objWCH.id;

                }
                insert ListWCCToInsert;


                //Added to sent mail in case of booking ///

                /////To project CRM Lead ///
                if (lstBooking[0].Project__r.Project_CRM_Lead__c != null) {
                    LstUsersProjectCRMLead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_CRM_Lead__c];
                }
                /////To project site head ///       
                if (lstBooking[0].Project__r.Project_Site_Head__c != null) {
                    LstUsersProjectSalesHead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_Site_Head__c];
                }

                ////For sales manager and Rm //////////   
                if (lstBooking[0].Sales_Manager__c != null && lstBooking[0].Ownerid != null) {
                    System.debug('Inside mailing code');
                    list < User > LstUsers = [select id, name, email from user where id = : lstBooking[0].Sales_Manager__c];
                    list < User > LstUsersRm = [select id, name, email from user where id = : lstBooking[0].Ownerid];
                    string strBookingHtmlBody = 'Dear ' + LstUsers[0].Name + ' ,<br> </br>' +

                    ' Booking failed at welcome call stage for following reasons. Please re-process booking to confirm. Below are the reasons for rejection.<br>  </br> ' +

                    +objopp.Reason_For_Rejection__c + '<br> </br><br></br>' +

                    ' Regards <br> </br>' +
                        ' Solitaire Care Desk ';

                    Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                    mail.setHtmlBody(strBookingHtmlBody);
                    list < string > lststringtoaddress = new list < string > ();
                    if (LstUsers.size() > 0) {
                        System.debug('inside LstUsers');
                        lststringtoaddress.add(LstUsers[0].Email);


                    }
                    if (LstUsersRm.size() > 0) {
                        System.debug('inside LstUsersRm ');
                        lststringtoaddress.add(LstUsersRm[0].Email);


                    }
                    if (LstUsersProjectSalesHead.size() > 0) {
                        System.debug('inside LstUsersProjectSalesHead  ');
                        lststringtoaddress.add(LstUsersProjectSalesHead[0].Email);

                    }
                    if (LstUsersProjectCRMLead.size() > 0) {
                        System.debug('inside LstUsersProjectCRMLead  ');
                        lststringtoaddress.add(LstUsersProjectCRMLead[0].Email);

                    }

                    System.debug('lststringtoaddress' + lststringtoaddress);
                    mail.setToAddresses(lststringtoaddress);
                    mail.setSubject('Booking Failed Notification |  Welcome Call Stage');
                    Messaging.sendEmail(new Messaging.Singleemailmessage[] {
                        mail
                    });
                    System.debug('After Mail Sent on reject of welcome call ');

                }
                //mail sending ends here  ///

                Reject();
            } else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'You must enter the Remarks'));
                return null;
            }
        } else if (objWCD.Call_Disposion__c == 'Wrong number/No Number' || objWCD.Call_Disposion__c == 'Ringing/Switched Off/Not reachable') {

            //Anuja inserting welcome call header
            objWCH.Call_Disposition__c = objWCD.Call_Disposion__c;
            objWCH.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
            objWCH.Booking__c = lstBooking[0].id;
            objWCH.Opportunity__c = lstBooking[0].Customer__c;
            insert objWCH;
            objWCD.Customer__c = objBooking.customer__c;
            upsert objWCD;
            objBooking.Call_Disposition__c = objWCD.Call_Disposion__c;
            objBooking.Call_Disposition_L2__c = objWCD.Call_Disposition_L2__c;
            objBooking.Welcome_Call_Done_By__c = UserInfo.getUserId();
            objBooking.Last_Call_Date__c = system.now();
            objBooking.Call_Back_Date__c = null;
            update objBooking;
            BooSuccess = false;
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please Select a call disposition.'));
            return null;

        }
        return null;
    }
}