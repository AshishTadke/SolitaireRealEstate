public with sharing class BookingClassForCancellation {
    public Booking__c bookingObj {
        get;
        set;
    }
    public Id bookingId {
        get;
        set;
    } //For Getting Booking Id 
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
    public Id optyId {
        get;
        set;
    }
    public string errorMsg {
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
    //public Date datetoday {get; set;}
    public DateTime dateTimeToday {
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
    }Public Integer k {
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
    public Boolean addressCheck {
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
    public String refereeName {
        get;
        set;
    }
    public boolean isError {
        get;
        set;
    }
    //-----------------------------Added by ashish for canceling parking-----------//
    
    List <Car_Parking_Charge__c>  ParkingListToUpdate = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  StackParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleDepParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  SingleIndepParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TandemCOVEREDParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  PuzzelParkingList = new List <Car_Parking_Charge__c>();
    List <Car_Parking_Charge__c>  TwoWheelerParkingList = new List <Car_Parking_Charge__c>();
    
    public List < Applicant_Details__c > listApplicant {get;set;}
    List < booking__c > listBooking = new list < booking__c > ();
    List < booking__c > bookingList = new list < booking__c > ();
    List < Opportunity > listOpportunity = new list < Opportunity > ();
    List < Project_Unit__c > listUnit = new list < Project_Unit__c > ();

    public BookingClassForCancellation() {

            //System.debug('inside cunstrructuiedipoi');
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
            bookingObj = new Booking__c();
            listApplicant = new list < Applicant_Details__c > ();
            //datetoday = system.today();
            //-----------------------------Added by ashish for canceling parking-----------//
                        
            ParkingListToUpdate  = new List<Car_Parking_Charge__c>();
            PuzzelParkingList = new List <Car_Parking_Charge__c>();
            TwoWheelerParkingList = new List <Car_Parking_Charge__c>();
            SingleDepParkingList = new List <Car_Parking_Charge__c>();
            SingleIndepParkingList = new List <Car_Parking_Charge__c>();
            TandemCOVEREDParkingList = new List <Car_Parking_Charge__c>();
            StackParkingList = new List <Car_Parking_Charge__c>();
            
            dateTimeToday = system.Now();
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
            refereeName = '';
            isError = false;
            if (ApexPages.currentPage().getParameters().get('Id') != null && ApexPages.currentPage().getParameters().get('Id') != '') {
                // system.debug('optyid' +optyid);

                bookingId = ApexPages.currentPage().getParameters().get('Id');
                system.debug('Booking Id :' + bookingId);

                listBooking = [SELECT Id, Opportunity__c, Customer__c, Customer__r.Id, Status__c, Quotation__c, Token_Amount__c, ST_Token_Amount__c, Application_No__c, Future_Correspondence_Contact__c,
                    Future_Correspondence_Contact_Relation__c, Future_Correspondence_Contact_Name__c, Future_Correspondence_Contact_Phone__c,
                    Future_Correspondence_Contact_Email__c, Source_of_Booking__c, Referred_By__c, Name_of_Referer_Direct_Corporate_Book__c,
                    Project__c, Unit_No__c, Booking_Date__c, Date_of_Cancellation__c, Reason_For_Cancellation__c FROM booking__c where Id = : bookingId
                ];
                
            QuoteDetails = [SELECT id,Tandem_car_park_Additional__c,Single_car_park_Additional__c,Two_Wheeler_Additional__c,Tandem_Open_Additional__c,Single_Open_Additional__c, PaymentPlan__c,PaymentPlan__r.Sub_Vention__c,Stack_Additional__c,Name,
            Booking__c,Allow_booking_without_full_token__c,Agreement_Value__c,Carpet_Area_Sq_Ft__c,Appartment_Configuration__c, Project__c, Service_Tax_On_Token_Amount__c, 
            Project_Unit__c, Token_Amount__c, ST_Token_Amount__c, Zone__c, Wing__c, Flat_Typology__c, FloorNo__c,FloorNo1__c, Carpet_Area__c, No_of_parking__c, Parking_Type__c, 
            Allotment_Premium_Agreement_Value__c,Agreement_Value_D__c, FlatNo__c,Level_One_Approver__c,Level_Two_Approver__c,Level_Three_Approver__c
            FROM Quotation__c WHERE id = : listBooking[0].Quotation__c];

                system.debug('ListBooking Details : ' + listBooking);
                
                k = 0;
                //parking type changed
                if (QuoteDetails[0].Tandem_car_park_Additional__c != null && QuoteDetails[0].Tandem_car_park_Additional__c > 0) { ///tandem covered//comented
                       k=1;    
                        TandemCOVEREDParkingList = [Select id,Parking__c,Status__c,Category__c,Name From Car_Parking_Charge__c where Parking__c =: 'Dependable-Stack' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('TandemCOVEREDParkingList Size ..........)  ' +TandemCOVEREDParkingList.size());
                    
               }
               if (QuoteDetails[0].Tandem_Open_Additional__c != null && QuoteDetails[0].Tandem_Open_Additional__c > 0) { ///tandem Open//Stack
                   k=1;
                    StackParkingList = [Select id,Parking__c,Status__c,Category__c,Name From Car_Parking_Charge__c where Parking__c =: 'Stack' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('StackParkingList Size ..........)  ' +StackParkingList.size());
               }
               
               if (QuoteDetails[0].Single_car_park_Additional__c != null && QuoteDetails[0].Single_car_park_Additional__c > 0) { // single covered//Single - Independent
                   k=1;
                    SingleIndepParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Single - Independent' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('SingleIndepParkingList Size ..........)  ' +SingleIndepParkingList.size());
               }
               
               if (QuoteDetails[0].Single_Open_Additional__c != null && QuoteDetails[0].Single_Open_Additional__c > 0) { // single Open//Single- Dependent
                   k=1;
                    SingleDepParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Single- Dependent' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('SingleDepParkingList Size ..........)  ' +SingleDepParkingList.size());
               }
               if (QuoteDetails[0].Stack_Additional__c != null && QuoteDetails[0].Stack_Additional__c > 0) { // Stack//Puzzle
                   k=1;
                    PuzzelParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Puzzle' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('PuzzelParkingList Size ..........)  ' +PuzzelParkingList.size());
               }
               if (QuoteDetails[0].Two_Wheeler_Additional__c != null && QuoteDetails[0].Two_Wheeler_Additional__c > 0) { // Stack//Puzzle
                   k=1;
                    TwoWheelerParkingList = [Select id,Parking__c,Category__c,Status__c,Name From Car_Parking_Charge__c where Parking__c =: 'Two Wheeler' and Status__c =: 'Booked' and Category__c =: 'Additional' and Project__c =: listBooking[0].Project__c];
                    System.debug('TwoWheelerParkingList Size ..........)  ' +TwoWheelerParkingList.size());
               }

                for (integer i = 0; i < listBooking.size(); i++) {
                    bookingObj.Id = listBooking[i].Id; // For Booking Cancellation
                    bookingObj.Opportunity__c = listBooking[i].Opportunity__c;
                    bookingObj.Quotation__c = listBooking[i].Quotation__c;
                    bookingObj.Token_Amount__c = listBooking[i].Token_Amount__c;
                    bookingObj.ST_Token_Amount__c = listBooking[i].ST_Token_Amount__c;
                    // commented by priya on 24 jan Application No is not writable    
                    bookingObj.Future_Correspondence_Contact__c = listBooking[i].Future_Correspondence_Contact__c;
                    bookingObj.Future_Correspondence_Contact_Relation__c = listBooking[i].Future_Correspondence_Contact_Relation__c;
                    bookingObj.Future_Correspondence_Contact_Name__c = listBooking[i].Future_Correspondence_Contact_Name__c;
                    bookingObj.Future_Correspondence_Contact_Phone__c = listBooking[i].Future_Correspondence_Contact_Phone__c;
                    bookingObj.Future_Correspondence_Contact_Email__c = listBooking[i].Future_Correspondence_Contact_Email__c;
                    bookingObj.Referred_By__c = listBooking[i].Referred_By__c;
                    if (listBooking[i].Name_of_Referer_Direct_Corporate_Book__c != null)
                        refereeName = listBooking[i].Name_of_Referer_Direct_Corporate_Book__c;
                    //else if (listBooking[i].Referee_CP_Name__c != null)
                     //   refereeName = listBooking[i].Referee_CP_Name__c;
                    bookingObj.Name_of_Referer_Direct_Corporate_Book__c = listBooking[i].Name_of_Referer_Direct_Corporate_Book__c;
                    bookingObj.Project__c = listBooking[i].Project__c;
                    if(listBooking[i].Unit_No__c != null)
                        bookingObj.Unit_No__c = listBooking[i].Unit_No__c;
                    else if(listBooking[i].Unit_No__c!= null)
                        bookingObj.Unit_No__c= listBooking[i].Unit_No__c;
                    bookingObj.Booking_Date__c = listBooking[i].Booking_Date__c;
                    bookingObj.Reason_For_Cancellation__c = listBooking[i].Reason_For_Cancellation__c; //For Booking Cancellation 
                    //bookingObj.Unit_No__c= listBooking[i].Unit_No__c; //For Booking Cancellation
                    bookingObj.Date_of_Cancellation__c = listBooking[i].Date_of_Cancellation__c;
                    bookingObj.Status__c = listBooking[i].Status__c; //For Booking Cancellation
                    bookingObj.Customer__c = listBooking[i].Customer__c;

                }

                if (bookingObj.Status__c == 'Cancelled') {
                    errorMsg = 'This Booking has been Cancelled!';
                    /*ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'This Booking is already Cancelled!');
                    ApexPages.addMessage(myMsg);*/
                }

                // For Applicant details:
                listApplicant = [SELECT Id, Salutation__c, Name, DOB__c, Permanent_Address__c,
                    Pincode__c,
                    Organisation_Pincode__c, Mailing_Pincode__c, Country__c,
                    Mailing_Address__c, Mailing_Country__c, Mobile_Number__c, Email_Address__c,
                    Nationality__c, Landline_Number__c, Occupation__c, Organization_Name__c, Designation__c,
                    Organization_Address__c, Organisation_Country__c, Organization_Phone_numbers__c,
                    Other_Details_Remarks__c, Type_Of_Applicant__c, Subtype_Of_Applicant__c, Pancard__c, PancardNo__c, Pan_Card_Number_of_Authority_Signatory__c,
                    Address_Proof__c, Address_Proof_Document__c, Address_Proof_Number__c, One_Passport_Size_Color_Photograph__c,
                    Funds_from_NRE_FCNR__c, Self_attested_copy_of_PIO_or_OCI_Card__c, Type_Of_Origin__c, Origin_Details__c,
                    PassportNumber__c, PassportNoDetails__c, Funds_from_NRE_NRO__c, Copy_of_Workpermit_Employment_contract__c, Copy_of_Memorandu_of_Association__c, Certified_copy_of_Article_of_Association__c,
                    Certified_copy_of_Board_Resolution__c, Certified_copy_of_ROC_Incorporation__c,
                    Self_attested_List_of_Shareholders__c, Self_attested_List_of_Directors__c,
                    PanCard_of_Authority_Signatory__c, Certified_copy_of_Partnership_Deed__c, Certified_extract_of_Registration__c,
                    Copy_of_Authorization_Letter_POA__c FROM Applicant_Details__c WHERE Booking__c = : bookingId
                ];
                system.debug('listApplicant' + listApplicant);

                if (listApplicant.size() > 0) {
                    applicant = listApplicant[0];
                }
                system.debug('Applicant : ' + applicant);

                if (listApplicant.size() > 1) {
                    applicant2 = listApplicant[1];
                }
                system.debug('Applicant2 : ' + applicant2);
                if (listApplicant.size() > 2) {
                    applicant3 = listApplicant[2];
                }
                system.debug('Applicant3 : ' + applicant3);
                if (listApplicant.size() > 3) {
                    applicant4 = listApplicant[3];
                }
                system.debug('Applicant4 : ' + applicant4);
                if (listApplicant.size() > 4) {
                    applicant5 = listApplicant[4];
                }
                system.debug('Applicant5 : ' + applicant5);
            }

            try {
                ReceiptDetails = [SELECT id, Name, DraweeBank__c, CreatedDate, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Cheque_DD_Amount_Rs__c,
                    Cheque_DD_Date__c FROM Receipt__c WHERE Opportunity__c = : bookingObj.Opportunity__c and Token_Amount_Receipt__c = true
                ];
                if (ReceiptDetails.size() > 0) {
                    bookingObj.Booking_Date__c = ReceiptDetails[0].CreatedDate;
                }
                STReceiptDetails = [SELECT id, Name, DraweeBank__c, LastModifiedDate, Token_Amount_Receipt__c, Due_Amount_Rs__c, Mode__c, Branch__c, Cheque_DD_Amount_Rs__c,
                    Cheque_DD_Date__c FROM Receipt__c WHERE Opportunity__c = : bookingObj.Opportunity__c and Token_Amount_ST__c = true
                ];
                system.debug('ReceiptDetails -------- ' + ReceiptDetails.size());
                system.debug('STReceiptDetails -------- ' + STReceiptDetails.size());
            } catch (DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());

            }

        } //Constructor Closed.

    // Cancel Method Starts.
    public PageReference Cancel() {
        isError = false;
            if(bookingObj.Reason_for_cancellation__c == null) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please Enter Reason for cancellation!');
                ApexPages.addMessage(myMsg);
                isError = true;
            }
            //if(bookingObj.Unit_Status_After_Cancellation__c == null) {
              //  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please enter Unit status after cancellation!');
                //ApexPages.addMessage(myMsg);
                //isError = true;
            //}
            if(isError == false) {
                //Update Opportunity
                if(bookingObj.Customer__c != null)
                    listOpportunity = [SELECT Id, Status__c, StageName, Project_Unit__c, Reason_For_Cancellation__c FROM Opportunity WHERE Id = : bookingObj.Customer__c];
                else if(bookingObj.Opportunity__c != null)
                    listOpportunity = [SELECT Id, Status__c, StageName, Project_Unit__c, Reason_For_Cancellation__c FROM Opportunity WHERE Id = : bookingObj.Opportunity__c];
                listOpportunity[0].Status__c = 'Inactive';
                listOpportunity[0].StageName = 'Cancelled';
                //listOpportunity[0].Reason_for_Closed_Lost__c = 'Booking Cancelled';
                listOpportunity[0].Project_Unit__c = null;
                listOpportunity[0].Reason_For_Cancellation__c = bookingObj.Reason_For_Cancellation__c;
                update listOpportunity;
    
                //Update Booking Details
                bookingList = [SELECT Id, Status__c, Quotation__c,Quotation__r.Quote_Status__c, Date_of_Cancellation__c, Reason_For_Cancellation__c FROM Booking__c WHERE Id = : bookingId];
                bookingList[0].Status__c = 'Cancelled';
                bookingList[0].Date_of_Cancellation__c = dateTimetoday;
                bookingList[0].Reason_For_Cancellation__c = bookingObj.Reason_For_Cancellation__c;
                update bookingList;


         
                
                //Update Unit
                if(bookingObj.Unit_No__c != null)
                    listUnit = [SELECT Id, Status__c, Customers__c, Booking__c FROM Project_Unit__c WHERE Id = : bookingObj.Unit_No__c];
               
                if(!listUnit.isEmpty()) {
                    listUnit[0].Unit_Status__c= 'Vacant';
                    listUnit[0].Customers__c = null;
                    listUnit[0].Booking__c = null;
                    update listUnit;
                }
                
                
//Updating Parkings/////
          
           ////Tandem Covered////
           if (QuoteDetails[0].Tandem_car_park_Additional__c > 0 ){
                 system.debug('TandemCOVEREDParkingList requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Tandem_car_park_Additional__c ; j++)
                 {
                 
                     TandemCOVEREDParkingList[j].Status__c =  'Vacant'; 
                     ParkingListToUpdate.add(TandemCOVEREDParkingList[j]);
                 }
                 
           }
           ////Tandem Open////
           if (QuoteDetails[0].Tandem_Open_Additional__c > 0){
                 system.debug('StackParkingList');
                 for(integer j = 0 ; j < QuoteDetails[0].Tandem_Open_Additional__c ; j++)
                 {
                 
                     StackParkingList[j].Status__c =  'Vacant'; 
                     ParkingListToUpdate.add(StackParkingList[j]);
                 }
                 
           }
           ////Single Open////
           if (QuoteDetails[0].Single_Open_Additional__c > 0 ){
                 system.debug('SingleDepParkingList requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Single_Open_Additional__c ; j++)
                 {
                 
                     SingleDepParkingList[j].Status__c =  'Vacant'; 
                     ParkingListToUpdate.add(SingleDepParkingList[j]);
                 }
                 
           }
           ////Single Covered////
           if (QuoteDetails[0].Single_car_park_Additional__c > 0){
                 system.debug('SingleIndepParkingList  Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Single_car_park_Additional__c ; j++)
                 {
                     SingleIndepParkingList[j].Status__c = 'Vacant'; 
                     ParkingListToUpdate.add(SingleIndepParkingList[j]);
                 
                 }
                 
           }
           //////Stack ////
           if (QuoteDetails[0].Stack_Additional__c > 0){
                 system.debug('PuzzelParkingList Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Stack_Additional__c ; j++)
                 {
                     PuzzelParkingList[j].Status__c = 'Vacant'; 
                     ParkingListToUpdate.add(PuzzelParkingList[j]);
                 
                 }                 
           }     
           if (QuoteDetails[0].Two_Wheeler_Additional__c > 0){
                 system.debug('TwoWheelerParkingList Requires');
                 for(integer j = 0 ; j < QuoteDetails[0].Two_Wheeler_Additional__c ; j++)
                 {
                     TwoWheelerParkingList[j].Status__c = 'Vacant'; 
                     ParkingListToUpdate.add(TwoWheelerParkingList[j]);
                 
                 }                 
           }     
           
            if(ParkingListToUpdate.size() > 0){
            system.debug('ParkingListToUpdate...........' +ParkingListToUpdate.size());
                update ParkingListToUpdate;
            }               
    
                     
              
                
                if (bookingObj.Id != null) {
                    PageReference newpage = new Pagereference('/' + bookingObj.Id);
                    return newpage;
                }

            
          }
            return null;
        } // Cancel Method Closed.
        public pageReference Cancelchanges() {
            //PageReference newpage;
            System.debug('inside cancel changes method::'+bookingId);
            if (bookingId != null) {
                PageReference newpage = new Pagereference('/' + bookingId);
                newpage.setRedirect(true);
                return newpage;
            }
            return null;
        }
}