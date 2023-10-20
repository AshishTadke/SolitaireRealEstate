public class S_PrintLedgerController {
    public Id oppId {get; set;}
    public String projectImage {
        get;
        set;
    }
    public Opportunity Customer {
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
    public String bookingDate {
        get;
        set;
    }
    public Decimal chequeDishonour {
        get;
        set;
    }
    public Decimal interestRate {
        get;
        set;
    }
    public String tdsRate {
        get;
        set;
    }
    public Map < String, Decimal > taxRateMap {
        get;
        set;
    }
    public Decimal taxRateBasic {
        get;
        set;
    }
    public Decimal tdsOnCurrent {
        get;
        set;
    }
    public Map < String, List<tax_breakup__c> > taxSlabMap {
        get;
        set;
    }
    public Legal_Entity__c le {
        get;
        set;
    }
    public string errMsg {
        get;
        set;
    }
    public string Msg {
        get;
        set;
    }
    public Boolean error {
        get;
        set;
    }
    public Date ledgerDate {
        get;
        set;
    }
    public Map < string, Decimal > chargeAmountMap {
        get;
        set;
    }
    public Map < string, Decimal > otherChargesMap {
        get;
        set;
    }
    public String totalBasicDemanded {
        get;
        set;
    }
    public String totalBasicTaxDemanded {
        get;
        set;
    }
    public String PercentagePaidBasic {
        get;
        set;
    }
    public String PercentagePaidBasicTax {
        get;
        set;
    }
    public String totalBasicPaid {
        get;
        set;
    }
    public String totalBasicTaxPaid {
        get;
        set;
    }
    public String totalBasicOutstanding {
        get;
        set;
    }
    public String totalBasicTaxOutstanding {
        get;
        set;
    }
    public String totalOtherDemanded {
        get;
        set;
    }
    public String totalOtherTaxDemanded {
        get;
        set;
    }
    public String PercentagePaidOther {
        get;
        set;
    }
    public String PercentagePaidOtherTax {
        get;
        set;
    }
    public String totalOtherPaid {
        get;
        set;
    }
    public String totalOtherTaxPaid {
        get;
        set;
    }
    public String totalOtherOutstanding {
        get;
        set;
    }
    public String totalOtherTaxOutstanding {
        get;
        set;
    }
    public String totalInterest {
        get;
        set;
    }
    public String totalInterestDue {
        get;
        set;
    }
    public String totalInterestPaid {
        get;
        set;
    }
    public String totalInterestSettled {
        get;
        set;
    }
    public String totalInterestWaived {
        get;
        set;
    }
    public String PercentageInterestPaid {
        get;
        set;
    }
    public String gtDemanded {
        get;
        set;
    }
    public String gtPaid {
        get;
        set;
    }
    public String gtPercentage {
        get;
        set;
    }
    public String tdsOnFlatCost {
        get;
        set;
    }
    public String agreementValue {
        get;
        set;
    }
    public String onAccountMoney {
        get;
        set;
    }
    public List<Booking__c> booking {
        get;
        set;
    }
    public Integer carParksAllotted {
        get;
        set;
    }
    public List<LedgerManagementServices.LedgerPrintWrapper> lpwList {
        get;
        set;
    }
    public List<LedgerPrintWrapper> lpwLocalList {
        get;
        set;
    }
    public string ledgerStyle {
        get;
        set;
    }
    public string paymentsStyle {
        get;
        set;
    }
    public string type {
        get;
        set;
    }
    public List<Ledger__c> ledgerList {
        get;
        set;
    }
    public string ProjectName {
        get;
        set;
    }
    public string ProjectUnitName {
        get;
        set;
    }
    public Decimal UnitActualArea {
        get;
        set;
    }
    public String CustomerPrimaryName {
        get;
        set;
    }
   public String CustomerApplicantName {
        get;
        set;
    }
   public String  CustomerMailingAddress {
        get;
        set;
    }
   public String  CustomerPhone {
        get;
        set;
    }
   public String  CustomerEmail {
        get;
        set;
    }
    public String  CustomerUnitStatus {
        get;
        set;
    }
  
    public S_PrintLedgerController() {
        System.debug('In constructor');
        ledgerStyle = 'None';
        paymentsStyle = 'None';
        getLedgerDetails();
    }
    public void getLedgerDetails() {
        System.debug('OPPID:' + oppId);
        error = false;
        Msg = '';
        errMsg = '';
        oppId = null;
        carParksAllotted = 0;
        totalBasicDemanded = '';
        totalBasicTaxDemanded = '';
        totalBasicOutstanding = '';
        totalBasicTaxOutstanding = '';
        totalOtherDemanded = '';
        totalOtherTaxDemanded = '';
        totalOtherOutstanding = '';
        totalOtherTaxOutstanding = '';
        totalInterest = '';
        totalInterestDue = '';
        totalInterestPaid ='';
        totalInterestWaived = '';
        totalInterestSettled = '';
        PercentageInterestPaid = '';
        agreementValue ='';
        totalBasicPaid = '';
        totalBasicTaxPaid = '';
        PercentagePaidBasic = '';
        PercentagePaidBasicTax = '';
        totalOtherPaid = '';
        totalOtherTaxPaid = '';
        PercentagePaidOther = '';
        PercentagePaidOtherTax = '';
        tdsOnFlatCost = '';
        OnAccountMoney = '';
        gtDemanded = '';
        gtPaid = '';
        gtPercentage = '';
        otherChargesMap = new Map < string, Decimal >();
        chargeAmountMap = new Map < string, Decimal >();
        
        lpwList = new List<LedgerManagementServices.LedgerPrintWrapper>();
        lpwLocalList = new List<LedgerPrintWrapper>();
        ledgerList  = new List<Ledger__c>();
        if(ApexPages.currentPage().getParameters().get('id') != null && ApexPages.currentPage().getParameters().get('id') != '')
        {
            oppId = (Id)ApexPages.currentPage().getParameters().get('id');
            taxRateMap = new Map < String, Decimal > ();
            taxSlabMap = InventoryCostServices.getChildTaxSlabs();
        }
        system.debug('oppId:: '+oppId);
        if(ApexPages.currentPage().getParameters().get('type') != null && ApexPages.currentPage().getParameters().get('type') != '')
        {
            type = ApexPages.currentPage().getParameters().get('type');
            if(type == 'payments') {
                paymentsStyle = '';
            } 
            taxRateMap = new Map < String, Decimal > ();
            taxSlabMap = InventoryCostServices.getChildTaxSlabs();
        }   
        if(type != 'payments') {
            ledgerStyle = '';
        }
        System.debug('Type:' + type + 'Payment Style:' + paymentsStyle + 'Ledger Style:' + ledgerStyle);
        if(oppId != null) {
            ledgerDate = system.today();
            getCustomerDetails();
        } else {
            errMsg = 'Please select a valid customer/opportunity for printing the ledger';
            error = true;
            System.debug('error:' + error);
        }
    }
    
    public void getCustomerDetails() {
        Customer = [select id, Name, Primary_Email__c, Other_Applicants_Email__c,Primary_Name__c, Total_Interest_Waiver__c,Total_Interest__c,Total_Interest_Settled__c,Total_Waiver__c,
                Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,Future_Correspondence_Contact_Email__c,
                Project__c, Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,
                Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name,Project_Unit__r.Carpet_Area__c,
                Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, 
                Project_Unit__r.Legal_Entity__r.RDS_Address1__c, Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,
                Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, 
                Account.BillingState, Account.BillingpostalCode,
                Account.BillingCountry, Account.PersonMobilePhone, 
                Project_Unit__r.Booking__r.Name, Project_Unit__r.Unit_Status__c,Project_Unit__r.Actual_Area_value__c,
                Project_Unit__r.Booking__r.Booking_Date__c, Project_Unit__r.Booking__r.Owner.Name, 
                Project_Unit__r.Booking__r.Owner.Email, Project_Unit__r.Booking__r.Owner.Phone,
                Project__r.RDS_Company_Code__r.RDS_Company_Code__c, 
                Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,
                Project__r.RDS_Interest_Rate__c, Project__r.Cheque_Dishonour__c, Project__r.RDS_Company_Code__r.Name, 
                Project__r.RDS_Company_Code__r.SPV_Bank_Account__c, Project__r.RDS_Company_Code__r.RDS_Address1__c
                from Opportunity
                where id = : oppId];
        if (Customer != null) {
            projectImage = Customer.Project__r.Project_Image__c;
            ////////Anuja Added////
            ProjectName =  Customer.Project__r.Name;
            ProjectUnitName = Customer.Project_Unit__r.Name;
            //UnitActualArea = Customer.Project_Unit__r.Actual_Area_value__c ;
            UnitActualArea = Customer.Project_Unit__r.Carpet_Area__c ;
            CustomerPrimaryName = Customer.Primary_Name__c;
            CustomerApplicantName =  Customer.Other_Applicants_Name__c;
            CustomerMailingAddress = Customer.Mailing_Address__c ;
            CustomerPhone = Customer.Account.PersonMobilePhone;
            CustomerEmail = Customer.Primary_Email__c ;
            CustomerUnitStatus = Customer.Project_Unit__r.Unit_Status__c;
            ///Anuja Added ENDS here/////
            CRMName = Customer.Project_Unit__r.Booking__r.Owner.Name;
            CRMEmail = Customer.Project_Unit__r.Booking__r.Owner.Email;
            CRMMobile = Customer.Project_Unit__r.Booking__r.Owner.Phone;
            if(Customer.Project_Unit__r.Booking__r.Booking_Date__c != null)
                bookingDate = Customer.Project_Unit__r.Booking__r.Booking_Date__c.format('dd MMM,yyyy');
            interestRate = Customer.Project__r.RDS_Interest_Rate__c;
            chequeDishonour = Customer.Project__r.Cheque_Dishonour__c;
            if (taxSlabMap.containsKey('TDS')) {
                tdsRate = string.valueOf(taxSlabMap.get('TDS')[0].Tax_Percentage__c.setscale(1)) + ' %';
            }   
            le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);
            taxRateBasic = 12;
            
            chargeAmountMap = DemandManagementServicesPortal.getDemandSoFarSummary('Basic', Customer.Id);
            otherChargesMap = DemandManagementServicesPortal.getDemandSoFarSummaryOtherCharges(Customer.Id);
            system.debug('Other charges map:' + otherChargesMap);
            
            booking = [Select Id, Quotation__c, Quotation__r.Id, 
                                    Quotation__r.Single_car_park_Earmarked__c, Quotation__r.Single_car_park_Additional__c,
                                    Quotation__r.Tandem_car_park_Earmarked__c, Quotation__r.Tandem_car_park_Additional__c, Quotation__r.Total_Independent__c, Quotation__r.Total_Dependent__c, Quotation__r.Total_Stack__c, Quotation__r.Total_New_Stack__c, Quotation__r.Total_Puzzle__c
                                    from Booking__c where Opportunity__r.Id = :oppId];
                                    
            if(booking.size() == 1) {
                if(Booking[0].Quotation__r.Single_car_park_Earmarked__c != null)
                    carParksAllotted += Integer.valueOf(Booking[0].Quotation__r.Single_car_park_Earmarked__c);
                if(Booking[0].Quotation__r.Single_car_park_Additional__c != null)
                    carParksAllotted += Integer.valueOf(Booking[0].Quotation__r.Single_car_park_Additional__c);
                if(Booking[0].Quotation__r.Tandem_car_park_Earmarked__c != null)
                    carParksAllotted += Integer.valueOf(Booking[0].Quotation__r.Tandem_car_park_Earmarked__c);
                if(Booking[0].Quotation__r.Tandem_car_park_Additional__c != null)
                    carParksAllotted += Integer.valueOf(Booking[0].Quotation__r.Tandem_car_park_Additional__c);
            }
            getledgerPrint();
            if(lpwList.size() > 0)
            { 
                if(lpwList[0].l.id != null){
                    ledgerList = [Select Name,Project__r.Project_Image__c From Ledger__c Where id =: lpwList[0].l.id];
                   
                }
            
            }
            System.debug('Charge Amount Map:' + chargeAmountMap);
            
            if(chargeAmountMap != null && chargeAmountMap.size() >0) {
                agreementValue = INformat(chargeAmountMap.get('Basic TOTAL'));
                totalBasicDemanded = INFormat(chargeAmountMap.get('Basic DEMANDED'));
                totalBasicTaxDemanded = INFormat(chargeAmountMap.get('Basic TAX DEMANDED'));
                if(chargeAmountMap.containsKey('Basic RECD') && chargeAmountMap.get('Basic RECD') != null)
                    totalBasicPaid = INFormat(chargeAmountMap.get('Basic RECD'));
                if(chargeAmountMap.containsKey('Basic TAX RECD') && chargeAmountMap.get('Basic TAX RECD') != null)
                    totalBasicTaxPaid = INFormat(chargeAmountMap.get('Basic TAX RECD'));
                if (taxSlabMap.containsKey('TDS')) {
                        tdsOnFlatCost = INFormat((chargeAmountMap.get('Basic TOTAL') * taxSlabMap.get('TDS')[0].Tax_Percentage__c / 100).setscale(0, RoundingMode.HALF_UP));
                }
                Decimal dSettled = 0;
                // this is the pending amounts.
                totalInterestDue =  INFormat(chargeAmountMap.get('Basic INTEREST') + chargeAmountMap.get('Basic INTEREST ON ST'));
                
                // this is the total interest on on the basic
                totalInterest =  INFormat(chargeAmountMap.get('Basic INTEREST DUE') + chargeAmountMap.get('Basic INTEREST ON ST DUE'));
                
                // this is the settled value - waived + paid
                totalInterestSettled =  INFormat(chargeAmountMap.get('Basic INTEREST PAID') + chargeAmountMap.get('Basic INTEREST ON ST PAID') + chargeAmountMap.get('Basic INTEREST WAIVED') + chargeAmountMap.get('Basic INTEREST ON ST WAIVED'));
                
                // this is the settled value - waived + paid in numeric value
                dSettled = chargeAmountMap.get('Basic INTEREST PAID') + chargeAmountMap.get('Basic INTEREST ON ST PAID') + chargeAmountMap.get('Basic INTEREST WAIVED') + chargeAmountMap.get('Basic INTEREST ON ST WAIVED');
                
                if(chargeAmountMap.get('Basic INTEREST DUE') + chargeAmountMap.get('Basic INTEREST ON ST DUE') > 0)
                    PercentageInterestPaid = ((dSettled / (chargeAmountMap.get('Basic INTEREST DUE') + chargeAmountMap.get('Basic INTEREST ON ST DUE')))*100).setscale(2,RoundingMode.HALF_UP) + ' %';
                
                if(chargeAmountMap.containsKey('Basic OUTSTANDING') && chargeAmountMap.get('Basic OUTSTANDING') != null)
                    totalBasicOutstanding = INFormat(chargeAmountMap.get('Basic OUTSTANDING'));
                
                if(chargeAmountMap.containsKey('Basic TAX OUTSTANDING') && chargeAmountMap.get('Basic TAX OUTSTANDING') != null)
                    totalBasicTaxOutstanding = INFormat(chargeAmountMap.get('Basic TAX OUTSTANDING'));
                if(chargeAmountMap.get('Basic DEMANDED') != 0)
                    PercentagePaidBasic = String.valueOf(( ( chargeAmountMap.get('Basic RECD') / chargeAmountMap.get('Basic DEMANDED') ) *100).setscale(2,RoundingMode.HALF_UP)) + ' %';
                if(chargeAmountMap.get('Basic TAX DEMANDED') != 0)
                    PercentagePaidBasicTax = String.valueOf(( ( chargeAmountMap.get('Basic TAX RECD') / chargeAmountMap.get('Basic TAX DEMANDED') ) *100).setscale(2,RoundingMode.HALF_UP)) + ' %';
                
                if(otherChargesMap != null && otherChargesMap.size() > 0) {
                    if(otherChargesMap.containsKey('Other OUTSTANDING') && otherChargesMap.get('Other OUTSTANDING') != null)
                        totalOtherOutstanding = INFormat(otherChargesMap.get('Other OUTSTANDING'));
                    
                    if(otherChargesMap.containsKey('Other TAX OUTSTANDING') && otherChargesMap.get('Other TAX OUTSTANDING') != null)
                        totalOtherTaxOutstanding = INFormat(otherChargesMap.get('Other TAX OUTSTANDING'));
                    
                    
                    if(otherChargesMap.containsKey('Other DEMANDED') && otherChargesMap.get('Other DEMANDED') != null)
                        totalOtherDemanded= INFormat(otherChargesMap.get('Other DEMANDED'));
                    
                    if(otherChargesMap.containsKey('Other TAX DEMANDED') && otherChargesMap.get('Other TAX DEMANDED') != null)
                        totalOtherTaxDemanded = INFormat(otherChargesMap.get('Other TAX DEMANDED'));
                    
                    if(otherChargesMap.containsKey('Other RECD') && otherChargesMap.get('Other RECD') != null)
                        totalOtherPaid= INFormat(otherChargesMap.get('Other RECD'));
                    
                    if(otherChargesMap.containsKey('Other TAX RECD') && otherChargesMap.get('Other TAX RECD') != null)
                        totalOtherTaxPaid = INFormat(otherChargesMap.get('Other TAX RECD'));
                    
                    if(otherChargesMap.get('Other DEMANDED') != 0)  
                        PercentagePaidOther = String.valueOf(( ( otherChargesMap.get('Other RECD') / otherChargesMap.get('Other DEMANDED') ) *100).setscale(2,RoundingMode.HALF_UP)) + ' %';
                    
                    if(otherChargesMap.get('Other TAX DEMANDED') != 0)
                    PercentagePaidOtherTax = String.valueOf(( ( otherChargesMap.get('Other TAX RECD') / otherChargesMap.get('Other TAX DEMANDED') ) *100).setscale(2,RoundingMode.HALF_UP)) + ' %';
                }
                Decimal grandTotalDemanded = 0;
                Decimal grandTotalPaid = 0;
                if(chargeAmountMap.containsKey('Basic DEMANDED') && chargeAmountMap.get('Basic DEMANDED') != null)
                    grandTotalDemanded = chargeAmountMap.get('Basic DEMANDED');
                if(chargeAmountMap.containsKey('Basic TAX DEMANDED') && chargeAmountMap.get('Basic TAX DEMANDED') != null)
                    grandTotalDemanded += chargeAmountMap.get('Basic TAX DEMANDED') ;
                if(Customer.Total_Interest__c != null)
                    grandTotalDemanded +=   Customer.Total_Interest__c;
                if(otherchargesMap != null && otherChargesMap.containsKey('Other DEMANDED') && otherChargesMap.get('Other DEMANDED') != null)
                    grandTotalDemanded += otherChargesMap.get('Other DEMANDED');
                
                gtDemanded = INFormat(grandTotalDemanded);
                
                if(chargeAmountMap.containsKey('Basic RECD') && chargeAmountMap.get('Basic RECD') != null)
                    grandTotalPaid = chargeAmountMap.get('Basic RECD');
                if(chargeAmountMap.containsKey('Basic TAX RECD') && chargeAmountMap.get('Basic TAX RECD') != null)
                    grandTotalPaid += chargeAmountMap.get('Basic TAX RECD') ;
                grandTotalPaid +=   dSettled;
                if(otherchargesMap != null && otherChargesMap.containsKey('Other RECD') && otherChargesMap.get('Other RECD') != null)
                    grandTotalPaid += otherChargesMap.get('Other RECD');
                
                gtPaid = INFormat(grandTotalPaid);
                if(grandTotalDemanded != 0) {
                    gtPercentage = String.valueOf(( ( grandtotalPaid / grandtotalDemanded ) *100).setscale(2,RoundingMode.HALF_UP)) + ' %'; 
                }
                    
                OnAccountMoney = InFormat(PaymentManagementServices.getOnAccountMoney(oppId));
            }
        } else {
            errMsg = 'Invalid customer: Ledger cannot be printed';
            error = true;
        }
        
        System.debug('Customer Detail:' + customer);
        System.debug('List in Ledger Print:' + lpwLocalList.size());
        
    }
    
    public void getledgerPrint() {
            String header = '';
            Integer count = 0;
            lpwList = LedgerManagementServices.getCustomerLedgers(oppId);
            String cc='';
            
            for(LedgerManagementServices.LedgerPrintWrapper lpw : lpwList) {
                if(lpw.refNo == 0)
                    cc = '#FACDCD';
                if(lpw.refNo == 1)
                    cc = '#F8FACD';
                if(lpw.refNo == 2)
                    cc = '#D2FACD';
                if(lpw.refNo == 3)
                    cc = '#CDFAEC';
                if(lpw.refNo == 4)
                    cc = '#ECCDFA';
                if(lpw.refNo == 5)
                    cc = '#F1DB42';
                if(lpw.refNo == 6)
                    cc = '#F04158';
                if(lpw.refNo == 7)
                    cc = '#9BBAF0';
                if(lpw.refNo == 8)
                    cc = '#FFC469';
                if(lpw.refNo == 9)
                    cc = '#79FEC0';
                if(lpw.refNo == 10)
                    cc = '#6BD9F8';
                if(lpw.refNo == 11)
                    cc = '#DFF79F';
                if(lpw.refNo == 12)
                    cc = '#B390C2';
                if(lpw.refNo == 13)
                    cc = '#DBC31D';
                if(lpw.refNo == 14)
                    cc = '#D6CEAA';
                if(lpw.refNo == 15)
                    cc = '#B8FD99';
                if(lpw.refNo == 16)
                    cc = '#FFFDC0';
                if(lpw.refNo == 17)
                    cc = '#D2BC24';
                if(lpw.refNo == 18)
                    cc = '#1CCB75';
                if(lpw.refNo == 19)
                    cc = '#6D997A';
                if(lpw.refNo == 20)
                    cc = '#DED1B6'; 
                if(lpw.refNo == 21)
                    cc = '#FECEA8'; 
                if(lpw.refNo == 22)
                    cc = '#FF847C'; 
                if(lpw.refNo == 23)
                    cc = '#F2F0DF'; 
                if(lpw.refNo == 24)
                    cc = '#7FB8B0';  
                if(lpw.refNo == 25)
                    cc = '#E8591C';  
                if(lpw.refNo == 26)
                    cc = '#B5AC01'; 
                if(lpw.refNo == 27)
                    cc = '#FFFDC0'; 
                if(lpw.refNo == 28)
                    cc = '#457D97'; 
                if(lpw.refNo == 29)
                    cc = '#C0D1C2';
                if(lpw.refNo == 30)
                    cc = '#2E4347';
                if(lpw.refNo == 31)
                    cc = '#BCA297';
                if(lpw.refNo == 32)
                    cc = '#AB526B';
                if(lpw.refNo == 33)
                    cc = '#6B5D4D';
                if(lpw.refNo == 34)
                    cc = '#F77825';
                if(lpw.refNo == 35)
                    cc = '#B9D48B';
                if(lpw.refNo == 36)
                    cc = '#8D2036';    
                if(lpw.refNo == 37)
                    cc = '#94B053';
                if(lpw.refNo == 38)
                    cc = '#82837E'; 
                if(lpw.refNo == 37)
                    cc = '#1F6764';
                if(lpw.refNo == 38)
                    cc = '#92B35A';
                if(lpw.refNo == 39)
                    cc = '#1F6764';
                if(lpw.refNo == 40)
                    cc = '#F2F26F';          
                if(lpw.refNo == 1001)
                    cc = '#F9BA84';
                if(lpw.refNo == 1002)
                    cc = '#E0E05A';
                    
                
                // setting the header to None, makes the display style none at the page.
                // setting the header style to '' makes the tr which contains the 
                // page break element and rowheader element to appear on every page break
                if(ledgerStyle == '') {
                    if (count < 7) {
                        header = 'None';
                    } else if(Math.mod(count+2,9) == 0) {
                        header = ''; 
                    } else {
                        header = 'None';
                    }
                } else {
                    if (count < 6) {
                        header = 'None';
                    } else if(Math.mod(count+2,8) == 0) {
                        header = ''; 
                    } else {
                        header = 'None';
                    }
                }
                
                LedgerPrintWrapper lpwLocal;
                if(lpw.l.Debit_Credit__c == 'Credit')
                    lpwLocal = new LedgerPrintWrapper(lpw.l, lpw.chargeName, lpw.Amount, lpw.refNo, lpw.refString, cc, lpw.Balance, lpw.demandFor, lpw.paymentFor, lpw.DemandDetails, lpw.PaymentDetails, header);
                else if(lpw.l.Debit_Credit__c == 'Debit' && ledgerStyle == '')
                    lpwLocal = new LedgerPrintWrapper(lpw.l, lpw.chargeName, lpw.Amount, lpw.refNo, lpw.refString, cc, lpw.Balance, lpw.demandFor, lpw.paymentFor, lpw.DemandDetails, lpw.PaymentDetails, header);
                
                lpwLocalList.add(lpwLocal);
                System.debug('Ledger wrapper:' + lpwLocal);
                if(lpw.l.Debit_Credit__c == 'Credit'){ 
                    count ++;
                } else if(lpw.l.Debit_Credit__c == 'Debit' && ledgerStyle == ''){
                    count++;
                } else { //skip counting the debit rows if the type is only payments, it affects the number of rows printed on a page
                    
                }
                cc='';
            }
            System.debug('List in Ledger Print:' + lpwLocalList.size());
    } 
    // method for formatting the currency details to Indian Commas Format
    public static String INFormat(Decimal money) {
        Boolean negative = false;
        if(money < 0) {
            negative = true;
        }
        String m1 = String.valueOf(math.abs(money.setscale(0,RoundingMode.HALF_UP))).reverse();
        String mF = '';
        for(Integer i=0; i < m1.length() ; i++) {
            mF += m1.substring(i,i+1);
            if(i==2) {
                mF += ',';
            }
            if(i==4 || i==6 || i==8 || i==10 || i==12) {
                mF += ',';
            }
        }
        mf = mf.reverse();
        if(mf.substring(0,1).equals(',')) {
            mf = mf.substring(1);
        }
        if(!negative)
            mf = 'Rs ' + mf + '/-';
        else
            mf = '- Rs ' + mf + '/-';
        return mf;
    }
    
    public class LedgerPrintWrapper {
        public Ledger__c l {get;set;}
        public Integer refNo {get;set;}
        public String refString {get;set;}
        public String chargeName {get;set;}
        public String Amount {get;set;}
        public String colorCode {get;set;}
        public String Balance {get;set;}
        public String DemandFor {get;set;}
        public String paymentFor {get;set;}
        public String demandDetails {get;set;}
        public String paymentDetails {get;set;}
        public String header {get;set;}
            
        public LedgerPrintWrapper(Ledger__c l , String cName, String Amount, Integer refNo, String refString,  String cc, String Balance, String demandFor, String paymentFor, String demandDetails, String paymentDetails, String Header) {
            this.l = l;
            this.chargeName = cName;
            this.Amount = Amount;
            this.refNo = refNo;
            this.colorCode = cc;
            this.balance = balance;
            this.demandFor = demandFor;
            this.paymentFor = paymentFor;
            this.demandDetails = demandDetails;
            this.paymentDetails = paymentDetails;
            this.refString = refString;
            this.header = header;
        }
    }
}