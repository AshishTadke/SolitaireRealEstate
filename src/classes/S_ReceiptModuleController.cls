public with sharing class S_ReceiptModuleController {
    public rMainWrapper rmw {get; set;}
    public string instrumentType {get;set;}
    public List < SelectOption > entityOptions {get;set;}
    public List < SelectOption > deductorPANOptions {get;set;}
    public List < SelectOption > deducteePANOptions {get;set;}
    public String entitySelected {get;set;}
    public List<Opportunity> oppList {get;set;}
    public Boolean onlyToken {get;set;}
    public Boolean unitError {get;set;}
    public Decimal totalAllocated {get;set;}
    public Boolean showPending {get;set;}
    public Boolean hasDues {get;set;}
    public Boolean hasPaymentDues {get;set;}
    public Boolean currentDues {get;set;}
    public Boolean advanceDues {get;set;}
    public Boolean penalties {get;set;}
    public Boolean amountAdjusted {get;set;}
    public Boolean raiseDemand {get;set;}
    public Boolean processComplete {get;set;}
    public Boolean debug {get;set;}
    public Boolean rtFlatCost {get;set;}
    public Boolean rtSeviceTax {get;set;}
    public Boolean rtRegistration {get;set;}
    public Boolean Flat {get;set;}
    public Boolean Service {get;set;}
    public Boolean Registration {get;set;}
    public Integer rowIndex {get;set;}
    public List<PPDWrapper> pwList {get;set;}
    public List<PPDWrapper> pw1List {get;set;}
    public List<Project__c> p {get;set;}
    Map<String,List<Tax_Breakup__c>> taxSlabMap  {get;set;}
    public Decimal totalAdvAllocated {get;set;}
    public Id receiptId {get;set;} 
    public Boolean adjustmentFlow {get;set;}
    public Boolean foreignCurrency {get;set;}
    public Decimal moneyInHand {get;set;}
    public Boolean error {get;set;}
    public Boolean receiptSaved {get;set;}
    public Id rmId {get;set;}
    public Boolean hideInterest {get;set;}
    public List<Receipt__c> recList{get;set;}
    public List<Receipt__c> last3MonthRecList{get;set;}
    public Boolean isDupe{get;set;}
    public Boolean isTDSAmt{get;set;}
    public Boolean adjustBtnDisable {get;set;}
    public string applicantNames {get;set;}
    public List<Ledger__c>  listLedger {get;set;}
    public List<ledgerWrapper>  lwList {get;set;}
    
    public S_ReceiptModuleController() {
        System.debug('Constructor:');
        rmw = new rMainWrapper();
        onlyToken = false;
        unitError = false;
        hasDues = false;
        totalAllocated = 0;
        totalAdvAllocated = 0;
        showPending = false;
        currentDues = false;
        advanceDues = false;
        penalties = false;
        amountAdjusted = false;
        raiseDemand = false;
        processComplete = false;
        adjustmentFlow = false;
        rtFlatCost = false;
        rtSeviceTax = false;
        rtRegistration = false;
        Flat = false;
        Service = false;
        Registration = false;
        moneyInHand = 0;
        foreignCurrency = false;
        isDupe = false;
        error = false;
        applicantNames ='';
        debug=false;
        receiptSaved = false;
        rmId = null;
        isTDSAmt = false;
        hideInterest = false;
        adjustBtnDisable = false;
        recList = new List<Receipt__c>();
        last3MonthRecList = new List<Receipt__c>();
        listLedger = new List<Ledger__c>();
        
        if(ApexPages.currentPage().getParameters().get('id') != null && ApexPages.currentPage().getParameters().get('id') != '')
        {
            receiptId = ApexPages.currentPage().getParameters().get('id');
        }
        List<Receipt__c> rc = new List<Receipt__c>();
        if(receiptId != null) {
         rc = [Select Id, Name, Amount_Rs__c, Mode__c, Receipt_Date__c, Cheque_DD_Date__c, DraweeBank__c,Drawee_Bank_If_Others__c,
                Drawn_in_favour_of__c,Receipt_Against__c, Cheque_DD__c, On_Account_Money__c, Receipt_status__c,Foreign_Currency_Type__c, 
                Amount_in_Foreign_Currency__c,PAN_no_of_TDS_Deductor__c, PAN_no_of_TDS_Deductee__c, Challan_No__c,TDS_Amount_In_Rs__c,IsTDS_And_NoDemandRaised__c,
                Currency__c, FOREX__c, Project__c,Project__r.Id, Project_Unit__c,Approval_Status__c,Opportunity_Email_Id__c from receipt__c where id =:receiptId ];
        }
        if(rc.size() == 1){
            rmw.r = rc[0];
            entitySelected = rmw.r.Drawn_in_favour_of__c; 
            if(rmw.r.mode__c.equalsIgnoreCase('Cheque') || 
            rmw.r.mode__c.equalsIgnoreCase('DD/Pay Order') || 
            rmw.r.mode__c.equalsIgnoreCase('EFT') || rmw.r.mode__c.equalsIgnoreCase('Credit Card')
            ) {
                instrumentType = 'ins1';
            } else if (rmw.r.mode__c.equalsIgnoreCase('TDS')) {
                instrumentType = 'ins2';
            } else if (rmw.r.mode__c.equalsIgnoreCase('Cash') || rmw.r.mode__c.equalsIgnoreCase('Credit Note')) {
                instrumentType = 'ins3';
            }else {
                instrumentType = 'error';
            }
            unitSelectionValidation();
            adjustmentFlow = true;
            if(rmw.r.Foreign_Currency_Type__c != null && !rmw.r.Foreign_Currency_Type__c.equalsIgnoreCase('Indian Rupee'))
                foreignCurrency = true;
            // commented this on 8/2/16. All currencies shd go to apply receipt and there we have checks to show what can be processed and what not
           // if(rmw.r.Currency__c.equalsIgnoreCase('Indian Rupee') || rmw.r.Currency__c.equalsIgnoreCase('RUPEES'))
                
                
                
            if(rmw.r.Receipt_Against__c == 'Flat Cost' ){  //|| rmw.r.Drawn_in_favour_of__c.contains('Flat Cost')
                rtFlatCost = True;
                rtSeviceTax = False;
                rtRegistration = False;
                } 
            else if (rmw.r.Receipt_Against__c == 'GST') {  //|| rmw.r.Drawn_in_favour_of__c.contains('Service Tax')
                rtFlatCost = False;
                rtSeviceTax = True;
                rtRegistration = False;
                }
            else if (rmw.r.Receipt_Against__c == 'Stamp Duty And Registration') { //|| rmw.r.Drawn_in_favour_of__c.contains('Stamp Duty And Registration')
                rtFlatCost = False;
                rtSeviceTax = False;
                rtRegistration = True;
                }
            else {
            }
            
            applyReceipt();
       
        }
    }
    public void selectInstrument() {
            
        if(rmw.r.mode__c.equalsIgnoreCase('Cheque') || 
            rmw.r.mode__c.equalsIgnoreCase('DD/Pay Order') || 
            rmw.r.mode__c.equalsIgnoreCase('EFT') || rmw.r.mode__c.equalsIgnoreCase('Credit Card')
        ) {
            instrumentType = 'ins1';
        } else if (rmw.r.mode__c.equalsIgnoreCase('TDS')) {
            instrumentType = 'ins2';
        }
        else if (rmw.r.mode__c.equalsIgnoreCase('Cash')|| rmw.r.mode__c.equalsIgnoreCase('Credit Note')){
            instrumentType = 'ins3';
        } else {
            instrumentType = 'error';
        }
         rmw.r.Receipt_Date__c = system.today();
    }
    
    public void  getEntityDetails() {
        entityOptions = new List<SelectOption>();
        Legal_Entity__c le = InventoryCostServices.getLegalEntityDetails(rmw.r.Project_Unit__c, rmw.r.Project__c);
        entityOptions.add(new SelectOption('','--None--'));
        if(le != null && le.Account_Name_Flat_Cost__c != null) {
           entityOptions.add(new SelectOption('Flat Cost |' +  le.Account_Name_Flat_Cost__c +'|'+ le.Bank_Name_Flat_Cost__c + '|' + le.Account_Number_Flat_Cost__c,'Flat Cost |' + le.Account_Name_Flat_Cost__c + '|' + le.Bank_Name_Flat_Cost__c + '|' + le.Account_Number_Flat_Cost__c));
        }
        if(le != null && le.Account_Name_Service_Tax__c != null) {
           entityOptions.add(new SelectOption('Service Tax |' + le.Account_Name_Service_Tax__c + '|' + le.Bank_Name_Service_tax__c + '|' + le.Account_Number_Service_tax__c,'Service Tax |' + le.Account_Name_Service_Tax__c + '|' + le.Bank_Name_Service_tax__c + '|' + le.Account_Number_Service_tax__c));
        }
        if(le != null && le.Account_Name_TDS__c != null) {
            entityOptions.add(new SelectOption('TDS |' + le.Account_Name_TDS__c + '|' + le.Bank_Name_TDS__c + '|' + le.Account_Number_TDS__c,'TDS |' + le.Account_Name_TDS__c + '|' + le.Bank_Name_TDS__c + '|' + le.Account_Number_TDS__c));
        }
        if(le != null && le.Account_Name_SRL__c!= null) {
            entityOptions.add(new SelectOption('Stamp Duty And Registration |' + le.Account_Name_SRL__c + '|' + le.Bank_Name_SRL__c + '|' + le.Account_Number_SRL__c,'Stamp Duty And Registration |' + le.Account_Name_SRL__c + '|' + le.Bank_Name_SRL__c + '|' + le.Account_Number_SRL__c));
        }
        entityOptions.add(new SelectOption('Not Specified','Not Specified'));
        
    }
    public void populateInFavour() {
        Legal_Entity__c le = InventoryCostServices.getLegalEntityDetails(rmw.r.Project_Unit__c, rmw.r.Project__c);
     if(rmw.r.Receipt_Against__c.equalsIgnoreCase('Flat Cost')){
        rmw.r.Drawn_in_favour_of__c = 'Flat Cost |' +  le.Account_Name_Flat_Cost__c +'|'+ le.Bank_Name_Flat_Cost__c + '|' + le.Account_Number_Flat_Cost__c;
        rtFlatCost = True;
        rtSeviceTax = False;
        rtRegistration = False;
      }
      else if (rmw.r.Receipt_Against__c.equalsIgnoreCase('GST')) {
           rmw.r.Drawn_in_favour_of__c = 'Service Tax |' + le.Account_Name_Service_Tax__c + '|' + le.Bank_Name_Service_tax__c + '|' + le.Account_Number_Service_tax__c;
           rtSeviceTax = True;
           rtFlatCost = False;
           rtRegistration = False;
        }
      else if (rmw.r.Receipt_Against__c.equalsIgnoreCase('Stamp Duty And Registration')) {
           rmw.r.Drawn_in_favour_of__c = 'Stamp Duty And Registration |' + le.Account_Name_SRL__c + '|' + le.Bank_Name_SRL__c + '|' + le.Account_Number_SRL__c;
           rtRegistration = True;
            rtFlatCost = False;
            rtSeviceTax = False;
        }
      else {
          rmw.r.Drawn_in_favour_of__c = 'Not Specified';
        }      
    }
    public void getPANDeductor() {
        deductorPANOptions = new List<SelectOption>();
        deductorPANOptions.add(new SelectOption('','--None--'));
        if(String.isNotBlank(oppList[0].Primary_pancard__c)) {
            deductorPANOptions.add(new SelectOption(oppList[0].Primary_pancard__c,oppList[0].Primary_pancard__c));
        }
        if(String.isNotBlank(oppList[0].Other_Applicants_Pancard__c)) {
            List<String> PANList = new List<String>();
            PANList = oppList[0].Other_Applicants_Pancard__c.split(',');
            if(PANList.size() > 0) {
                for(String p : PANList) {
                    deductorPANOptions.add(new SelectOption(p, p));
                }
            }
        }
    }
    
    public void  getPANDeductee() {
        deducteePANOptions = new List<SelectOption>();
        Legal_Entity__c le = InventoryCostServices.getLegalEntityDetails(rmw.r.Project_Unit__c, rmw.r.Project__c);
        deducteePANOptions.add(new SelectOption('','--None--'));
        if(le != null && le.RDS_PAN_No__c != null) {
            deducteePANOptions.add(new SelectOption(le.RDS_PAN_No__c, le.RDS_PAN_No__c));
        }
        if(le != null && le.RDS_Service_Tax_No__c != null) {
            deducteePANOptions.add(new SelectOption(le.RDS_Service_Tax_No__c, le.RDS_Service_Tax_No__c));
        }
    }

    public void getCustomerDetails() {
        oppList = [Select Name, Id, StageName,Primary_Name__c,Other_Applicants_Name__c, 
                Future_Correspondence_Contact__c,Future_Correspondence_Contact_Name__c, Email__c, 
                Future_Correspondence_Contact_Email__c, Primary_Email__c, Other_Applicants_Email__c,
                Total_Interest_Settled__c, 
                Total_Waiver__c, Total_Interest_Waiver__c, Project__r.Cheque_Dishonour__c,
                Primary_pancard__c, Other_Applicants_Pancard__c
                from Opportunity where Project__c = : rmw.r.Project__c and Project_Unit__c =: rmw.r.Project_Unit__c and Status__c ='Active'];
       system.debug('opp size::: '+oppList.size());
        system.debug('opp ::: '+oppList);
        if(oppList.size() == 1) {
            if(String.isNotBlank(oppList[0].Primary_Name__c)) 
                applicantNames = oppList[0].Primary_Name__c;
            if(String.isNotBlank(oppList[0].Other_Applicants_Name__c) && string.IsnotBlank(applicantNames))
                applicantNames += ',' + oppList[0].Other_Applicants_Name__c;
            else if(String.isNotBlank(oppList[0].Other_Applicants_Name__c))
                applicantNames = oppList[0].Other_Applicants_Name__c;
        }
        if(oppList.size() == 1 && !oppList[0].stageName.equalsIgnoreCase('Booking Confirmed')) {
            onlyToken = true;
            rmw.r.Token_Amount_Receipt__c = true;
        } else if(oppList.size() != 1){
            unitError = true;
        } 
        if(oppList != null && oppList.size() == 1) {
            List<Booking__c> bookList = [Select Id, OwnerId from Booking__C where opportunity__c = : oppList[0].Id];
            if( bookList != null && bookList.size() == 1) {
                rmId = bookList[0].ownerId;
                rmw.r.Booking__c = bookList[0].Id;
            }
        }
    }
    
    public void unitSelectionValidation() {
        unitError = false;
        onlyToken = false;
        rmw.r.Token_Amount_Receipt__c = false;
        hasDues = false;
        advanceDues = false;
        totalAllocated = 0;
        currentDues = false;
        advanceDues = false;
        penalties = false;
        raiseDemand = false;
        error = false;
        
        getCustomerDetails();
        if(unitError) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'There is an issue with customer association for this unit, can\'t proceed with receipt processing'));
        } else if(onlyToken) {
            rmw.r.Opportunity__c = oppList[0].Id;
            getEntityDetails();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Booking is yet to be processed. The money will be put on Account till then'));
        } else if (!unitError) {
            rmw.r.Opportunity__c = oppList[0].Id;
            hasPaymentDues = false;
            // check if there any dues against this account, past or upcoming
            hasPaymentDues = PaymentManagementServices.accountHasDues(rmw.r.Project_Unit__c, oppList[0].Id);
            
            // check if there are any penalties [currently only cheque bounce incurs a penalty]
            listLedger = PaymentManagementServices.getChequeDishonours(oppList[0].Id);
            if(listLedger != null && listLedger.size() > 0) {
                penalties = true;
            }
            
            // If any of the above is true, then the unit/ customer has dues and we can process the payment made.
            if(hasPaymentDues || penalties)
                hasDues = true;
            getEntityDetails();
            getPANDeductor();  
            getPANDeductee();  
            if(!hasDues) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'All dues have been paid against this unit, Money can only be saved on account'));
            }
            
        }
    }
    
    public PageReference applyReceipt() {
     boolean isError = false;
       if(rmw.r.DraweeBank__c == 'Other'){
            if(rmw.r.Drawee_Bank_If_Others__c == null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Drawee Bank(If Others)'));
              isError = true;
              return null;
         }  
           
       }   
         if(isError == false){     
        System.debug('Apply receipt:');
        showPending = false;
        currentDues = false;
        advanceDues = false;
        totalAllocated = 0;
        error = false;
        pwList = new List<PPDWrapper>();
        pw1List = new List<PPDWrapper>();
        
        if(!adjustmentFlow) {
            if(rmw.r.mode__c.equalsIgnoreCase('Cheque') || 
            rmw.r.mode__c.equalsIgnoreCase('DD/Pay Order')) {
                if(rmw.r.Cheque_DD_Date__c < system.today().addDays(-20000) || rmw.r.Cheque_DD_Date__c > system.today().addDays(1) ) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Instrument date has to be between 90 days ago from today to 1 day ahead of today'));
                    error = true;
                    return null;
                }
            } 
            if(rmw.r.mode__c.equalsIgnoreCase('EFT') || rmw.r.mode__c.equalsIgnoreCase('Credit Card') ||
            rmw.r.mode__c.equalsIgnoreCase('TDS') || rmw.r.mode__c.equalsIgnoreCase('Cash') || rmw.r.mode__c.equalsIgnoreCase('Credit Note')) {
                if(rmw.r.Cheque_DD_Date__c > system.today()) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Instrument date cannot be a future date'));
                    error = true;
                    return null;
                }
            }
            if(rmw.r.mode__c.equalsIgnoreCase('TDS') || rmw.r.mode__c.equalsIgnoreCase('Cash') || rmw.r.mode__c.equalsIgnoreCase('Credit Note')) {
                rmw.r.Currency__c = 'Indian Rupee';
            }
        }
        
        if(adjustmentFlow) {
            if(foreignCurrency && rmw.r.Receipt_status__c != 'Cleared') {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Foreign currency cheques can be processed only after the money has been realized & approved by finance'));
                error = true;
                return null;
            } else if(rmw.r.Receipt_Status__c.equalsIgnoreCase('Physical Verification Rejected') || rmw.r.Receipt_Status__c.equalsIgnoreCase('Dishonored') ) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'No further processing can be done on this instrument. The instrument is in ' + rmw.r.receipt_status__c + ' status'));
                error = true;
                return null;
            } 
            moneyInHand = rmw.r.On_Account_Money__c;
            // added this on 6/2/16 to stop processing when on account money is 0
            if(moneyInHand == 0) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No further processing can be done on this instrument. The instrument is  fully adjusted'));
                processComplete = true;
                return null;
            }
        } else {
            moneyInHand = rmw.r.Amount_Rs__c;
        }
        
        // dont display the interest entry columns in the apportionment screen if a delayed EFT entry is being made.
        // interest needs to be recalculated after apportionment
        if(rmw.r.mode__c.equalsIgnoreCase('EFT')  && rmw.r.Cheque_DD_Date__c <> system.today()) 
           hideInterest = true;
            
        taxSlabMap = InventoryCostServices.getChildTaxRateForCharges(rmw.r.Project__c);
        
        if(moneyInHand > 0 && (rmw.r.Currency__c.equalsIgnoreCase('Indian Rupee') || rmw.r.Currency__c.equalsIgnoreCase('RUPEES'))) {
            if(!hasDues) {
                rmw.r.On_Account_Money__c = moneyInHand;
                // For Indian currency, in no dues scenarion 
                // adjust button is not necessary as there is nothing to adjust
                // directly go to advance demands
                   processComplete = true;
            }else if(onlyToken) {
                rmw.r.On_Account_Money__c = moneyInHand;    
            } else {
                if(penalties) {
                    ledgerWrapper lw;
                    lwList = new List<LedgerWrapper>();
                    for(Ledger__c l : listLedger){
                        if(moneyInHand >= 500) {
                            moneyInHand -= 500;
                            lw = new ledgerWrapper(l, oppList[0].Project__r.Cheque_Dishonour__c, true);
                        }
                        else {
                            lw = new ledgerWrapper(l, oppList[0].Project__r.Cheque_Dishonour__c, false);
                        }
                        lwList.add(lw);
                    }
                } 
                // fetch all outstanding and advanced dues for this account.
                List<Standard_Customer_Pay_Plan_Detail__c> ppdList = PaymentManagementServices.getMileStonesToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
                List<Standard_Customer_Pay_Plan_Detail__c> ppdListUpcoming = PaymentManagementServices.getUpcomingToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
                
               
                if(ppdList.size() > 0) {
                    currentDues = true;
                    for(Standard_Customer_Pay_Plan_Detail__c s :ppdList) {
                        PPDWrapper pw = new PPDWrapper(s,'');
                        pwList.add(pw);
                    }
                }
                system.debug('inside applyreceipt::: '+pwList);
                if(pwList.size() > 0){
                 system.debug('rtSeviceTax:: '+rtSeviceTax);
                        system.debug('rtFlatCost  :: '+rtFlatCost );
                        system.debug('rtRegistration  :: '+rtRegistration );
                        Flat = false;
                        Service = false;
                        Registration = false;
                    for(PPDWrapper p: pwList) {
                        system.debug('p.s.Service_Tax_Amount_Due__c:: '+p.s.Service_Tax_Amount_Due__c);
                        system.debug('Charge_Amount_Due__c :: '+p.s.Charge_Amount_Due__c );
                        system.debug('p.s.Is_to_be__c :: '+p.s.Is_to_be__c);
                        
                       if(p.s.Service_Tax_Amount_Due__c > 0) {
                            Service = True;
                        }
                        
                        if(p.s.Is_to_be__c != 'On Registration' && p.s.Charge_Amount_Due__c > 0){
                            flat = True;
                        }
                        
                       if(p.s.Is_to_be__c == 'On Registration' && p.s.Charge_Amount_Due__c > 0){
                            Registration = True;
                        }
                    }
                    system.debug('Service :: '+Service );
                    system.debug('Flat :: '+Flat );
                    system.debug('Registration :: '+Registration );
                    
                    //added by ashish
                        if(!Service && rtSeviceTax) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'All dues have been paid against this unit For GST, Money can only be saved on account'));
                            //return null;
                        }
                        
                        if(!Flat && rtFlatCost) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'All dues have been paid against this unit For Flat Cost, Money can only be saved on account'));
                            //return null;
                        }
                        
                        if(!Registration && rtRegistration) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'All dues have been paid against this unit For StampDuty And Registration, Money can only be saved on account'));
                            //return null;
                        } 
                }
                
                // fetch all outstanding dues
                
                Decimal upcomingInstallment = 0;
                Decimal upcomingST = 0;
                if(ppdListUpcoming.size() > 0) {
                    for(Standard_Customer_Pay_Plan_Detail__c s :ppdListUpcoming) {
                        if(s.Installment__c == null) {
                            s.Installment__c =0;
                        }
                        if(s.Charge_Amount_Advance_Recd__c == null) {
                            s.Charge_Amount_Advance_Recd__c =0;
                        }
                        if(s.Installment__c - s.Charge_Amount_Billed__c > 0) {
                            upcomingInstallment = s.Installment__c - s.Charge_Amount_Billed__c;
                            if(taxSlabMap.containsKey(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                for(Tax_Breakup__c tb : taxSlabMap.get(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    upcomingST += ((tb.Taxable_Percentage__c * upcomingInstallment/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                }
                            }
                            else
                                upcomingST = 0;
                            PPDWrapper pw = new PPDWrapper(s,'',upcomingInstallment,upcomingST);
                            pw1List.add(pw);
                        }
                        upcomingInstallment = 0;
                        upcomingST = 0;
                    }
                } 
                
                if(pw1List.size() > 0) {
                    advanceDues = true;
                    // skip directly to the raise demand flow, in case of adjustment of Indian currency where are there no current dues or penalties
                    // here the save button is not necessary as there is nothing to save
                    if((!currentDues && !penalties) && adjustmentFlow) {
                        raiseDemand = true;
                        processComplete = true;
                    }
                }  
                rmw.r.On_Account_Money__c = moneyInHand - totalAllocated;
                if (!currentDues && !advanceDues && !penalties) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'no dues scenario, this flow - cant happen?!'));
                    error = true;
                    return null;
                }           
            }
        } else if (rmw.r.Amount_Rs__c > 0 && !rmw.r.Currency__c.equalsIgnoreCase('Indian Rupee') && !adjustmentFlow){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Instrument is in foreign currency, money from the receipt can be adjusted only after banking the cheque'));
            foreignCurrency = true; 
            rmw.r.On_Account_Money__c = moneyInHand;
        } else if(rmw.r.Amount_Rs__c <= 0) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Invalid Amount entered'));
            error = true;
            return null;
            
        }else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Something went wrong!'));
            error = true;
            return null;
        }
        System.debug('Save:');
        if((!adjustmentFlow)) {
            Id rId;
            Receipt__c rt = new Receipt__c();
            rt = rmw.r;
            rt.Receipt_Status__c = 'UnProcessed';  
            if(rt.Mode__c != 'Cash' || rt.Mode__c != 'Credit Note')
               rt.Receipt_Status__c = 'UnProcessed';
            if(rt.Mode__c == 'Cash' || rt.Mode__c == 'Credit Note'){
               rt.Receipt_Status__c = 'Cleared';
               rt.Physically_Cheque_Received__c  = true;
               rt.Banking__c = 'Payment Successful';
               rt.Reason_for_rejection_new__c  = 'Accepted';
            }        
            if(rmw.r.Mode__c.equalsIgnoreCase('TDS') && (pwList.size() == 0 || pwList == null)){
                 rmw.r.On_Account_Money__c = 0;
                 rt.On_Account_Money__c = 0;
                 rt.TDS_Amount_In_Rs__c = rmw.r.Amount_Rs__c;
                 isTDSAmt = true;
                 rt.IsTDS_And_NoDemandRaised__c = true;
            }
            else{     
                  rt.On_Account_Money__c = rmw.r.Amount_Rs__c;    
                }
            rt.Total_Amount__c = rmw.r.Amount_Rs__c;
            if(rt.Mode__c != 'Cash')
               // rt.Drawn_In_Favour_Of__c =  entitySelected;
            if(foreignCurrency) {
                rt.Amount_in_Foreign_Currency__c = rt.Total_Amount__c;
                rt.Foreign_Currency_Type__c = rt.Currency__c;
            }
            if(rmId != null) {
                rt.ownerId = rmId;
            }
            if (oppList[0].Primary_Email__c != null && oppList[0].Primary_Email__c != '' && String.isBlank(rt.Opportunity_Email_Id__c) )
                    rt.Opportunity_Email_Id__c = oppList[0].Primary_Email__c;
            try {   
                Database.SaveResult r = Database.insert(rt);
                if(r.isSuccess())
                    rId = r.getId();
            } catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }
            if(!onlyToken && !foreignCurrency) {
                processComplete = true;
            }
            receiptSaved = true;
        } else {
            receiptSaved = true;
            processComplete = true;
        }
      }  return null;
    }

    // this is called on tab out of every entry
    public void applyDues() {
        System.debug('Apply Dues:');
        showPending = true;
        amountAdjusted = false;
        totalAllocated = 0;
        raiseDemand = false;
    Boolean calcError = false;
        
        for(PPDWrapper p: pwList) {
            totalAllocated += p.s1.Charge_Amount_Paid__c + p.s1.Service_Tax_Amount_Paid__c + p.s1.Int_flatcost_paid__c + p.s1.Int_servicetax_paid__c;
            if(totalAllocated > moneyInHand) {
                p.s1.Int_flatcost_paid__c.addError('Total allocation greater than money received');
        calcError = true;
            } else if (p.s1.Int_servicetax_paid__c > p.s.Int_servicetax_pending__c || totalAllocated > moneyInHand){
                p.s1.Int_servicetax_paid__c.addError('Incorrect Interest (ST) Allocation');
        calcError = true;
            } else if (p.s1.Int_flatcost_paid__c > p.s.Int_flatcost_pending__c || totalAllocated > moneyInHand){
                p.s1.Int_flatcost_paid__c.addError('Incorrect Interest (flatcost) Allocation');
        calcError = true;
            } else if (p.s1.Int_servicetax_waived__c > (p.s.Int_servicetax_pending__c - p.s1.Int_servicetax_paid__c)){
                p.s1.Int_servicetax_waived__c.addError('Amount waived is greater than amount due');
        calcError = true;
            } else if (p.s1.Int_flatcost_waived__c > (p.s.Int_flatcost_pending__c - p.s1.Int_flatcost_paid__c)){
                p.s1.Int_flatcost_waived__c.addError('Amount waived is greater than amount due');
        calcError = true;
            } else if (p.s1.Charge_Amount_Paid__c > p.s.charge_amount_due__c || totalAllocated > moneyInHand) {
                p.s1.Charge_Amount_Paid__c.addError('Incorrect Installment Allocation');
        calcError = true;
            } else if(p.s1.Service_Tax_Amount_Paid__c > p.s.Service_Tax_Amount_Due__c) {
                p.s1.Service_Tax_Amount_Paid__c.addError('Incorrect Service Tax Allocation');
        calcError = true;
            }
            // there are two copies of the milestone records.
            // s represents the original state, i.e. the one in the table record
            // s1 represents the data entered by user as part of the updating the payment against these milestones.
            // once the receipt is processed, the amounts entered by the user are saved in the record.
            // below, we are getting the value of the new due values, after applying the payments
            p.newSTDue = p.s.Service_Tax_Amount_Due__c - p.s1.Service_Tax_Amount_Paid__c ;
            p.newInstallmentDue = p.s.charge_amount_due__c- p.s1.Charge_Amount_Paid__c;
            p.newIFCDue = p.s.Int_flatcost_pending__c - (p.s1.Int_flatcost_paid__c + p.s1.Int_flatcost_waived__c);
            p.newISTDue = p.s.Int_servicetax_pending__c - (p.s1.Int_servicetax_paid__c + p.s1.Int_servicetax_waived__c);
        }
    if(!calcError) {
            rmw.r.On_Account_Money__c = moneyInHand - totalAllocated;
            if (totalAllocated == moneyInHand){
                amountAdjusted = true;
            }   
    }
    } 
    public PageReference save(){
            Boolean calcErrorSave = false;
         if(isTDSAmt == false){
            // redoing the validations on monies as part of save as well, in case the on change of event didnt trigger on any of the tab outs
            // just a double checking the amounts at server side
            Map<String,Project_Charges__c> chargeMap = Inventorycostservices.getProjectChargesMap(rmw.r.Project__c);
            List<Receipt_Details__C> rdList = new List<Receipt_Details__c>();
            totalAllocated = 0;
            
            System.debug('in Save for adjustment flow:' + pwList);
            
            for(PPDWrapper p: pwList) {
                totalAllocated += p.s1.Charge_Amount_Paid__c + p.s1.Service_Tax_Amount_Paid__c  + p.s1.Int_flatcost_paid__c + p.s1.Int_servicetax_paid__c;
                if(totalAllocated > moneyInHand) {
                    p.s1.Int_flatcost_paid__c.addError('Total allocation greater than money received');
            calcErrorSave = true;
                } else if (p.s1.Int_servicetax_paid__c > p.s.Int_servicetax_pending__c || totalAllocated > moneyInHand){
                    p.s1.Int_servicetax_paid__c.addError('Incorrect Interest (ST) Allocation');
            calcErrorSave = true;
                } else if (p.s1.Int_flatcost_paid__c > p.s.Int_flatcost_pending__c || totalAllocated > moneyInHand){
                    p.s1.Int_flatcost_paid__c.addError('Incorrect Interest (flatcost) Allocation');
            calcErrorSave = true;
                } else if (p.s1.Int_servicetax_waived__c > (p.s.Int_servicetax_pending__c - p.s1.Int_servicetax_paid__c)){
                    p.s1.Int_servicetax_waived__c.addError('Amount waived is greater than amount due');
            calcErrorSave = true;
                } else if (p.s1.Int_flatcost_waived__c > (p.s.Int_flatcost_pending__c - p.s1.Int_flatcost_paid__c)){
                    p.s1.Int_flatcost_waived__c.addError('Amount waived is greater than amount due');
            calcErrorSave = true;
                } else if (p.s1.Charge_Amount_Paid__c > p.s.charge_amount_due__c || totalAllocated > moneyInHand) {
                    p.s1.Charge_Amount_Paid__c.addError('Incorrect Installment Allocation');
            calcErrorSave = true;
                } else if(p.s1.Service_Tax_Amount_Paid__c > p.s.Service_Tax_Amount_Due__c) {
                    p.s1.Service_Tax_Amount_Paid__c.addError('Incorrect Service Tax Allocation');
            calcErrorSave = true;
                }
                // there are two copies of the milestone records.
                // s represents the original state, i.e. the one in the table record
                // s1 represents the data entered by user as part of the updating the payment against these milestones.
                // once the receipt is processed, the amounts entered by the user are saved in the record.
                // below, we are getting the value of the new due values, after applying the payments
                p.newSTDue = p.s.Service_Tax_Amount_Due__c - p.s1.Service_Tax_Amount_Paid__c ;
                p.newInstallmentDue = p.s.charge_amount_due__c- p.s1.Charge_Amount_Paid__c;
                p.newIFCDue = p.s.Int_flatcost_pending__c - (p.s1.Int_flatcost_paid__c + p.s1.Int_flatcost_waived__c);
                p.newISTDue = p.s.Int_servicetax_pending__c - (p.s1.Int_servicetax_paid__c + p.s1.Int_servicetax_waived__c);
        }
            if(calcErrorSave) {
                  System.debug(LOGGINGLEVEL.ERROR, 'Calculation error in save:');
                  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Money can\'t be adjusted. You have made an error in allocation. Please recheck.'));
                  return null;
            }
            rmw.r.On_Account_Money__c = moneyInHand - totalAllocated;
            if (totalAllocated == moneyInHand){
                amountAdjusted = true;
            }
            Id rId;
            rdList = new List<Receipt_Details__c>();
            Receipt__c rt = new Receipt__c();
            if(rmw.r.Id == null) {
                rt = rmw.r;
                rt.Total_Amount__c = rmw.r.Amount_Rs__c;
                //rt.Drawn_In_Favour_Of__c =  entitySelected; 
                System.debug('Receipt to be inserted:' + rt);
            }else {
                rt = rmw.r;
                 if (oppList[0].Primary_Email__c != null && oppList[0].Primary_Email__c != '' && String.isBlank(rt.Opportunity_Email_Id__c) )
                    rt.Opportunity_Email_Id__c = oppList[0].Primary_Email__c;
            }
            try {   
                Database.UpsertResult r = Database.upsert(rt);
                if(r.isSuccess())
                    rId = r.getId();
                    System.debug(LoggingLevel.ERROR, 'After upsert in receipt save:' + r);
                List<Ledger__c> lstLedger  = new List<Ledger__c>();
                if(penalties){
                    List<Receipt_Details__c> rdList1 = new List<Receipt_Details__c>();
                        System.debug(LoggingLevel.ERROR, 'lwlist:' + lwList);
                        if(lwList != null && lwList.size() > 0) {
                    for(ledgerWrapper lw: lwList){
                                System.debug(LoggingLevel.ERROR,'Inside the ledger for penalties loop:');
                        if(lw.Deducted) {
                            // create a credit ledger and attach it as a lookup to the debit ledger
                            // for cheque dishonour
                            Receipt_Details__c rd1 = new Receipt_Details__c();
                            rd1.Amount__c = lw.amount;
                            rd1.Project__c = rmw.r.Project__c;
                            rd1.Is_Cheque_Dishonour__c = true;
                            rd1.Receipts__c = rmw.r.Id;
                            if(rmId != null)
                                rd1.ownerId = rmId;
                            rdList1.add(rd1);
                            
                            Ledger__c newledger = new Ledger__c();
                            Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Cheque Dishonor'];
                            newledger.Opportunity__c = oppList[0].Id;  
                            newledger.Project_Unit__c = rmw.r.Project_Unit__c;
                            newledger.Reciepts__c = rId;                            
                            newledger.Debit_Credit__c = 'Credit';
                            newledger.Remarks__c = 'Cheque dishonour penalty credited for : ' + lw.l.Reciepts__r.Cheque_DD__c;
                            if(g != NULL)
                                newledger.Global_Charges__c = g.Id;
                            newledger.Amount__c = lw.amount;
                            newledger.Transaction_Date__c = rmw.r.Receipt_Date__c;
                            lstledger.add(newledger);                           
                        }
                    }
                            System.debug(LoggingLevel.ERROR,'Outside the ledger for penalties loop: 1');
                    List<Id> rdId = new List<Id>();
                    if(rdList1.size() > 0) {
                        Database.UpsertResult[] rdRes = Database.upsert(rdList1);
                        for(Database.UpsertResult rd : rdRes) {
                            if(rd.isSuccess())
                            rdId.add(rd.getId());
                        }
                    }
                            System.debug(LoggingLevel.ERROR,'Outside the ledger for penalties loop:2');
                    List<Id> newLedgerId = new List<Id>();
                    if(lstledger.size() > 0) {
                        Database.UpsertResult[] ll = Database.upsert(lstledger);
                        for(Database.UpsertResult l : ll) {
                            if(l.isSuccess())
                            newLedgerId.add(l.getId());
                        }
                    }
                            System.debug(LoggingLevel.ERROR,'Outside the ledger for penalties loop:3');
                    Integer count = 0;
                    List<Ledger__c> ledgerList = new List<Ledger__c>();
                    if(newLedgerId.size() > 0){
                        for(ledgerWrapper lw: lwList){
                            if(lw.deducted) {
                                Ledger__c l = new Ledger__c();
                                l = lw.l;
                                l.Associated_Dishonour_Credit_Ledger__c = newLedgerId[count];
                                count++;
                                ledgerList.add(l);
                            }
                        }
                        if(ledgerList.size() >0 )
                        update ledgerList;
                        count = 0;
                        List<Ledger__c> ledgerUpdate = [Select Id from Ledger__C where id in :newLedgerId];
                        for(Ledger__c l : ledgerUpdate) {
                            l.Receipt_Details__c = rdId[count];
                            count++;
                        }
                        update ledgerUpdate;
                        for(Integer i =0; i< lwList.size() ; i++) {
                            if(lwList[i].deducted)
                                lwList.remove(i);
                        }
                    }
                }
                    }
                
                    System.debug(LoggingLevel.ERROR,'receipt id:' + rId);
                // inserting receipt details for existing dues against which the receipt is apportioned
                // receipt detail trigger creates the credit ledgers 
                
                for(PPDWrapper p: pwList) {
                    if(p.s1.Charge_Amount_Paid__c != null &&  p.s1.Charge_Amount_Paid__c > 0) {
                        Receipt_Details__c rd1 = new Receipt_Details__c();
                        rd1.Amount__c = p.s1.Charge_Amount_Paid__c;
                        rd1.Project__c = rmw.r.Project__c;
                        rd1.Charges__c = chargeMap.get(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name).Id;
                        rd1.Receipts__c = rId;
                        rd1.Standard_Customer_Pay_Plan_Detail__c = p.s1.Id;
                        if(p.s1.Milestone_Demand_Id__c != null)
                            rd1.Demand_Invoice__c = p.s1.Milestone_Demand_Id__c;
                        else {
                            rd1.Demand_Invoice__c = p.s1.Advance_Demand_Id__c;
                            rd1.Is_Advanced_Demand__c = true;
                        }
                        if(rmId != null)
                           rd1.ownerId = rmId;
                        rdList.add(rd1);
                    }
                    if(p.s1.Service_Tax_Amount_Paid__c >0) {
                        Receipt_Details__c rd2 = new Receipt_Details__c();
                        rd2.Amount__c = p.s1.Service_Tax_Amount_Paid__c;
                        rd2.Project__c = rmw.r.Project__c;
                        rd2.Charges__c = chargeMap.get(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name).Id;
                        rd2.Receipts__c = rId;
                        rd2.Standard_Customer_Pay_Plan_Detail__c = p.s1.Id;
                        rd2.For_Service_Tax__c = true;
                        if(p.s1.Milestone_Demand_Id__c != null)
                            rd2.Demand_Invoice__c = p.s1.Milestone_Demand_Id__c;
                        else {
                            rd2.Demand_Invoice__c = p.s1.Advance_Demand_Id__c;
                            rd2.Is_Advanced_Demand__c = true;
                        }
                        if(rmId != null)
                           rd2.ownerId = rmId;
                        rdList.add(rd2);
                    }
                    if(p.s1.Int_flatcost_paid__c >0) {
                        Receipt_Details__c rd3 = new Receipt_Details__c();
                        rd3.Amount__c = p.s1.Int_flatcost_paid__c;
                        rd3.Interest_flatcost_waived__c = p.s1.Int_Flatcost_waived__c;
                        rd3.Project__c = rmw.r.Project__c;
                        rd3.Charges__c = chargeMap.get(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name).Id;
                        rd3.Is_interest_settlement__c = true;
                        rd3.Receipts__c = rId;
                        rd3.Standard_Customer_Pay_Plan_Detail__c = p.s1.Id;                
                        if(rmId != null)
                            rd3.ownerId = rmId;
                        rdList.add(rd3);
                   }
                   if(p.s1.Int_servicetax_paid__c >0) {
                        Receipt_Details__c rd4 = new Receipt_Details__c();
                        rd4.Amount__c = p.s1.Int_servicetax_paid__c;
                        rd4.Interest_servicetax_waived__c = p.s1.Int_servicetax_waived__c;
                        rd4.Project__c = rmw.r.Project__c;
                        rd4.Charges__c = chargeMap.get(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name).Id;
                        rd4.Is_interest_settlement_ST__c = true;
                        rd4.Receipts__c = rId;
                        rd4.Standard_Customer_Pay_Plan_Detail__c = p.s1.Id;                
                        if(rmId != null)
                            rd4.ownerId = rmId;
                        rdList.add(rd4);
                   }
                }
                    System.debug(LoggingLevel.ERROR,'receipt details: rdList' + rdList);
                if(rdList.size() >0) {
                    insert rdList;
                }
                rmw.r = [Select Id, Name, Amount_Rs__c, Mode__c, Receipt_Date__c, Cheque_DD_Date__c, DraweeBank__c,
                        Drawn_in_favour_of__c,Receipt_Against__c, Cheque_DD__c, On_Account_Money__c,Receipt_Status__c,
                        Currency__c, FOREX__c, Project__c, Project__R.Id, Project_Unit__c, Approval_Status__c , Challan_No__c, 
                        PAN_no_of_TDS_Deductor__c,PAN_no_of_TDS_Deductee__c,Opportunity_Email_Id__c,Drawee_Bank_If_Others__c, 
                        Foreign_Currency_Type__c,TDS_Amount_In_Rs__c,IsTDS_And_NoDemandRaised__c,
                        Amount_in_Foreign_Currency__c
                        from receipt__c where id =:rId];
            } catch (Exception e) {
                    System.debug(LOGGINGLEVEL.ERROR, 'exception in receipt save:' + e.getMessage());
                ApexPages.addMessages(e);
                return null;
            }
            if(rmw.r.On_Account_Money__c > 0) {
                moneyInHand = rmw.r.On_Account_Money__c;
                pw1List = new List<PPDWrapper>();
                Decimal upcomingInstallmentNew = 0;
                Decimal upcomingSTNew = 0;
                List<Standard_Customer_Pay_Plan_Detail__c> ppdListUpcoming = PaymentManagementServices.getUpcomingToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
                if(ppdListUpcoming.size() > 0) {
                    for(Standard_Customer_Pay_Plan_Detail__c s :ppdListUpcoming) {
                        if(s.Installment__c == null) {
                            s.Installment__c =0;
                        }
                        if(s.Charge_Amount_Advance_Recd__c == null) {
                            s.Charge_Amount_Advance_Recd__c =0;
                        }
                        if(s.Installment__c - s.Charge_Amount_Billed__c > 0) {
                            upcomingInstallmentNew = s.Installment__c - s.Charge_Amount_Billed__c;
                                if(taxSlabMap.containsKey(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    for(Tax_Breakup__c tb : taxSlabMap.get(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                        upcomingSTNew += ((tb.Taxable_Percentage__c * upcomingInstallmentNew/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    }
                                }
                            else
                                upcomingSTNew = 0;
                            PPDWrapper pw = new PPDWrapper(s,'',upcomingInstallmentNew,upcomingSTNew);
                            pw1List.add(pw);
                        }
                        upcomingInstallmentNew = 0;
                        upcomingSTNew = 0;
                    }
                 } 
                 if(pw1List.size() > 0) {
                    advanceDues = true;
                    raiseDemand = true;
                 }
            } 
            
            List<Standard_Customer_Pay_Plan_Detail__c> ppdList = PaymentManagementServices.getMileStonesToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
            pwList = new List<PPDWrapper>();
            if(ppdList.size() > 0) {
                currentDues = true;
                for(Standard_Customer_Pay_Plan_Detail__c s :ppdList) {
                    PPDWrapper pw = new PPDWrapper(s,'');
                    pwList.add(pw);
                }
            } else {
                currentDues = false;
            }
            
            processComplete = true;
            // remove the hideinterest flag after the apportionments are made one time.
            hideInterest = false;
         }
         else{
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No further processing can be done on this instrument. There is No Demand raised for Adjustment'));
              return null;
         }   
         
         if(rmw.r.On_Account_Money__c == null || rmw.r.On_Account_Money__c <= 0){
              adjustBtnDisable = true;
         }
         
       return null;
    }
    // called on tab out of the advance input boxes to validate the data entered
    public void applyAdvance() {
        System.debug('Apply Advance:');
        // there are two copies of the milestone records.
        // p represents the original state, i.e. the one in the table record
        // p1 represents the data entered by user as part of the updating the payment against these milestones.
        // once the receipt is processed, the amounts entered by the user are saved in the record.
        amountAdjusted = false;
        totalAdvAllocated = 0;
        rmw.r.On_Account_Money__c = moneyInHand;
        Decimal upcomingST = 0;
        
        System.debug('All monies: allocated ::  on account :: moneyInHand :: ' + totalAllocated  + ':::' + rmw.r.On_Account_Money__c +':::' + moneyInHand);
        
        for(PPDWrapper p: pw1List) {
            p.preview = false;
            upcomingST = 0;
            if (p.s1.Charge_Amount_Advance_Recd__c > p.upcomingInstallment) {
                p.s1.Charge_Amount_Advance_Recd__c.addError('Incorrect Installment Allocation - upcoming milestone flow');
            } else if( p.s1.Charge_Amount_Advance_Recd__c > 0 ) {
                if(taxSlabMap.containsKey(p.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                    for(Tax_Breakup__c tb : taxSlabMap.get(p.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                        upcomingST += ((tb.Taxable_Percentage__c * p.s1.Charge_Amount_Advance_Recd__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                    }
                    p.s1.Service_Tax_Amount_Advance_Recd__c = upcomingST;
                } 
                p.preview = true;
            }
        }
        System.debug('More on monies:: on account ::  moneyInHand :: advallocated :: ' + rmw.r.On_Account_Money__c + '::::' + moneyInHand + ':::' + totalAdvAllocated);
        rmw.r.On_Account_Money__c = moneyInHand - totalAdvAllocated;
        if (totalAdvAllocated == moneyInHand){
            amountAdjusted = true;
        }
    }
    
    public PageReference showPreview() {
        String milestoneList = '';
        String demandType = '';
        System.debug('rowIndex' + rowIndex);
        
        PPDWrapper advDemand = pw1List[rowIndex];
        mileStoneList = advDemand.s.Id;
        demandType = 'advance';
        
        if(mileStoneList != null) {
            PageReference pageRef = new PageReference('/apex/DemandLetterTemplate');
            pageRef.getParameters().put('mileStoneList',mileStoneList);
            pageRef.getParameters().put('demandType',demandType);
            pageRef.getParameters().put('mode','preview');
            pageRef.getParameters().put('advanceAmt', string.valueOf(advDemand.s1.Charge_Amount_Advance_Recd__c));
            pageRef.getParameters().put('stAmt', string.valueOf(advDemand.s1.Service_Tax_Amount_Advance_Recd__c));
            System.debug('pageref:' + PageRef);
            return pageRef;
        } else {
            return null;
        }
    }
    
    public PageReference raiseDemand(){
        amountAdjusted = false;
        totalAdvAllocated = 0;
        rmw.r.On_Account_Money__c = moneyInHand;
        Decimal upcomingST = 0;
        
        Map<String,Project_Charges__c> chargeMap = Inventorycostservices.getProjectChargesMap(rmw.r.Project__c);
        List<Receipt_Details__c> rdList = new List<Receipt_Details__c>();
        for(PPDWrapper p: pw1List) {
            p.preview = false;
            upcomingST = 0;
            if (p.s1.Charge_Amount_Advance_Recd__c > p.upcomingInstallment) {
                pw1List[rowIndex].s1.Charge_Amount_Advance_Recd__c.addError('Incorrect Installment Allocation');
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Incorrect Installment Allocation'));
                pw1List[rowIndex].style='error';
                return null;
            } else if( p.s1.Charge_Amount_Advance_Recd__c > 0 ) {
                if(taxSlabMap.containsKey(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                    for(Tax_Breakup__c tb : taxSlabMap.get(p.s1.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                        upcomingST += ((tb.Taxable_Percentage__c * p.s1.Charge_Amount_Advance_Recd__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                    }
                    p.s1.Service_Tax_Amount_Advance_Recd__c = upcomingST;
                }
            }
        }
        Id dId;
        System.debug('Raise demand for row: ' + rowIndex);
        PPDWRapper r = pw1List[rowIndex];
        
        if((r.s1.Charge_Amount_Advance_Recd__c != null &&  r.s1.Charge_Amount_Advance_Recd__c > 0 )) {
                
            Project__c p = InventoryCostServices.getProjectDetails(rmw.r.Project_Unit__c);
            System.debug('Project Details:' + p);
            Demand_Invoice__c di = new Demand_Invoice__c();
            di.Customer__c = oppList[0].Id;
            if (oppList[0].Primary_Email__c != null && oppList[0].Primary_Email__c != '') 
                di.Email__c = oppList[0].Primary_Email__c;
            if (oppList[0].Other_Applicants_Email__c != null && oppList[0].Other_Applicants_Email__c != '')  {
                String[] objEmailList = oppList[0].Other_Applicants_Email__c.split(',');
                    for(Integer i=0; i< objEmailList.size(); i++) {
                        if(i == 0)
                            di.cc1_Email__c = objEmailList[0];
                        if(i==1)
                            di.cc2_Email__c =objEmailList[1];
                        if(i==2)
                            di.cc3_Email__c =objEmailList[2];
                        if(i==3)
                            di.cc4_Email__c =objEmailList[3];
                     }
            }
            if (oppList[0].Future_Correspondence_Contact__c != null &&  oppList[0].Future_Correspondence_Contact__c.equals('Other')) {
                if (oppList[0].Future_Correspondence_Contact_Email__c != null && oppList[0].Future_Correspondence_Contact_Email__c != '')  
                    di.Future_Correspondence_Email__c = oppList[0].Future_Correspondence_Contact_Email__c;
            }  
            di.Project_Construction_Stage__c = r.s.Project_Construction_Stages__c;
            di.Invoice_Date__c = system.today();
            di.Due_Date__c = system.today().addDays(Integer.valueOf(p.Days_to_Send_Demand__c));
            di.Total_Amount__c  = r.s1.Charge_Amount_Advance_Recd__c + r.s1.Service_Tax_Amount_Advance_Recd__c;
            di.Standard_Customer_Pay_Plan_Detail__c = r.s.Id;
            di.Milestone_Name__c = r.s.Is_to_be__c;
            // di.Service_Tax_Rate__c = taxSlabMap.get(r.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name);
            di.Current_Demand_Installment__c =r.s1.Charge_Amount_Advance_Recd__c ;    
            di.Current_Demand_Service_Tax__c = r.s1.Service_Tax_Amount_Advance_Recd__c;
            di.Total_Payable_Installment__c =r.s1.Charge_Amount_Advance_Recd__c ;    
            di.Total_Payable_Service_Tax__c = r.s1.Service_Tax_Amount_Advance_Recd__c;
            di.Total_Payable_Overall__c = r.s1.Charge_Amount_Advance_Recd__c + r.s1.Service_Tax_Amount_Advance_Recd__c;
            di.Is_Advanced_Demand__c = true;
            di.Project__c = rmw.r.Project__c;
            di.Demand_generated__c = true;
            if(rmId != null) {
                di.ownerId = rmId;
            }
            try {   
                Database.SaveResult d1 = Database.insert(di);
                if(d1.isSuccess())
                    dId = d1.getId();
                List<Id> diList = new List<Id>();
                diList.add(dId);
                
                List<Standard_Customer_Pay_Plan_Detail__c> scppdToUpdate = new List<Standard_Customer_Pay_Plan_Detail__c>();
                scppdToUpdate = [Select Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c from  Standard_Customer_Pay_Plan_Detail__c where Id = : r.s1.id];
                System.debug('scppd to update:' + scppdToUpdate);
                
                // added this to capture the advance demand Id
                scppdToUpdate[0].Advance_Demand_Id__c = dId;
                
                update scppdToUpdate;
                
                // create the demand detail record
                Demand_Detail__c dd = new Demand_Detail__c();
                dd.Type__c = 'Current';
                dd.Installment_Amount__c = r.s1.Charge_Amount_Advance_Recd__c;
                dd.Total_Amount__c = r.s1.Charge_Amount_Advance_Recd__c + r.s1.Service_Tax_Amount_Advance_Recd__c;
                dd.Demand_Invoice__c = dId;
                dd.charge_name__c = r.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                dd.scppd_1__c = r.s.Id;
                dd.scppd_Amount_1__c = r.s1.Charge_Amount_Advance_Recd__c;
                Integer count = 1;
                Decimal taxST = 0;
                Decimal taxableST = 0;
                if(taxSlabMap.containsKey(r.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                    for(Tax_Breakup__c tb : taxSlabMap.get(r.s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                        taxST = ((tb.Taxable_Percentage__c * r.s1.Charge_Amount_Advance_Recd__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                        taxableST = ((tb.Taxable_Percentage__c * r.s1.Charge_Amount_Advance_Recd__c/100) ).setscale(0,RoundingMode.HALF_UP);
                        String fieldTaxableAmount = 'Taxable_Amount_' + count + '__c';
                        String fieldTaxAmount = 'Tax_Amount_' + count  + '__c';
                        String fieldTaxBreakupId = 'Tax_Breakup_' + count  + '__c';
                        dd.put(fieldTaxAmount, taxST);
                        dd.put(fieldTaxableAmount, taxableST);
                        dd.put(fieldTaxBreakupId, tb.Id);
                        count ++;
                    }
                }
                dd.Total_Tax__c = r.s1.Service_Tax_Amount_Advance_Recd__c;
                Database.SaveResult d2 = Database.insert(dd);
                Id ddId;
                if(d2.isSuccess())
                    ddId = d2.getId();
                 
                LedgerManagementServices.createDebitLedgersForDemandsNew(diList);   
                      
            }catch(Exception e) {
                ApexPages.addMessages(e);
                return null;
            }
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Either one of the advance charges have to be greater than 0'));
        }
        pw1List = new List<PPDWrapper>();
        Decimal upcomingInstallmentNew = 0;
        Decimal upcomingSTNew = 0;
        List<Standard_Customer_Pay_Plan_Detail__c> ppdListUpcoming = PaymentManagementServices.getUpcomingToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
        if(ppdListUpcoming.size() > 0) {
            for(Standard_Customer_Pay_Plan_Detail__c s :ppdListUpcoming) {
                if(s.Installment__c == null) {
                    s.Installment__c =0;
                }
                if(s.Charge_Amount_Advance_Recd__c == null) {
                    s.Charge_Amount_Advance_Recd__c =0;
                }
                if(s.Installment__c - s.Charge_Amount_Billed__c > 0) {
                    upcomingInstallmentNew = s.Installment__c - s.Charge_Amount_Billed__c;
                    if(taxSlabMap.containsKey(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                        for(Tax_Breakup__c tb : taxSlabMap.get(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                            upcomingSTNew += ((tb.Taxable_Percentage__c * upcomingInstallmentNew/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                        }
                    }
                    else
                        upcomingSTNew = 0;
                    PPDWrapper pw = new PPDWrapper(s,'',upcomingInstallmentNew,upcomingSTNew);
                    pw1List.add(pw);
                }
                upcomingInstallmentNew = 0;
                upcomingSTNew = 0;
            }
         } 
         if(pw1List.size() > 0) {
            advanceDues = true;
         }
         List<Standard_Customer_Pay_Plan_Detail__c> ppdList = PaymentManagementServices.getMileStonesToBeAdjusted(rmw.r.Project_Unit__c, oppList[0].Id);
         pwList = new List<PPDWrapper>();
         if(ppdList.size() > 0) {
             currentDues = true;
             for(Standard_Customer_Pay_Plan_Detail__c s :ppdList) {
                PPDWrapper pw = new PPDWrapper(s,'');
                pwList.add(pw);
             }
         } else {
            currentDues = false;
         } 
        return null;
    }
    
     //////////--------------------------- Below method Added by vikas for check duplicate receipt -----------------////////////
     public pageReference checkDupeList() {
       boolean error = false; 
     
     
     if(recList.size() > 0){
       isDupe = false;
      
      recList.clear();
    }
        last3MonthRecList = [select id, name,Cheque_DD_Date__c,DraweeBank__c,Drawee_Bank_If_Others__c ,Cheque_DD__c,Drawn_in_favour_of__c,Receipt_Against__c,Currency__c,Amount_Rs__c,Receipt_Status__c,TDS_Amount_In_Rs__c,IsTDS_And_NoDemandRaised__c
                   from Receipt__c where Receipt_Date__c = LAST_90_DAYS and DraweeBank__c =: rmw.r.DraweeBank__c and Cheque_DD__c =: rmw.r.Cheque_DD__c];
                   
      if(last3MonthRecList.size() > 0) {
                   
         if(rmw.r.DraweeBank__c == 'Other'){
            if(rmw.r.Drawee_Bank_If_Others__c == null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Drawee Bank(If Others)'));
              error = true;
          }
          else{
              for(Receipt__c rec : last3MonthRecList){
              if(rec.Drawee_Bank_If_Others__c == rmw.r.Drawee_Bank_If_Others__c && rec.Cheque_DD__c == rmw.r.Cheque_DD__c)
                          recList.add(rec);
             }
          }
        }    
          else{         
                for(Receipt__c rec : last3MonthRecList){
                     recList.add(rec);
              }            
           }     
     }          
                  if(recList.size() > 0){
                   isDupe = true;
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,recList.size()+' Duplicate Receipts Found'));
                   }
                   if(recList.size() == 0 && error == false)
                     {
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Duplicate Receipts Found'));
                   }
            
         return null;
     }
    //////////////////// ----------------------- vikas added method end here ----------------------------//////////////////////////
    
    public pageReference close() {
        Pagereference pRef = new PageReference('/apex/S_ReceiptDashboard');
        return pRef;
    }
    public class rMainWrapper{
        public Receipt__c r {get;set;}
        
        public rMainWrapper() {
        this.r = new Receipt__c();
        }
    }
    
    public class ledgerWrapper{
        public ledger__c l {get;set;}
        public Decimal Amount {get;set;}
        public String strAmount {get;set;}
        public Boolean Deducted {get;set;}
        public ledgerWrapper() {
            this.l = new ledger__c();
        }
        public ledgerWrapper(Ledger__c l, Decimal amount, Boolean deducted) {
            this.l = new ledger__c();
            this.l = l;
            this.amount = amount;
            this.strAmount = QuotationManagementServices.InFormat((amount.setscale(0, RoundingMode.HALF_UP)));
            this.deducted = deducted;
        } 
    }
    
    public class PPDWrapper{
        public Standard_Customer_Pay_Plan_detail__c s {get;set;}
        public Standard_Customer_Pay_Plan_detail__c s1 {get;set;}
        public string Style {get;set;}
        public Decimal newSTDue {get;set;}
        public Decimal newInstallmentDue {get;set;}
        public Decimal newIFCDue {get;set;}
        public Decimal newISTDue {get;set;}
        public Decimal upcomingInstallment {get;set;}
        public Decimal upcomingST{get;set;}
        public boolean preview{get;set;}

        
        public PPDWrapper(Standard_Customer_Pay_Plan_Detail__c s,String style) {
            this.s = s;
            this.s1 = s;
            this.s1.Charge_Amount_Paid__c = 0;
            this.s1.Service_Tax_Amount_Paid__c = 0;
            this.style = style;
            this.s1.Int_Flatcost_paid__c = 0;
            this.s1.Int_servicetax_paid__c = 0;
            this.s1.Int_Flatcost_waived__c = 0;
            this.s1.Int_servicetax_waived__c = 0;
            this.newiFCDue = 0;
            this.newiSTDue = 0;
        }
        public PPDWrapper(Standard_Customer_Pay_Plan_Detail__c s,String style,Decimal upcomingI, Decimal upcomingS) {
            this.s = s;
            this.s1 = s;
            this.s1.Charge_Amount_Paid__c = 0;
            this.s1.Service_Tax_Amount_Paid__c = 0;
            this.style = style;
            this.upcomingInstallment = upcomingI;
            this.upcomingST = upcomingS;
            this.s1.Charge_Amount_Advance_Recd__c = 0;
            this.s1.Service_Tax_Amount_Advance_Recd__c = 0;
            this.s1.Int_Flatcost_paid__c = 0;
            this.s1.Int_servicetax_paid__c = 0;
            this.s1.Int_Flatcost_waived__c = 0;
            this.s1.Int_servicetax_waived__c = 0;
            this.newiFCDue = 0;
            this.newiSTDue = 0;
            this.preview = false;
        }
    }
    
    
}