public with sharing class DocumentChecklistPageController {

    public string test {
        get;
        set;
    }

    public String ArrayApplicant1String {
        get;
        set;
    }
    public String ArrayApplicant2String {
        get;
        set;
    }
    public String a {
        get;
        set;
    }
    public String b {
        get;
        set;
    }
    public String ArrayApplicant3String {
        get;
        set;
    }
    public String ArrayApplicant4String {
        get;
        set;
    }
    public String ArrayApplicant5String {
        get;
        set;
    }
    public boolean isError {
        get;
        set;
    }
    public boolean d1 {
        get;
        set;
    }
    public boolean d2 {
        get;
        set;
    }
    public boolean d3 {
        get;
        set;
    }
    public boolean d4 {
        get;
        set;
    }
    public boolean d5 {
        get;
        set;
    }
    public boolean d6 {
        get;
        set;
    }
    public boolean d7 {
        get;
        set;
    }
    public boolean d8 {
        get;
        set;
    }
    public boolean d9 {
        get;
        set;
    }
    public boolean d10 {
        get;
        set;
    }
    public boolean d11 {
        get;
        set;
    }
    public boolean d12 {
        get;
        set;
    }
    public boolean d13 {
        get;
        set;
    }
    public boolean d14 {
        get;
        set;
    }
    public boolean d15 {
        get;
        set;
    }
    public boolean d16 {
        get;
        set;
    }
    public boolean d17 {
        get;
        set;
    }
    public boolean d18 {
        get;
        set;
    }
    public boolean d19 {
        get;
        set;
    }
    public boolean d20 {
        get;
        set;
    }
    public boolean d21 {
        get;
        set;
    }
    public boolean d22 {
        get;
        set;
    }
    public boolean d23 {
        get;
        set;
    }
    public boolean d24 {
        get;
        set;
    }
    public boolean d25 {
        get;
        set;
    }
    public boolean d26 {
        get;
        set;
    }
    public boolean d27 {
        get;
        set;
    }
    public boolean d28 {
        get;
        set;
    }
    public boolean d29 {
        get;
        set;
    }
    public boolean d30 {
        get;
        set;
    }
    public boolean d31 {
        get;
        set;
    }
    
    
    
    
    
    
    
    

    public String drow1 {
        get;
        set;
    }
    public String drow2 {
        get;
        set;
    }
    public String drow3 {
        get;
        set;
    }
    public String drow4 {
        get;
        set;
    }
    public String drow5 {
        get;
        set;
    }
    public String drow6 {
        get;
        set;
    }
    public String drow7 {
        get;
        set;
    }
    public String drow8 {
        get;
        set;
    }
    public String drow9 {
        get;
        set;
    }
    public String drow10 {
        get;
        set;
    }
    public String drow11 {
        get;
        set;
    }
    public String drow12 {
        get;
        set;
    }
    public String drow13 {
        get;
        set;
    }
    public String drow14 {
        get;
        set;
    }
    public String drow15 {
        get;
        set;
    }
    public String drow16 {
        get;
        set;
    }
    public String drow17 {
        get;
        set;
    }
    public String drow18 {
        get;
        set;
    }
    public String drow19 {
        get;
        set;
    }
    public String drow20 {
        get;
        set;
    }
    public String drow21 {
        get;
        set;
    }
    public String drow22 {
        get;
        set;
    }
    public String drow23 {
        get;
        set;
    }
    public String drow24 {
        get;
        set;
    }
    public String drow25 {
        get;
        set;
    }
    public String drow26 {
        get;
        set;
    }
    public String drow27 {
        get;
        set;
    }
    public String drow28 {
        get;
        set;
    }
    public String drow29 {
        get;
        set;
    }
    public String drow30 {
        get;
        set;
    }
    public String drow31 {
        get;
        set;
    }

    


    public List < String > ArrayApplicant1 {
        get;
        set;
    }
    public List < String > ArrayApplicant2 {
        get;
        set;
    }
    public List < String > ArrayApplicant3 {
        get;
        set;
    }
    public List < String > ArrayApplicant4 {
        get;
        set;
    }
    public List < String > ArrayApplicant5 {
        get;
        set;
    }

    public List < Booking__c > lstBooking {
        get;
        set;
    }

    public Receipt__c lstReceiptTokenToShow {
        get;
        set;
    }
    public Receipt__c lstReceiptServiceTaxToShow {
        get;
        set;
    }
    public List < Receipt__c > lstReceiptToken {
        get;
        set;
    }
    public List < Receipt__c > lstReceiptServiceTax {
        get;
        set;
    }

    public List < Project__c > lstproject {
        get;
        set;
    }

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
    public Quotation__c quotationObj {
        get;
        set;
    }
    public List < Booking__c > lstBookingmk {
        get;
        set;
    }
    public Document_Checklist_Header__c checklistHeader {
        get;
        set;
    }
    List < Document_Checklist__c > lstDocumentChecklist = new List < Document_Checklist__c > ();
    List < Document_Checklist__c > lstDocumentChecklistApplicant = new List < Document_Checklist__c > ();
    public Document_Checklist__c DocRow1 {
        get;
        set;
    }
    public Document_Checklist__c DocRow2 {
        get;
        set;
    }
    public Document_Checklist__c DocRow3 {
        get;
        set;
    }
    public Document_Checklist__c DocRow4 {
        get;
        set;
    }
    public Document_Checklist__c DocRow5 {
        get;
        set;
    }
    public Document_Checklist__c DocRow6 {
        get;
        set;
    }
    public Document_Checklist__c DocRow7 {
        get;
        set;
    }
    public Document_Checklist__c DocRow8 {
        get;
        set;
    }
    public Document_Checklist__c DocRow9 {
        get;
        set;
    }
    public Document_Checklist__c DocRow10 {
        get;
        set;
    }
    public Document_Checklist__c DocRow11 {
        get;
        set;
    }
    public Document_Checklist__c DocRow12 {
        get;
        set;
    }
    public Document_Checklist__c DocRow13 {
        get;
        set;
    }
    public Document_Checklist__c DocRow14 {
        get;
        set;
    }
    public Document_Checklist__c DocRow15 {
        get;
        set;
    }
    public Document_Checklist__c DocRow16 {
        get;
        set;
    }
    public Document_Checklist__c DocRow17 {
        get;
        set;
    }
    public Document_Checklist__c DocRow18 {
        get;
        set;
    }
    public Document_Checklist__c DocRow19 {
        get;
        set;
    }
    public Document_Checklist__c DocRow20 {
        get;
        set;
    }
     public Document_Checklist__c DocRow21 {
        get;
        set;
    }
     public Document_Checklist__c DocRow22 {
        get;
        set;
    }
     public Document_Checklist__c DocRow23 {
        get;
        set;
    }
     public Document_Checklist__c DocRow24 {
        get;
        set;
    }
     public Document_Checklist__c DocRow25 {
        get;
        set;
    }
     public Document_Checklist__c DocRow26 {
        get;
        set;
    }
     public Document_Checklist__c DocRow27 {
        get;
        set;
    }
     public Document_Checklist__c DocRow28 {
        get;
        set;
    }
     public Document_Checklist__c DocRow29 {
        get;
        set;
    }
     public Document_Checklist__c DocRow30 {
        get;
        set;
    }
     public Document_Checklist__c DocRow31 {
        get;
        set;
    } 
    
    
     
     

    List < Applicant_Details__c > listApplicant = new list < Applicant_Details__c > ();

    //Declaration of variables being used in the original code

    public list < Booking__c > lstbookingUnitChange;
    public boolean tokenAmountNotMention;
    public boolean ReceiptNotProcessed;
    public list < Booking__c > lstbookingToMapMilstone;
    public string oppidforreciept;
    public Booking__c booking {
        get;
        set;
    }
    public Receipt__c objReceipt {
        get;
        set;
    }
    public Receipt__c objReceiptbooked {
        get;
        set;
    }

    public Unit_Event_History__c objUnitEventHistory {
        get;
        set;
    }
    public List < Ledger__c > lstLedgerUp {
        get;
        set;
    }
   
    public Boolean isAlreadyProcess {
        get;
        set;
    }
    public Boolean alreadyProcessed {
        get;
        set;
    }
    public list < Receipt__c > lstReceipt;
    public decimal Amount = 0;
    public List < Standard_Customer_Pay_Plan_Detail__c > lstscppdetail;
    public map < id, list < Standard_Customer_Pay_Plan_Detail__c >> mapofSPPHeadesAndSCppDetails;
    public Database.SaveResult MySaveResult;
    public set < id > setstandardpayplainheader;
    public set < id > setbookingdetails;

    public Boolean checkstatus {
        get;
        set;
    }
    public boolean status {
        get;
        set;
    }
    public List < Ledger__c > lstLedegr {
        get;
        set;
    }
    public List < Ledger__c > lstLedegrToUpdate {
        get;
        set;
    }
    public Booking__c bookingProc {
        get;
        set;
    }
    public Ledger__c objLedger {
        get;
        set;
    }
    public date BookingDate {
        get;
        set;
    }
    public decimal ConsiderationValue {
        get;
        set;
    }
    public Opportunity objopportunity {
        get;
        set;
    }

    public Project_Unit__c objProj {
        get;
        set;
    }
    public string outputmessage {
        get;
        set;
    }
    public string ErrorMessage {
        get;
        set;
    }
    public list < Receipt__c > lstReceiptNew {
        get;
        set;
    }

    String strOppQuery {
        get;
        set;
    }
    public boolean IsValidUser {
        get;
        set;
    }
    public decimal BookingAmount {
        get;
        set;
    }


    //Get the booking id from the page URL
    String BookingId {
        get;
        set;
    }
    Public String instrumentno {
        get;
        set;
    }

    //This list stores the list of applicants for this booking
    //List<Applicant_Details__c> applicantList = new List<Applicant_Details__c>();
    public List < Applicant_Details__c > applicantList {
        get;
        set;
    }
    public Integer i {
        get;
        set;
    }
    public Integer j {
        get;
        set;
    }
    public string err {
        get;
        set;
    }
    public string subsource {
        get;
        set;
    }
    public String error {
        get;
        set;
    }
    public Boolean isRejected {
        get;
        set;
    }
    public Boolean isAccepted {
        get;
        set;
    }
    //Anuja added on 29/12/15   
    public string infavourtoken1 {
        get;
        set;
    }
    public string infavourST1 {
        get;
        set;
    }
    public String alotment {
        get;
        set;
    }
    public String tokenamt {
        get;
        set;
    }
    public String STamt {
        get;
        set;
    }
    public String ApplicantNames {
        get;
        set;
    }
    public boolean NoST {
        get;
        set;
    }
    public boolean docrow1checkbox {
        get;
        set;
    }
    public list < User > LstUsersProjectSalesHead {
        get;
        set;
    }
    public Decimal AgreementValue{
        get;
        set;
    }
    public String AgreementValueString{
        get;
        set;
    }
    public Decimal ExclusiveArea{
        get;
        set;
    }


    public DocumentChecklistPageController() {
        system.debug('Inside constructor');
        isError = true;
        isRejected = false;
        isAccepted = false;
        docrow1checkbox = false;
        LstUsersProjectSalesHead = new List < User > ();
        ArrayApplicant1 = new List < String > ();
        ArrayApplicant2 = new List < String > ();
        ArrayApplicant3 = new List < String > ();
        ArrayApplicant4 = new List < String > ();
        ArrayApplicant5 = new List < String > ();

        applicant = new Applicant_Details__c();
        applicant2 = new Applicant_Details__c();
        applicant3 = new Applicant_Details__c();
        applicant4 = new Applicant_Details__c();
        applicant5 = new Applicant_Details__c();
        ApplicantNames = '';

        boookingObj = new Booking__c();
        quotationObj = new Quotation__c();
        lstDocumentChecklist = new List < Document_Checklist__c > ();
        checklistHeader = new Document_Checklist_Header__c();
        lstReceiptTokenToShow = new Receipt__c();
        lstReceiptServiceTaxToShow = new Receipt__c();
        DocRow1 = new Document_Checklist__c();
        DocRow2 = new Document_Checklist__c();
        DocRow3 = new Document_Checklist__c();
        DocRow4 = new Document_Checklist__c();
        DocRow5 = new Document_Checklist__c();
        DocRow6 = new Document_Checklist__c();
        DocRow7 = new Document_Checklist__c();
        DocRow8 = new Document_Checklist__c();
        DocRow9 = new Document_Checklist__c();
        DocRow10 = new Document_Checklist__c();
        DocRow11 = new Document_Checklist__c();
        DocRow12 = new Document_Checklist__c();
        DocRow13 = new Document_Checklist__c();
        DocRow14 = new Document_Checklist__c();
        DocRow15 = new Document_Checklist__c();
        DocRow16 = new Document_Checklist__c();
        DocRow17 = new Document_Checklist__c();
        DocRow18 = new Document_Checklist__c();
        DocRow19 = new Document_Checklist__c();
        DocRow20 = new Document_Checklist__c();
        DocRow21 = new Document_Checklist__c();
        DocRow22 = new Document_Checklist__c();
        DocRow23 = new Document_Checklist__c();
        DocRow24 = new Document_Checklist__c();
        DocRow25 = new Document_Checklist__c();
        DocRow26 = new Document_Checklist__c();
        DocRow27 = new Document_Checklist__c();
        DocRow28 = new Document_Checklist__c();
        DocRow29 = new Document_Checklist__c();
        DocRow30 = new Document_Checklist__c();
        DocRow31 = new Document_Checklist__c();
       
    

        DocRow1.Description__c = 'Booking Form To Be Signed By All Applicants';
        DocRow2.Description__c = 'Quotation page is signed by all applicants';
        DocRow3.Description__c = 'Floor plan and other Annexure signed by all applicants';
        DocRow4.Description__c = 'All supporting documents to be self attested ';
        DocRow5.Description__c = 'All empty applicant pages to be striked out';
        DocRow6.Description__c = 'No white ink can be used';
        DocRow7.Description__c = 'Mistakes Check full application form';
        DocRow8.Description__c = 'Any mistake on the Unit details page';
        DocRow9.Description__c = 'Future Correspondence Contact';
        DocRow10.Description__c = 'Future Correspondence Contact Relation';
        DocRow11.Description__c = 'Future Correspondence Contact Name';
        DocRow12.Description__c = 'Future Correspondence Contact Mobile';
        DocRow13.Description__c = 'Future Correspondence Contact Email';
        DocRow14.Description__c = 'Booking Date';
        DocRow15.Description__c = 'Wing';
        DocRow16.Description__c = 'Unit Typology';
        DocRow17.Description__c = 'Floor';
        DocRow18.Description__c = 'Unit No';
        DocRow19.Description__c = 'Carpet Area';
        DocRow20.Description__c = 'Terrace Area';
        DocRow21.Description__c = 'No. of Parking';
        DocRow22.Description__c = 'Consideration Value';
        DocRow23.Description__c = 'Check All Receipt';
        DocRow24.Description__c = 'Booking Source And Sub-Source';
        DocRow25.Description__c = 'Signature of Sales Manager';
        DocRow26.Description__c = 'Base Price';
        DocRow27.Description__c = 'Discount';
        DocRow28.Description__c = 'Consideration Value (Agreement Value)';
        DocRow29.Description__c = 'Signature of Business Head and Sales Head';
        DocRow30.Description__c = 'Signed by all applicants';
        DocRow31.Description__c = 'Signature of Business Head and Sales Head';
       

        
        subsource = '';

        //Get the booking id from URL
        if (ApexPages.currentPage().getParameters().get('id') != null && ApexPages.currentPage().getParameters().get('id') != '') BookingId = ApexPages.currentPage().getParameters().get('id');
        system.debug('BookingId ' + BookingId);

        if (BookingId != null && BookingId != '') {

            lstBooking = [Select Id, Sales_Managers__c, Ownerid, LastModifiedDate, Project__r.Project_Site_Head__c, Name, Status__c, Sales_Manager__c, Project__c, Customer__c, Customer__r.Physical_document_received__c, Unit_No__c, Unit_No__r.Unit_Status__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Relation__c,
                Customer__r.Name_of_Refree__c, Customer__r.Mobile_of_Refree__c, Quotation__r.Customer_Total_Discount_PSF__c, Quotation__r.Base_Rate_PSF__c, Customer__r.Walk_in_Channel_Partner__r.Name,
                Future_Correspondence_Contact_Email__c, Future_Correspondence_Contact_Phone__c, Future_Correspondence_Contact_Name__c, Zone__c, Wing__c, Flat_Typology__c, Floor__c,Floor1__c, Flat_No__c, Carpet_Area__c, No_of_Parking__c, Parking_Type__c, Allotment_Premium__c, Opportunity__c,
                Sales_Manager_Approver__c, Level_One_Approver__r.Name, Level_Two_Approver__r.Name, Level_Three_Approver__r.Name, Quotation__r.Owner.Name, Unit_No__r.Terrace_Area__c, Quotation__r.Agreement_Value__c, Quotation__r.Agreement_Value_D__c, 
                Source_of_Booking__c, Sub_Source__c, Customer__r.Respective_Customer_Account__r.Name, Referred_By__c, Booking_Date__c, Quotation__r.No_of_parking__c, Unit_No__r.Exclusive_Area__c,
                Booking_Source_CP_New__c, Booking_Source_CP_Registered__c,Booking_Source_Reference_by_Customer__c,Booking_Source_Reference_By_Employee__c, Booking_Source_Reference_By_Others__c /**Customer__r.Account.Salutation**/,Quotation__r.Total_Independent__c,Quotation__r.Total_Dependent__c,Quotation__r.Total_Stack__c,Quotation__r.Total_New_Stack__c,Quotation__r.Total_Puzzle__c,Quotation__r.Total_Dependable_Stack__c,Quotation__r.Two_Wheeler_Additional__c
                from Booking__c Where Id = : BookingId
            ];
            system.debug('lstBooking ' + lstBooking);
            if (lstBooking != null && lstBooking.size() > 0) {
                //Anuja added on 29/12/15
                if (lstBooking[0].Allotment_Premium__c != null){
                        alotment = QuotationManagementServices1.INFormat(lstBooking[0].Allotment_Premium__c);
                    }
                if(lstBooking[0].Quotation__r.Agreement_Value_D__c != 0 || lstBooking[0].Quotation__r.Agreement_Value_D__c != 0.00){                                        
                        AgreementValue = lstBooking[0].Quotation__r.Agreement_Value_D__c ;
                        AgreementValueString = QuotationManagementServices1.INFormat(lstBooking[0].Quotation__r.Agreement_Value_D__c );
                  }else {
                        AgreementValue = lstBooking[0].Quotation__r.Agreement_Value__c;
                        AgreementValueString = QuotationManagementServices1.INFormat(lstBooking[0].Quotation__r.Agreement_Value__c);
                    }
            }
            if (lstBooking[0].Sub_Source__c != null) {
                subsource = ' - ' + lstBooking[0].Sub_Source__c;
            }
            if (lstBooking[0].Status__c == 'Cancelled') {
                error = 'yes';
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'This Booking Has Been Cancelled.'));

            } else {

                if (lstBooking[0].Customer__r.Physical_document_received__c == False) {
                    error = 'yes';
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please Check Physical Document Received on Opportunity to Proceed'));
                } else {
                    if (lstBooking[0].Unit_No__r.Unit_Status__c != 'BIP - RM Verification' && lstBooking[0].Unit_No__r.Unit_Status__c != 'BIP - Sales' && lstBooking[0].Unit_No__r.Unit_Status__c != 'CRM Returned To Sales') {
                        error = 'yes';
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error, 'Please ensure that the unit status is "BIP - RM Verification" or "BIP - Sales" or "CRM Returned To Sales"'));

                    } else {
                        system.debug('xxxxxxxxxx');
                        //lstReceiptToken 
                        lstReceiptToken = [SELECT Cheque_DD__c, Cheque_DD_Date__c, Cheque_DD_Amount_Rs__c, Drawn_in_favour_of__c, DraweeBank__c, Branch__c, NEFT__c, RTGS__c, Challan_No__c, Pay_Order__c FROM Receipt__c Where Opportunity__c = : lstBooking[0].Customer__c and Token_Amount_Receipt__c = true]; //change from Token_Amount_Receipt__c = true to Token_Amount_ST__c = False
                        system.debug('lstReceiptToken ' + lstReceiptToken);
                        if (lstReceiptToken.size() > 0) {
                            lstReceiptTokenToShow = lstReceiptToken[0];
                            // getting substring of (in favour of) field from receipt  added on 29/12/15
                            string infavourtoken = lstReceiptToken[0].Drawn_in_favour_of__c;
                            if (infavourtoken != null) {
                                integer l = infavourtoken.IndexOf('|');
                                infavourtoken1 = infavourtoken.Substring(0, l);
                            }
                            if (lstReceiptToken[0].Cheque_DD_Amount_Rs__c != null)
                                tokenamt = QuotationManagementServices1.INFormat(lstReceiptToken[0].Cheque_DD_Amount_Rs__c);
                        }
                        system.debug('xxxxxxxxxx');

                        //lstReceiptServiceTax
                        lstReceiptServiceTax = [SELECT Cheque_DD__c, Cheque_DD_Date__c, Cheque_DD_Amount_Rs__c, DraweeBank__c, Branch__c, NEFT__c, RTGS__c, Drawn_in_favour_of__c, Challan_No__c, Pay_Order__c FROM Receipt__c Where Opportunity__c = : lstBooking[0].Customer__c and Token_Amount_ST__c = true];
                        system.debug('lstReceiptServiceTax.size()::::: ' + lstReceiptServiceTax.size());
                        if (lstReceiptServiceTax.size() > 0) {
                            lstReceiptServiceTaxToShow = lstReceiptServiceTax[0];
                            // getting substring of (in favour of) field from receipt added on 29/12/15
                            string infavourST = lstReceiptServiceTax[0].Drawn_in_favour_of__c;
                            system.debug('infavourST :::::' + infavourST);
                            if (infavourST != null) {
                                integer l = infavourST.IndexOf('|');
                                infavourST1 = infavourST.Substring(0, l);
                            }
                            if (lstReceiptServiceTax[0].Cheque_DD_Amount_Rs__c != null)
                                STamt = QuotationManagementServices1.INFormat(lstReceiptServiceTax[0].Cheque_DD_Amount_Rs__c);
                        } else {
                            NoST = true;
                        }
                        //Project Details
                        lstproject = [SELECT Id, Deal_Approver__c, Quotation_Approver__c, Discount_Approval__c FROM Project__c Where Id = : lstBooking[0].Project__c];
                        system.debug('Inside Else');
                    }
                }
            }
            //Fetch the list of applications for the bookingid provided in the URL
            applicantList = [Select Id, Mailing_Address_same_as_PermanentAddress__c, OwnerId, IsDeleted, Name, Salutation__c, BookingDetails__c, Type_Of_Applicant__c, Pancard__c, PancardNo__c,
                Organization_Name__c, Permanent_Address__c, Mailing_Address__c, Mailing_Country__c, Mailing_Pincode__c, Country__c, Pincode__c, Email_Address__c, Mobile_Number__c, Address_Proof_Document__c, Subtype_Of_Applicant__c, PassportNumber__c, Funds_from_NRE_FCNR__c, Self_attested_copy_of_PIO_or_OCI_Card__c, PassportNoDetails__c,
                Funds_from_NRE_NRO__c, Copy_of_Workpermit_Employment_contract__c, Copy_of_Memorandu_of_Association__c, Certified_copy_of_Article_of_Association__c, Certified_copy_of_Board_Resolution__c, Certified_copy_of_ROC_Incorporation__c, Self_attested_List_of_Shareholders__c,
                Self_attested_List_of_Directors__c, PanCard_of_Authority_Signatory__c, Certified_copy_of_Partnership_Deed__c, Pan_Card_Number_of_Authority_Signatory__c, Certified_extract_of_Registration__c, Copy_of_Authorization_Letter_POA__c, Address_Proof__c, Address_Proof_Number__c, One_Passport_Size_Color_Photograph__c, Type_Of_Origin__c, Origin_Details__c, Booking__c, Applicant_Number__c FROM Applicant_Details__c WHERE Booking__c = : bookingId
            ];

            if (applicantList.size() > 0) {
                applicant = applicantList[0];
                applicant.Permanent_Address__c = applicantList[0].Permanent_Address__c.replace(',', ' ');

                ApplicantNames = applicantList[0].Salutation__c + ' ' + applicantList[0].Name;
                if (applicant.Mailing_Address_same_as_PermanentAddress__c == true) {
                    applicant.Mailing_Address__c = 'Correspondance address same as permanent address';
                } else {
                    if (applicantList[0].Mailing_Address__c != null) {
                        applicant.Mailing_Address__c = applicantList[0].Mailing_Address__c.replace(',', ' ');
                    }
                    applicant.Mailing_Address__c = applicant.Mailing_Address__c + ' Pincode :' + applicant.Mailing_Pincode__c + ' Country :' + applicant.Mailing_Country__c;
                }

            }
            if (applicantList.size() > 1) {
                applicant2 = applicantList[1];
                ApplicantNames = ApplicantNames + ', ' + applicantList[1].Salutation__c + ' ' + applicantList[1].Name;
                applicant2.Permanent_Address__c = applicantList[1].Permanent_Address__c.replace(',', ' ');
                if (applicant2.Mailing_Address_same_as_PermanentAddress__c == true) {
                    applicant2.Mailing_Address__c = 'Correspondance address same as permanent address';
                } else {
                    if (applicantList[1].Mailing_Address__c != null) {
                        applicant2.Mailing_Address__c = applicantList[1].Mailing_Address__c.replace(',', ' ');
                    }
                    applicant2.Mailing_Address__c = applicant2.Mailing_Address__c + ' Pincode :' + applicant2.Mailing_Pincode__c + ' Country :' + applicant2.Mailing_Country__c;
                }

            }
            if (applicantList.size() > 2) {
                applicant3 = applicantList[2];
                ApplicantNames = ApplicantNames + ', ' + applicantList[2].Salutation__c + ' ' + applicantList[2].Name;
                applicant3.Permanent_Address__c = applicantList[2].Permanent_Address__c.replace(',', ' ');
                if (applicant3.Mailing_Address_same_as_PermanentAddress__c == true) {
                    applicant3.Mailing_Address__c = 'Correspondance address same as permanent address';
                } else {
                    if (applicantList[2].Mailing_Address__c != null) {
                        applicant3.Mailing_Address__c = applicantList[2].Mailing_Address__c.replace(',', ' ');
                    }
                    applicant3.Mailing_Address__c = applicant3.Mailing_Address__c + ' Pincode :' + applicant3.Mailing_Pincode__c + ' Country :' + applicant3.Mailing_Country__c;
                }
            }
            if (applicantList.size() > 3) {
                applicant4 = applicantList[3];
                ApplicantNames = ApplicantNames + ', ' + applicantList[3].Salutation__c + ' ' + applicantList[3].Name;
                applicant4.Permanent_Address__c = applicantList[3].Permanent_Address__c.replace(',', ' ');
                if (applicant4.Mailing_Address_same_as_PermanentAddress__c == true) {
                    applicant4.Mailing_Address__c = 'Correspondance address same as permanent address';
                } else {
                    if (applicantList[3].Mailing_Address__c != null) {
                        applicant4.Mailing_Address__c = applicantList[3].Mailing_Address__c.replace(',', ' ');
                    }
                    applicant4.Mailing_Address__c = applicant4.Mailing_Address__c + ' Pincode :' + applicant4.Mailing_Pincode__c + ' Country :' + applicant4.Mailing_Country__c;
                }

            }
            if (applicantList.size() > 4) {
                applicant5 = applicantList[4];
                ApplicantNames = ApplicantNames + ', ' + applicantList[4].Salutation__c + ' ' + applicantList[4].Name;
                applicant5.Permanent_Address__c = applicantList[4].Permanent_Address__c.replace(',', ' ');
                if (applicant5.Mailing_Address_same_as_PermanentAddress__c == true) {
                    applicant5.Mailing_Address__c = 'Correspondance address same as permanent address';
                } else {
                    if (applicantList[4].Mailing_Address__c != null) {
                        applicant5.Mailing_Address__c = applicantList[4].Mailing_Address__c.replace(',', ' ');
                    }
                    applicant5.Mailing_Address__c = applicant5.Mailing_Address__c + ' Pincode :' + applicant5.Mailing_Pincode__c + ' Country :' + applicant5.Mailing_Country__c;
                }

            }
            system.debug('last of constructor');
        }
    }

    public Pagereference receipt() {
        return (new PageReference('/apex/AllReceiptpage?id=' + BookingId));
    }


    public PageReference saveArray() {
        system.debug('lstBooking.size() >>' + lstBooking.size());
        System.Debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Value of d1 inside the SaveArray method :' + d1);
        err = '';
        checklistHeader.Name = 'checklistHeader';
        checklistHeader.Booking__c = BookingId;
        insert(checklistHeader);
        system.debug('CheckLISTHEADER :- ' + checklistHeader.id);
        system.debug('ArrayApplicant1String ===>' + ArrayApplicant1String);
        ////////////Converting Applicant's DocumentArray into List//////////////////
        if (String.isNotBlank(ArrayApplicant1String)) {
            for (String eachStr: ArrayApplicant1String.split(',')) {
                ArrayApplicant1.add(eachStr);
            }
        }
        if (String.isNotBlank(ArrayApplicant2String)) {
            for (String eachStr: ArrayApplicant2String.split(',')) {
                ArrayApplicant2.add(eachStr);
            }
        }
        if (String.isNotBlank(ArrayApplicant3String)) {
            for (String eachStr: ArrayApplicant3String.split(',')) {
                ArrayApplicant3.add(eachStr);
            }
        }
        if (String.isNotBlank(ArrayApplicant4String)) {
            for (String eachStr: ArrayApplicant4String.split(',')) {
                ArrayApplicant4.add(eachStr);
            }
        }
        if (String.isNotBlank(ArrayApplicant5String)) {
            for (String eachStr: ArrayApplicant5String.split(',')) {
                ArrayApplicant5.add(eachStr);
            }
        }
        ////////////Adding Applicant1's Document to list if not Approved//////////////////
        if (ArrayApplicant1.size() > 0) {
            System.debug('ArrayApplicant1.size() - ' + ArrayApplicant1.size());
            for (i = 0; i < ArrayApplicant1.size(); i = i + 5) {
                Document_Checklist__c DocApp1 = new Document_Checklist__c();
                for (j = 0; j < ArrayApplicant1.size(); j++) {
                    DocApp1.Document_Checklist_Header__c = checklistHeader.id;
                    DocApp1.Name = 'Applicant 1';
                    DocApp1.Description__c = ArrayApplicant1[i + 1];
                    DocApp1.Verified__c = False;
                   // DocApp1.Rejection_Remarks__c = ArrayApplicant1[i + 5];
                }
                
                //System.debug('ArrayList class::'+ArrayApplicant1);
                if (ArrayApplicant1[i + 4] == 'false') {
                    
                    lstDocumentChecklistApplicant.add(DocApp1);
                }
            }
        }
        ////////////Adding Applicant2's Document to list if not Approved//////////////////
        if (ArrayApplicant2.size() > 0) {
            System.debug('ArrayApplicant2.size() - ' + ArrayApplicant2.size());
            for (i = 0; i < ArrayApplicant2.size(); i = i + 5) {
                Document_Checklist__c DocApp2 = new Document_Checklist__c();
                for (j = 0; j < ArrayApplicant2.size(); j++) {
                    DocApp2.Document_Checklist_Header__c = checklistHeader.id;
                    DocApp2.Name = 'Applicant 2';
                    DocApp2.Description__c = ArrayApplicant2[i + 1];
                    DocApp2.Verified__c = False;
                   // DocApp2.Rejection_Remarks__c = ArrayApplicant2[i + 5];
                }
                
                if (ArrayApplicant2[i + 4] == 'false') {
                   
                    lstDocumentChecklistApplicant.add(DocApp2);
                }
            }

        }
        ////////////Adding Applicant3's Document to list if not Approved//////////////////
        if (ArrayApplicant3.size() > 0) {
            System.debug('ArrayApplicant3.size() - ' + ArrayApplicant3.size());
            for (i = 0; i < ArrayApplicant3.size(); i = i + 5) {
                Document_Checklist__c DocApp3 = new Document_Checklist__c();
                for (j = 0; j < ArrayApplicant3.size(); j++) {
                    DocApp3.Document_Checklist_Header__c = checklistHeader.id;
                    DocApp3.Name = 'Applicant 3';
                    DocApp3.Description__c = ArrayApplicant3[i + 1];
                    DocApp3.Verified__c = False;
                  //  DocApp3.Rejection_Remarks__c = ArrayApplicant3[i + 5];
                }
               
                if (ArrayApplicant3[i + 4] == 'false') {
                   
                    lstDocumentChecklistApplicant.add(DocApp3);
                }
            }

        }
        ////////////Adding Applicant4's Document to list if not Approved//////////////////
        if (ArrayApplicant4.size() > 0) {
            System.debug('ArrayApplicant4.size() - ' + ArrayApplicant4.size());
            for (i = 0; i < ArrayApplicant4.size(); i = i + 5) {
                Document_Checklist__c DocApp4 = new Document_Checklist__c();
                for (j = 0; j < ArrayApplicant4.size(); j++) {
                    DocApp4.Document_Checklist_Header__c = checklistHeader.id;
                    DocApp4.Name = 'Applicant 4';
                    DocApp4.Description__c = ArrayApplicant4[i + 1];
                    DocApp4.Verified__c = False;
                    //DocApp4.Rejection_Remarks__c = ArrayApplicant4[i + 5];
                }
                
                if (ArrayApplicant4[i + 4] == 'false') {
                    
                    lstDocumentChecklistApplicant.add(DocApp4);
                }
            }

        }
        ////////////Adding Applicant5's Document to list if not Approved//////////////////
        if (ArrayApplicant5.size() > 0) {
            System.debug('ArrayApplicant5.size() - ' + ArrayApplicant5.size());
            for (i = 0; i < ArrayApplicant5.size(); i = i + 5) {
                Document_Checklist__c DocApp5 = new Document_Checklist__c();
                for (j = 0; j < ArrayApplicant5.size(); j++) {
                    DocApp5.Document_Checklist_Header__c = checklistHeader.id;
                    DocApp5.Name = 'Applicant 5';
                    DocApp5.Description__c = ArrayApplicant5[i + 1];
                    DocApp5.Verified__c = False;
                   // DocApp5.Rejection_Remarks__c = ArrayApplicant5[i + 5];
                }
                
                if (ArrayApplicant5[i + 4] == 'false') {
                    
                    lstDocumentChecklistApplicant.add(DocApp5);
                }
            }

        }
        
        btnReject();
        System.Debug('After the button reject call');
        return null;
    }

    //Copied method from the existing code 
    public void btnReject() {

        //Added to sent mail in case of booking ///

        /////To project site head ///
        System.debug('Inside reject');


        if (lstBooking[0].Project__r.Project_Site_Head__c != null) {
            LstUsersProjectSalesHead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_Site_Head__c];
        }
        System.debug('Inside reject1111');
        System.debug('lstBooking[0].Sales_Manager__c ' + lstBooking[0].Sales_Manager__c);
        ////For sales manager and Rm //////////   
        if (lstBooking[0].Sales_Manager__c != null && lstBooking[0].Ownerid != null) {
            System.debug('Inside mailing code');
            list < User > LstUsers = [select id, name, email, Salutation__c from user where id = : lstBooking[0].Sales_Manager__c];
            list < User > LstUsersRm = [select id, name, email, Salutation__c from user where id = : lstBooking[0].Ownerid];

            String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
            string PageLink = '/apex/S_ProcessDocumentVerification';
            string strBookingHtmlBody = 'Dear ' + ' ' + LstUsers[0].Salutation__c + ' ' + LstUsers[0].Name + ',<br></br><br></br>' +
                'Booking failed at documents processing stage for following reasons. <br></br>' +
                'Please provide the necessary documents to process the booking. <br></br>' +
                baseUrl + PageLink + '<br></br> <br></br>' +

            'Regards <br></br>' +
                'Solitaire Care Desk';

            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            mail.setHtmlBody(strBookingHtmlBody);
            list < string > lststringtoaddress = new list < string > ();
            system.debug('lststringtoaddress' + lststringtoaddress);
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

            System.debug('lststringtoaddress' + lststringtoaddress);
            mail.setToAddresses(lststringtoaddress);
            mail.setSubject('Booking Failed Notification | Booking Proccessing stage');
            Messaging.sendEmail(new Messaging.Singleemailmessage[] {
                mail
            });
            System.debug('After Mail Sent ');

        }
        //mail sending ends here  ///


        // Update the Project Unit Status
        if (ApexPages.currentPage().getParameters().get('bookingid') != null && ApexPages.currentPage().getParameters().get('bookingid') != '')
            BookingId = ApexPages.currentPage().getParameters().get('bookingid');
        if (BookingId != null && BookingId != '') {
            Booking__c updateBooking = new Booking__c();
            updateBooking.id = Id.ValueOf(BookingId);
            updateBooking.Document_Checklist_Header__c = checklistHeader.id;
            updateBooking.Verification_status__c = 'Rejected';
            updateBooking.Flat_Applicants__c = ApplicantNames;


            if (lstBooking != null && lstBooking.size() > 0) {


                System.Debug('Value of the d1:' + d1);
                
                if (d1 == False) {
                    DocRow1.Name = 'N/A';
                    DocRow1.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow1.Rejection_Remarks__c = drow1;
                    //DocRow1.Details__c = lstBooking[0].Future_Correspondence_Contact_Name__c;
                    lstDocumentChecklistApplicant.add(DocRow1);
                }
                if (d2 == False) {
                    DocRow2.Name = 'N/A';
                    DocRow2.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow2.Rejection_Remarks__c = drow2;
                    lstDocumentChecklistApplicant.add(DocRow2);
                }
                
                if (d3 == False) {
                    DocRow3.Name = 'N/A';
                    DocRow3.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow3.Rejection_Remarks__c = drow3;
                    lstDocumentChecklistApplicant.add(DocRow3);
                }
                if (d4 == False) {
                    DocRow4.Name = 'N/A';
                    DocRow4.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow4.Rejection_Remarks__c = drow4;
                    lstDocumentChecklistApplicant.add(DocRow4);
                }
                if (d5 == False) {
                    DocRow5.Name = 'N/A';
                    DocRow5.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow5.Rejection_Remarks__c = drow5;
                    lstDocumentChecklistApplicant.add(DocRow5);
                }
                if (d6 == False) {
                    DocRow6.Name = 'N/A';
                    DocRow6.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow6.Rejection_Remarks__c = drow6;
                    lstDocumentChecklistApplicant.add(DocRow6);
                }
                if (d7 == False) {
                    DocRow7.Name = 'N/A';
                    DocRow7.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow7.Rejection_Remarks__c = drow7;
                    lstDocumentChecklistApplicant.add(DocRow7);
                }
                if (d8 == False) {
                    DocRow8.Name = 'N/A';
                    DocRow8.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow8.Rejection_Remarks__c = drow8;
                    lstDocumentChecklistApplicant.add(DocRow8);
                }
                if (d9 == False) {
                    DocRow9.Name = 'N/A';
                    DocRow9.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow9.Rejection_Remarks__c = drow9;
                    DocRow9.Details__c = lstBooking[0].Future_Correspondence_Contact__c;
                    lstDocumentChecklistApplicant.add(DocRow9);
                }
                
                if (d10 == False) {
                    DocRow10.Name = 'N/A';
                    DocRow10.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow10.Rejection_Remarks__c = drow10;
                    DocRow10.Details__c = lstBooking[0].Future_Correspondence_Contact_Relation__c;
                    lstDocumentChecklistApplicant.add(DocRow10);
                }
                if (d11 == False) {
                    DocRow11.Name = 'N/A';
                    DocRow11.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow11.Rejection_Remarks__c = drow11;
                    DocRow11.Details__c = lstBooking[0].Future_Correspondence_Contact_Name__c;
                    lstDocumentChecklistApplicant.add(DocRow11);
                }
                if (d12 == False) {
                    DocRow12.Name = 'N/A';
                    DocRow12.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow12.Rejection_Remarks__c = drow12;
                    DocRow12.Details__c = lstBooking[0].Future_Correspondence_Contact_Phone__c;
                    lstDocumentChecklistApplicant.add(DocRow12);
                }
                if (d13 == False) {
                    DocRow13.Name = 'N/A';
                    DocRow13.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow13.Rejection_Remarks__c = drow13;
                    DocRow13.Details__c = lstBooking[0].Future_Correspondence_Contact_Email__c;
                    lstDocumentChecklistApplicant.add(DocRow13);
                }
                if (d14 == False) {
                    DocRow14.Name = 'N/A';
                    DocRow14.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow14.Rejection_Remarks__c = drow14;
                    DocRow14.Details__c = string.valueOfGmt(lstBooking[0].Booking_Date__c);
                    lstDocumentChecklistApplicant.add(DocRow14);
                }
                if (d15 == False) {
                    DocRow15.Name = 'N/A';
                    DocRow15.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow15.Rejection_Remarks__c = drow15;
                    DocRow15.Details__c = lstBooking[0].Wing__c;
                    lstDocumentChecklistApplicant.add(DocRow15);
                }
                if (d16 == False) {
                    DocRow16.Name = 'N/A';
                    DocRow16.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow16.Rejection_Remarks__c = drow16;
                    DocRow16.Details__c = lstBooking[0].Flat_Typology__c;
                    lstDocumentChecklistApplicant.add(DocRow16);
                }
                 if (d17 == False) {
                    DocRow17.Name = 'N/A';
                    DocRow17.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow17.Rejection_Remarks__c = drow17;
                    DocRow17.Details__c = lstBooking[0].Floor1__c;
                    lstDocumentChecklistApplicant.add(DocRow17);
                }
                if (d18 == False) {
                    DocRow18.Name = 'N/A';
                    DocRow18.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow18.Rejection_Remarks__c = drow18;
                    DocRow18.Details__c = lstBooking[0].Flat_No__c;
                    lstDocumentChecklistApplicant.add(DocRow18);
                }
                
                if (d19 == False) {
                    DocRow19.Name = 'N/A';
                    DocRow19.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow19.Rejection_Remarks__c = drow19;
                    DocRow19.Details__c = string.valueOf(lstBooking[0].Carpet_Area__c);
                    lstDocumentChecklistApplicant.add(DocRow19);
                }
                if (d20 == False) {
                    DocRow20.Name = 'N/A';
                    DocRow20.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow20.Rejection_Remarks__c = drow20;
                    DocRow20.Details__c = string.valueOf(lstBooking[0].Unit_No__r.Terrace_Area__c);
                    lstDocumentChecklistApplicant.add(DocRow20);
                }
                if (d21 == False) {
                    DocRow21.Name = 'N/A';
                    DocRow21.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow21.Rejection_Remarks__c = drow21;
                    DocRow21.Details__c = string.valueOf(lstBooking[0].No_of_Parking__c);
                    lstDocumentChecklistApplicant.add(DocRow21);
                }
                if (d22 == False) {
                    DocRow22.Name = 'N/A';
                    DocRow22.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow22.Rejection_Remarks__c = drow22;
                    DocRow22.Details__c = string.valueOf(alotment);
                    lstDocumentChecklistApplicant.add(DocRow22);
                }
                if (d23 == False) {
                    DocRow23.Name = 'N/A';
                    DocRow23.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow23.Rejection_Remarks__c = drow23;
                    //DocRow13.Details__c = lstBooking[0].Future_Correspondence_Contact_Email__c;
                    lstDocumentChecklistApplicant.add(DocRow23);
                }
               
                if (d24 == False) {
                    DocRow24.Name = 'N/A';
                    DocRow24.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow24.Rejection_Remarks__c = drow24;
                    DocRow24.Details__c = lstBooking[0].Source_of_Booking__c + subsource;
                    lstDocumentChecklistApplicant.add(DocRow24);
                }
                if (d25 == False) {
                    DocRow25.Name = 'N/A';
                    DocRow25.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow25.Rejection_Remarks__c = drow25;
                    DocRow25.Details__c = lstBooking[0].Sales_Managers__c;
                    lstDocumentChecklistApplicant.add(DocRow25);
                }
                if (d26 == False) {
                    DocRow26.Name = 'N/A';
                    DocRow26.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow26.Rejection_Remarks__c = drow26;
                    DocRow26.Details__c = string.valueOf(lstBooking[0].Quotation__r.Base_Rate_PSF__c);
                    lstDocumentChecklistApplicant.add(DocRow26);
                }
                if (d27 == False) {
                    DocRow27.Name = 'N/A';
                    DocRow27.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow27.Rejection_Remarks__c = drow27;
                    DocRow27.Details__c = string.valueOf(lstBooking[0].Quotation__r.Customer_Total_Discount_PSF__c) ;
                    lstDocumentChecklistApplicant.add(DocRow27);
                }
                if (d28 == False) {
                    DocRow28.Name = 'N/A';
                    DocRow28.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow28.Rejection_Remarks__c = drow28;
                    DocRow28.Details__c = string.valueOf(alotment) ;
                    lstDocumentChecklistApplicant.add(DocRow28);
                }
                if (d29 == False) {
                    DocRow29.Name = 'N/A';
                    DocRow29.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow29.Rejection_Remarks__c = drow29;
                    DocRow29.Details__c = lstBooking[0].Level_Three_Approver__r.Name+','+lstBooking[0].Level_Two_Approver__r.Name;
                    lstDocumentChecklistApplicant.add(DocRow29);
                }
                if (d30 == False) {
                    DocRow30.Name = 'N/A';
                    DocRow30.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow30.Rejection_Remarks__c = drow30;
                    //DocRow30.Details__c = lstBooking[0].Level_Three_Approver__r.Name+','+lstBooking[0].Level_Two_Approver__r.Name;
                    lstDocumentChecklistApplicant.add(DocRow30);
                }
                if (d31 == False) {
                    DocRow31.Name = 'N/A';
                    DocRow31.Document_Checklist_Header__c = checklistHeader.id;
                    DocRow31.Rejection_Remarks__c = drow31;
                    DocRow31.Details__c = lstBooking[0].Level_Three_Approver__r.Name+','+lstBooking[0].Level_Two_Approver__r.Name ;
                    lstDocumentChecklistApplicant.add(DocRow31);
                }
                
               

                system.debug(' lstDocumentChecklistApplicant' + lstDocumentChecklistApplicant.size());
                if (lstDocumentChecklistApplicant.size() > 0) {
                    insert(lstDocumentChecklistApplicant);
                    //system.debug('inserted Idddd' + lstDocumentChecklistApplicant[1].id);
                }

                List < Project_Unit__c > lstPU = [Select Id, Name, Reason_For_CRM_returns_to_sales__c from Project_Unit__c Where Id = : lstBooking[0].Unit_No__c limit 1];
                System.Debug('lstPSU' + lstPU);
                if (lstPU != null && lstPU.size() > 0) {
                    ///////////////Adding to change the unit status field///////////////////////////////
                    lstPU[0].Unit_Status__c = 'CRM Returned To Sales';
                    lstPU[0].Reason_For_CRM_returns_to_sales__c = 'Physical Document Rejected';


                    System.Debug('Unit status to be changed to CRM returned to sales');
                    update lstPU;
                    if (updateBooking != null) {
                        update updateBooking;
                    }
                } else {
                    System.Debug('No unit associated for the booking');
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning, 'There is no Project Unit in this Booking.'));
                }
            }
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'The document has been rejected and returned to sales'));
        isRejected = true;
    }


    //Copied method from the existing code     
    public pagereference Accept() {
        ///////////////////////////////Anuja writing validation for checking all documents verified or not///////////////////////////
        System.debug('inside Accept');

        System.Debug('lstDocumentChecklist' + lstDocumentChecklist);
        if (ApexPages.currentPage().getParameters().get('bookingid') != null && ApexPages.currentPage().getParameters().get('bookingid') != '') BookingId = ApexPages.currentPage().getParameters().get('bookingid');
        if (BookingId != null && BookingId != '') {

            List < Booking__c > lstBooking = [Select Id, Name, Sales_Manager__c, Project__r.Project_Site_Head__c, /** Customer__r.Account.Salutation, **/ Ownerid, Unit_No__r.Name, Project__r.Name, Customer__r.Name, LastModifiedDate, Customer__c, Customer__r.project_unit__c, Unit_No__c from Booking__c Where Id = : BookingId];
            System.Debug('lstBooking' + lstBooking);
            if (lstBooking != null && lstBooking.size() > 0) {
                Booking__c updateAcceptBooking = new Booking__c();
                updateAcceptBooking.id = lstBooking[0].Id;
                updateAcceptBooking.Verification_status__c = 'Accepted';
                updateAcceptBooking.Document_Checklist_Header__c = null;
                updateAcceptBooking.Flat_Applicants__c = ApplicantNames;
                update updateAcceptBooking;

                List < Project_Unit__c > lstPU = [Select Id, Name, Unit_Status__c, Reason_For_CRM_returns_to_sales__c from Project_Unit__c Where Id = : lstBooking[0].Unit_No__c limit 1];
                System.Debug('lstPU' + lstPU);
                if (lstPU != null && lstPU.size() > 0) {
                    if (lstBooking[0].Customer__r.project_unit__c != null) {
                        System.Debug('Inside the if condition- checking the project unit on opty');
                        if (lstPU[0].Unit_Status__c == 'BIP - RM Verification' || (lstPU[0].Unit_Status__c == 'CRM Returned To Sales' && lstPU[0].Reason_For_CRM_returns_to_sales__c == 'Physical Document Rejected')) {
                            lstPU[0].Unit_Status__c = 'Welcome Call Pending';
                            update lstPU;
                            //Added to sent mail in case of booking ///


                            /// to RCD ///
                            System.debug('Inside mailing code on accept');
                            list < User > LstUsersRCD = [select id, name, email, Salutation__c from user where Name = : 'RCD'];

                            String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
                            string PageLink = '/apex/S_PickWelcomeCall';
                            string strBookingHtmlBody = 'Dear RCD Team ,<br></br>' +
                                'Welcome call for' + ' ' + /**lstBooking[0].Customer__r.Account.Salutation + ' ' + **/lstBooking[0].Customer__r.Name + ', Flat - ' + lstBooking[0].Unit_No__r.Name + 'in ' + lstBooking[0].Project__r.Name + ' is in queue on ' + ' ' + lstBooking[0].LastModifiedDate + '<br></br>' +
                                'please click the following link to accept and process the booking further.' + '<br></br>' +
                                baseUrl + PageLink;

                            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                            mail.setHtmlBody(strBookingHtmlBody);
                            list < string > lststringtoaddress = new list < string > ();

                            if (LstUsersRCD.size() > 0) {
                                System.debug('inside LstUsersRCD ');
                                lststringtoaddress.add(LstUsersRCD[0].Email);

                                System.debug('lststringtoaddress' + lststringtoaddress);
                                mail.setToAddresses(lststringtoaddress);
                                mail.setSubject('Booking Accepted Notification | Booking Proccessing stage');
                                Messaging.sendEmail(new Messaging.Singleemailmessage[] {
                                    mail
                                });
                                System.debug('After Mail Sent in ACCEPT to RCD');
                            }


                            ///For RCD ENDS Here//////////////// 

                            ////Project Site Head //////////                   
                            if (lstBooking[0].Project__r.Project_Site_Head__c != null) {
                                LstUsersProjectSalesHead = [select id, name, email from user where id = : lstBooking[0].Project__r.Project_Site_Head__c];
                            }

                            ////For sales manager and Rm //////////   
                            if (lstBooking[0].Sales_Manager__c != null && lstBooking[0].Ownerid != null) {

                                list < User > LstUsers = [select id, name, email, Salutation__c from user where id = : lstBooking[0].Sales_Manager__c];
                                list < User > LstUsersRm = [select id, name, email, Salutation__c from user where id = : lstBooking[0].Ownerid];

                                string strBookingHtmlBodyNew = 'Dear ' + LstUsers[0].Salutation__c + ' ' + LstUsers[0].Name + ',<br></br> ' +

                                'Booking is at Document Verifica stage - physical documentation successful.' + '<br></br><br></br>' +

                                'Regards <br></br>' +
                                    'Solitaire Care Desk';

                                Messaging.Singleemailmessage mailNEW = new Messaging.Singleemailmessage();
                                mailNEW.setHtmlBody(strBookingHtmlBodyNew);
                                list < string > lststringtoaddressNew = new list < string > ();
                                if (LstUsers.size() > 0) {
                                    System.debug('inside LstUsers');
                                    lststringtoaddressNew.add(LstUsers[0].Email);


                                }
                                if (LstUsersRm.size() > 0) {
                                    System.debug('inside LstUsersRm ');
                                    lststringtoaddressNew.add(LstUsersRm[0].Email);
                                }
                                if (LstUsersProjectSalesHead.size() > 0) {
                                    System.debug('inside LstUsersProjectSalesHead  ');
                                    lststringtoaddressNew.add(LstUsersProjectSalesHead[0].Email);
                                }
                                if (lststringtoaddressNew.size() > 0) {
                                    System.debug('lststringtoaddressNew ' + lststringtoaddressNew);
                                    mailNEW.setToAddresses(lststringtoaddressNew);
                                    mailNEW.setSubject('Booking Accept Notification | Booking Proccessing stage');
                                    Messaging.sendEmail(new Messaging.Singleemailmessage[] {
                                        mailNEW
                                    });
                                    System.debug('After Mail Sent on accept to others ');
                                }
                            }
                            //mail sending ends here  ///

                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'The documents have been successfully verified for this booking.'));
                            isAccepted = true;
                            return null;
                        } else {
                            System.Debug('Inside the else condition.');
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning, 'Unit status must be "BIP - RM Verification" to Accept ( Opportunity must be marked as Physically Document Received ).'));
                            return null;
                        }
                    } else {
                        System.Debug('if the project unit on opty is null');
                        lstPU[0].Unit_Status__c = 'Welcome Call Pending';
                        update lstPU;
                        ApexPages.PageReference page = new ApexPages.PageReference('/' + BookingId);
                        return page;
                    }

                } else {
                    System.Debug('no unit associated to the booking');
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning, 'There is no Project Unit in this Booking.'));
                    isAccepted = true;
                    return null;
                }
            }


        }


        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'The document has been accepted'));
        isAccepted = true;
        return null;
    }

}