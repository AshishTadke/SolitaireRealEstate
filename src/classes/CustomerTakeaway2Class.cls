public with sharing class CustomerTakeaway2Class {
    ApexPages.StandardController controller;
    public Booking__c b {
        get;
        set;
    }
    public List < Booking__c > bList {
        get;
        set;
    }
    public List < Customer_Pay_Plan_Header__c > cpphList {
        get;
        set;
    }
    public List < Standard_Customer_Pay_Plan_Detail__c > scppList {
        get;
        set;
    }
    public List < Applicant_Details__c > applicantList {
        get;
        set;
    }
    public Id bkId {
        get;
        set;
    }
    public List < Receipt__c > recList {
        get;
        set;
    }
    public List < wrapperclass > wrapperList {
        get;
        set;
    }
    public List < Receipt__c > newRecordList {
        get;
        set;
    }
    public List < wrapperclass2 > wrapperList2 {
        get;
        set;
    }
    public List < Standard_Customer_Pay_Plan_Detail__c > newRecordList2 {
        get;
        set;
    }
    public Decimal installment {
        get;
        set;
    }
    public Decimal serviceTaxAmount {
        get;
        set;
    }
    public Decimal totalAmountDue {
        get;
        set;
    }
    public Decimal finalAmountDue {
        get;
        set;
    }
    public Decimal totAmount {
        get;
        set;
    }
    public Decimal srNo {
        get;
        set;
    }
    public String wordNumber {
        get;
        set;
    }
    public String nm {
        get;
        set;
    }
    public Boolean milestone {
        get;
        set;
    }
    public Boolean receipt {
        get;
        set;
    }

    public class wrapperclass {
        public Receipt__c receiptDetails {
            get;
            set;
        }
        public String chequeno {
            get;
            set;
        }
        public Decimal totalAmt {
            get;
            set;
        }
        public Decimal finalAmt {
            get;
            set;
        }
        public String bankName {
            get;
            set;
        }
        public String instrument {
            get;
            set;
        }
        public Date recDate {
            get;
            set;
        }
        public wrapperclass(Receipt__c newRecord, String chequeDdNo, Decimal totalAmount, Decimal finalAmount, String DraweeBank, String mode, Date ReceiptDate) {
            system.debug('Inside Wrapper Class : ');

            receiptDetails = newRecord;
            chequeno = chequeDdNo;
            totalAmt = totalAmount;
            finalAmt = finalAmount;
            bankName = DraweeBank;
            instrument = mode;
            recDate = ReceiptDate;
            system.debug(' receiptDetails ' + receiptDetails);
            system.debug(' chequeno ' + chequeno);
            system.debug('totalAmt ' + totalAmt);
            system.debug(' finalAmt ' + finalAmt);
            system.debug(' bankName : ' + bankName);
            system.debug(' instrument : ' + instrument);
            system.debug(' recDate :    ' + recDate);
        }
    }

    public class wrapperclass2 {
        public Standard_Customer_Pay_Plan_Detail__c scppDetails {
            get;
            set;
        }
        public String toBePaid1 {
            get;
            set;
        }
        public Decimal amtValue1 {
            get;
            set;
        }
        public Decimal installment1 {
            get;
            set;
        }
        public Decimal serviceTaxAmt1 {
            get;
            set;
        }
        public Decimal finalAmt1 {
            get;
            set;
        }
        public Date dueDate1 {
            get;
            set;
        }
        public Decimal sNo {
            get;
            set;
        }
        public wrapperclass2(Standard_Customer_Pay_Plan_Detail__c scpp, String toBePaid, Decimal amtValue, Decimal installment, Decimal serviceTaxAmt, Decimal finalAmt, Date dueDate, Decimal srNo) {
            system.debug('Inside Wrapper Class 2: ');
            scppDetails = scpp;
            toBePaid1 = toBePaid;
            amtValue1 = amtValue;
            installment1 = installment;
            serviceTaxAmt1 = serviceTaxAmt;
            finalAmt1 = finalAmt;
            dueDate1 = dueDate;
            sNo = srNo;
            system.debug('toBePaid1 : ' + toBePaid1);
            system.debug('2 : ' + amtValue1);
            system.debug('3 : ' + installment1);
            system.debug('4 : ' + serviceTaxAmt1);
            system.debug('5 : ' + finalAmt1);
            system.debug('6 : ' + dueDate1);
        }
    }

    //------------------- Constructor -------------------------- //
    public CustomerTakeaway2Class(ApexPages.StandardController controller) {
        System.Debug('Inside Contructor');
        newRecordList = new List < Receipt__c > ();
        totAmount = 0;
        installment = 0;
        serviceTaxAmount = 0;
        totalAmountDue = 0;
        finalAmountDue = 0;
        nm = '';
        milestone = False;
        receipt = False;
        bkid = ApexPages.currentPage().getParameters().get('bId');
        this.controller = controller;
        system.debug('this.controller : ' + this.controller);
        b = (Booking__c) controller.getRecord();
        system.debug(' Booking xxx : ' + b);
        system.debug(' Booking ID xxx : ' + b.Id);
        if (b.Id != null || bkid != null) {
            bList = [SELECT Id, Name, Booking_Date__c, Application_No__c, Opportunity__c, Opportunity__r.Primary_Name__c, Opportunity__r.Other_Applicants_Name__c, No_of_Parking__c,
                Opportunity__r.Account.BillingAddress, Allotment_Premium__c, Source_of_Booking__c, Booking_Source_Details__c, Sub_Source__c, Date_for_offer_of_Possession__c,
                Opportunity__r.Account.BillingStreet, Opportunity__r.Account.BillingCity, Opportunity__r.Account.BillingState, Opportunity__r.Account.BillingPostalCode,
                Opportunity__r.Account.BillingCountry, Opportunity__r.Account.Mobile__c, Opportunity__r.Account.Alternate_number_1__c, Opportunity__r.Mailing_Address__c,
                Opportunity__r.Account.PersonEmail, Opportunity__r.Account.Pan__c, Opportunity__r.Account.Resident_Status__c, Opportunity__r.Primary_Phone__c,
                Unit_No__c, Unit_No__r.RDS_Project_Unit_Type__r.Name,
                Project__c, Project__r.Name, Unit_No__r.Name, Unit_No__r.Carpet_Area__c, Unit_No__r.Actual_Area_value__c, Unit_No__r.Configuration__c, Future_Correspondence_Contact_Name__c
                FROM Booking__c WHERE(Id = : b.Id OR Id = : bkid)
            ];
            system.debug('BList IN CLASS : ' + bList);
            if (bList.size() > 0) {
                system.debug('bList :' + bList);
                wordNumber = S_NumberToWord.convertNumbertoWords(bList[0].Allotment_Premium__c);
                system.debug('wordNumber :' + wordNumber);
                applicantList = [SELECT Id, Name, Mobile_Number__c, Email_Address__c, Landline_Number__c, Applicant_Number__c, Booking__c, Pincode__c, Country__c, City__c, State__c, Permanent_Address__c, PancardNo__c, Subtype_Of_Applicant__c FROM Applicant_Details__c WHERE(Booking__r.Id = : bkid OR Booking__r.Id = : bList[0].Id) AND Applicant_Number__c = 'Primary Applicant'];
                system.debug('applicantList   : ************ ' + applicantList);
            }

            recList = [SELECT Id, Cheque_DD__c, Total_Amount__c, Mode__c, DraweeBank__c, Receipt_Date__c, Token_Amount_ST__c, Token_Amount_Receipt__c FROM Receipt__c WHERE(Booking__r.Id = : bList[0].Id OR Booking__r.Id = : bkid) AND(Token_Amount_Receipt__c = True OR Token_Amount_ST__c = True)];
            system.debug('recList :' + recList);

            if (recList.size() > 0 || recList.size() != null) {
                receipt = True;
                wrapperList = new List < wrapperclass > ();
                system.debug('recList :' + recList);
                newRecordList = new List < Receipt__c > ();
                for (integer i = 0; i < recList.size(); i++) {
                    Receipt__c newReceipt = new Receipt__c();
                    newReceipt.Cheque_DD__c = recList[i].Cheque_DD__c;
                    newReceipt.Total_Amount__c = recList[i].Total_Amount__c;
                    newReceipt.DraweeBank__c = recList[i].DraweeBank__c;
                    newReceipt.Mode__c = recList[i].Mode__c;
                    newReceipt.Receipt_Date__c = recList[i].Receipt_Date__c;
                    newRecordList.add(newReceipt);

                    system.debug('newReceipt 11111 : ' + newReceipt);
                }
                for (integer i = 0; i < newRecordList.size(); i++) {
                    //system.debug('newRecordList xxxx : ' + newRecordList);
                    if (newRecordList[i].Total_Amount__c != null) {
                        totAmount += newRecordList[i].Total_Amount__c;
                        system.debug('totAmount : xxxxxxx : ' + totAmount);
                    } else {
                        totAmount = 0;
                    }
                    system.debug('Wrapper Total Amount : ' + totAmount);
                    wrapperList.add(new wrapperclass(newRecordList[i], newRecordList[i].Cheque_DD__c, newRecordList[i].Total_Amount__c, totAmount, newRecordList[i].DraweeBank__c, newRecordList[i].Mode__c, newRecordList[i].Receipt_Date__c));
                }
            } //Closed  if(recList.size() > 0)
            else {
                receipt = False;
            }


            // ------------------------ customer payment plan --------------------------
            cpphList = [SELECT Id, Name, Booking__c, Global_Charges__c, Global_Charges__r.Name FROM Customer_Pay_Plan_Header__c WHERE(Booking__r.Id = : bList[0].Id) AND Global_Charges__r.Name = 'Basic'];
            system.debug('cpphList :' + cpphList);

            if (cpphList.size() > 0 || cpphList.size() != null) {
                milestone = True;
                system.debug('cpphList[0].Id ' + cpphList[0].Id);
                if (cpphList[0].Id != null || cpphList[0].Id != '') {
                    scppList = [SELECT Id, Customer_Pay_Plan_Header__c, Is_to_be__c, Installment__c, Amount_Value__c, Due_Date__c, Service_Tax_Amount_Q__c, Installment_Number__c FROM Standard_Customer_Pay_Plan_Detail__c WHERE Customer_Pay_Plan_Header__r.Id = : cpphList[0].Id ORDER BY Installment_Number__c ASC];
                }
                system.debug('scppList :' + scppList);
                if (scppList.size() > 0 || scppList.size() != null) {
                    milestone = True;
                    wrapperList2 = new List < wrapperclass2 > ();
                    system.debug('Netra ...... scppList :' + scppList);
                    newRecordList2 = new List < Standard_Customer_Pay_Plan_Detail__c > ();
                    for (integer i = 0; i < scppList.size(); i++) {
                        Standard_Customer_Pay_Plan_Detail__c newSccp = new Standard_Customer_Pay_Plan_Detail__c();
                        newSccp.Is_to_be__c = scppList[i].Is_to_be__c;
                        newSccp.Installment__c = scppList[i].Installment__c;
                        newSccp.Service_Tax_Amount_Q__c = scppList[i].Service_Tax_Amount_Q__c;
                        newSccp.Amount_Value__c = scppList[i].Amount_Value__c;
                        newSccp.Due_Date__c = scppList[i].Due_Date__c;
                        newRecordList2.add(newSccp);
                        system.debug('newSccp :--------   ' + newSccp);
                    }

                    if (newRecordList2.size() > 0 || newRecordList2.size() != null) {
                        system.debug('newRecordList2 :--------   ' + newRecordList2);
                        for (integer i = 0; i < newRecordList2.size(); i++) {
                            srNo = i + 1;
                            system.debug('srNo  I --------- ' + srNo);
                            if (newRecordList2[i].Installment__c != null || newRecordList2[i].Installment__c != 0) {
                                installment = newRecordList2[i].Installment__c;
                                system.debug('Installment : ' + i + ' :' + installment);
                            } else {
                                installment = 0;
                            }
                            if (newRecordList2[i].Service_Tax_Amount_Q__c != null) {
                                serviceTaxAmount = newRecordList2[i].Service_Tax_Amount_Q__c;
                            } else {
                                serviceTaxAmount = 0;
                            }
                            if (installment != null && serviceTaxAmount != null) {
                                finalAmountDue = installment + serviceTaxAmount;
                            }
                            system.debug('srNo  I new --------- ' + srNo);
                            system.debug('newRecordList2[i].Is_to_be__c : ' + newRecordList2[i].Is_to_be__c);
                            system.debug('newRecordList2[i].Amount_Value__c : ' + newRecordList2[i].Amount_Value__c);
                            system.debug('installment : ' + installment);
                            system.debug('serviceTaxAmount : ' + serviceTaxAmount);
                            system.debug('finalAmountDue  : ' + finalAmountDue);
                            system.debug('newRecordList2[i].Due_Date__c : ' + newRecordList2[i].Due_Date__c);

                            wrapperList2.add(new wrapperclass2(newRecordList2[i], newRecordList2[i].Is_to_be__c, newRecordList2[i].Amount_Value__c, installment, serviceTaxAmount, finalAmountDue, newRecordList2[i].Due_Date__c, srNo));
                        } // for close       
                    } else {
                        system.debug('Inside Else Part');
                    }

                } //Closed if(scppList.size() > 0)
                else {
                    milestone = False;
                }
            } // closed if(cpphList.size() > 0)
            else {
                milestone = False;
            }

        } // if bkid not null

    }
}