public class S_DemandLetter {
    public String strDemandInvId {
        get;
        set;
    }
    public wrpDemand wrpDemand {
        get;
        set;
    }
    public String strMileStoneList {
        get;
        set;
    }
    public String strMode {
        get;
        set;
    }
    public String strDemandType {
        get;
        set;
    }
    public Decimal advanceAmtD {
        get;
        set;
    }
    public Decimal stAmtD {
        get;
        set;
    }

    public string Msg {
        get;
        set;
    }
    public string InvcNo {
        get;
        set;
    }
    public datetime InvcDate {
        get;
        set;
    }
    public datetime InvcDueDate {
        get;
        set;
    }
    public datetime dtCurrDemand {
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
    public String clusterName {
        get;
        set;
    }
    public String towerName {
        get;
        set;
    }
    public String UnitName {
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
    public String CustomerPanNo {
        get;
        set;
    }
    public String greentingName {
        get;
        set;
    }
    public Opportunity Customer {
        get;
        set;
    }
    public Decimal CustomerRDSInterest {
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
    public Date bookingDate {
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
    public Decimal interestAmount {
        get;
        set;
    }
    public Decimal interestAmountST {
        get;
        set;
    }
    public String tdsRate {
        get;
        set;
    }
    public String PreviousAmountReceivedstr {
        get;
        set;
    }
    public Decimal PreviousAmountReceived {
        get;
        set;
    }public String PreviousGSTReceivedStr {
        get;
        set;
    }public Decimal PreviousGstReceived {
        get;
        set;
    }
    public Decimal PreviousOnAccountMoney {
        get;
        set;
    }
    public String PreviousOnAccountMoneyStr {
        get;
        set;
    }
    public Decimal PreviousOnAccountFlatcost {
        get;
        set;
    }
    public String PreviousOnAccountFlatcostStr {
        get;
        set;
    }
    public Decimal PreviousOnAccountGST {
        get;
        set;
    }
    public String PreviousOnAccountGSTStr {
        get;
        set;
    }
    public Decimal PreviousOnAccountSDR {
        get;
        set;
    }
    public String PreviousOnAccountSDRStr {
        get;
        set;
    }
    public Decimal BalanceCurrentDue{
        get;
        set;
    }
    public String BalanceCurrentDueStr {
        get;
        set;
    }
     public Decimal BalanceCurrentGSTDue{
        get;
        set;
    }
    public String BalanceCurrentDueGSTStr {
        get;
        set;
    }
    public Decimal GrandTotal{
        get;
        set;
    }
    public String GrandTotalStr {
        get;
        set;
    }
    public Decimal LessLandCost{
        get;
        set;
    }
    public String LessLandCostStr {
        get;
        set;
    }
    public Decimal taxless{
        get;
        set;
    }
    public String taxlessStr {
        get;
        set;
    }
    public Map < string, Decimal > chargeAmountMap {
        get;
        set;
    }
    public Map < string, Decimal > otherchargeAmountMap {
        get;
        set;
    }
    public Map < string, String > demandedChargesMapStr {
        get;
        set;
    }
     public Set<String> outstandingChargesSet {
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
    public Legal_Entity__c le {
        get;
        set;
    }
    public List < DemandUIWrapper > dList {
        get;
        set;
    }
    public List < DemandUIWrapper > dList1 {
        get;
        set;
    }
    public List < DemandUIWrapper > dList2 {
        get;
        set;
    }
    public List < DemandUIWrapper > dListH {
        get;
        set;
    }
     public List < DemandUIWrapper > dListH1 {
        get;
        set;
    }
    // new demand ui variables
    public Map<Integer,String> headerMap {
        get;
        set;
    }
    
    public Map<Integer,List<String>> subHeaderMap {
        get;
        set;
    }
    
    public Map<Integer,Integer> subHeaderSizeMap {
        get;
        set;
    }
    public List<String> taxNames {
        get;
        set;
    }
    public Map<Integer,Integer> taxColSize  {
        get;
        set;
    }
    // this for printing outstandings
    public Map<Integer,String> headerMapO {
        get;
        set;
    }
    
    public Map<Integer,List<String>> subHeaderMapO {
        get;
        set;
    }
    
    public Map<Integer,Integer> subHeaderSizeMapO {
        get;
        set;
    }
    public List<String> taxNamesO {
        get;
        set;
    }
    public Map<Integer,Integer> taxColSizeO  {
        get;
        set;
    }
    
    public Map < String, List<Tax_Breakup__c>>  taxSlabMap {
        get;
        set;
    }
    ///Anuja added 
    public Demand_Invoice__c DemandInv {
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
    public string milestoneName {
        get;
        set;
    }
    public  String  displayStyle {
        get;
        set;
    }
    public String displayStyleReg {
        get;
        set;
    }
    public String displayStyleGST {
        get;
        set;
    }
    public String displayStyleCommon {
        get;
        set;
    }
    public String agreementValue {
        get;
        set;
    }
    public Boolean letterH {
        get;
        set;
    }
    public Decimal PercentPaid {
        get;
        set;
    }
    public boolean hasOutstandings {
        get;
        set;
    }
    
    public String ProjectAddress {
        get;
        set;
    }
     public String CustomerEmail {
        get;
        set;
    }
    Public String CompanyName{
        get;
        set;
    }
     Public String CompanyAddress{
        get;
        set;
    }
    Public String DemandNumber{
        get;
        set;
    }
    Public String GSTTIN  {
        get;
        set;
    }
    Public String ServiceCode {
        get;
        set;
    }
    Public String Phone{
        get;
        set;
    }
    Public Decimal Stampduty{
        get;
        set;
    }
    Public String Stampdutystr{
        get;
        set;
    }
    Public Decimal Registration{
        get;
        set;
    }
    Public String Registrationstr{
        get;
        set;
    }
    Public Decimal Legal{
        get;
        set;
    }
    Public String Legalstr{
        get;
        set;
    }
    Public Decimal RegistrationTotal{
        get;
        set;
    }
    Public String RegistrationTotalstr{
        get;
        set;
    }
    Public Decimal RegistrationTotal2{
        get;
        set;
    }
    Public String RegistrationTotal2str{
        get;
        set;
    }
     public Boolean registrationcheck {
        get;
        set;
    }
    public string chargeName{get;set;}
    public string chargeBucket{get;set;}    
    public string GSTINOfClient{get;set;}
    public string placeOfSupply{get;set;}
    public string stateCode{get;set;}
    public string HSNCode{get;set;}
    public String totalPrincipal {get;set;}
    public String totalTaxable {get;set;}
    public String totaloftotalTaxes {get;set;}
    public String TotalBalanceTaxes {get;set;}
    public String invoiceTotal{get;set;}
    public string totalOuststandingFormatted {get;set;}
    public String totalTaxOutstandingformatted {get;set;}
    public String totalpreviousDues {get;set;}
    public String totalBalanceDues {get;set;}
    public String totalDues {get;set;}
    public String totalNetdue {get;set;}
    public String totalNetdueWords {get;set;}
    public Map<String, String> totalTaxesmap{get;set;}
    public S_DemandLetter() {
        taxRateMap = new Map < String, Decimal > ();
        chargeAmountMap = new Map < String, Decimal > ();
        totalTaxesmap = new Map < String, String> ();
        taxSlabMap = InventoryCostServices.getChildTaxSlabs();
        DemandInv = new Demand_Invoice__c();
        displayStyle='none';
        displayStyleReg = 'none';
        displayStyleGST = 'none';
        displayStyleCommon = '';
        interestAmount = 0;
        interestAmountST = 0;
        letterH = false;
        hasOutstandings = false;
        registrationcheck = false; 
        totalPrincipal ='';
        totalTaxable = '';
        totaloftotalTaxes = '';
        TotalBalanceTaxes = '';
        invoiceTotal = '';
        totalOuststandingFormatted = '';
        totalTaxOutstandingformatted = '';
        totalpreviousDues = '';
        totalDues = '';
        totalBalanceDues = '';
        totalNetdue = '';
        totalNetdueWords = '';
        chargeName = '';
        chargeBucket = '';
        PreviousAmountReceivedstr = 'Rs 0/-';
        PreviousGstReceivedstr = 'Rs 0/-'; 
        PreviousAmountReceived = 0;
        PreviousGstReceived = 0;
        PreviousOnAccountMoney = 0;
        PreviousOnAccountMoneystr = 'Rs 0/-';
        PreviousOnAccountFlatcost = 0;
        PreviousOnAccountFlatcoststr = 'Rs 0/-';
        PreviousOnAccountGST = 0;
        PreviousOnAccountGSTstr = 'Rs 0/-';
        PreviousOnAccountSDR = 0;
        PreviousOnAccountSDRstr = 'Rs 0/-'; 
        BalanceCurrentDue = 0 ;
        BalanceCurrentDuestr = 'Rs 0/-'; 
        BalanceCurrentGSTDue = 0 ;
        BalanceCurrentDueGSTstr = 'Rs 0/-'; 
        GrandTotal = 0;
        GrandTotalstr = 'Rs 0/-'; 
        taxless= 0;
        taxlessstr = 'Rs 0/-'; 
        LessLandCost = 0;
        LessLandCoststr = 'Rs 0/-';
        Stampduty = 0;
        Stampdutystr = 'Rs 0/-'; 
        Registration = 0;
        Registrationstr = 'Rs 0/-'; 
        Legal = 0;
        Legalstr = 'Rs 0/-'; 
        RegistrationTotal = 0;
        RegistrationTotalstr = 'Rs 0/-'; 
        RegistrationTotal2 = 0;
        RegistrationTotal2str = 'Rs 0/-'; 
    }
    // ***************************************************************************************************************************************//
    // Methods defined and their purpose 
    // 1) prepareDemandUIMapforPreviewNew - replaces the prepareDemandUIMapforPreview and prepareDemandUIMapforPreviewAdvance - this is for previewing demands from demand generation screen and receipt apportioning screen
    // 2) prepareDemandUIMapforshowInvoiceAdvance - on click of print button from the demand detail page for advance demands
    // 3) prepareDemandUIMapforRegShow - on click of print button from registration demand detail page
    // 4) prepareDemandUIMapforshowInvoice - on click of print button from a regular demand detail page
    // 5) prepareDemandUIMapforRegPreview - preview of registration demand from the show registrations tab of the demand generation screen
    //***************************************************************************************************************************************//
    public void getDemandLetter() {
        System.debug('incoming params:' + strDemandType + '====' + strmode + '===' + strmilestonelist + '---letterHead--' + letterH);
        // this is for preview of demands from the send demand invoice screen
        if (String.isNotBlank(strdemandType) && String.isNotBlank(strMode) && String.isNotBlank(strMilestoneList) && strdemandType.equalsIgnoreCase('FlatCost') && strmode.equalsIgnoreCase('preview') && strmileStoneList != null) {
            displayStyleGST = '';
            List < Id > msList = strMileStoneList.split(',');
            wrpDemand = DemandManagementServices.getCurrentDemandDetails(msList, 'FlatCost');
            system.debug('wrpDemand:' + wrpDemand);
            if (wrpDemand != null) {
                Msg = 'This is only a preview of Demand Invoice before generated. You can see also preview of generated invoice by clicking "Show Invoice" button on "Demand Invoice" tab. ';
                InvcNo = 'Not Generated';
                Customer = [select id, Name, Primary_Email__c, Primary_Phone__c, Other_Applicants_Email__c,Primary_Name__c, 
                            Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,
                            Future_Correspondence_Contact_Email__c,Agreement_Value__c,Primary_pancard__c,Project_Name__c,
                            Project__c, Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,Total_Interest_Waiver__c,
                            Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name, Project__r.RDS_Company_Code__r.RDS_Address1__c,
                            Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, Project_Unit__r.Legal_Entity__r.RDS_Address1__c, Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,
                            Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, Account.BillingState, Account.BillingpostalCode,Account.GSTIN_of_Client__c,Project__r.Place_of_Supply__c,Project__r.State_Code_Where_Supplied__c,Project__r.HSN_Code__c,
                            Account.BillingCountry, Account.PersonMobilePhone, Project_Unit__r.Booking__r.Name, Project_Unit__r.Booking__r.Owner.Name, Project_Unit__r.Booking__r.Owner.Email, Project_Unit__r.Booking__r.Booking_Date__c, Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C,
                            Project_Unit__r.Booking__r.Owner.Phone, Project__r.RDS_Company_Code__r.RDS_Company_Code__c, Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,Project__r.RDS_Company_Code__r.RDS_Company_Name__c,
                            Project__r.Legal_In_AV__c, Project__r.RDS_Interest_Rate__c, Project_Unit__r.Floor__c,Project_Unit__r.Floor1__c,Project_Unit__r.Cluster__c,Project_Unit__r.TowerName__r.Name,Project__r.Cheque_Dishonour__c, Project__r.RDS_Company_Code__r.Name, Project__r.RDS_Company_Code__r.SPV_Bank_Account__c,
                            Project__r.RDS_Company_Code__r.GSTIN__c, Project__r.RDS_Company_Code__r.Service_Code__c, Project__r.RDS_Company_Code__r.RDS_Phone__c
                            from Opportunity
                            where id = : wrpDemand.OpportunityId];
                system.debug('wrpDemand-OpportunityId:' + wrpDemand.OpportunityId);
                List<User> u = [Select Name, Phone, MobilePhone, Title, Email from User where Id = : Customer.Project_Unit__r.Booking__r.OwnerId];

                //-------------------------------added------------------------------------------
                if (Customer != null) {
                    projectImage = Customer.Project__r.Project_Image__c;
                    ////Anuja Added ////
                    projectName = Customer.Project__r.Name;
                    clusterName = Customer.Project_Unit__r.Cluster__c;
                    towerName = Customer.Project_Unit__r.TowerName__r.Name;
                    UnitName  = customer.Project_Unit__r.Floor1__c+customer.Project_Unit__r.Name;
                    CustomerPrimaryName  = Customer.Primary_Name__c;
                    CustomerOtherApplicantName = Customer.Other_Applicants_Name__c;
                    CustomerMailingAddress = Customer.Mailing_Address__c;
                    CustomerMobilePhone  = Customer.Primary_Phone__c;
                    CustomerPanNo = Customer.Primary_pancard__c;
                    CustomerRDSInterest = Customer.Project__r.RDS_Interest_Rate__c;
                   
                    ProjectAddress =  Customer.Project__r.Address__c;
                    CustomerEmail = Customer.Primary_Email__c;
                     // BY ASHISH
     PreviousOnAccountMoney = PaymentManagementServices.getOnAccountMoney(Customer.Id);
     PreviousOnAccountMoneyStr =INformat(PreviousOnAccountMoney );
     PreviousOnAccountFlatcost = PaymentManagementServices.getOnAccountMoneyFlatcost(Customer.Id);
     PreviousOnAccountFlatcostStr =INformat(PreviousOnAccountFlatcost);
     PreviousOnAccountGST = PaymentManagementServices.getOnAccountMoneyGST(Customer.Id);
     PreviousOnAccountGSTStr =INformat(PreviousOnAccountGST);
     PreviousOnAccountSDR = PaymentManagementServices.getOnAccountMoneySDR (Customer.Id);
     PreviousOnAccountSDRStr =INformat(PreviousOnAccountSDR);
     //ashish 9-1-19
     chargeBucket = '';
      
                  
                    if(string.isNotBlank(customer.Account.GSTIN_of_Client__c))
                        GSTINOfClient = customer.Account.GSTIN_of_Client__c;
                    else
                        GSTINOfClient = 'Not Applicable (Unregistered - Consumer)';
                    placeOfSupply = customer.Project__r.Place_of_Supply__c;
                    stateCode = customer.Project__r.State_Code_Where_Supplied__c;
                    HSNCode = customer.Project__r.HSN_Code__c;
                    ///Anuja Added ENDS here///
                    if(u != null && u.size() ==1 ) {
                        CRMName = u[0].Title + u[0].Name;
                        CRMEmail = u[0].Email;
                        CRMMobile = u[0].MobilePhone;
                    }
                    if(Customer.Project_Unit__r.Booking__r.Booking_Date__c != null)
                        bookingDate = Customer.Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C;
                    interestRate = Customer.Project__r.RDS_Interest_Rate__c;
                    chequeDishonour = Customer.Project__r.Cheque_Dishonour__c;
                    InvoiceDate = wrpDemand.InvoiceDate;
                    InvoiceDueDate = wrpDemand.InvoiceDueDate;
                    mileStoneName = wrpDemand.mileStoneName;
                    if (taxSlabMap.containsKey('TDS')) {
                        tdsRate = string.valueOf(taxSlabMap.get('TDS')[0].Tax_Percentage__c.setscale(1)) + ' %';
                        tdsOnCurrent = (wrpDemand.CurrentDemandAmount * taxSlabMap.get('TDS')[0].Tax_Percentage__c / 100).setscale(0, RoundingMode.HALF_UP);
                    }
                    le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);
                    
                  
                   
                    /////// Added by Priya on 13 Jan 2018 /////
                    if(le.Name == Null){
                         CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
                    }else{
                         CompanyName = le.Name;
                    }                    
                    
                    if(le.RDS_Address1__c == Null){
                         CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c; 
                    }else{
                         CompanyAddress = le.RDS_Address1__c;
                    }
                    
                     if(le.GSTIN__c == Null){
                         GSTTIN = Customer.Project__r.RDS_Company_Code__r.GSTIN__c; 
                    }else{
                         GSTTIN= le.GSTIN__c;
                    }
                    
                     if(le.Service_Code__c == Null){
                         ServiceCode = Customer.Project__r.RDS_Company_Code__r.Service_Code__c ; 
                    }else{
                         ServiceCode= le.Service_Code__c ;
                    }
                    
                    if(le.RDS_Phone__c == Null){
                         Phone = Customer.Project__r.RDS_Company_Code__r.RDS_Phone__c;
                    }else{
                         Phone= le.RDS_Phone__c;
                    }   
                    
                    
                    otherchargeAmountMap = DemandManagementServices.getDemandSoFarSummaryOtherChargesNew(Customer.Id);
                    if((otherchargeAmountMap != null) && (otherchargeAmountMap.get('Basic RECD') != null)){
                        PreviousAmountReceived  = otherchargeAmountMap.get('Basic RECD');
                        PreviousAmountReceivedstr  = Informat(PreviousAmountReceived);
                    }
                    
                    if((otherchargeAmountMap != null) && (otherchargeAmountMap.get('Basic TAX RECD') != null)){
                        PreviousGstReceived = otherchargeAmountMap.get('Basic TAX RECD');
                        PreviousGstReceivedstr = Informat(PreviousGstReceived);
                    }
                    
                    outstandingChargesSet = new Set<String>();
                    outstandingChargesSet = DemandManagementServices.getOutstandingChargesName(Customer.Id);
                    if(outstandingChargesSet.size() > 0)
                        hasOutstandings = true;
                    if(Customer.Agreement_Value__c != null)
                        agreementValue = Informat(Customer.Agreement_Value__c);
                  
                    prepareDemandUIMapforPreviewNew();
                }
                System.debug('Customer Detail:' + customer);
            }
        } else if (String.isNotBlank(strdemandType) && String.isNotBlank(strMode) && String.isNotBlank(strMilestoneList) && strdemandType.equalsIgnoreCase('advance') && strmode.equalsIgnoreCase('preview') && strmileStoneList != null && (advanceAmtD > 0 || stAmtD > 0)) {
            // this is for preview of advance demands from the receipt apportionment screen          
            displayStyleGST = '';
            List < Id > msList = strMileStoneList.split(',');
            wrpDemand = DemandManagementServices.getAdvanceDemandDetails(msList, 'advance', advanceAmtD, stAmtD);
            system.debug('wrpDemand:' + wrpDemand);
            if (wrpDemand != null) {
                Msg = 'This is only a preview of Demand Invoice before generated. You can see also preview of generated invoice by clicking "Show Invoice" button on "Demand Invoice" tab. ';
                InvcNo = 'Not Generated';
                Customer = [select id, Name, Primary_Email__c,Primary_Phone__c, Other_Applicants_Email__c,Primary_Name__c, Primary_pancard__c,
                Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,Future_Correspondence_Contact_Email__c,
                Project__c, Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,Project_Name__c,
                Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name,Agreement_Value__c,Account.GSTIN_of_Client__c,Project__r.Place_of_Supply__c,Project__r.State_Code_Where_Supplied__c,Project__r.HSN_Code__c,
                Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, Project_Unit__r.Legal_Entity__r.RDS_Address1__c, Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,
                Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, Account.BillingState, Account.BillingpostalCode,
                Account.BillingCountry, Account.PersonMobilePhone, Project_Unit__r.Booking__r.Name, Project_Unit__r.Booking__r.Booking_Date__c, Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C, Project_Unit__r.Booking__r.Owner.Name, Project_Unit__r.Booking__r.Owner.Email, Project_Unit__r.Booking__r.Owner.Phone,
                Project__r.RDS_Company_Code__r.RDS_Company_Code__c, Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,
                Project__r.Legal_In_AV__c, Project__r.RDS_Interest_Rate__c, Project_Unit__r.Floor__c,Project_Unit__r.Floor1__c,Project__r.Cheque_Dishonour__c, Project_Unit__r.Cluster__c,Project_Unit__r.TowerName__r.Name,Project__r.RDS_Company_Code__r.Name, Project__r.RDS_Company_Code__r.SPV_Bank_Account__c, Project__r.RDS_Company_Code__r.RDS_Address1__c,
                Project__r.RDS_Company_Code__r.GSTIN__c, Project__r.RDS_Company_Code__r.Service_Code__c
                from Opportunity
                where id = : wrpDemand.OpportunityId];
                List<User> u = [Select Name, Phone, MobilePhone, Title, Email from User where Id = : Customer.Project_Unit__r.Booking__r.OwnerId];

                //-------------------------------added------------------------------------------
                if (Customer != null) {
                    projectImage = Customer.Project__r.Project_Image__c;
                    ////Anuja Added ////
                    projectName = Customer.Project__r.Name;
                    clusterName = Customer.Project_Unit__r.Cluster__c;
                    towerName = Customer.Project_Unit__r.TowerName__r.Name;
                    UnitName  = Customer.Project_Unit__r.Floor1__c + customer.Project_Unit__r.Name;
                    CustomerPrimaryName  = Customer.Primary_Name__c;
                    CustomerOtherApplicantName = Customer.Other_Applicants_Name__c;
                    CustomerMailingAddress = Customer.Mailing_Address__c;
                    CustomerMobilePhone  = Customer.Primary_Phone__c;
                    CustomerPanNo = Customer.Primary_pancard__c;
                    CustomerRDSInterest = Customer.Project__r.RDS_Interest_Rate__c;
                    
                     // BY ASHISH
     PreviousOnAccountMoney = PaymentManagementServices.getOnAccountMoney(Customer.Id);
     PreviousOnAccountMoneyStr =INformat(PreviousOnAccountMoney );
     PreviousOnAccountFlatcost = PaymentManagementServices.getOnAccountMoneyFlatcost(Customer.Id);
     PreviousOnAccountFlatcostStr =INformat(PreviousOnAccountFlatcost);
     PreviousOnAccountGST = PaymentManagementServices.getOnAccountMoneyGST(Customer.Id);
     PreviousOnAccountGSTStr =INformat(PreviousOnAccountGST);
     PreviousOnAccountSDR = PaymentManagementServices.getOnAccountMoneySDR (Customer.Id);
     PreviousOnAccountSDRStr =INformat(PreviousOnAccountSDR);
     //ashish 9-1-19
      
     
                    ProjectAddress =  Customer.Project__r.Address__c;
                    CustomerEmail = Customer.Primary_Email__c;
          //          CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
          //          CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c;
                   
                    if(string.isNotBlank(customer.Account.GSTIN_of_Client__c))
                        GSTINOfClient = customer.Account.GSTIN_of_Client__c;
                    else
                        GSTINOfClient = 'Not Applicable (Unregistered - Consumer)';
                    placeOfSupply = customer.Project__r.Place_of_Supply__c;
                    stateCode = customer.Project__r.State_Code_Where_Supplied__c;
                    HSNCode = customer.Project__r.HSN_Code__c;    
                    ///Anuja Added ENDS here///
                    if(u != null && u.size() ==1 ) {
                        CRMName = u[0].Title + u[0].Name;
                        CRMEmail = u[0].Email;
                        CRMMobile = u[0].MobilePhone;
                    }
                    if(Customer.Project_Unit__r.Booking__r.Booking_Date__c != null)
                        bookingDate = Customer.Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C;
                    interestRate = Customer.Project__r.RDS_Interest_Rate__c;
                    chequeDishonour = Customer.Project__r.Cheque_Dishonour__c;
                    InvoiceDate = wrpDemand.InvoiceDate;
                    InvoiceDueDate = wrpDemand.InvoiceDueDate;
                    mileStoneName = wrpDemand.mileStoneName;
                    if (taxSlabMap.containsKey('TDS')) {
                        tdsRate = string.valueOf(taxSlabMap.get('TDS')[0].Tax_Percentage__c.setscale(1)) + ' %';
                        tdsOnCurrent = (wrpDemand.CurrentDemandAmount * taxSlabMap.get('TDS')[0].Tax_Percentage__c / 100).setscale(0, RoundingMode.HALF_UP);
                    }
                    le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);
                    
                    
                    /////// Added by Priya on 13 Jan 2018 //////
                    if(le.Name == Null){
                         CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
                    }else{
                         CompanyName = le.Name;
                    }                    
                    
                    if(le.RDS_Address1__c == Null){
                         CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c; 
                    }else{
                         CompanyAddress = le.RDS_Address1__c;
                    }
                    
                     if(le.GSTIN__c == Null){
                         GSTTIN = Customer.Project__r.RDS_Company_Code__r.GSTIN__c; 
                    }else{
                         GSTTIN= le.GSTIN__c;
                    }
                    
                     if(le.Service_Code__c == Null){
                         ServiceCode = Customer.Project__r.RDS_Company_Code__r.Service_Code__c ; 
                    }else{
                         ServiceCode= le.Service_Code__c ;
                    }
                     if(le.RDS_Phone__c == Null){
                         Phone = Customer.Project__r.RDS_Company_Code__r.RDS_Phone__c;
                    }else{
                         Phone= le.RDS_Phone__c;
                    }   
                    
                    otherchargeAmountMap = DemandManagementServices.getDemandSoFarSummaryOtherChargesNew(Customer.Id);
                    outstandingChargesSet = new Set<String>();
                    outstandingChargesSet = DemandManagementServices.getOutstandingChargesName(Customer.Id);
                    if(Customer.Agreement_Value__c != null)
                        agreementValue = Informat(Customer.Agreement_Value__c);
                    prepareDemandUIMapforPreviewNew();
                }
                System.debug('Customer Detail:' + customer);
            }
        } else if (strDemandInvId != null) {
            // this is from the demand detail page, print demand button
            DemandInv = [Select id, Name,Demand_Number__c, Project__r.Project_Image__c,Project__r.Footer_Image__c, Customer__r.Id, Customer__r.Name, Customer__r.Account.Correspondence_Address__c, Customer__r.Account.PersonMobilePhone, Invoice_Date__c, Due_Date__c,
            Customer__r.Project__r.Project_Image__c, Customer__r.Project_Unit__r.Booking__r.Owner.Email, Customer__r.Project_Unit__r.Booking__r.Owner.Phone, Customer__r.Project_Unit__r.Booking__r.Owner.Name, Customer__r.Project__r.Name, Customer__r.Project_Unit__r.Name,
            Customer__r.Project_Unit__r.Booking__r.Name, Project_Construction_Stage__r.Name,Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c, Customer__r.Project__r.Footer_Image__c, Total_Demanded_Installment__c,
            Total_Demanded_Service_Tax__c, Total_Recd_Installment__c, Total_Recd_Service_Tax__c, Outstanding_Installment__c, Outstanding_Service_Tax__c,
            Current_Demand_Installment__c, Current_Demand_Service_Tax__c, Is_Advanced_Demand__c,Registration_Demand_Generation__c, Legal_Charges_Service_Tax__c,Legal_Charges_Amount__c,
            MVAT_Amount__c,Stamp__c, Registration_Charges_Amount__c, Ready_Reckoner_Value__c,Agreement_Value__c,Interest_Amount__c, Service_Tax_on_Interest__c,
            Total_Demanded_Service_Tax_Basic__c,Total_Demanded_Service_Tax_SBC__c,Total_Demanded_Service_Tax_KKC__c,Total_Recd_Service_Tax_Basic__c ,            Total_Recd_Service_Tax_SBC__c ,Total_Recd_Service_Tax_KKC__c ,Outstanding_Service_Tax_Basic__c ,Outstanding_Service_Tax_SBC__c ,Outstanding_Service_Tax_KKC__c ,
            Legal_charges_Service_Tax_KKC__c,Legal_charges_Service_Tax_SBC__c,Legal_charges_Service_Tax_Basic__c,            Current_Demand_Service_Tax_KKC__c,Current_Demand_Service_Tax_SBC__c,Current_Demand_Service_Tax_Basic__c, gst__c, demand_generated__c,Service_Tax_Rate__c, TDS_Rate__c,
            Total_Payable_Installment__c, Total_Payable_Service_Tax__c,Total_Payable_Overall__c, TDSAmount__c, Milestone_Name__c
            from Demand_Invoice__c Where id = : strDemandInvId];

            Customer = [select id, Name,  Flatcost_Paid_Percent_Against_AV__c,Project__c, Agreement_Value__c,Primary_Email__c,Primary_Phone__c, Other_Applicants_Email__c,Primary_Name__c, Primary_pancard__c,Other_Applicants_Pancard__c,
            Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,Future_Correspondence_Contact_Email__c,
            Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,Project_Unit__r.TowerName__r.Name,Project_Name__c,
            Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name,Account.GSTIN_of_Client__c,Project__r.Place_of_Supply__c,Project__r.State_Code_Where_Supplied__c,Project__r.HSN_Code__c,
            Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, Project_Unit__r.Legal_Entity__r.RDS_Address1__c, 
            Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,Project_Unit__r.Cluster__c,
            Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, Account.BillingState, Account.BillingpostalCode,
            Account.BillingCountry, Account.PersonMobilePhone, Project_Unit__r.Booking__r.Name, Project_Unit__r.Booking__r.Owner.Name, Project_Unit__r.Booking__r.Booking_Date__c,Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C,
            Project_Unit__r.Booking__r.Owner.Email, Project_Unit__r.Booking__r.Owner.Phone,Project_Unit__r.Floor__c,Project_Unit__r.Floor1__c,
            Project__r.Legal_In_AV__c, Project__r.RDS_Company_Code__r.RDS_Company_Code__c, Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,
            Project__r.RDS_Interest_Rate__c, Project__r.Cheque_Dishonour__c, Project__r.RDS_Company_Code__r.Name, Project__r.RDS_Company_Code__r.SPV_Bank_Account__c, 
            Project__r.RDS_Company_Code__r.RDS_Address1__c, Project__r.RDS_Company_Code__r.GSTIN__c, Project__r.RDS_Company_Code__r.Service_Code__c
            from Opportunity
            where id = : DemandInv.Customer__r.Id];
            List<User> u =  [Select Name, Phone, MobilePhone, Title, Email from User where Id = : Customer.Project_Unit__r.Booking__r.OwnerId];

            System.Debug('DemandInv' + DemandInv);
            System.Debug('DemandInv1' + DemandInv.Customer__r.Name);
            System.Debug('DemandInv2' + DemandInv.Customer__r.Account.Correspondence_Address__c);
            System.Debug('DemandInv3' + DemandInv.Customer__r.Account.PersonMobilePhone);

            if (Customer != null) {
                projectImage = Customer.Project__r.Project_Image__c;
                ////Anuja Added ////
                projectName = Customer.Project__r.Name;
                clusterName = Customer.Project_Unit__r.Cluster__c;
                towerName = Customer.Project_Unit__r.TowerName__r.Name;
                UnitName  = Customer.Project_Unit__r.Floor1__c + customer.Project_Unit__r.Name;
                CustomerPrimaryName  = Customer.Primary_Name__c;
                CustomerOtherApplicantName = Customer.Other_Applicants_Name__c;
                CustomerMailingAddress = Customer.Mailing_Address__c;
                CustomerMobilePhone  = Customer.Primary_Phone__c;
                CustomerPanNo = Customer.Primary_pancard__c;
                CustomerRDSInterest = Customer.Project__r.RDS_Interest_Rate__c;
                PercentPaid = Customer.Flatcost_Paid_Percent_Against_AV__c;
                
                 // BY ASHISH
     PreviousOnAccountMoney = PaymentManagementServices.getOnAccountMoney(Customer.Id);
     PreviousOnAccountMoneyStr =INformat(PreviousOnAccountMoney );
     PreviousOnAccountFlatcost = PaymentManagementServices.getOnAccountMoneyFlatcost(Customer.Id);
     PreviousOnAccountFlatcostStr =INformat(PreviousOnAccountFlatcost);
     PreviousOnAccountGST = PaymentManagementServices.getOnAccountMoneyGST(Customer.Id);
     PreviousOnAccountGSTStr =INformat(PreviousOnAccountGST);
     PreviousOnAccountSDR = PaymentManagementServices.getOnAccountMoneySDR (Customer.Id);
     PreviousOnAccountSDRStr =INformat(PreviousOnAccountSDR);
     //ashish 9-1-19
    
                
                ProjectAddress =  Customer.Project__r.Address__c;
                CustomerEmail = Customer.Primary_Email__c;
       //         CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
       //         CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c;
                
                if(string.isNotBlank(customer.Account.GSTIN_of_Client__c))
                   GSTINOfClient = customer.Account.GSTIN_of_Client__c;
                else
                   GSTINOfClient = 'Not Applicable (Unregistered - Consumer)';
                placeOfSupply = customer.Project__r.Place_of_Supply__c;
                stateCode = customer.Project__r.State_Code_Where_Supplied__c;
                HSNCode = customer.Project__r.HSN_Code__c;   
                ///Anuja Added ENDS here///
                if(u != null && u.size() ==1 ) {
                    CRMName = u[0].Title + u[0].Name;
                    CRMEmail = u[0].Email;
                    CRMMobile = u[0].MobilePhone;
                }
                if(Customer.Project_Unit__r.Booking__r.Booking_Date__c != null)
                    bookingDate = Customer.Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C;
                interestRate = Customer.Project__r.RDS_Interest_Rate__c;
                chequeDishonour = Customer.Project__r.Cheque_Dishonour__c;
                InvoiceDate = DemandInv.Invoice_Date__c;
                InvoiceDueDate = DemandInv.Due_Date__C;
                mileStoneName = DemandInv.Milestone_Name__c;
                InvcNo = DemandInv.Demand_Number__c;
                
              
              
                
                tdsRate = string.valueOf(DemandInv.TDS_Rate__c.setscale(0, RoundingMode.HALF_UP)) + ' %';
                tdsOnCurrent = DemandInv.TDSAmount__c.setscale(0, RoundingMode.HALF_UP);
                
                le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);
                if(Customer.Agreement_Value__c != null)                
                    agreementValue = Informat(Customer.Agreement_Value__c);
                
                taxRateBasic = DemandInv.Service_Tax_Rate__c;
                
                System.debug('Customer Detail:' + customer);
                
                le = InventoryCostServices.getLegalEntityDetails(DemandInv.Customer__r.Project_Unit__c, DemandInv.Customer__r.Project__r.Id);
                
              
                 
                  /////// Added by Priya on 13 Jan 2018 /////
                    if(le.Name == Null){
                         CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
                    }else{
                         CompanyName = le.Name;
                    }                    
                    
                    if(le.RDS_Address1__c == Null){
                         CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c; 
                    }else{
                         CompanyAddress = le.RDS_Address1__c;
                    }
              
                     if(le.GSTIN__c == Null){
                         GSTTIN = Customer.Project__r.RDS_Company_Code__r.GSTIN__c; 
                    }else{
                         GSTTIN= le.GSTIN__c;
                    }
                    
                     if(le.Service_Code__c == Null){
                         ServiceCode = Customer.Project__r.RDS_Company_Code__r.Service_Code__c ; 
                    }else{
                         ServiceCode= le.Service_Code__c ;
                    }
                     if(le.RDS_Phone__c == Null){
                         Phone = Customer.Project__r.RDS_Company_Code__r.RDS_Phone__c;
                    }else{
                         Phone= le.RDS_Phone__c;
                    }   
              
              
                if(demandInv.Is_Advanced_Demand__c && !DemandInv.gst__c) {
                    displayStyle = '';
                    system.debug('condition first');
                    prepareDemandUIMapforshowInvoiceAdvance();
                }
                else if(demandInv.Registration_Demand_Generation__c) {
                    displayStyle='none';
                    displayStyleCommon = 'none';
                    displayStyleGST = 'none';
                    displayStyleReg='';
                    registrationcheck = True;
                    
        if(DemandInv.Stamp__c != Null)
        { 
        Stampduty = DemandInv.Stamp__c ;
        Stampdutystr = INFormat(Stampduty ); 
        }
       
        if(DemandInv.Registration_Charges_Amount__c != Null)
        { 
        Registration = DemandInv.Registration_Charges_Amount__c ;
        Registrationstr = INFormat(Registration );

        }
        if(DemandInv.Legal_Charges_Amount__c != Null)
        { 
        Legal = DemandInv.Legal_Charges_Amount__c ;
        Legalstr = INFormat(Legal ); 
        }
        if((DemandInv.Legal_Charges_Amount__c != Null)&&(DemandInv.Registration_Charges_Amount__c != Null)&&(DemandInv.Stamp__c != Null))
        { 
        RegistrationTotal = Stampduty + Registration + Legal ;
        RegistrationTotalstr = INFormat(RegistrationTotal);
        }
        if((DemandInv.Registration_Charges_Amount__c != Null)&&(DemandInv.Stamp__c != Null))
        { 
        RegistrationTotal2 = Stampduty + Registration;
        RegistrationTotal2str = INFormat(RegistrationTotal2);
        }
                    
                    system.debug('condition second');
                    prepareDemandUIMapforRegShow();
                } else if (!DemandInv.gst__c) {
                    displayStyle='';
                    displayStyleGST = 'none';
                    displayStyleReg='none';
                    system.debug('condition third');
                    prepareDemandUIMapforshowInvoice();
                } else {
                    displayStyle='none';
                    displayStyleGST = '';
                    displayStyleReg='none';
                    system.debug('condition fourth');
                    prepareDemandUIMapforShowNew(DemandInv.Id);
                }
            }
            
        } else if (String.isNotBlank(strdemandType) && String.isNotBlank(strMode) && String.isNotBlank(strMilestoneList) && strdemandType.equalsIgnoreCase('registration') && strmode.equalsIgnoreCase('preview')) {
            // in case of registration demands, the preview has oppId in the milestone list.
            displayStyle='none';
            displayStyleReg='';
            displayStyleCommon = 'none';
            displayStyleGST = 'none';
            registrationcheck = True;
            wrpDemand = DemandManagementServices.getDemandDetailsRegistration(strMilestoneList);
            system.debug('wrpDemand:' + wrpDemand);
            if (wrpDemand != null && wrpDemand.OpportunityId != null) {
                Msg = 'This is only a preview of Demand Invoice before generated. You can see also preview of generated invoice by clicking "Show Invoice" button on "Demand Invoice" tab. ';
                InvcNo = 'Not Generated';
                Customer = [select id, Name, Flatcost_Paid_Percent_Against_AV__c, Primary_Email__c,Primary_Phone__c, Other_Applicants_Email__c,Primary_Name__c,Primary_pancard__c,Other_Applicants_Pancard__c,
                Other_Applicants_Name__c,Mailing_Address__c, Future_Correspondence_Contact__c, Future_Correspondence_Contact_Name__c,Future_Correspondence_Contact_Email__c,
                Project__c, Project__r.name, Project__r.Project_Image__c, Project__r.Footer_Image__c,Project_Name__c,
                Project_Unit__c, Project_Unit__r.Name, Project_Unit__r.Intrest__c, Project_Unit__r.Legal_Entity__r.name,Account.GSTIN_of_Client__c,Project__r.Place_of_Supply__c,Project__r.State_Code_Where_Supplied__c,Project__r.HSN_Code__c,
                Project_Unit__r.Legal_Entity__r.RDS_PAN_No__c, Project_Unit__r.Legal_Entity__r.RDS_Service_Tax_No__c, Project_Unit__r.Legal_Entity__r.RDS_Address1__c, Project_Unit__r.Legal_Entity__r.SPV_Bank_Account__c, Project_Unit__r.Param2__c,
                Account.Correspondence_Address__c, Project__r.Address__c, Account.BillingCity, Account.BillingStreet, Account.BillingState, Account.BillingpostalCode,
                Account.BillingCountry, Account.PersonMobilePhone, Project_Unit__r.Booking__r.Name, Project_Unit__r.Booking__r.Booking_Date__c, Project_Unit__r.Booking__r.Owner.Name, Project_Unit__r.Booking__r.Owner.Email, Project_Unit__r.Booking__r.Owner.Phone,
                Project__r.Legal_In_AV__c, Project__r.RDS_Company_Code__r.RDS_Company_Code__c, Project__r.RDS_Company_Code__r.RDS_PAN_No__c, Project__r.RDS_Company_Code__r.RDS_Service_Tax_No__c,Project_Unit__r.Booking__r.Quotation__R.Prepared_Date__C,
                Project__r.RDS_Interest_Rate__c, Project_Unit__r.Floor__c,Project_Unit__r.Floor1__c,Project_Unit__r.TowerName__r.Name,Project_Unit__r.Cluster__c,Project__r.Cheque_Dishonour__c, Project__r.RDS_Company_Code__r.Name, Project__r.RDS_Company_Code__r.SPV_Bank_Account__c, Project__r.RDS_Company_Code__r.RDS_Address1__c,
                Project__r.RDS_Company_Code__r.GSTIN__c, Project__r.RDS_Company_Code__r.Service_Code__c, Project__r.RDS_Company_Code__r.RDS_Phone__c
                from Opportunity
                where id = : wrpDemand.OpportunityId];
                List<User> u = [Select Name, Phone, MobilePhone, Title, Email from User where Id = : Customer.Project_Unit__r.Booking__r.OwnerId];
                //-------------------------------added------------------------------------------
                if (Customer != null) {
                    projectImage = Customer.Project__r.Project_Image__c;
                    ////Anuja Added ////
                    projectName = Customer.Project__r.Name;
                    clusterName = Customer.Project_Unit__r.Cluster__c;
                    towerName = Customer.Project_Unit__r.TowerName__r.Name;
                    UnitName  = Customer.Project_Unit__r.Floor1__c + customer.Project_Unit__r.Name;
                    CustomerPrimaryName  = Customer.Primary_Name__c;
                    CustomerOtherApplicantName = Customer.Other_Applicants_Name__c;
                    CustomerMailingAddress = Customer.Mailing_Address__c;
                    CustomerMobilePhone  = Customer.Primary_Phone__c;
                    CustomerPanNo = Customer.Primary_pancard__c;
                    CustomerRDSInterest = Customer.Project__r.RDS_Interest_Rate__c;
                    PercentPaid = Customer.Flatcost_Paid_Percent_Against_AV__c;
                    
                     // BY ASHISH
     PreviousOnAccountMoney = PaymentManagementServices.getOnAccountMoney(Customer.Id);
     PreviousOnAccountMoneyStr =INformat(PreviousOnAccountMoney );
     PreviousOnAccountFlatcost = PaymentManagementServices.getOnAccountMoneyFlatcost(Customer.Id);
     PreviousOnAccountFlatcostStr =INformat(PreviousOnAccountFlatcost);
     PreviousOnAccountGST = PaymentManagementServices.getOnAccountMoneyGST(Customer.Id);
     PreviousOnAccountGSTStr =INformat(PreviousOnAccountGST);
     PreviousOnAccountSDR = PaymentManagementServices.getOnAccountMoneySDR (Customer.Id);
     PreviousOnAccountSDRStr =INformat(PreviousOnAccountSDR);
     //ashish 9-1-19
 
    
                         
                    ProjectAddress =  Customer.Project__r.Address__c;
                    CustomerEmail = Customer.Primary_Email__c;
        //            CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
        //            CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c;
                   
                    if(string.isNotBlank(customer.Account.GSTIN_of_Client__c))
                        GSTINOfClient = customer.Account.GSTIN_of_Client__c;
                    else
                        GSTINOfClient = 'Not Applicable (Unregistered - Consumer)';
                    placeOfSupply = customer.Project__r.Place_of_Supply__c;
                    stateCode = customer.Project__r.State_Code_Where_Supplied__c;
                    HSNCode = customer.Project__r.HSN_Code__c;    
                    ///Anuja Added ENDS here///
                    if(u != null && u.size() ==1 ) {
                        CRMName = u[0].Title + u[0].Name;
                        CRMEmail = u[0].Email;
                        CRMMobile = u[0].MobilePhone;
                    }
                    if(Customer.Project_Unit__r.Booking__r.Booking_Date__c != null)
                        bookingDate = Customer.Project_Unit__r.Booking__r.Quotation__r.Prepared_Date__c;
                    interestRate = Customer.Project__r.RDS_Interest_Rate__c;
                    chequeDishonour = Customer.Project__r.Cheque_Dishonour__c;
                    InvoiceDate = wrpDemand.InvoiceDate;
                    InvoiceDueDate = wrpDemand.InvoiceDueDate;
                    mileStoneName = wrpDemand.mileStoneName;
                    if (taxSlabMap.containsKey('TDS')) {
                        tdsRate = string.valueOf(taxSlabMap.get('TDS')[0].Tax_Percentage__c.setscale(1)) + ' %';
                        tdsOnCurrent = (wrpDemand.CurrentDemandAmount * taxSlabMap.get('TDS')[0].Tax_Percentage__C / 100).setscale(0, RoundingMode.HALF_UP);
                    }
                    le = InventoryCostServices.getLegalEntityDetails(Customer.Project_Unit__r.Id, Customer.Project__r.Id);

                   
                    /////// Added by Priya on 13 Jan 2018 /////
                     if(le.Name == Null){
                         CompanyName = Customer.Project__r.RDS_Company_Code__r.Name;
                    }else{
                         CompanyName = le.Name;
                    }                    
                    
                    if(le.RDS_Address1__c == Null){
                         CompanyAddress = Customer.Project__r.RDS_Company_Code__r.RDS_Address1__c; 
                    }else{
                         CompanyAddress = le.RDS_Address1__c;
                    }
                    
                    if(le.GSTIN__c == Null){
                         GSTTIN = Customer.Project__r.RDS_Company_Code__r.GSTIN__c; 
                    }else{
                         GSTTIN= le.GSTIN__c;
                    }
                    
                     if(le.Service_Code__c == Null){
                         ServiceCode = Customer.Project__r.RDS_Company_Code__r.Service_Code__c ; 
                    }else{
                         ServiceCode= le.Service_Code__c ;
                    }
                     if(le.RDS_Phone__c == Null){
                         Phone = Customer.Project__r.RDS_Company_Code__r.RDS_Phone__c;
                    }else{
                         Phone= le.RDS_Phone__c;
                    }   
                    
                   
                    chargeAmountMap = DemandManagementServices.getChargesForRegistration(Customer.Id);
                    if(chargeAmountMap != null)
                        agreementValue = Informat(chargeAmountMap.get('Basic TOTAL'));
                    prepareDemandUIMapforRegPreview();
                }
                System.debug('Customer Detail:' + customer);
            }
        } else {
            Msg = ' Demand can\'t be previewed. This demand is already processed. Use show invoice button on demand record to view the demand';
        }
    }
    
    public void prepareDemandUIMapforRegPreview() {
        dList = new List < DemandUIWrapper > ();
        dList1 = new List < DemandUIWrapper > ();
        dList2 = new List < DemandUIWrapper > ();
   //     dList.add(new DemandUIWrapper('Ready Reckoner Value', INFormat(chargeAmountMap.get('Ready Reckoner')), 'Details for Payment of Stamp Duty and Registration Charges:', ''));
        dList.add(new DemandUIWrapper('Total Sales Value', INFormat(chargeAmountMap.get('Basic TOTAL')), 'Cheque in Favour of',''));
        dList.add(new DemandUIWrapper('Value For Calculating Stamp Duty', INFormat(chargeAmountMap.get('Basic TOTAL')), 'For RTGS/NEFT/Electronic Transfer', ''));
        dList.add(new DemandUIWrapper('', '', 'Account Name', ''));
        dList.add(new DemandUIWrapper('Stamp Duty', INFormat(chargeAmountMap.get('Stamp Duty')),'Account Number',''));
        if(!chargeAmountMap.containsKey('Registration Charges'))
            chargeAmountMap.put('Registration Charges', 0);
        dList.add(new DemandUIWrapper('Registration Charges', INFormat(chargeAmountMap.get('Registration Charges')),'Bank Name',''));
        Decimal grandAmount = chargeAmountMap.get('Stamp Duty') + chargeAmountMap.get('Registration Charges');
        dList.add(new DemandUIWrapper('Total (to be paid together)', INFormat(grandAmount), 'IFSCode', '','','',''));
        dList1.add(new DemandUIWrapper(Customer.Primary_Name__c, Customer.Primary_pancard__c,'','','','',''));
        List<String> otherApplicants = new List<String>();
        if(String.isnotBlank(Customer.Other_Applicants_Name__c))
            otherApplicants = Customer.Other_Applicants_Name__c.split(',');
        List<String> othersPAN = new List<String>();
        if(String.isnotBlank(Customer.Other_Applicants_Pancard__c))
            othersPAN = Customer.Other_Applicants_Pancard__c.split(',');
        Integer i=0;
        if(OtherApplicants != null && otherApplicants.Size() > 0 && othersPAN != null) {
            for(String oa : OtherApplicants) {
                if(othersPAN[i] != 'null')
                    dList1.add(new DemandUIWrapper(oa, othersPAN[i] ,'','','','',''));
                i++;    
            }
        }
        if(chargeAmountMap.get('Stamp Duty') != Null)
        { 
        Stampduty = chargeAmountMap.get('Stamp Duty');
        Stampdutystr = INFormat(Stampduty ); 
        }
       
        if(chargeAmountMap.get('Registration Charges') != Null)
        { 
        Registration = chargeAmountMap.get('Registration Charges');
        Registrationstr = INFormat(Registration );

        }
        if(chargeAmountMap.get('Legal Charges') != Null)
        { 
        Legal = chargeAmountMap.get('Legal Charges');
        Legalstr = INFormat(Legal ); 
        }
        if((chargeAmountMap.get('Legal Charges') != Null)&&(chargeAmountMap.get('Registration Charges') != Null)&&(chargeAmountMap.get('Stamp Duty') != Null))
        { 
        RegistrationTotal = Stampduty + Registration + Legal ;
        RegistrationTotalstr = INFormat(RegistrationTotal);
        }
        if((chargeAmountMap.get('Registration Charges') != Null)&&(chargeAmountMap.get('Stamp Duty') != Null))
        { 
        RegistrationTotal2 = Stampduty + Registration;
        RegistrationTotal2str = INFormat(RegistrationTotal2);
        }
        
        
        Map<String,List<Tax_Breakup__c>> taxMap = new Map<String, List<Tax_breakup__c>>();
        taxMap = InventoryCostServices.getChildTaxRateForCharges(Customer.Project__c); //Project_Name__c
        system.debug('taxMap:: '+taxMap);
        String eachCharge = 'Legal Charges';
        Map<String , String> taxdetailsMap = new Map<String, String>();
        Decimal taxValue = 0;
        Decimal totalTax = 0;
        if(taxMap != null && !taxMap.isEmpty() && taxMap.containsKey(eachCharge)) {
            for(Tax_Breakup__c tb : taxMap.get(eachCharge)) {
                taxValue = 0;
                taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAX RATE' , string.valueOf(tb.tax_percentage__c) + '%' );
                taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat((tb.Taxable_Percentage__c * chargeAmountMap.get(eachCharge)/100).setscale(0,RoundingMode.HALF_UP)));
                taxDetailsMap.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT' , QuotationManagementServices.INFormat(((tb.Taxable_Percentage__c * chargeAmountMap.get(eachCharge)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ));
                taxValue = ((tb.Taxable_Percentage__c * chargeAmountMap.get(eachCharge)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                totalTax += taxValue;
            }
        }
        system.debug('eachCharge :: '+eachCharge );
        System.debug('Tax details registration:' + taxDetailsMap);
        if(chargeAmountMap.containsKey('Legal Charges'))
            dList2.add(new DemandUIWrapper('Legal Charges', INFormat(chargeAmountMap.get('Legal Charges')),INFormat(chargeAmountMap.get('Legal Charges TAX')), taxDetailsMap.get('Legal Charges CGST TAX AMT'),taxDetailsMap.get('Legal Charges SGST TAX AMT'),INFormat(0),INFormat((chargeAmountMap.get('Legal Charges') + chargeAmountMap.get('Legal Charges TAX')))));
        if(chargeAmountMap.containsKey('MVAT'))
            dList2.add(new DemandUIWrapper('MVAT', INFormat(chargeAmountMap.get('MVAT')),'','-','-','-',INFormat(chargeAmountMap.get('MVAT'))));
        Decimal grandAmount2 = 0;
        Decimal grandTax2 = 0;
        if(chargeAmountMap != null && chargeAmountMap.containsKey('Legal Charges')) {
            grandAmount2= chargeAmountMap.get('Legal Charges');
            grandTax2 = chargeAmountMap.get('Legal Charges TAX');
        }
        Decimal grandTotal2 = grandAmount2 + grandTax2;
        dList2.add(new DemandUIWrapper('Total Amount Payable', INFormat(grandAmount2), INFormat(grandTax2), '-', '-', '-', INFormat(grandTotal2)));
    }
    // using common registration show for GST and non GST registration demands
    public void prepareDemandUIMapforRegShow() {
        dList = new List < DemandUIWrapper > ();
        dList1 = new List < DemandUIWrapper > ();
        dList2 = new List < DemandUIWrapper > ();
        if(DemandInv.Legal_charges_Service_Tax_KKC__c == null)DemandInv.Legal_charges_Service_Tax_KKC__c = 0;
        if(DemandInv.Legal_charges_Service_Tax_SBC__c == null)DemandInv.Legal_charges_Service_Tax_SBC__c = 0;
        if(DemandInv.Legal_charges_Service_Tax_Basic__c == null)DemandInv.Legal_charges_Service_Tax_Basic__c = 0;
        //dList.add(new DemandUIWrapper('Ready Reckoner Value', INFormat(DemandInv.Ready_Reckoner_Value__c), 'Details for Payment of Stamp Duty and Registration Charges:', ''));
        dList.add(new DemandUIWrapper('Total Sales Value', INFormat(DemandInv.Agreement_Value__c), 'Cheque in Favour of','','','',''));
        dList.add(new DemandUIWrapper('Value For Calculating Stamp Duty', INFormat(DemandInv.Agreement_Value__c), 'For RTGS/NEFT/Electronic Transfer', '','','',''));
        dList.add(new DemandUIWrapper('', '', 'Account Name', '','','',''));
        dList.add(new DemandUIWrapper('Stamp Duty', INFormat(DemandInv.Stamp__c),'Account Number','','','',''));
        dList.add(new DemandUIWrapper('Registration Charges', INFormat(DemandInv.Registration_Charges_Amount__c ),'Bank Name','','','',''));
        Decimal grandAmount = DemandInv.stamp__c + DemandInv.Registration_Charges_Amount__c;
        dList.add(new DemandUIWrapper('Total (to be paid together)', INFormat(grandAmount), 'IFSCode', '','','',''));
        dList1.add(new DemandUIWrapper(Customer.Primary_Name__c, Customer.Primary_pancard__c,'','','','',''));
        List<String> otherApplicants = new List<String>();
        if(Customer.Other_Applicants_Name__c != null)
            otherApplicants = Customer.Other_Applicants_Name__c.split(',');
        List<String> othersPAN = new List<string>();
        if(Customer.Other_Applicants_Pancard__c != null)
            othersPAN = Customer.Other_Applicants_Pancard__c.split(',');
        Integer i=0;
        if(OtherApplicants != null && otherApplicants.Size() > 0 && othersPAN != null) {
            for(String oa : OtherApplicants) {
                if(othersPAN[i] != 'null')
                    dList1.add(new DemandUIWrapper(oa, othersPAN[i] ,'','','','',''));
                i++;    
            }
        }
        
        if(chargeAmountMap.get('Stamp Duty') != Null)
        { 
        Stampduty = chargeAmountMap.get('Stamp Duty');
        Stampdutystr = INFormat(Stampduty ); 
        }
       
        if(chargeAmountMap.get('Registration Charges') != Null)
        { 
        Registration = chargeAmountMap.get('Registration Charges');
        Registrationstr = INFormat(Registration );

        }
        if(chargeAmountMap.get('Legal Charges') != Null)
        { 
        Legal = chargeAmountMap.get('Legal Charges');
        Legalstr = INFormat(Legal ); 
        }
        if((chargeAmountMap.get('Legal Charges') != Null)&&(chargeAmountMap.get('Registration Charges') != Null)&&(chargeAmountMap.get('Stamp Duty') != Null))
        { 
        RegistrationTotal = Stampduty + Registration + Legal ;
        RegistrationTotalstr = INFormat(RegistrationTotal);
        }
        if((chargeAmountMap.get('Registration Charges') != Null)&&(chargeAmountMap.get('Stamp Duty') != Null))
        { 
        RegistrationTotal2 = Stampduty + Registration;
        RegistrationTotal2str = INFormat(RegistrationTotal2);
        }
        
        
        if(DemandInv.Legal_Charges_Amount__c != 0)
            dList2.add(new DemandUIWrapper('Legal Charges', INFormat(DemandInv.Legal_Charges_Amount__c),INFormat(DemandInv.Legal_Charges_Service_Tax__c),INFormat(DemandInv.Legal_charges_Service_Tax_KKC__c),INFormat(DemandInv.Legal_charges_Service_Tax_SBC__c),INFormat(DemandInv.Legal_charges_Service_Tax_Basic__c), INFormat(DemandInv.Legal_Charges_Amount__c + DemandInv.Legal_Charges_Service_Tax__c)));
        if(DemandInv.MVAT_Amount__c != 0)
            dList2.add(new DemandUIWrapper('MVAT', INFormat(DemandInv.MVAT_Amount__c),'','-','-','-',INFormat(DemandInv.MVAT_Amount__c)));
        Decimal grandAmount2 = DemandInv.MVAT_Amount__c + DemandInv.Legal_Charges_Amount__c;
        Decimal grandTax2 = DemandInv.Legal_Charges_Service_Tax__c;
        Decimal grandTotal2 = grandAmount2 + grandTax2;
        dList2.add(new DemandUIWrapper('Total Amount Payable', INFormat(grandAmount2), INFormat(grandTax2), INFormat(DemandInv.Legal_charges_Service_Tax_KKC__c),INFormat(DemandInv.Legal_charges_Service_Tax_SBC__c),INFormat(DemandInv.Legal_charges_Service_Tax_Basic__c),INFormat(grandTotal2)));
    }
    // for pre GST demands show. no changes here
    public void prepareDemandUIMapforshowInvoice() {
        system.debug('rrrrrrr  Total_Demanded_Installment__c : ' + DemandInv.Total_Demanded_Installment__c);
        dList = new List < DemandUIWrapper > ();
        dList1 = new List < DemandUIWrapper > ();
        dListH = new List < DemandUIWrapper > ();
        if(DemandInv.Interest_Amount__c == null)
            DemandInv.Interest_Amount__c = 0;
        if(DemandInv.Service_Tax_on_Interest__c == null)
            DemandInv.Service_Tax_on_Interest__c = 0;
        dListH.add(new DemandUIWrapper('', 'Principal Amount', 'Service Tax', 'Total'));
        dList.add(new DemandUIWrapper('Total Demanded (excluding Current Demand)', INFormat(DemandInv.Total_Demanded_Installment__c), INFormat(DemandInv.Total_Demanded_Service_Tax__c), INFormat(DemandInv.Total_Demanded_Installment__c + DemandInv.Total_Demanded_Service_Tax__c)));
        dList.add(new DemandUIWrapper('Received till date', INFormat(DemandInv.Total_Recd_Installment__c), INFormat(DemandInv.Total_Recd_Service_Tax__c), INFormat(DemandInv.Total_Recd_Installment__c + DemandInv.Total_Recd_Service_Tax__c)));
        dList.add(new DemandUIWrapper('Outstanding till last Demand', INFormat(DemandInv.Outstanding_Installment__c), INFormat(DemandInv.Outstanding_Service_Tax__c), INFormat(DemandInv.Outstanding_Installment__c + DemandInv.Outstanding_Service_Tax__c)));
        dList.add(new DemandUIWrapper('Interest in Outstanding till date', InFormat(DemandInv.Interest_Amount__c), InFormat(DemandInv.Service_Tax_on_Interest__c), InFormat(DemandInv.Interest_Amount__c + DemandInv.Service_Tax_on_Interest__c)));
        dList.add(new DemandUIWrapper('Current Demand', INFormat(DemandInv.Current_Demand_Installment__c), INFormat(DemandInv.Current_Demand_Service_Tax__c), INFormat(DemandInv.Current_Demand_Installment__c + DemandInv.Current_Demand_Service_Tax__c)));
        Decimal grandAmount = DemandInv.Outstanding_Installment__c + DemandInv.Current_Demand_Installment__c + DemandInv.Interest_Amount__c;
        Decimal grandTax = DemandInv.Outstanding_Service_Tax__c + DemandInv.Current_Demand_Service_Tax__c + DemandInv.Service_Tax_on_Interest__c;
        dList.add(new DemandUIWrapper('Total Outstanding', INFormat(grandAmount), INFormat(grandTax), INFormat(grandAmount + grandTax)));
        dList1.add(new DemandUIWrapper('Total Payable (A = B+C)', INFormat(grandAmount + grandTax), S_NumberToWord.convertNumbertoWords(grandAmount +grandTax), ''));
        dList1.add(new DemandUIWrapper('Principal Amount (B)', INFormat(grandAmount), S_NumberToWord.convertNumbertoWords(grandAmount), ''));
        dList1.add(new DemandUIWrapper('Service Tax (C)', INFormat(grandTax), S_NumberToWord.convertNumbertoWords(grandTax), ''));
    }
    // for pregst advance demands show
    public void prepareDemandUIMapForshowInvoiceAdvance() {
        System.debug('inside method::');
        dList = new List < DemandUIWrapper > ();
        dList1 = new List < DemandUIWrapper > ();
        dListH = new List < DemandUIWrapper > ();
        dListH.add(new DemandUIWrapper('', 'Principal Amount', 'Service Tax', 'Total'));
        dList.add(new DemandUIWrapper('Current Demand', INFormat(DemandInv.Current_Demand_Installment__c), INFormat(DemandInv.Current_Demand_Service_Tax__c), INFormat(DemandInv.Current_Demand_Installment__c + DemandInv.Current_Demand_Service_Tax__c)));
        dList.add(new DemandUIWrapper('Amount Received', INFormat(0), INFormat(0), INFormat(0)));

        Decimal grandAmount = DemandInv.Current_Demand_Installment__c;
        Decimal grandTax = DemandInv.Current_Demand_Service_Tax__c;
        dList.add(new DemandUIWrapper('Total Outstanding', INFormat(grandAmount), INFormat(grandTax), INFormat(grandAmount + grandTax)));
        dList1.add(new DemandUIWrapper('Total Payable (A = B+C)', INFormat(grandAmount + grandTax), S_NumberToWord.convertNumbertoWords(grandAmount + grandTax), ''));
        dList1.add(new DemandUIWrapper('Principal Amount (B)', INFormat(grandAmount), S_NumberToWord.convertNumbertoWords(grandAmount), ''));
        dList1.add(new DemandUIWrapper('Service Tax (C)', INFormat(grandTax), S_NumberToWord.convertNumbertoWords(grandTax), ''));
    }

 
    // this is for preview of gst demands
    public void prepareDemandUIMapforPreviewNew() {
        // for current demand
        headerMap = new Map<Integer,String>();
        subHeaderMap = new Map<Integer,List<String>>();
        subHeaderSizeMap = new Map<Integer, Integer>();
        List<String> st = new List<String>();
        System.debug('In prepare demand UI for Preview :' + wrpDemand);
        //  Header
        //headerMap.put(1 , 'Heads');
        //headerMap.put(2 , 'Current Demand');
        //headerMap.put(3, 'Total');

        // Sub Header
        st.add('Particulars');
        subHeaderMap.put(1, st);
        subHeaderSizeMap.put(1,st.size());
        
        st = new List<String>();
        st.add('Principal Amount(Inclusive of TDS)');
        st.add('GST');
        subHeaderMap.put(2, st);
        subHeaderSizeMap.put(2,st.size());
        
        st = new List<String>();
        //st.add('Invoice Total');
        //st.add('Total Words');
        subHeaderMap.put(3, st);
        subHeaderSizeMap.put(3,st.size());
        taxNames = new List<String>();
        
        taxNames.addAll(wrpDemand.taxnames);
        System.debug('taxnames in demand preview:' + taxNames);
        // if there are no taxes for a particular charge and that's the only charge that's being charged in this demand
        if(taxNames == null || taxNames.size() == 0) {
            taxNames.add('CGST');
            taxNames.add('SGST');
            wrpDemand.TaxRateMap.put('CGST',  '0%');
            wrpDemand.TaxRateMap.put('SGST',  '0%');
            for(String t: taxnames){
                for(string c: wrpDemand.ChargeNameMap.keyset()) {
                    wrpDemand.ChargeTaxMap.put(c + ' '+ t +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat(0));
                    wrpDemand.ChargeTaxMap.put(c + ' '+  t + ' TAX AMT' , QuotationManagementServices.INFormat(0) );
                }
            }
        }
        
        taxColSize = new Map<Integer,INteger>();
        Integer count  = 1;
        Integer addSize = 0;
        for(Integer i: subHeaderMap.keyset()) {
            for(String s: subHeaderMap.get(i)){
                
                if(s.equalsIgnoreCase('GST') && taxNames.size() > 0) { 
                    // each tax has tax amt and taxable amt - hence *2 and then we add a total tax column - +1  +1 for IGST
                    taxColSize.put(count,taxNames.size() * 2 +2);
                    addSize +=taxNames.size() * 2 +2;
                }
                else
                    taxColSize.put(count,1);    
                count ++;
            }
            if(addSize > 0)
                // if have tax columns then the same number of column span have to be increased in the parent header also.
                // the header structure is Current Demand Details -> [Current Amt, Tax [Dyanmic list of tax columns + 1 Tax total], Total]
                subHeaderSizeMap.put(i, subHeaderSizeMap.get(i) +addSize -1);
            addSize = 0;
        }
        // for calculating current dues
        decimal totalprincipalDec = 0;
        decimal totaltaxableDec = 0;
        decimal totaloftotalTaxesDec = 0;
        decimal totalinvoicedec = 0;
          
        for(string c: wrpDemand.ChargeNameMap.keyset()) {
            totalprincipalDec += wrpDemand.chargeAmountMapD.get(c);
            totaltaxableDec += wrpDemand.ChargeTaxMapD.get(c+ ' TAXABLE VALUE D');
            totaloftotalTaxesDec += wrpDemand.ChargeTaxMapD.get(c+ ' TOTAL TAX AMT D');
            totalinvoicedec += wrpDemand.ChargeOverallTotalD.get(c);
                for(String t: taxnames){
                   if(!totalTaxesmap.containsKey(t)) {
                       decimal totaltaxesbreakup = 0;
                        totaltaxesbreakup += wrpDemand.ChargeTaxMapD.get(c+ ' ' + t + ' TAX AMT D');
                        totalTaxesmap.put(t,QuotationManagementServices.INFormat(totaltaxesbreakup));
                    }
                }
            
        }
        
     
        invoiceTotal = QuotationManagementServices.INFormat(totalinvoicedec);
        LessLandCost = totalprincipalDec - totaltaxableDec;
     LessLandCostStr = INFormat(LessLandCost);
     
     taxless = totalprincipalDec - LessLandCost;
     taxlessstr =INFormat(taxless);
       
        System.debug('GrandTotal :' + GrandTotal );

        // for pending demands [printing the outstandings]
        headerMapO = new Map<Integer,String>();
        subHeaderMapO = new Map<Integer,List<String>>();
        subHeaderSizeMapO = new Map<Integer, Integer>();
        List<String> stO = new List<String>();
        System.debug('In prepare demand UI for Preview :outstandings section :' + wrpDemand);
        //  Header
        headerMapO.put(1 , 'Heads');
        headerMapO.put(2 , 'Demanded till date');
        headerMapO.put(3, 'Total');

        // Sub Header
        stO.add('Charge Name');
        subHeaderMapO.put(1, stO);
        subHeaderSizeMapO.put(1,stO.size());
        
        stO = new List<String>();
        stO.add('Amount Demanded');
        stO.add('Amount Received');
        stO.add('Amount Outstanding');
        stO.add('Tax Demanded');
        stO.add('Tax Received');
        stO.add('Tax Outstanding');
        stO.add('Interest');
        subHeaderMapO.put(2, stO);
        subHeaderSizeMapO.put(2,stO.size());
        
        stO = new List<String>();
        stO.add('Total');
        stO.add('Total Words');
        subHeaderMapO.put(3, stO);
        subHeaderSizeMapO.put(3,stO.size());
        taxNamesO = new List<String>();
        // though i am adding the taxnames to the outstanding demand headers as well, we are not  printing the tax breakup for outstanding demands
        // as it can be a mix of ST and GST.
        taxNamesO.addAll(wrpDemand.taxnames);
        
        taxColSizeO = new Map<Integer,INteger>();
        Integer countO  = 1;
        Integer addSizeO = 0;
        for(Integer i: subHeaderMapO.keyset()) {
            for(String s: subHeaderMapO.get(i)){
                
                if(s.equalsIgnoreCase('Tax Demanded XYZ')) { // skipping this for now. we will see whether we need to print cgst, sgst for oustandings later
                    taxColSizeO.put(countO,taxNamesO.size() + 1);
                    addSizeO +=TaxNamesO.size() +1;
                }
                else
                    taxColSizeO.put(countO,1);  
                countO ++;
            }
            if(addSizeO > 0)
                subHeaderSizeMapO.put(i, subHeaderSizeMapO.get(i) +addSizeO -1);
            addSizeO = 0;
        }
        demandedChargesMapStr = new Map<String, String>();
        decimal totalOutstanding = 0;
        decimal totalTaxOutstanding = 0;
        if(otherchargeAmountMap != null && otherchargeAmountMap.size() > 0) {
            for(String s: otherchargeAmountMap.keyset()) {
                System.debug('otherchargeAmountMap:' + s + '::' + otherchargeAmountMap.get(s));
                
                demandedChargesMapStr.put(s, INformat(otherChargeAmountMap.get(s)));
                If(!outstandingChargesSet.isEmpty()) {
                   for(String eachCharge : outstandingChargesSet) {
                       if(eachCharge + ' OUTSTANDING' == s) {
                           totalOutstanding += otherChargeAmountMap.get(s);
                       }
                       if(eachCharge + ' TAX OUTSTANDING' == s) {
                           totalTaxOutstanding += otherChargeAmountMap.get(s);
                       }
                   }
                }
            
                if(s.contains('TOTAL OUTSTANDING')) {
                    System.debug('inside total outstanding :' + s + ':Amt:' + otherchargeAmountMap.get(s));
                    
                    String Amount = S_NumberToWord.convertNumbertoWords(otherchargeAmountMap.get(s));
                    demandedChargesMapStr.put(s + ' WORDS', Amount);
                }
            }
        }
        totalOuststandingFormatted = INformat(totalOutstanding);
        totalTaxOutstandingformatted = INformat(totalTaxOutstanding);
        totalpreviousDues = INformat(totalOutstanding + totalTaxOutstanding);
        totalPrincipal = QuotationManagementServices.INFormat(totalprincipalDec);
        totalTaxable = QuotationManagementServices.INFormat(totaltaxableDec);
        totaloftotalTaxes = QuotationManagementServices.INFormat(totaloftotalTaxesDec);
        BalanceCurrentDue  = (totalprincipalDec + totalOutstanding)- PreviousOnAccountFlatcost;          
        BalanceCurrentDueStr =INformat(BalanceCurrentDue);
              
        BalanceCurrentGSTDue  = (totaloftotalTaxesDec+ totalTaxOutstanding)- PreviousOnAccountGST;          
        BalanceCurrentDueGSTStr =INformat(BalanceCurrentGSTDue);
        GrandTotal = BalanceCurrentDue + BalanceCurrentGSTDue;
        GrandTotalstr = INformat(GrandTotal); 
        
if(PreviousAmountReceived != null) 
{
totalBalanceDues = INformat(((totalprincipalDec + totalOutstanding)- PreviousAmountReceived ));
} else 
{
totalBalanceDues = INformat((totalprincipalDec + totalOutstanding));
}
        
        totalNetdue = INformat(totalinvoicedec + totalOutstanding + totalTaxOutstanding);

if(PreviousAmountReceived != null && PreviousGstReceived != null ) 
{
totalDues = INformat(((totalprincipalDec + totalOutstanding + totaloftotalTaxesDec + totalTaxOutstanding)- (PreviousAmountReceived +PreviousGstReceived ) ));
} else 
{
totalDues = INformat((totalprincipalDec + totalOutstanding + totaloftotalTaxesDec + totalTaxOutstanding));
}
       
        totalNetdueWords = S_NumberToWord.convertNumbertoWords(totalinvoicedec + totalOutstanding + totalTaxOutstanding);
        
        
if(PreviousGstReceived != null) 
{
TotalBalanceTaxes = INformat(((totaloftotalTaxesDec + totalTaxOutstanding)- PreviousGstReceived ));
} else 
{
TotalBalanceTaxes = INformat((totaloftotalTaxesDec + totalTaxOutstanding));
}

        Decimal grandTotalAmt = 0;
        Decimal grandTaxTotal = 0;
        if(otherchargeAmountMap != null && otherchargeAmountMap.size() > 0) {
            grandTotalAmt = wrpDemand.totalCurrentCharges.get('CURRENT AMT TOTAL') + otherchargeAmountMap.get('OUTSTANDING AMT');
            grandTaxTotal = wrpDemand.totalCurrentCharges.get('CURRENT TAX TOTAL') + otherchargeAmountMap.get('OUTSTANDING TAX');
        } else {
            grandTotalAmt = wrpDemand.totalCurrentCharges.get('CURRENT AMT TOTAL');
            grandTaxTotal = wrpDemand.totalCurrentCharges.get('CURRENT TAX TOTAL');
        }
        demandedChargesMapStr.put('GRAND AMT TOTAL', INformat(grandTotalAmt));
        demandedChargesMapStr.put('GRAND TAX TOTAL', INformat(grandTaxTotal));
        demandedChargesMapStr.put('GRAND OVERALL TOTAL', INformat(grandTaxTotal + grandTotalAmt));
        demandedChargesMapStr.put('GRAND AMT TOTAL WORDS', S_NumberToWord.convertNumbertoWords(grandTotalAmt));
        demandedChargesMapStr.put('GRAND TAX TOTAL WORDS', S_NumberToWord.convertNumbertoWords(grandTaxTotal));
        demandedChargesMapStr.put('GRAND OVERALL TOTAL WORDS', S_NumberToWord.convertNumbertoWords(grandTaxTotal + grandTotalAmt));
        
    }
   
   
   // this is for show of gst demands
    public void prepareDemandUIMapforShowNew(Id DemandId) {
        // for current demand
        headerMap = new Map<Integer,String>();
        subHeaderMap = new Map<Integer,List<String>>();
        subHeaderSizeMap = new Map<Integer, Integer>();
        List<String> st = new List<String>();
        System.debug('In prepare demandg UI for Preview :' + wrpDemand);
        //  Header
        //headerMap.put(1 , 'Heads');
        //headerMap.put(2 , 'Current Demand');
        //headerMap.put(3, 'Total');

        // Sub Header
        st.add('Particulars');
        subHeaderMap.put(1, st);
        subHeaderSizeMap.put(1,st.size());
        
        st = new List<String>();
        st.add('Principal Amount (Inclusive of TDS)');
        st.add('GST');
        subHeaderMap.put(2, st);
        subHeaderSizeMap.put(2,st.size());
        
        st = new List<String>();
        //st.add('Total');
        //st.add('Total Words');
        subHeaderMap.put(3, st);
        subHeaderSizeMap.put(3,st.size());
        taxNames = new List<String>();
        
        Set<String> taxNameSet = new Set<String>();
        List<Demand_Detail__c> ddListCurrent = new List<Demand_Detail__c>();
        List<Demand_Detail__c> ddListOld = new List<Demand_Detail__c>();
        wrpDemand = new wrpDemand();
        Integer counter = 1;
        ddListCurrent = [Select Id, Name, Demand_Invoice__r.Id, Type__c, Charge_Name__c, 
                                    Total_Amount__c, Installment_Amount__c, Total_Tax__c,
                                    Tax_Breakup_1__c, Taxable_Amount_1__c,Tax_Amount_1__c, Tax_Breakup_1__r.Name,Tax_Breakup_1__r.Tax_Percentage__c,Tax_Breakup_1__r.Tax_Name__c,
                                    Tax_Breakup_2__c, Taxable_Amount_2__c,Tax_Amount_2__c , Tax_Breakup_2__r.Name, Tax_Breakup_2__r.Tax_Percentage__c, Tax_Breakup_2__r.Tax_Name__c
                                    from Demand_Detail__c where Demand_Invoice__r.Id = :DemandId and Type__c = 'Current'];
        for(Demand_Detail__c dd : ddListCurrent) {
            wrpDemand.chargeAmountMap.put(dd.Charge_Name__c, Informat(dd.Installment_Amount__c));
            wrpDemand.chargeAmountMapD.put(dd.Charge_Name__c, dd.Installment_Amount__c);
            wrpDemand.chargeNameMap.put(dd.Charge_Name__c, counter);
            if(dd.Tax_Breakup_1__c != null) {
                taxNameSet.add(dd.Tax_Breakup_1__r.Tax_Name__c);
                wrpDemand.TaxRateMap.put(dd.Tax_Breakup_1__r.Tax_Name__c, string.valueOf(dd.Tax_Breakup_1__r.Tax_Percentage__c) + '%');
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_1__r.Tax_Name__c + ' TAX AMT', Informat(dd.Tax_Amount_1__c));
                wrpDemand.ChargeTaxMapD.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_1__r.Tax_Name__c + ' TAX AMT D', dd.Tax_Amount_1__c);
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_1__r.Tax_Name__c + ' TAXABLE AMOUNT', Informat(dd.Taxable_Amount_1__c));
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' TAXABLE VALUE', Informat(dd.Taxable_Amount_1__c));
                wrpDemand.ChargeTaxMapD.put(dd.Charge_Name__c + ' TAXABLE VALUE D', dd.Taxable_Amount_1__c);
            }
            if(dd.Tax_Breakup_2__c != null) {
                taxNameSet.add(dd.Tax_Breakup_2__r.Tax_Name__c);
                wrpDemand.TaxRateMap.put(dd.Tax_Breakup_2__r.Tax_Name__c, string.valueOf(dd.Tax_Breakup_2__r.Tax_Percentage__c) + '%');
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_2__r.Tax_Name__c + ' TAX AMT', Informat(dd.Tax_Amount_2__c));
                wrpDemand.ChargeTaxMapD.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_2__r.Tax_Name__c + ' TAX AMT D', dd.Tax_Amount_2__c);
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' '+ dd.Tax_Breakup_2__r.Tax_Name__c + ' TAXABLE AMOUNT', Informat(dd.Taxable_Amount_2__c));
                wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c + ' TAXABLE VALUE', Informat(dd.Taxable_Amount_2__c));
                wrpDemand.ChargeTaxMapD.put(dd.Charge_Name__c + ' TAXABLE VALUE D', dd.Taxable_Amount_2__c);
            }
            wrpDemand.ChargeTaxMap.put(dd.Charge_Name__c +  ' TOTAL TAX AMT', Informat(dd.Total_Tax__c));
            wrpDemand.ChargeTaxMapD.put(dd.Charge_Name__c +  ' TOTAL TAX AMT D', dd.Total_Tax__c);
            wrpDemand.chargeOverallTotal.put(dd.Charge_Name__c, informat(dd.Total_Amount__c));
            wrpDemand.chargeOverallTotalD.put(dd.Charge_Name__c, dd.Total_Amount__c);
            wrpDemand.ChargeOverallTotalWords.put(dd.charge_name__c,  S_NumberToWord.convertNumbertoWords(Integer.valueOf(dd.Total_Amount__c)));
            counter ++;
        }                           
        taxNames.addAll(taxNameSet);
       
     

        // if there are two charges and one doesn't contain taxes and other has, then which ever is not taxable add 0 in their tax values
        for(String t: taxnames){
            for(string c: wrpDemand.ChargeNameMap.keyset()) {
                if(!wrpDemand.ChargeTaxMap.containsKey(c + ' '+  t + ' TAX AMT')) {
                    wrpDemand.ChargeTaxMap.put(c + ' '+ t +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat(0));
                    wrpDemand.ChargeTaxMap.put(c + ' '+  t + ' TAX AMT' , QuotationManagementServices.INFormat(0) );
                }
                if(!wrpDemand.ChargeTaxMapD.containsKey(c + ' '+  t + ' TAX AMT D')) {
                    wrpDemand.ChargeTaxMapD.put(c + ' '+  t + ' TAX AMT D' , 0 );
                }
                if(!wrpDemand.ChargeTaxMap.containsKey(c + ' TAXABLE VALUE')) {
                    wrpDemand.ChargeTaxMap.put(c + ' TAXABLE VALUE', QuotationManagementServices.INFormat(0));
                }
                if(!wrpDemand.ChargeTaxMapD.containsKey(c + ' TAXABLE VALUE D')) {
                    wrpDemand.ChargeTaxMapD.put(c + ' TAXABLE VALUE D', 0);
                }
            }
        }
        // if there are no taxes for a particular charge and that's the only charge that's being charged in this demand
        if(taxNames == null || taxNames.size() == 0) {
            taxNames.add('CGST');
            taxNames.add('SGST');
            wrpDemand.TaxRateMap.put('CGST',  '0%');
            wrpDemand.TaxRateMap.put('SGST',  '0%');
            for(String t: taxnames){
                for(string c: wrpDemand.ChargeNameMap.keyset()) {
                    wrpDemand.ChargeTaxMap.put(c + ' '+ t +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat(0));
                    wrpDemand.ChargeTaxMap.put(c + ' '+  t + ' TAX AMT' , QuotationManagementServices.INFormat(0) );
                    wrpDemand.ChargeTaxMapD.put(c + ' '+  t + ' TAX AMT D' , 0);
                    wrpDemand.ChargeTaxMap.put(c + ' TAXABLE VALUE', QuotationManagementServices.INFormat(0));
                    wrpDemand.ChargeTaxMapD.put(c + ' TAXABLE VALUE D', 0);
                }
            }
        }
        taxColSize = new Map<Integer,INteger>();
        Integer count  = 1;
        Integer addSize = 0;
        for(Integer i: subHeaderMap.keyset()) {
            for(String s: subHeaderMap.get(i)){
                
                if(s.equalsIgnoreCase('GST') && taxNames.size() > 0) { 
                    // each tax has tax amt and taxable amt - hence *2 and then we add a total tax column - +1  +1 for iGST
                    taxColSize.put(count,taxNames.size() * 2 + 2);
                    addSize +=taxNames.size() * 2 + 2;
                }
                else
                    taxColSize.put(count,1);    
                count ++;
            }
            if(addSize > 0)
                // if have tax columns then the same number of column span have to be increased in the parent header also.
                // the header structure is Current Demand Details -> [Current Amt, Tax [Dyanmic list of tax columns + 1 Tax total], Total]
                subHeaderSizeMap.put(i, subHeaderSizeMap.get(i) +addSize -1);
            addSize = 0;
        }
        
        // for calculating current dues
        decimal totalprincipalDec = 0;
        decimal totaltaxableDec = 0;
        decimal totaloftotalTaxesDec = 0;
        decimal totalinvoicedec = 0;
          
        for(string c: wrpDemand.ChargeNameMap.keyset()) {
            totalprincipalDec += wrpDemand.chargeAmountMapD.get(c);
            totaltaxableDec += wrpDemand.ChargeTaxMapD.get(c+ ' TAXABLE VALUE D');
            totaloftotalTaxesDec += wrpDemand.ChargeTaxMapD.get(c+ ' TOTAL TAX AMT D');
            totalinvoicedec += wrpDemand.ChargeOverallTotalD.get(c);
                for(String t: taxnames){
                   if(!totalTaxesmap.containsKey(t)) {
                       decimal totaltaxesbreakup = 0;
                        totaltaxesbreakup += wrpDemand.ChargeTaxMapD.get(c+ ' ' + t + ' TAX AMT D');
                        totalTaxesmap.put(t,QuotationManagementServices.INFormat(totaltaxesbreakup));
                    }
                }
            
        }
        
     
        
        System.debug('GrandTotal :' + GrandTotal );
        // for pending demands [printing the outstandings]
        headerMapO = new Map<Integer,String>();
        subHeaderMapO = new Map<Integer,List<String>>();
        subHeaderSizeMapO = new Map<Integer, Integer>();
        List<String> stO = new List<String>();
        System.debug('In prepare demand UI for Preview :outstandings section :' + wrpDemand);
        //  Header
        headerMapO.put(1 , 'Heads');
        headerMapO.put(2 , 'Demanded till date');
        headerMapO.put(3, 'Total');

        // Sub Header
        stO.add('Charge Name');
        subHeaderMapO.put(1, stO);
        subHeaderSizeMapO.put(1,stO.size());
        
        stO = new List<String>();
        stO.add('Amount Demanded');
        stO.add('Amount Received');
        stO.add('Amount Outstanding');
        stO.add('Tax Demanded');
        stO.add('Tax Received');
        stO.add('Tax Outstanding');
        stO.add('Interest');
        subHeaderMapO.put(2, stO);
        subHeaderSizeMapO.put(2,stO.size());
        
        stO = new List<String>();
        stO.add('Total');
        stO.add('Total Words');
        subHeaderMapO.put(3, stO);
        subHeaderSizeMapO.put(3,stO.size());
        taxNamesO = new List<String>();
        demandedChargesMapStr = new Map<String, String>();
        ddListOld = [Select Id, Name, Demand_Invoice__r.Id, Type__c, Charge_Name__c, 
                                    Total_Amount__c, Installment_Amount__c, Total_Tax__c,
                                    Tax_Breakup_1__c, Taxable_Amount_1__c,Tax_Amount_1__c, Tax_Breakup_1__r.Name,
                                    Tax_Breakup_2__c, Taxable_Amount_2__c,Tax_Amount_2__c , Tax_Breakup_2__r.Name,
                                    Amount_Demanded__c, Amount_Received__c,Amount_Outstanding__c,
                                    Tax_Demanded__c, Tax_Received__c, Tax_Outstanding__c, Interest_Outstanding__c
                                    from Demand_Detail__c where Demand_Invoice__r.Id = :DemandId and Type__c = 'Outstanding'];
                                    
        Set<String> taxNames0Set = new Set<String>();
        outstandingChargesSet = new Set<String>();
        decimal totalOutstanding = 0;
        decimal totalTaxOutstanding = 0;
        for(Demand_Detail__c dd : ddListOld) {
            outstandingChargesSet.add(dd.Charge_name__c);
            if(dd.Tax_Breakup_1__c != null) {
                taxNames0Set.add(dd.Tax_Breakup_1__r.Name);
            }
            if(dd.Tax_Breakup_2__c != null) {
                taxNames0Set.add(dd.Tax_Breakup_2__r.Name);
            }
            demandedChargesMapStr.put(dd.Charge_Name__c + ' DEMANDED' , Informat(dd.Amount_Demanded__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' RECD' , InFormat(dd.Amount_Received__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' RECD INTEGER' , string.valueOf(dd.Amount_Received__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' OUTSTANDING' , InFormat(dd.Amount_Outstanding__c));
            totalOutstanding += dd.Amount_Outstanding__c;
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TAX DEMANDED' , InFormat(dd.Tax_Demanded__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TAX RECD' , InFormat(dd.Tax_Received__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TAX RECD INTEGER' , string.valueOf(dd.Tax_Received__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TAX OUTSTANDING' , InFormat(dd.Tax_Outstanding__c));
            totalTaxOutstanding += dd.Tax_Outstanding__c;
            demandedChargesMapStr.put(dd.Charge_Name__c + ' INTEREST OUTSTANDING' , InFormat(dd.Interest_Outstanding__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TOTAL OUTSTANDING' , InFormat(dd.Total_Amount__c));
            demandedChargesMapStr.put(dd.Charge_Name__c + ' TOTAL OUTSTANDING WORDS' , S_NumberToWord.convertNumbertoWords(Integer.valueOf(dd.Total_Amount__c)));
        }
        
        if((demandedChargesMapStr != null) && (demandedChargesMapStr.get('Basic RECD') != null)){
            PreviousAmountReceived  = Integer.valueOf(demandedChargesMapStr.get('Basic RECD INTEGER'));
            PreviousAmountReceivedstr  = demandedChargesMapStr.get('Basic RECD');
        }
        
        if((demandedChargesMapStr != null) && (demandedChargesMapStr.get('Basic TAX RECD') != null)){
            PreviousGstReceived = Integer.valueOf(demandedChargesMapStr.get('Basic TAX RECD INTEGER'));
            PreviousGstReceivedstr = demandedChargesMapStr.get('Basic TAX RECD');
        }
        if(PreviousAmountReceived != null) 
        {
            totalBalanceDues = INformat(((totalprincipalDec + totalOutstanding)- PreviousAmountReceived ));
        } else 
        {
            totalBalanceDues = INformat((totalprincipalDec + totalOutstanding));
        }
        if(PreviousGstReceived != null) 
        {
            TotalBalanceTaxes = INformat(((totaloftotalTaxesDec + totalTaxOutstanding)- PreviousGstReceived ));
        } else 
        {
            TotalBalanceTaxes = INformat((totaloftotalTaxesDec + totalTaxOutstanding));
        }
        if(PreviousAmountReceived != null && PreviousGstReceived != null ) 
        {
            totalDues = INformat(((totalprincipalDec + totalOutstanding + totaloftotalTaxesDec + totalTaxOutstanding)- (PreviousAmountReceived +PreviousGstReceived ) ));
        } else 
        {
            totalDues = INformat((totalprincipalDec + totalOutstanding + totaloftotalTaxesDec + totalTaxOutstanding));
        }
        totalOuststandingFormatted = INformat(totalOutstanding);
        totalTaxOutstandingformatted = INformat(totalTaxOutstanding);
        totalpreviousDues = INformat(totalOutstanding + totalTaxOutstanding);
        totalPrincipal = QuotationManagementServices.INFormat(totalprincipalDec);
        totalTaxable = QuotationManagementServices.INFormat(totaltaxableDec);
        totaloftotalTaxes = QuotationManagementServices.INFormat(totaloftotalTaxesDec);
       LessLandCost = totalprincipalDec - totaltaxableDec;
     LessLandCostStr =INformat(LessLandCost);
        invoiceTotal = QuotationManagementServices.INFormat(totalinvoicedec);
       BalanceCurrentDue  = (totalprincipalDec + totalOutstanding)- PreviousOnAccountFlatcost;          
        BalanceCurrentDueStr =INformat(BalanceCurrentDue); 
        totalNetdue = INformat(totalinvoicedec + totalOutstanding + totalTaxOutstanding);
        totalNetdueWords = S_NumberToWord.convertNumbertoWords(totalinvoicedec.setScale(0) + totalOutstanding.setScale(0) + totalTaxOutstanding.setScale(0));
        BalanceCurrentGSTDue  = (totaloftotalTaxesDec+ totalTaxOutstanding)- PreviousOnAccountGST;          
        BalanceCurrentDueGSTStr =INformat(BalanceCurrentGSTDue); 
        GrandTotal = BalanceCurrentDue + BalanceCurrentGSTDue;
        GrandTotalstr = INformat(GrandTotal);
        taxless = totalprincipalDec - LessLandCost;
     taxlessstr =INFormat(taxless);
              
        if(outstandingChargesSet.size() > 0)
            hasOutstandings = true;
            
        taxNamesO.addAll(taxNames0Set);
        taxColSizeO = new Map<Integer,INteger>();
        Integer countO  = 1;
        Integer addSizeO = 0;
        for(Integer i: subHeaderMapO.keyset()) {
            for(String s: subHeaderMapO.get(i)){
                
                if(s.equalsIgnoreCase('Tax Demanded XYZ')) { // skipping this for now. we will see whether we need to print cgst, sgst for oustandings later
                    taxColSizeO.put(countO,taxNamesO.size() + 1);
                    addSizeO +=TaxNamesO.size() +1;
                }
                else
                    taxColSizeO.put(countO,1);  
                countO ++;
            }
            if(addSizeO > 0)
                subHeaderSizeMapO.put(i, subHeaderSizeMapO.get(i) +addSizeO -1);
            addSizeO = 0;
        }
        
        
        demandedChargesMapStr.put('GRAND AMT TOTAL', INformat(demandinv.Total_Payable_Installment__c));
        demandedChargesMapStr.put('GRAND TAX TOTAL', INformat(demandinv.Total_Payable_Service_Tax__c));
        demandedChargesMapStr.put('GRAND OVERALL TOTAL', INformat(demandinv.Total_Payable_Overall__c));
        demandedChargesMapStr.put('GRAND AMT TOTAL WORDS', S_NumberToWord.convertNumbertoWords(demandinv.Total_Payable_Installment__c));
        demandedChargesMapStr.put('GRAND TAX TOTAL WORDS', S_NumberToWord.convertNumbertoWords(demandinv.Total_Payable_Service_Tax__c));
        demandedChargesMapStr.put('GRAND OVERALL TOTAL WORDS', S_NumberToWord.convertNumbertoWords(demandinv.Total_Payable_Overall__c));
        
    }
    public class DemandUIWrapper {
        public String col1 {
            get;
            set;
        }
        public String col2 {
            get;
            set;
        }
        public String col3 {
            get;
            set;
        }
        public String col4 {
            get;
            set;
        }
        public String col5 {
            get;
            set;
        }
        public String col6 {
            get;
            set;
        }
        public String col7 {
            get;
            set;
        }
        
        public DemandUIWrapper(String col1, String col2, String col3, String col4,String col5,String col6,String col7) {
            this.col1 = col1;
            this.col2 = col2;
            this.col3 = col3;
            this.col4 = col4;
            this.col5 = col5;
            this.col6 = col6;
            this.col7 = col7;
        }
        public DemandUIWrapper(String col1, String col2, String col3, String col4) {
            this.col1 = col1;
            this.col2 = col2;
            this.col3 = col3;
            this.col4 = col4;
        }
    }
    // method for formatting the currency details to Indian Commas Format
    public static String INFormat(Decimal money) {
        String m1 = String.valueOf(money.setscale(0, RoundingMode.HALF_UP)).reverse();
        String mF = '';
        for (Integer i = 0; i < m1.length(); i++) {
            mF += m1.substring(i, i + 1);
            if (i == 2) {
                mF += ',';
            }
            if (i == 4 || i == 6 || i == 8 || i == 10 || i == 12) {
                mF += ',';
            }
        }
        mf = mf.reverse();
        if (mf.substring(0, 1).equals(',')) {
            mf = mf.substring(1);
        }
        mf = 'Rs ' + mf + '/-';
        return mf;
    }
}