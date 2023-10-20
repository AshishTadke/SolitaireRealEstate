public with sharing class S_CancellationLetter {
        public String strcancelId {
            get;
            set;
        }
        public String strMode {
            get;
            set;
        }
        public Boolean letterH {
            get;
            set;
        }
        public Opportunity customer {
            get;
            set;
        }
        public Cancellation_Intimation__c cLetter {
            get;
            set;
        }
        public String CustomerPrimaryName {
        get;
        set;
        }
        public String CustomerOtherApplicantName {
            get;
            set;
        }
        public String CustomerMailingAddress {
            get;
            set;
        }
        public String CustomerMobilePhone {
            get;
            set;
        }
        public String projectImage {
            get;
            set;
        }
        public String projectName {
            get;
            set;
        }
        public String UnitName {
            get;
            set;
        }
        public String letterType {
            get;
            set;
        }
        public Date letterDate {
            get;
            set;
        }
        public Date applicationDate {
            get;
            set;
        }
        public String TowerName {
            get;
            set;
        }
        public String floorNo {
            get;
            set;
        }
        public string projectAddress {
            get;
            set;
        }
        public string subject {
            get;
            set;
        }
        public Legal_Entity__c le {
            get;
            set;
        }
        public Boolean format1 {
            get;
            set;
        }
        public Boolean format2 {
            get;
            set;
        }
        public String CRMName {
            get;
            set;
        }
        public String CRMEmail {
            get;
            set;
        }
        public String CRMMobile {
            get;
            set;
        }
        public String applicationNumber {
            get;
            set;
        }
        public Demand_Invoice__c demandInv {
            get;
            set;
        }
        public Date invoiceDate {
            get;
            set;
        }
        public Date invoiceDueDate {
            get;
            set;
        }
        public String invoiceNumber {
            get;
            set;
        }
        public String invoiceAmount {
            get;
            set;
        }
        public String invoiceAmountWords {
            get;
            set;
        }
        public String outstandingAmount {
            get;
            set;
        }
        public string outstandingAmountWords {
            get;
            set;
        }
        public string milestoneName {
            get;
            set;
        }
        public Decimal interestRate {
            get;
            set;
        }
        public String colHeaderInterest {
            get;
            set;
        }
        public List<DemandWrapper> dwList {
            get;
            set;
        }
        public date firstReminderDate {
            get;
            set;
        }
        public date secondReminderDate {
            get;
            set;
        }
        public date finalReminderDate {
            get;
            set;
        }
        public date agreementDate {
            get;
            set;
        }
        public String agreementNumber {
            get;
            set;
        }
        public date finalReminderDueDate {
            get;
            set;
        }
        public String finalReminderAmount {
            get;
            set;
        }
        public String finalReminderAmountWords {
            get;
            set;
        }
        public date previousReminderDate {
            get;
            set;
        }
        public String previousReminderAmount {
            get;
            set;
        }
        public String previousReminderAmountWords {
            get;
            set;
        }
        public Receipt__c receipt {get;set;}
        public String reasonForRejection {get;set;}
        public string paymentTowards {get;set;}
        public string bankAccount {get;set;}
        public string amountStr {get;set;}
        public string amountStrWords {get;set;}

        public S_cancellationLetter() {
            letterH = false;
            format1 = false;
            format2 = false;
            dwList = new List<DemandWrapper>();
        }
        
        public void getCancellationLetter() {
            if(String.isNotBlank(strCancelId)) {
                cLetter = [Select id, Name, Customer__r.Project__r.Project_Image__c,Customer__r.Project__r.Footer_Image__c, 
                                Customer__r.Id, Customer__r.Name, Customer__r.Account.Correspondence_Address__c, /**Customer__r.Account.PersonMobilePhone, **/
                                Customer__r.Project__r.Name, Customer__r.Project_Unit__r.Name,Customer__r.Cancellation_Initiation_Record__c, 
                                Customer__r.Cancellation_In_Progress__c, Customer__r.Cancellation_Type__c, lettertype__c, subject__c,
                                Letter_Category__c,Is_Letter_Sent__c,Letter_sent_date__c, 
                                Previous_Letter__r.Letter_Sent_Date__c, Previous_Letter__r.Amount_Demanded__c,
                                Previous_Letter__r.Previous_Letter__r.Previous_Letter__r.Letter_Sent_Date__c,
                                Previous_Letter__r.Previous_Letter__r.Letter_Sent_Date__c
                                From Cancellation_Intimation__c Where id = :strcancelId];
                Customer = [select id, Flatcost_Paid_Percent_Against_AV__c,Project__c, Primary_Email__c,Primary_Phone__c, Other_Applicants_Email__c,Primary_Name__c, Primary_pancard__c,Other_Applicants_Pancard__c,
                                        Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,Future_Correspondence_Contact_Email__c,
                                        Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,
                                        Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name,
                                        Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, Project_Unit__r.Legal_Entity__r.RDS_Address1__c, 
                                        Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,
                                        Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, Account.BillingState, Account.BillingpostalCode,
                                        Account.BillingCountry, /**Account.PersonMobilePhone,**/ Booking__r.Name, Booking__r.Owner.Name, Booking__r.Booking_Date__c,
                                        Booking__r.Owner.Email, Booking__r.Owner.Phone,
                                     Booking__r.Quotation__r.Prepared_Date__c, Project_Unit__r.Towername__r.Name, Project_Unit__r.Floor__c, Project_Unit__r.Floor1__c,Booking__R.Application_No__c,
                                        Project__r.RDS_Company_Code__r.RDS_Company_Code__c, Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,
                                        Project__r.RDS_Interest_Rate__c, Project__r.Cheque_Dishonour__c, Project__r.RDS_Company_Code__r.Name, Project__r.RDS_Company_Code__r.SPV_Bank_Account__c, 
                                        Project__r.RDS_Company_Code__r.RDS_Address1__c, Date_of_Agreement__c, Agreement_Serial_Number__c
                                        from Opportunity
                                        where id = : cLetter.Customer__r.Id];      
                if (Customer != null) {
                    projectImage = Customer.Project__r.Project_Image__c;
                    projectName = Customer.Project__r.Name;
                    UnitName  = customer.Project_Unit__r.Name;
                    CustomerPrimaryName  = Customer.Primary_Name__c;
                    CustomerOtherApplicantName = Customer.Other_Applicants_Name__c;
                    CustomerMailingAddress = Customer.Mailing_Address__c;
                    CustomerMobilePhone  = Customer.Primary_Phone__c;
                    unitName = Customer.Project_Unit__r.Name;
                    applicationDate = Customer.Booking__r.Quotation__r.Prepared_Date__c;
                    applicationNumber = Customer.Booking__r.Application_No__c;
                    TowerName = Customer.Project_Unit__r.Towername__r.Name;
                    projectName = Customer.Project__r.Name;
                    floorNo = Customer.Project_Unit__r.Floor1__c;
                    projectAddress = Customer.Project__R.Address__c;
                    interestRate = Customer.Project__r.RDS_Interest_Rate__c;
                    
                    List<User> u = [Select Name, Phone, MobilePhone, Title, Email from User where Id = : Customer.Booking__r.OwnerId];
                    
                    if(u != null && u.size() ==1 ) {
                        CRMName = u[0].Title + u[0].Name;
                        CRMEmail = u[0].Email;
                        CRMMobile = u[0].MobilePhone;
                    }
                }    
                if(cLetter.Letter_Category__c.equalsIgnoreCase('L1')) {
                    // get the details of the bounced check that triggered the DoT cancellation flow
                    getChequeDetails(cLetter.Customer__r.Cancellation_Initiation_Record__c);
                } else if (
                    // first reminders for various categories of cancellation
                            cLetter.Letter_Category__c.equalsIgnoreCase('L2') || 
                            cLetter.Letter_Category__c.equalsIgnoreCase('L4') ||
                            cLetter.Letter_Category__c.equalsIgnoreCase('L8')
                        )
                {
                    if( String.isNotBlank(strMode) && strMode.equalsIgnoreCase('preview')) {
                        // get the details of the demand that triggered the cancellation flow
                        getCancellationDemandDetails(cLetter.Customer__r.Cancellation_Initiation_Record__c);
                    } else if(String.isNotBlank(strMode) && strMode.equalsIgnoreCase('view')){
                        // take the details from the database
                        getCancellationDemandDetailsDB(strCancelId);
                    }
                } else if (cLetter.Letter_Category__c.equalsIgnoreCase('L3') || cLetter.Letter_Category__c.equalsIgnoreCase('L7') || cLetter.Letter_Category__c.equalsIgnoreCase('L11') ) {
                    // termination letter for Pre confirmation scenario
                    finalReminderDate = cLetter.Previous_Letter__r.Letter_Sent_Date__c;
                    finalReminderDueDate = cLetter.Previous_Letter__r.Letter_Sent_Date__c.addDays(30);
                    finalReminderAmount = QuotationManagementServices.Informat(cLetter.Previous_Letter__r.Amount_Demanded__c);
                    finalReminderAmountWords = ' (' + S_NumberToWord.convertNumbertoWords(cLetter.Previous_Letter__r.Amount_Demanded__c) + ' only )';
                    if(cLetter.Letter_Category__c.equalsIgnoreCase('L11') || cLetter.Letter_Category__c.equalsIgnoreCase('L7')) {
                        firstReminderDate = cLetter.Previous_Letter__r.Previous_Letter__r.Previous_Letter__r.Letter_Sent_Date__c;
                        secondReminderDate = cLetter.Previous_Letter__r.Previous_Letter__r.Letter_Sent_Date__c;
                    }
                    if(cLetter.Letter_Category__c.equalsIgnoreCase('L11') ) {
                        agreementDate = Customer.Date_of_Agreement__c;
                        agreementNumber = Customer.Agreement_Serial_Number__c;
                    }
                    
                } else if (cLetter.Letter_Category__c.equalsIgnoreCase('L5') || cLetter.Letter_Category__c.equalsIgnoreCase('L9')
                            || cLetter.Letter_Category__c.equalsIgnoreCase('L6') || cLetter.Letter_Category__c.equalsIgnoreCase('L10') ) {
                    // second reminders and final reminders
                    previousReminderDate = cLetter.Previous_Letter__r.Letter_Sent_Date__c;
                    previousReminderAmount = QuotationManagementServices.Informat(cLetter.Previous_Letter__r.Amount_Demanded__c);
                    previousReminderAmountWords = ' (' + S_NumberToWord.convertNumbertoWords(cLetter.Previous_Letter__r.Amount_Demanded__c) + ' only )';
                    if( String.isNotBlank(strMode) && strMode.equalsIgnoreCase('preview')) {
                        getOutstandingDemandDetails(customer.Id);
                    } else if(String.isNotBlank(strMode) && strMode.equalsIgnoreCase('view')) {
                        // take the same info from the cancellation references stored in the DB
                        getOutstandingDemandDetailsDB(strCancelId);
                    }
                }
                else {
                }
                // for deciding the content of the email body..  reminder letter Vs termination letter
                if( cLetter.Letter_Category__c.equalsIgnoreCase('L2') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L4') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L5') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L6') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L8') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L9') ||
                    cLetter.Letter_Category__c.equalsIgnoreCase('L10') 
                    
                ) {
                    format1 = true;
                } else {
                    format2 = true;
                }
                    
                if(cLetter.Letter_sent_date__c != null)
                    letterDate = cLetter.Letter_sent_date__c;
                else
                    letterDate = System.today();
                    
                letterType = cLetter.lettertype__c;
                subject = cLetter.subject__c;
                
                le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);
            }
        }
        
        public void getChequeDetails(Id receiptId) {
            receipt = [SELECT id, Name,Mode__c,
                                     Bank__c,Project__c,Project__r.Name,
                                     Project_Unit__c,Project_Unit__r.Name,
                                     Cheque_DD__c,Opportunity__c,
                                     Opportunity__r.Name,Cheque_DD_Date__c,
                                     Amount_Rs__c,
                                     Reason_for_Reject__c,
                                     Drawn_in_favour_of__c,
                                     Banking__c,
                                     DraweeBank__c,
                                     Reason_for_rejection_new__c,
                                     receipt_status__c,
                                     Project__r.Cheque_Dishonour__c,
                                     Opportunity__r.Primary_Name__c,
                                     Opportunity__r.Primary_Phone__c,
                                     Opportunity__r.Other_Applicants_Name__c,
                                     Opportunity__r.Mailing_Address__C,
                                     Project__r.Project_Image__c,
                                     Project__r.Footer_Image__c,
                                     Receipt_Date__c
                                     FROM Receipt__c WHERE id = :receiptId];
                if(receipt != null ) {
                        amountStr = QuotationManagementServices.InFormat(receipt.Amount_Rs__c);
                        amountStrWords = ' (' + S_NumberToWord.convertNumbertoWords(receipt.Amount_Rs__c) + ' only )';
                        if(string.IsNotBlank(receipt.receipt_status__c)  && receipt.receipt_status__c.equalsIgnoreCase('Physical Verification Rejected'))
                            reasonForRejection = receipt.Reason_for_rejection_new__c;
                        else if (string.IsNotBlank(receipt.receipt_status__c)  && receipt.receipt_status__c.equalsIgnoreCase('Dishonored'))
                            reasonForRejection = receipt.Banking__c;
                        if(string.IsNotBlank(receipt.Drawn_in_favour_of__c)) {
                            List<String> sList = receipt.Drawn_in_favour_of__c.split('\\|', 5); 
                            system.debug(sList);
                            if(sList != null && sList.size() > 0) {
                                paymentTowards = sList[0];
                            }
                            Integer count = 0;
                            for(String s: sList) {
                                if(count != 0) {
                                    bankAccount += sList[count] + ',';
                                }
                                count ++;
                            }
                            // remove the last character only if its a comma.
                            if(bankAccount.length() > 0 && bankAccount.substring(bankAccount.length() -1).equals(','))
                                bankAccount = bankAccount.substring(0,bankAccount.length() -1);
                            system.debug('bank account:' + bankAccount);
                            system.debug('payment towards:' + paymentTowards);
                        }
            }
        }
        
        public Cancellation_References__c getCancellationDemandDetails(Id demandId) {
            DemandInv = [Select id, Name, Demand_Number__c, Invoice_Date__c, Due_Date__c,Current_Demand_Installment__c, Current_Demand_Service_Tax__c, 
                            Is_Advanced_Demand__c,Registration_Demand_Generation__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c,
                            Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c
                            From Demand_Invoice__c Where id = : demandId];
            Cancellation_References__c c = new Cancellation_References__c();
            if(DemandInv != null) {
                c.Demand_Invoice__c = DemandInv.Id;
                c.Flat_Cost_Outstanding__c = DemandInv.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c;
                c.Service_Tax_Oustanding__c = DemandInv.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c;
                c.Interest__c = DemandInv.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c;
                invoiceDate = DemandInv.Invoice_Date__c;
                invoiceDueDate = demandInv.Due_Date__c;
                invoiceNumber = DemandInv.Demand_Number__c;
                milestoneName = DemandInv.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                invoiceAmount = QuotationManagementServices.INformat(DemandInv.Current_Demand_Installment__c + DemandInv.Current_Demand_Service_Tax__c);
                invoiceAmountWords = ' (' + S_NumberToWord.convertNumbertoWords(DemandInv.Current_Demand_Installment__c + DemandInv.Current_Demand_Service_Tax__c) + ' only )';
                outstandingAmount = QuotationManagementServices.INFormat(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c + DemandInv.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c + DemandInv.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c);
                if(!Test.isRunningTest())
                    outstandingAmountWords = ' (' + S_NumberToWord.convertNumbertoWords(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c + DemandInv.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c + DemandInv.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c) + ' only )';
                colHeaderInterest = 'Interest calculated at the rate ' + string.valueOf(InterestRate) + '% p.a. till ' + system.today().format(); 
                
                DemandWrapper dw = new DemandWrapper();
                dw.col1 =  mileStoneName;
                dw.col2 =  invoiceNumber;
                dw.col3 = invoiceDate.format();
                dw.col4 = invoiceDueDate.format();
                dw.col5 = QuotationManagementServices.INFormat(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c);
                dw.col6 = QuotationManagementServices.INFormat(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c);
                dw.col7 = QuotationManagementServices.INFormat(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c);
                dw.col8 = QuotationManagementServices.INFormat(DemandInv.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c +
                                                                DemandInv.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c +
                                                                DemandInv.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c);
                dwList.add(dw);
                                                                
            }
            
            return c;
        }
        
        public void getCancellationDemandDetailsDB(Id cancelId) {
            Cancellation_References__c cRef = [Select id, Name, Demand_Invoice__r.Demand_Number__c, Demand_Invoice__r.Invoice_Date__c, Demand_Invoice__r.Due_Date__c,
                            Demand_Invoice__r.Current_Demand_Installment__c, Demand_Invoice__r.Current_Demand_Service_Tax__c,
                            Demand_Invoice__r.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c,
                            cancellation_intimation__r.Amount_Demanded__c,
                            Flat_Cost_Outstanding__c,Service_Tax_Oustanding__c, Interest__c, Total__c
                            From Cancellation_References__c Where cancellation_intimation__c = : cancelId];
            if(cRef != null) {
                
                invoiceDate = cRef.Demand_Invoice__r.Invoice_Date__c;
                invoiceDueDate = cRef.Demand_Invoice__r.Due_Date__c;
                invoiceNumber = cRef.Demand_Invoice__r.Demand_Number__c;
                milestoneName = cRef.Demand_Invoice__r.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                invoiceAmount = QuotationManagementServices.INformat(cRef.Demand_Invoice__r.Current_Demand_Installment__c + cRef.Demand_Invoice__r.Current_Demand_Service_Tax__c);
                invoiceAmountWords = ' (' + S_NumberToWord.convertNumbertoWords(cRef.Demand_Invoice__r.Current_Demand_Installment__c + cRef.Demand_Invoice__r.Current_Demand_Service_Tax__c) + ' only )';
                outstandingAmount = QuotationManagementServices.INFormat(cRef.Flat_Cost_Outstanding__c + cRef.Service_Tax_Oustanding__c + cRef.Interest__c);
                outstandingAmountWords =  ' (' + S_NumberToWord.convertNumbertoWords(cRef.Flat_Cost_Outstanding__c + cRef.Service_Tax_Oustanding__c + cRef.Interest__c) + ' only )';
                colHeaderInterest = 'Interest calculated at the rate ' + string.valueOf(InterestRate) + '% p.a. till ' + system.today().format(); 
                
                DemandWrapper dw = new DemandWrapper();
                dw.col1 =  mileStoneName;
                dw.col2 =  invoiceNumber;
                dw.col3 = invoiceDate.format();
                dw.col4 = invoiceDueDate.format();
                dw.col5 = QuotationManagementServices.INFormat(cRef.Flat_Cost_Outstanding__c);
                dw.col6 = QuotationManagementServices.INFormat(cRef.Service_Tax_Oustanding__c);
                dw.col7 = QuotationManagementServices.INFormat(cRef.Interest__c);
                dw.col8 = QuotationManagementServices.INFormat(cRef.Total__C);
                dwList.add(dw);
            }
                
        }
        public List<cancellation_references__c> getOutstandingDemandDetails(Id customerId) {
            List<Demand_Invoice__c> demandList = new List<Demand_Invoice__c>();
            List<Cancellation_References__c> crList = new List<Cancellation_References__c>();
            demandList = [Select id, Name, Demand_Number__c, Invoice_Date__c, Due_Date__c,Current_Demand_Installment__c, Current_Demand_Service_Tax__c, 
                            Is_Advanced_Demand__c,Registration_Demand_Generation__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c, 
                            Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c,
                            Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c
                            From Demand_Invoice__c 
                            Where customer__c = : customerId
                            and  Standard_Customer_Pay_Plan_Detail__r.IsPaymentOverdue__c = true
                            and Customer__r.Status__c = 'Active'
                            and Customer__r.StageName = 'Booking confirmed'];
            Decimal OutstandingAmountD = 0;
            Decimal totalFlatCost = 0;
            Decimal totalServiceTax = 0;
            Decimal totalInterest = 0;
            if(demandList.size() > 0) {
                for(Demand_Invoice__c d : demandList) {
                    DemandWrapper dw = new DemandWrapper();
                    dw.col1 = d.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                    dw.col2 = d.Demand_Number__c;
                    dw.col3 = d.Invoice_Date__c.format();
                    dw.col4 = d.Due_Date__c.format();
                    dw.col5 = QuotationManagementServices.INFormat(d.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c);
                    dw.col6 = QuotationManagementServices.INFormat(d.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c);
                    dw.col7 = QuotationManagementServices.INFormat(d.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c);
                    dw.col8 = QuotationManagementServices.INFormat(d.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c + 
                                                                    d.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c +
                                                                    d.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c);
                    outstandingAmountD += d.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c + d.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c + d.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c;
                    dwList.add(dw);
                    totalFlatCost += d.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c;
                    totalServiceTax += d.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c;
                    totalInterest += d.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c;
                    Cancellation_References__c c = new Cancellation_References__c();
                    c.Demand_Invoice__c = d.Id;
                    c.Flat_Cost_Outstanding__c = d.Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Due__c;
                    c.Service_Tax_Oustanding__c = d.Standard_Customer_Pay_Plan_Detail__r.Service_Tax_Amount_Due__c;
                    c.Interest__c = d.Standard_Customer_Pay_Plan_Detail__r.Total_Interest_Amount__c;    
                    crList.add(c);                                          
                }
                DemandWrapper dw = new DemandWrapper();
                dw.col1 = 'Total Payable';
                dw.col2 = '';
                dw.col3 = '';
                dw.col4 = '';
                dw.col5 = QuotationManagementServices.INFormat(totalFlatCost);
                dw.col6 = QuotationManagementServices.INFormat(totalServiceTax);
                dw.col7 = QuotationManagementServices.INFormat(totalInterest);
                dw.col8 = QuotationManagementServices.INFormat(outstandingAmountD);
                dwList.add(dw);
            }
            outstandingAmount = QuotationManagementServices.INFormat(outstandingAmountD);
            if(!Test.isRunningTest())
                outstandingAmountWords =  ' (' + S_NumberToWord.convertNumbertoWords(outstandingAmountD) + ' only )';
            colHeaderInterest = 'Interest calculated at the rate ' + string.valueOf(InterestRate) + '% p.a. till ' + system.today().format();   
            return crList;
        }
        
        public void getOutstandingDemandDetailsDB(Id cancelId) {
            List<Cancellation_References__c> crList = new List<Cancellation_References__c>();
            crList = [Select id, Name, Demand_Invoice__r.Demand_Number__c, Demand_Invoice__r.Invoice_Date__c, Demand_Invoice__r.Due_Date__c,
                            Demand_Invoice__r.Current_Demand_Installment__c, Demand_Invoice__r.Current_Demand_Service_Tax__c,
                            Demand_Invoice__r.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c,
                            cancellation_intimation__r.Amount_Demanded__c,
                            Flat_Cost_Outstanding__c,Service_Tax_Oustanding__c, Interest__c, Total__c
                            From Cancellation_References__c Where cancellation_intimation__c = : cancelId ];
                Decimal OutstandingAmountD = 0;
                Decimal totalFlatCost = 0;
                Decimal totalServiceTax = 0;
                Decimal totalInterest = 0;
                if(crList.size() > 0) {
                    for(cancellation_references__c cRef : crList) {
                        DemandWrapper dw = new DemandWrapper();
                        dw.col1 = cRef.Demand_Invoice__r.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                        dw.col2 = cRef.Demand_Invoice__r.Demand_Number__c;
                        dw.col3 = cRef.Demand_Invoice__r.Invoice_Date__c.format();
                        dw.col4 = cRef.Demand_Invoice__r.Due_Date__c.format();
                        dw.col5 = QuotationManagementServices.INFormat(cRef.Flat_Cost_Outstanding__c);
                        dw.col6 = QuotationManagementServices.INFormat(cRef.Service_Tax_Oustanding__c);
                        dw.col7 = QuotationManagementServices.INFormat(cRef.Interest__c);
                        dw.col8 = QuotationManagementServices.INFormat(cRef.Total__C);
                        dwList.add(dw);
                        totalFlatCost += cRef.Flat_Cost_Outstanding__c;
                        totalServiceTax += cRef.Service_Tax_Oustanding__c;
                        totalInterest += cRef.Interest__c;
                        outstandingAmountD += cRef.Total__c;
                    }
                }
                DemandWrapper dw = new DemandWrapper();
                dw.col1 = 'Total Payable';
                dw.col2 = '';
                dw.col3 = '';
                dw.col4 = '';
                dw.col5 = QuotationManagementServices.INFormat(totalFlatCost);
                dw.col6 = QuotationManagementServices.INFormat(totalServiceTax);
                dw.col7 = QuotationManagementServices.INFormat(totalInterest);
                dw.col8 = QuotationManagementServices.INFormat(outstandingAmountD);
                dwList.add(dw);
                outstandingAmount = QuotationManagementServices.INFormat(outstandingAmountD);
                if(!Test.isRunningTest())
                    outstandingAmountWords =  ' (' + S_NumberToWord.convertNumbertoWords(outstandingAmountD) + ' only )';
                colHeaderInterest = 'Interest calculated at the rate ' + string.valueOf(InterestRate) + '% p.a. till ' + system.today().format(); 
        }
        public class demandWrapper {
            public String col1 {
                get; set;
            }
            public String col2 {
                get; set;
            }
            public String col3 {
                get; set;
            }
            public String col4 {
                get; set;
            }
            public String col5 {
                get; set;
            }
            public String col6 {
                get; set;
            }
            public String col7 {
                get; set;
            }
            public String col8 {
                get; set;
            }
            public demandWrapper() {
                
            }
            
            
        }
        
                    
}