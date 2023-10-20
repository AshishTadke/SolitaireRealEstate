public with sharing class QuotationExtn
{
    public Project_Unit__c u {get; set;}
    public Opportunity o {get; set;}
    public Quotation__c q {get;set;}
    public User UserObj{get;set;}
    public Id userId {get;set;}
    public Id unitId {get;set;}
    public Id subventionPlanId {get;set;}
    public Id oppId {get; set;}
    public Id subPlanId {get; set;}
    public String Finished {get; set;}
    public String SubCharge{get; set;}
    public Project__c proj {get; set;}
    public Map<String, Decimal> allChargesMap {get;set;}
    public Map<String, Decimal> allChargesMapDisc {get; set;}
    
    public Map<String,List<QuotationManagementServices.QuoteUIWrapper>> quoteUIMap {get;set;}
    public Map<String,List<QuotationManagementServices.QuoteUIWrapper>> quoteUIMapDisc {get;set;}
    
    public List<Payment_Plan__c> payPlanList {get;set;}
    public List<Payment_Plan__c> subventionPayPlanList {get;set;}

    public Decimal discountPSF {get;set;}
    public Decimal discountLumpsum {get;set;}
    public Decimal agreementValue {get;set;}
    public List<InventoryCostServices.PlanDetailWrapper> payplanDetails;
    public List<InventoryCostServices.PlanDetailWrapper> subventionPayplanDetails;
    public List<QPlanDetailWrapper> qplanWrapperList = new List<QPlanDetailWrapper>();
    public List<QPlanDetailWrapper> qplanWrapper {get { return qplanWrapperList; } set { qplanWrapperList = null; qplanWrapperList = value; }}
    
    public List<QPlanDetailWrapper> qplanWrapperListC = new List<QPlanDetailWrapper>();
    public List<QPlanDetailWrapper> qplanWrapperC {get { return qplanWrapperListC; } set { qplanWrapperListC = null; qplanWrapperListC = value; }}
    
    public Id selectedPlan {get; set;}
    public Boolean editSchedule {get; set;}
    public Boolean scheduleEdited {get;set;}
    public List<InventoryCostServices.DiscountWrapper> pDisc {get;set;}
    public List<InventoryCostServices.DiscountWrapper> pDisc1 {get;set;}
    public String discountPageMode {get;set;}
    public Boolean disableDiscount {get;set;}
    
    public Decimal OriginalPlanNPV {get;set;}
    public Decimal OriginalNPVPSF {get;set;}
    public Decimal UpdatedPlanNPV {get;set;}
    public Decimal UpdatedNPVPSF {get;set;}
    public Decimal NPVDiffLumpsum {get;set;}
    public Decimal NPVDiffPSF {get;set;}
    public Decimal DiscountThreshold{get;set;}
    
    public String SOriginalPlanNPV {get;set;}
    public String SOriginalNPVPSF {get;set;}
    public String SUpdatedPlanNPV {get;set;}
    public String SUpdatedNPVPSF {get;set;}
    public String SNPVDiffLumpsum {get;set;}
    public String SNPVDiffPSF {get;set;}
    public String StotalRateCardPSF {get;set;}
    public String StotalRateCardLumspum {get;set;}
    
    public Integer rowNumber {get;set;}
    public String addType {get;set;}
    public String quoteValidity {get;set;}
    public String quoteDate {get;set;}
    public String quoteFor {get;set;}
    public String quoteApprovalMsg {get;set;}
    public boolean  canAddCarPark1 {get;set;}
    public boolean  canAddCarPark2 {get;set;} 
    public boolean  canAddCarPark3 {get;set;}
    public boolean  canAddCarPark4 {get;set;} 
    public boolean  canAddCarPark5 {get;set;}
    public boolean  canAddCarPark6 {get;set;}
    public boolean  canAddCarPark7 {get;set;}
    public boolean  showAddCarPark {get;set;} 
    public Integer selectedCarPark1 {get;set;}
    public Integer selectedCarPark2 {get;set;}
    public Integer selectedCarPark3 {get;set;}
    public Integer selectedCarPark4 {get;set;}
    public Integer selectedCarPark5 {get;set;}
    public Integer selectedCarPark6 {get;set;}
    public Integer selectedCarPark7 {get;set;}
    public Decimal allotmentCharges {get;set;}
    public Decimal baseRate{get;set;}
    Public Decimal discountVal{get;set;}
    // on load page, get all the charges, the flat details and render it on the UI.
    public QuotationExtn()
    {  
        q = new Quotation__c();
        oppId = null;
        unitId = null;
        subPlanId = null;
        Finished = '';
        SubCharge = '';
        quoteApprovalMsg = 'N/A';
        selectedCarPark1 = 0;
        selectedCarPark2 = 0;
        selectedCarPark3 = 0;
        selectedCarPark4 = 0;
        selectedCarPark5 = 0;
        selectedCarPark6 = 0;
        selectedCarPark7 = 0;
        allotmentCharges = 0;
        baseRate = 0;
        discountVal = 0;
        DiscountThreshold = 0;
        if(ApexPages.currentPage().getParameters().containsKey('id'))       
            unitId = (Id)ApexPages.currentPage().getParameters().get('id');    
        if(ApexPages.currentPage().getParameters().containsKey('oppId'))  
            if(ApexPages.currentPage().getParameters().get('oppId') != '')      
                oppId = (Id)ApexPages.currentPage().getParameters().get('oppId');           
            if(ApexPages.currentPage().getParameters().containsKey('subPlanId'))       
            subPlanId = (Id)ApexPages.currentPage().getParameters().get('subPlanId');
            
            if(ApexPages.currentPage().getParameters().containsKey('Finished'))       
            Finished = (String)ApexPages.currentPage().getParameters().get('Finished'); 
            
            if(ApexPages.currentPage().getParameters().containsKey('SubCharge'))       
            SubCharge= (String)ApexPages.currentPage().getParameters().get('SubCharge');
            
           // userId = UserInfo.getUserId();        
            UserObj = new User();
        if( unitId != null ) {
            u = InventoryCostServices.getUnitDetails(unitId);
            proj = InventoryCostServices.getProjectDetails(unitId);
           // if(userId != null) {
                    UserObj = [Select Id, Name,Discount_Approver_Type__c from User where Id = :UserInfo.getUserId()];
           //  }
               system.debug('Usser:: '+UserObj.Discount_Approver_Type__c ); 
             if(UserObj.Discount_Approver_Type__c == 'Sales User'){
                 DiscountThreshold = Proj.Discount_Threshold_SM__c;
             }
             else if(UserObj.Discount_Approver_Type__c == 'Team Leader'){
                 DiscountThreshold = Proj.Discount_Threshold_TL__c;
             }
             else if(UserObj.Discount_Approver_Type__c == 'Site Head'){
                 DiscountThreshold = Proj.Discount_Threshold_SH__c;
             }
            
             system.debug('DiscountThreshold ::'+DiscountThreshold );
            //if(subPlanId != null)
            //{
                allChargesMap = InventoryCostServices.getAllCharges(unitId,0.0,0.0,subPlanId, Finished,SubCharge);
                quoteUIMap = QuotationManagementServices.getQuotationUIFormat(unitId,0.0,0.0, selectedCarpark1 + selectedcarPark2, subPlanId, Finished,SubCharge);
                System.Debug('Quote UI Map : '+quoteUIMap);
                quoteUIMapDisc = null;
                payPlanList = InventoryCostServices.getPlanList(u.Project__r.Id, u.TowerName__r.Id, subPlanId);
                agreementValue = allChargesMap.get('AGREEMENTVALUE');
                System.Debug('agreementValue in the extn'+agreementValue);
                StotalRateCardPSF = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDPSF'));
                StotalRateCardLumspum = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDLUMPSUM'));
                pDisc = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
                pDisc1 = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
                baseRate = allChargesMap.get('BASERATE');
                q.Original_Base_Rate__c = allChargesMap.get('BasicPSF');
            //}
            q.Project_Unit__c = u.id;
            q.Project__c = proj.id;
        }
        if(oppId != null) {
            o = [Select Id, Name, Account.Name, StageName, Sales_Manager__c from Opportunity where Id = :oppId];
            q.Opportunity__c = o.Id;
            quoteFor = o.Name;
            q.Finished_Unfinished__c = Finished;
            q.Subvention_Charge__c = SubCharge;
        }
        
        discountPSF = 0;
        discountLumpsum = 0;
        editSchedule = false;
        scheduleEdited = false;
        disableDiscount = false;
        OriginalPlanNPV = 0.0;
        UpdatedPlanNPV = 0.0;
        OriginalNPVPSF = 0.0;
        UpdatedNPVPSF = 0.0;
        NPVDiffLumpsum = 0.0;
        NPVDiffPSF = 0.0;
        // string values of the NPV fields for displaying Rs /-
        SOriginalPlanNPV = '';
        SOriginalNPVPSF = '';
        SUpdatedPlanNPV = '';
        SUpdatedNPVPSF = '';
        SNPVDiffLumpsum = '';
        SNPVDiffPSF = '';
        selectedCarPark1 = 0;
        selectedCarPark2 = 0;
        selectedCarPark3 = 0;
        selectedCarPark4 = 0;
        selectedCarPark5 = 0;
        selectedCarPark6 = 0;
        selectedCarPark7 = 0;
       // DiscountThreshold = 0;
        if(proj != null) {
            checkCarParkAvailablity();
            quoteValidity = (System.today().addDays(Integer.valueOf(proj.Quotation_Validity__c))).format();
            quoteDate = System.today().format();
        }
    }
    
    // ====== START: car park method =========
    public void checkCarParkAvailablity() {
        // this is single covered
        if(proj.Single_car_park_available__c != null && proj.Single_car_park_available__c > 0) 
            canAddCarPark1 = true;
        else 
            canAddCarPark1 = false;
        // this is tandem covered
        if(proj.Tandem_car_park_available__c != null && proj.Tandem_car_park_available__c > 0) 
            canAddCarPark2 = true;
        else 
            canAddCarPark2 = false;
            
        if(proj.Single_Open_available__c != null && proj.Single_Open_available__c > 0) 
            canAddCarPark3 = true;
        else 
            canAddCarPark3 = false;
            
        if(proj.Tandem_Open_available__c != null && proj.Tandem_Open_available__c > 0) 
            canAddCarPark4 = true;
        else 
            canAddCarPark4 = false;
                        
        if(proj.Stack_available__c != null && proj.Stack_available__c > 0) 
            canAddCarPark5 = true;
        else 
            canAddCarPark5 = false;
            
        if(proj.New_Stack_available__c != null && proj.New_Stack_available__c > 0) 
            canAddCarPark6 = true;
        else 
            canAddCarPark6 = false;
            
         if(proj.Two_wheeler_Available__c != null && proj.Two_wheeler_Available__c > 0) 
            canAddCarPark7 = true;
        else 
            canAddCarPark7 = false;    
            
            
        if(canAddCarPark1 || canAddCarPark2 || canAddCarPark3 || canAddCarPark4 || canAddCarPark5 || canAddCarPark6 || canAddCarPark7)
            showAddCarPark = true;
        else
            showAddCarPark = false;
    }
    public PageReference addCarPark() {
        Decimal totalAmount = 0;
        discountLumpsum = 0;
        discountPSF = 0;
        selectedCarPark1 = 0;
        selectedCarPark2 = 0;
        selectedCarPark3 = 0;
        selectedCarPark4 = 0;
        selectedCarPark5 = 0;
        selectedCarPark6 = 0;
        selectedCarPark7 = 0;
        Decimal carParkAmount1 = 0;
        Decimal carParkAmount2 = 0;
        Decimal carParkAmount3 = 0;
        Decimal carParkAmount4 = 0;
        Decimal carParkAmount5 = 0;
        Decimal carParkAmount6 = 0;
        Decimal carParkAmount7 = 0;
        
        if(q.Single_car_park_additional__c  > proj.Single_car_park_available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of single covered car parks not available'));
            q.Single_car_park_additional__c = 0;
        } 
        if(q.Tandem_car_park_additional__c  > proj.Tandem_car_park_available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of tandem covered car parks not available'));
            q.Tandem_car_park_additional__c = 0;
        }
      
        if(q.Single_Open_additional__c  > proj.Single_Open_available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of single open car parks not available'));
            q.Single_Open_additional__c = 0;
        } 
        if(q.Tandem_Open_Additional__c  > proj.Tandem_Open_available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of tandem open car parks not available'));
            q.Tandem_Open_Additional__c = 0;
        }
        
        if(q.Stack_additional__c  > proj.Stack_Available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of stack car parks not available'));
            q.Stack_additional__c = 0;
        } 
        
        if(q.New_Stack_additional__c  > proj.New_Stack_Available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of New stack car parks not available'));
            q.New_Stack_additional__c = 0;
        }
        if(q.Two_Wheeler_Additional__c > proj.Two_wheeler_Available__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'selected quantity of Two Wheeler parks not available'));
            q.Two_Wheeler_Additional__c = 0;
        } 
         

        
        if(q.single_car_park_additional__c > 0) {
            carParkAmount1 = proj.Allotment_Charges_2__c * q.single_car_park_additional__c;
            selectedCarPark1 = Integer.valueOf(q.single_car_park_additional__c);
        }
        if(q.Tandem_car_park_additional__c > 0) {
            carParkAmount2 = proj.allotment_charges_4__c * q.Tandem_car_park_additional__c;
            selectedCarPark2 = Integer.valueOf(q.Tandem_car_park_additional__c);
        }
        
        
        if(q.Single_Open_additional__c > 0) {
            carParkAmount3 = proj.Allotment_Charges_1__c* q.Single_Open_additional__c;
            selectedCarPark3 = Integer.valueOf(q.Single_Open_additional__c);
        }
        if(q.Tandem_Open_additional__c > 0) {
            carParkAmount4 = proj.Allotment_Charges_3__c* q.Tandem_Open_additional__c;
            selectedCarPark4 = Integer.valueOf(q.Tandem_Open_additional__c);
        }
       
        
        if(q.Stack_Additional__c > 0) {
            carParkAmount5 = proj.allotment_charges_5__c * q.Stack_Additional__c;
            selectedCarPark5 = Integer.valueOf(q.Stack_Additional__c);
        }
        
        if(q.New_Stack_Additional__c > 0) {
            carParkAmount6 = proj.allotment_charges_6__c * q.New_Stack_Additional__c;
            selectedCarPark6 = Integer.valueOf(q.New_Stack_Additional__c);
        }
        if(q.Two_Wheeler_Additional__c > 0) {
            carParkAmount7 = proj.allotment_charges_7__c * q.Two_Wheeler_Additional__c ;
            selectedCarPark7 = Integer.valueOf(q.Two_Wheeler_Additional__c );
        }
        
        
        
        totalAmount = carParkAmount1 + carParkAmount2 + carParkAmount3 + carParkAmount4 + carParkAmount5 + carParkAmount6 + carParkAmount7;
       
        
        allotmentCharges = totalAmount;
        InventoryCostServices.baseRateVal = baseRate;
        quoteUIMap = QuotationManagementServices.getQuotationUIFormat(unitId,allotmentCharges,discountLumpsum,selectedCarPark1 + selectedCarPark2 + selectedCarPark3 + selectedCarPark4 + selectedCarPark5 + selectedCarPark6 + selectedCarPark7, subPlanId, Finished,SubCharge);        
        allChargesMap = InventoryCostServices.getAllCharges(unitId, allotmentCharges, discountLumpsum,subPlanId, Finished,SubCharge);
        agreementValue = allChargesMap.get('AGREEMENTVALUE');
        StotalRateCardPSF = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDPSF'));
        StotalRateCardLumspum = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDLUMPSUM'));
                    
        /* if(subPlanId != null) {
            Apexpages.currentPage().getParameters().put('subPlanId',subPlanId);
            QueryPlanDetails();
        }*/
        if(selectedPlan != null) {
            Apexpages.currentPage().getParameters().put('subPlanId',selectedPlan);
            QueryPlanDetails();
        }
        return null;
    }
    
    
    public List<InventoryCostServices.PlanDetailWrapper> getPlanDetails(Id planId,  Map<String,Decimal> allChargesMapP){
        List<InventoryCostServices.PlanDetailWrapper> planDetails = new List<InventoryCostServices.PlanDetailWrapper>();
        planDetails = InventoryCostServices.getPlanDetails(planId,allChargesMapP);
        return planDetails;
    }
   
    
    public void QueryPlanDetails(){
        allChargesMapDisc = new Map<String, Decimal>();
        qplanWrapperListC = new List<QPlanDetailWrapper>();
        Standard_Customer_Pay_Plan_Detail__c scppd = new Standard_Customer_Pay_Plan_Detail__c();
        String planIdstr  = Apexpages.currentPage().getParameters().get('subPlanId');
        Id planId;
        if(string.isNotBlank(subPlanId))
            planId = subPlanId;
        else
            planId = null;
        Boolean isValid = (planIdstr InstanceOf ID) ? true : false;
        If(isValid) {
            selectedPlan = planIdstr;
            planId = planIdstr;
        }
        if(!scheduleEdited && planId != null) {
            payplanDetails = new List<InventoryCostServices.PlanDetailWrapper>();
            InventoryCostServices.baseRateVal = baseRate;
            allChargesMapDisc = InventoryCostServices.getAllCharges(unitId, allotmentCharges,discountLumpsum,subPlanId, Finished,SubCharge);
            payplanDetails = getPlanDetails(planId, allChargesMapDisc);
            OriginalPlanNPV = InventoryCostServices.calculateNPV(payplanDetails, proj.Id);
            OriginalNPVPSF = (OriginalPlanNPV/allChargesMap.get('AREA')).setscale(0,RoundingMode.HALF_UP);
            SOriginalPlanNPV = QuotationManagementServices.INFormat(OriginalPlanNPV);
            SOriginalNPVPSF = QuotationManagementServices.INFormat(OriginalNPVPSF);
            qplanWrapperList = new List<QPlanDetailWrapper>();
            for(Integer i=0; i < payplanDetails.size(); i++) {
                system.debug('payplanDetails:: '+payplanDetails[i]);
                QPlanDetailWrapper q = new QPlanDetailWrapper(payplanDetails[i].amount,payplanDetails[i].serviceTax, payplanDetails[i].totalPay, payplanDetails[i].payPlanRecord, payplanDetails[i].taxMap);
                if(payplanDetails[i].payPlanRecord != null)
                    scppd = payplanDetails[i].payPlanRecord.clone(true,true);
                else
                    scppd = null;
                qplanWrapperList.add(q);
                QPlanDetailWrapper q1 = new QPlanDetailWrapper(payplanDetails[i].amount,payplanDetails[i].serviceTax, payplanDetails[i].totalPay, scppd, payplanDetails[i].taxMap);
                // cloning the entire pay plan wrapper to maintain two separate list for editing
                qplanWrapperListC.add(q1);
            }

        } else {
            // do nothing, if there is an edited schedule already in the controller wrapper class. return the same
            // or no plan is selected
        }
    }
   
   // ======== END: Methods related to PLAN QUERYING and formatting end here =========
   
   // ===========START: PLAN EDIT Methods Start here
   
    // action function to add, remove, clone rows for plan editing
    // action related to the +, ++, --
    public void rowModify(){
        if(addType.equals('new')){
            QPlanDetailWrapper q = qplanWrapperListC[rowNumber];
            Standard_Customer_Pay_Plan_Detail__c pp = q.payPlanRecord.clone(true,true);
            QPlanDetailWrapper qNew = new QPlanDetailWrapper(0,0,pp);
            
            qNew.payPlanRecord.Amount_Value__c = 0;
            qNew.payPlanRecord.Amount__c = '';
            qNew.payPlanRecord.Days_Months__c = '';
            qNew.payPlanRecord.Days_Months_Value__c = 0;
            qNew.payPlanRecord.Is_To_Be_Paid__c = '';
            qNew.payPlanRecord.Remarks__c = 'New Row';
            qNew.payPlanRecord.Project_Construction_Stages__c = null;
            qNew.payPlanRecord.Total_Charge_Value_Minus__c = 0;
        qNew.payPlanRecord.Registration_Linked__c = false;
            qNew.payPlanRecord.Deduct_Token__c = false;
            qplanWrapperListC.add(rowNumber+1,qNew);
            
        } else if(addType.equals('clone')) {
            QPlanDetailWrapper q = qplanWrapperListC[rowNumber];
            Standard_Customer_Pay_Plan_Detail__c pp = q.payPlanRecord.clone(true,true);
            QPlanDetailWrapper qNew = new QPlanDetailWrapper(0,0,pp);
            qplanWrapperListC.add(rowNumber+1,qNew);
        } else if(addType.equals('remove')) {
            qplanWrapperListC.remove(rowNumber);
        }
    }

    // cancels the changes made to the plan by updating the boolean variables
    // after cancel the plan is refetched and the page is refreshed
    // action related to Cancel Changes button
    public void cancelEdit(){
        system.debug('inside cancelEdit method');
        scheduleEdited = false;
        editSchedule = false;
        OriginalPlanNPV = 0.0;
        UpdatedPlanNPV = 0.0;
        OriginalNPVPSF = 0.0;
        UpdatedNPVPSF = 0.0;
        // remove the NPV line item from the discount array as the pay plan changes have been canceled
        if(NPVDiffPSF != 0.0) {
            pDisc.remove(pDisc.size()-2);
        }
        NPVDiffLumpsum = 0.0;
        NPVDiffPSF = 0.0;
        //wipe out the decimal and the String values of NPV when the plan edit is canceled
        SOriginalPlanNPV = '';
        SOriginalNPVPSF = '';
        SUpdatedPlanNPV = '';
        SUpdatedNPVPSF = '';
        SNPVDiffLumpsum = '';
        SNPVDiffPSF = '';
        if(String.isNotBlank(quoteApprovalMsg) && quoteApprovalMsg.contains('Discount'))
            quoteApprovalMsg = quoteApprovalMsg.replace('& Modifications have been made to the payment plan','');
        else 
            quoteApprovalMsg = 'N/A';
    }

    // method for handling edits to the payment plan
    // here we disable discounts as discounts cant be applied after editing the payment plan
    // action related to button View Updated Schedule
    public PageReference updatePaymentSchedule() {
        InventoryCostServices.baseRateVal = baseRate;
        Map<String,Decimal> allChargesMapNew = InventoryCostServices.getAllCharges(unitId, allotmentCharges, discountLumpsum, subPlanId, Finished,SubCharge);
        Boolean error = false;
        Integer counter = 0;
        List<InventoryCostServices.PlanDetailWrapper> pdList  = new List<InventoryCostServices.PlanDetailWrapper>();
        List<InventoryCostServices.PlanDetailWrapper> pdListOriginal  = new List<InventoryCostServices.PlanDetailWrapper>();
        for(Integer i=0; i < qPlanWrapperC.size()-1; i++) {
            QPlanDetailWrapper q= qPlanWrapperC[i];
            if(String.isBlank(q.payPlanRecord.Amount__c) || q.payPlanRecord.Amount__c == null || q.payPlanRecord.Amount_Value__c == 0.00 || String.isBlank(q.payPlanRecord.Days_Months__c)  || 
                                        String.IsBlank(q.payPlanRecord.Is_To_Be_Paid__c)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Milestone defintion Incorrect'));              
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter all required fields'));
                q.style = 'error';
                error = true;
            }
            if(q.payPlanRecord.Is_To_Be_Paid__c != null && (q.payPlanRecord.Is_To_Be_Paid__c.equals('Construction Stage') && q.payplanRecord.Project_Construction_Stages__c == null)) {
                q.style = 'error';
                error = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Milestone defintion Incorrect'));      
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter all required fields'));
            }
            counter++;
        }
        if(error && !Test.isRunningTest()) {
            return null;
        }
        for(QPlanDetailWrapper q : qPlanWrapperC) {
            InventoryCostServices.PlanDetailWrapper pdw = new InventoryCostServices.PlanDetailWrapper(q.amount,q.serviceTax,q.payPlanRecord);
            pdList.add(pdw);
        }
        pdList.remove(pdList.size()-1);
        
        for(QPlanDetailWrapper q : qPlanWrapper) {
            InventoryCostServices.PlanDetailWrapper pdwOriginal = new InventoryCostServices.PlanDetailWrapper(q.amount,q.serviceTax,q.payPlanRecord);
            pdListOriginal.add(pdwOriginal);
        }
        pdListOriginal.remove(pdListOriginal.size()-1);
        
        //calculate NPV for the new payment plan, if there is a difference, apply that as an discount for the customers payment
        List<InventoryCostServices.PlanDetailWrapper> updatedPd = InventoryCostServices.calculateUpdatedPaymentSchedule(pdList,allChargesMapNew, pdListOriginal);
        UpdatedPlanNPV = InventoryCostServices.calculateNPV(updatedPd, proj.Id);
        UpdatedNPVPSF = (UpdatedPlanNPV/ allChargesMap.get('AREA')).setscale(0,RoundingMode.HALF_UP);
        NPVDiffLumpsum = OriginalPlanNPV - UpdatedPlanNPV;
        NPVDiffPSF = (NPVDiffLumpsum/ allChargesMap.get('AREA')).setscale(0,RoundingMode.HALF_UP);
        SUpdatedPlanNPV = QuotationManagementServices.INFormat(UpdatedPlanNPV);
        SUpdatedNPVPSF = QuotationManagementServices.INFormat(UpdatedNPVPSF);
        SNPVDiffLumpsum = QuotationManagementServices.INFormat(NPVDiffLumpsum);
        SNPVDiffPSF = QuotationManagementServices.INFormat(NPVDiffPSF);
        error = false;
        qplanWrapperListC = new List<QPlanDetailWrapper>();
        for(Integer i=0; i < updatedPd.size(); i++) {
            QPlanDetailWrapper q = new QPlanDetailWrapper(updatedPd[i].amount,updatedPd[i].serviceTax,updatedPd[i].totalPay, updatedPd[i].payPlanRecord,updatedPd[i].taxMap);
            if(updatedPd[i].totalError) {
                q.style = 'error';
                error = true;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'The payment plan defintion is incorrect,the amount/percentages are not adding up to agreement value'));
            } 
            qplanWrapperListC.add(q);
        }
        if(error) {
            return null;
        }
        disableDiscount = true;
        editSchedule = true;
        scheduleEdited = true;
        showAddCarPark = false;
        
        return null;
    }
    
    // method for final save of the payment changes 
    // here we disable discounts as discounts cant be applied after editing the payment plan
    // action related to button, Save Changes
    public PageReference savePaymentSchedule() {
        if(NPVDiffPSF != 0.0) {
            pDisc.add(pDisc.size()-1,new InventoryCostServices.DiscountWrapper('Payment plan deviation (NPV)', NPVDiffPSF, NPVDiffLumpsum,false,false,true,'NPV'));
        }
        getUpdatedCharges();
        qPlanWrapperList = new List<QPlanDetailWrapper>(); 
        qPlanWrapperList.addAll(qPlanWrapperListC);
        disableDiscount = true;
        editSchedule = false;
        scheduleEdited = true;
        if(quoteApprovalMsg.equals('N/A'))
            quoteApprovalMsg = 'This quotation will go for an approval as Modifications have been made to the payment plan';
        else 
            quoteApprovalMsg += ' & Modifications have been made to the payment plan';
        return null;
    }
    
    // ===========END: PLAN EDIT Methods end here
    
    // =============START: All DISCOUNT related methods start here ============
        
    
    public PageReference openDiscountPage(){
        PageReference pageRef = new PageReference('/apex/QuotationDiscount');
        pageRef.getParameters().put('id',u.Id);
        return pageRef;
    }
    public PageReference backtoQuotePage(){
        PageReference pageRef = new PageReference('/apex/Quotation2');
                pageRef.getParameters().put('subPlanId',selectedPlan);
                pageRef.getParameters().put('id',unitId);
                pageRef.getParameters().put('oppId',oppId);
                system.debug('selectedPlan ::: '+selectedPlan );
        // if a plan was already selected, refetch the plan with the updated CV apportionment
        if(selectedPlan != null) {
            Apexpages.currentPage().getParameters().put('subPlanId',selectedPlan);
            QueryPlanDetails();
        }
        return pageRef;
    }
    public PageReference clearDiscount(){
        discountPSF = 0;
        discountlumpsum = 0;
        pDisc = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
        pDisc1 = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
        FinalCustomerDiscount = null;
        quoteApprovalMsg = 'N/A';
        PageReference pageRef = new PageReference('/apex/QuotationDiscount');
        pageRef.getParameters().put('id',u.Id);
        pageRef.getParameters().put('oppId',oppId);
        pageRef.getParameters().put('subPlanId',subPlanId);
        return pageRef;
    }
    
    // customer discount details wrapper list
    public List<InventoryCostServices.DiscountWrapper> FinalCustomerDiscount{
        
        get {
            if(FinalCustomerDiscount == null) {
                FinalCustomerDiscount = new List<InventoryCostServices.DiscountWrapper>();
                FinalCustomerDiscount.add(new InventoryCostServices.DiscountWrapper('Customer Discount Total', 0.0, 0.0,false,false,false, 'Customer Discount Total') );
                FinalCustomerDiscount.add(new InventoryCostServices.DiscountWrapper('Client Rate (Post Discount)', 0.0, 0.0,false,false,false, 'Client Rate (Post Discount)') );
            } 
            return FinalCustomerDiscount;
        }
        set  {
            FinalCustomerDiscount = value;
        }
    }
    
    // used for getting the discounted cost values. this is called from "Apply discount button
    // on apply discount, we keep the original quotation values as is in the quoteUIMap and
    //populate the quoteUIDiscMap with the new values of charges
    // if the discount is 0, then make the map values back to null, the map with the discount details
    // section renders only if its not null
    public void getUpdatedCharges(){
        Decimal custLumpsumActual = 0.0;
        Decimal custPSFActual = 0.0; 
        Decimal custLumpsumNotional = 0.0; //includes the NPV
        Decimal custPSFNotional = 0.0;  // includes the NPV
        discountPSF = 0;
        discountLumpsum =0; 
        // get the sumtotal of all applied discounts
        for(InventoryCostServices.DiscountWrapper  d : pDisc) {
            if(d.type.equals('Total Discount')) {
                    d.PerSqFtVal = 0;
                    d.LumpsumVal  = 0;
            }
           if(d.applied && d.type != 'Payment Plan Deviation (NPV)') {
                discountLumpsum += d.LumpsumVal;
                custLumpsumActual += d.LumpsumVal;
                custPSFActual += d.PerSqFtVal;
            } 
            if (d.applied) {
                custLumpsumNotional += d.LumpsumVal;
                custPSFNotional += d.PerSqFtVal;
            }
        }
        system.debug('pDisc1::: '+pDisc1);
        for(InventoryCostServices.DiscountWrapper  d : pDisc1) {
            system.debug('d:: '+d);
            if (d.applied) {
                discountLumpsum += d.LumpsumVal;
                custLumpsumActual += d.LumpsumVal;
                custPSFActual += d.PerSqFtVal;
                
                custLumpsumNotional += d.LumpsumVal;
                custPSFNotional += d.PerSqFtVal;
                if(d.PerSqFtVal > d.PerSqFtMax) {
                    quoteApprovalMsg = 'Approval Required for Discount - ' + d.type + '--';
                }
            }
        }
        System.debug('Customer Notional:' + custPSFNotional + ':' + custLumpsumNotional);
        System.debug('Customer Actual:' + custPSFActual + ':' + custLumpsumActual);
        
        // the total discount reflects the notional discount as well in the discount categories
        if(custPSFNotional != 0) {
            for(InventoryCostServices.DiscountWrapper  d : pDisc) {
                if(d.type.equals('Total Discount')) {
                    d.PerSqFtVal = custPSFNotional;
                    d.LumpsumVal  = custLumpsumNotional;
                }
            }
        }
        
                
        // if at all any actual discounts have been applied to the customer, then set the customer level discount wrapper
        // with max at project level and whats the increment given to the customer
        // recalculate the total cost
        // NPV is a notional discount and doesnt affect the final rates
        if(custLumpsumNotional != 0 || custPSFNotional != 0) {
                
            for(InventoryCostServices.DiscountWrapper  cf : FinalCustomerDiscount) {
                if(cf.Type.equals('Customer Discount Total')) {
                    cf.PerSqFtVal = custPSFActual;
                    cf.LumpsumVal = custLumpsumActual;  
                    cf.SPerSqFtVal  = QuotationManagementServices.INFormat(cf.PerSqFtVal);
                    cf.SLumpsumVal  = QuotationManagementServices.INFormat(cf.LumpsumVal);
                }
                if(cf.Type.equals('Client Rate (Post Discount)')) {
                    cf.PerSqFtVal = allChargesMap.get('TOTALRATECARDPSF') - custPSFActual;
                    cf.LumpsumVal = allChargesMap.get('TOTALRATECARDLUMPSUM') - custLumpsumActual;
                    cf.SPerSqFtVal  = QuotationManagementServices.INFormat(cf.PerSqFtVal);
                    cf.SLumpsumVal  = QuotationManagementServices.INFormat(cf.LumpsumVal);
                }
            }
        }
        // recalculate the project cost
        if(discountLumpsum != 0) {
            InventoryCostServices.baseRateVal = baseRate;
            quoteUIMapDisc = QuotationManagementServices.getQuotationUIFormat(unitId,allotmentCharges,discountLumpsum, selectedCarPark1 + selectedCarPark2 + selectedCarPark3 + selectedCarPark4 + selectedCarPark5 + selectedCarPark6 + selectedCarPark7, subPlanId, Finished,SubCharge);
        } else {
            quoteUIMapDisc = null;
        }
        
        disableDiscount = true;
        editSchedule = false;
        showAddCarPark = false;
    }
    
    public PageReference MathforAppliedDiscount(){
        Boolean change = false;
        Boolean change1 = false;
        for(InventoryCostServices.DiscountWrapper  d : pDisc) {
            if(d.selected) {
                change = true;
            } 
        }
        for(InventoryCostServices.DiscountWrapper  d : pDisc1) {
            if(d.selected) {
                change1 = true;
            }
        }
        for(InventoryCostServices.DiscountWrapper  d : pDisc) {
            if(change && !(d.DiscountType == 'NPV'  || d.discountType == 'Total') ) {
                if(d.selected) {
                    d.applied = true;
                    d.selected = false;
                } else {
                    d.applied = false;
                    d.selected = false;
                }
            } 
        }
        for(InventoryCostServices.DiscountWrapper  d : pDisc1) {
            if(change1) {
                if(d.selected) {
                    d.applied = true;
                    d.selected = false;
                } else {
                    d.applied = false;
                    d.selected = false;
                }
            }
            if(d.perSqFtVal != 0 && d.applied) {
                d.lumpsumVal = (d.perSqFtVal * u.Actual_Area_value__c).setscale(0, RoundingMode.HALF_UP);
                d.SlumpsumVal = QuotationManagementServices.INFormat(d.lumpsumVal);
                d.SperSqFtVal = QuotationManagementServices.INFormat(d.perSqFtVal);
            }   
        }
        Decimal custLumpsumActual = 0.0;
        Decimal custPSFActual = 0.0; 
        Decimal custLumpsumNotional = 0.0; //includes the NPV
        Decimal custPSFNotional = 0.0;  // includes the NPV
        
        for(InventoryCostServices.DiscountWrapper  d : pDisc) {
            if(d.type.equals('Total Discount')) {
                d.PerSqFtVal = 0;
                d.LumpsumVal  = 0;
                d.SlumpsumVal = QuotationManagementServices.INFormat(d.lumpsumVal);
                d.SperSqFtVal = QuotationManagementServices.INFormat(d.perSqFtVal);
            }
            if(d.applied && d.type != 'Payment Plan Deviation (NPV)') {
                discountLumpsum += d.LumpsumVal;
                custLumpsumActual += d.LumpsumVal;
                custPSFActual += d.PerSqFtVal;
            } 
            if (d.applied) {
                custLumpsumNotional += d.LumpsumVal;
                custPSFNotional += d.PerSqFtVal;
            }
        }
        for(InventoryCostServices.DiscountWrapper  d : pDisc1) {
            if (d.applied) {
                custLumpsumNotional += d.LumpsumVal;
                custPSFNotional += d.PerSqFtVal;
            }
        }
        System.debug('Customer Notional:' + custPSFNotional + ':' + custLumpsumNotional);
        System.debug('Customer Notional:' + custLumpsumActual + ':' + custPSFActual);
        
        // the total discount reflects the notional discount as well in the discount categories
        if(custPSFNotional != 0) {
            for(InventoryCostServices.DiscountWrapper  d : pDisc) {
                if(d.type.equals('Total Discount')) {
                    d.PerSqFtVal = custPSFNotional;
                    d.LumpsumVal  = custLumpsumNotional;
                    d.SlumpsumVal = QuotationManagementServices.INFormat(d.lumpsumVal);
                    d.SperSqFtVal = QuotationManagementServices.INFormat(d.perSqFtVal);
                }
            }
        }
        return null;
    }
    
    // =============END: DISCOUNT related methods end here ============
    
    // =======START: quote related methods start here
    public PageReference savePrint(){
        // writing the save method within the controller as this save cant be reused elsewhere.
        // its very much tied to the quote wrapper classes.
        q.Finished_Unfinished__c = Finished; 
        q.Subvention_Charge__c = SubCharge;
        Map<String, Id> quoteApproversMap = QuotationManagementServices.getApprovers(proj.Id);
        Integer carParks =0;
        String SM;
        // unit details
        if(o != null && o.sales_manager__c != null)
            SM = o.sales_manager__c;
        else
            SM = 'Not Available';
        q.Name = proj.Name + '-' + u.Name  + '-'+ System.now().format() + '-' + SM ;
        q.Prepared_Date__c = date.parse(quoteDate);
        q.Valid_Till_Date__c = date.parse (quoteValidity);
        q.FlatNo__c = u.Name;
        q.FloorNo__c = allChargesMap.get('FLOORNO');
        q.Carpet_Area_Sq_Ft__c =u.Carpet_Area__c;
        q.Appartment_Configuration__c = u.Project_Unit_Type__r.Name;
        q.Wing__c = u.TowerName__r.Name;
        q.Zone__c = u.TowerName__r.Zone_Name__r.Name;
        

        if(string.isNotBlank(subPlanId)){
            q.Plan_Type__c = 'Subvention Plan';
            q.PaymentPlan__c = subPlanId;
        }
        else{
            q.Plan_Type__c = 'Non Subvention Plan';
            q.PaymentPlan__c = selectedPlan;
        }
        
        String views = '';
        if(String.isNotBlank(u.S_View1__c))
            views = u.S_View1__c +' ,';
        if(String.isNotBlank(u.S_View_2__c))
            views = views + u.S_View_2__c + ' ,';
        if(String.isNotBlank(u.S_View_3__c))
            views = views + u.S_View_3__c;
        // remove the last character only if its a comma.
        if(views.length() > 0 && views.substring(views.length() -1).equals(','))
            views = views.substring(0,views.length() -1);
            
        q.View__c = views;
        if(u.single_car_park_earmarked__c != null) {
            q.single_car_park_earmarked__c = u.single_car_park_earmarked__c;
            carParks += Integer.valueOf(u.single_car_park_earmarked__c);
        }
        if(u.tandem_car_park_earmarked__c != null) {
            q.tandem_car_park_earmarked__c = u.tandem_car_park_earmarked__c;
            carParks +=  Integer.valueOf(u.tandem_car_park_earmarked__c)*2;
        }
        if(u.Single_Open_Earmarked__c != null) {
            q.Single_Open_Earmarked__c = u.Single_Open_Earmarked__c;
            carParks += Integer.valueOf(u.Single_Open_Earmarked__c);
        }
        if(u.Tandem_Open_Earmarked__c != null) {
            q.Tandem_Open_Earmarked__c = u.Tandem_Open_Earmarked__c;
            carParks += Integer.valueOf(u.Tandem_Open_Earmarked__c)*2;
        }
        if(u.Stack__c != null) {
            q.Stack_Earmarked__c = u.Stack__c;
            carParks += Integer.valueOf(u.Stack__c);
        }
        
       
        
        q.No_of_parking__c = carParks + selectedCarPark1 + selectedCarPark2 + selectedCarPark3 + selectedCarPark4 + selectedCarPark5 + selectedCarPark6 + selectedCarPark7;
        
        if(quoteApproversMap.size() > 0) {
            q.Level_One_Approver__c = quoteApproversMap.get('First Level');
            q.Level_Two_Approver__c = quoteApproversMap.get('Second Level');
            q.Level_Three_Approver__c = quoteApproversMap.get('Third Level');
        }
        
        List<Project_Charges__c> projChargesList = InventoryCostServices.getProjectChargesDefined(u.Project__r.Name);
        Map<String, Project_Charges__c> chargeDescriptionMap = new Map<String, Project_Charges__c>();
        for(Project_Charges__C pc : projChargesList) {
            if(pc.Active__c) {
                chargeDescriptionMap.put(pc.Name, pc);
            }
        }
        // base rates
        q.Token_Amount__c = qPlanWrapperC[0].Amount;
        q.ST_Token_Amount__c = qPlanWrapperC[0].serviceTax;
        
        // stamp duty registration fields
        if(allChargesMap.get('Registration Charges') != null)
            q.Registration_Charges__c = allChargesMap.get('Registration Charges');
        if(allChargesMap.get('Legal Charges') != null)
            q.Legal_Charges__c = allChargesMap.get('Legal Charges');
        if(allChargesMap.get('Legal Charges TOTAL TAX AMT') != null)
            q.Legal_Charges_ST__c = allChargesMap.get('Legal Charges TOTAL TAX AMT');
         if(allChargesMap.get('Stamp Duty') != null)
            q.Stamp_Duty__c = allChargesMap.get('Stamp Duty');
         if(allChargesMap.get('MVAT') != null)
            q.MVAT__c = allChargesMap.get('MVAT');
         if(allChargesMap.get('MVAT TOTAL TAX AMT') != null)
            q.MVAT_ST__c = allChargesMap.get('MVAT TOTAL TAX AMT');
                    
        // Base Rates and Other Rates for the unit 
        // discounts applied
        q.Base_Rate_L__c = allChargesMap.get('Basic');
        q.Base_Rate_PSF__c = allChargesMap.get('BasicPSF');
        q.Floor_Rise_L__c = allChargesMap.get('FLOORRISETOTAL');
        q.Floor_Rise_PSF__c = allChargesMap.get('FLOORRISEPERSQFT');
        if(allChargesMap.containsKey('Premium 1')) {
            q.Premium_Charges_Category_1__c = chargeDescriptionMap.get('Premium 1').S_Charge_Bucket__c;
            q.Premium_Charges_Description_1__c = chargeDescriptionMap.get('Premium 1').Remarks__C;
            q.Premium_Charges_Amount_1__c = allChargesMap.get('Premium 1PSF');
        }
        if(allChargesMap.containsKey('Premium 2')) {
            q.Premium_Charges_Category_2__c = chargeDescriptionMap.get('Premium 2').S_Charge_Bucket__c;
            q.Premium_Charges_Description_2__c = chargeDescriptionMap.get('Premium 2').Remarks__C;
            q.Premium_Charges_Amount_2__c = allChargesMap.get('Premium 2PSF');
        }
        if(allChargesMap.containsKey('Premium 3')) {
            q.Premium_Charges_Category_3__c = chargeDescriptionMap.get('Premium 3').S_Charge_Bucket__c;
            q.Premium_Charges_Description_3__c = chargeDescriptionMap.get('Premium 3').Remarks__C;
            q.Premium_Charges_Amount_3__c = allChargesMap.get('Premium 3PSF');
        }
        if(allChargesMap.containsKey('Premium 4')) {
            q.Premium_Charges_Category_4__c = chargeDescriptionMap.get('Premium 4').S_Charge_Bucket__c;
            q.Premium_Charges_Description_4__c = chargeDescriptionMap.get('Premium 4').Remarks__C;
            q.Premium_Charges_Amount_4__c = allChargesMap.get('Premium 4PSF');
        }
        
        if(allChargesMap.get('Infrastructure Charges') != null)
            q.Infrastructure_charges__c = allChargesMap.get('Infrastructure Charges');
        if(allChargesMap.get('Infrastructure Charges TOTAL TAX AMT') != null)
            q.Infrastructure_Charges_ST__c = allChargesMap.get('Infrastructure Charges TOTAL TAX AMT');
        
        if(allChargesMap.get('Development Charges') != null)
            q.Development_Charges_L__c = allChargesMap.get('Development Charges');
            
        q.Total_Rate_Card_L__c = allChargesMap.get('TOTALRATECARDLUMPSUM');
        q.Total_Rate_Card_PSF__c = allChargesMap.get('TOTALRATECARDPSF');
        // copy the original rates to discounted rates, if discounts are applied this will get overwritten with that information
        q.Base_Rate_PSF_D__c = allChargesMap.get('TOTALRATECARDPSF');
        q.Base_Rate_L_D__c = allChargesMap.get('TOTALRATECARDLUMPSUM');
        
        // Discount details
        for(InventoryCostServices.DiscountWrapper  cf : FinalCustomerDiscount) {
                if(cf.Type.equals('Customer Discount Total')) {
                    q.Customer_Total_Discount_PSF__c  = cf.PerSqFtVal;
                    q.Customer_Total_Discount_L__c = cf.LumpsumVal; 
                }
                if(cf.Type.equals('Client Rate (Post Discount)')) {
                    if(cf.PerSqFtVal > 0)
                        q.Base_Rate_PSF_D__c = cf.PerSqFtVal;
                    if(cf.LumpsumVal > 0)
                        q.Base_Rate_L_D__c = cf.LumpsumVal;
                }
        }
        // get the sumtotal of all applied discounts
        for(InventoryCostServices.DiscountWrapper  d : pDisc) {
            // System.debug('pdisc:d' + d);
            if(d.type != 'Payment Plan Deviation (NPV)' && d.type != 'Total Discount') {
                if (d.applied) {
                    q.Discount_1_L__c = d.LumpsumVal;
                    q.Discount_1_PSF__c = d.PerSqFtVal;
                    q.Discount_1_Type__c = d.type;
                }
            }
            if(d.applied && d.type == 'Payment Plan Deviation (NPV)') {
                q.NPV_Applied__c = true;
                q.NPV_L__c = d.LumpsumVal;
                q.NPV_PSF__c = d.PerSqFtVal;
                q.NPV_Type__c = d.type;
            } 
            if(d.type.equals('Total Discount')) {
                q.Total_Discount_L__c = d.LumpsumVal;
                q.Total_Discount_PSF__c = d.PerSqFtVal;
                q.Total_Discount_Type__c = d.type;
            } 
        }
        // get the sumtotal of all applied discounts
        for(InventoryCostServices.DiscountWrapper  d : pDisc1) {
            if (d.applied) {
                q.Discount_2_L__c = d.LumpsumVal;
                q.Discount_2_PSF__c = d.PerSqFtVal;
                q.Discount_2_Type__c = d.type;
            }
            if(d.PerSqFtVal > d.PerSqFtMax) 
                q.Approval_Required_on_Discount__c = true;
        }
        
        if(q.Approval_Required_on_Discount__c || scheduleEdited) 
            q.Quote_Status__c = 'Approval Pending';
        else
            q.Quote_Status__c = 'Valid';
        if(scheduleEdited) {
            q.Payment_Plan_Modified__c = true;  
        } else {
            q.Payment_Plan_Modified__c = false; 
        }
        if(allChargesMap.get('AGREEMENTVALUE') != null)
            q.Agreement_Value__c = allChargesMap.get('AGREEMENTVALUE');
        if(allChargesMap.get('AGREEMENTVALUE TAX AMT') != null)
            q.Agreement_Value_ST__c = allChargesMap.get('AGREEMENTVALUE TAX AMT');
        
        // Maintenance charges
        if(allChargesMap.containsKey('Maintenance Charges 1')) {
            q.Proj_Maint_Charges_Desc_1__c = chargeDescriptionMap.get('Maintenance Charges 1').Remarks__c;
            q.Project_Maintenance_Charges_Category_1__c = chargeDescriptionMap.get('Maintenance Charges 1').S_Charge_Bucket__c;
            q.Project_Maintenance_Charges_Amount_1__c = allChargesMap.get('Maintenance Charges 1');
        if(allChargesMap.containsKey('Maintenance Charges 1 TOTAL TAX AMT'))
                q.Project_Maintenance_Charges_ST_1__c = allChargesMap.get('Maintenance Charges 1 TOTAL TAX AMT');
        }
        if(allChargesMap.containsKey('Maintenance Charges 2')) {
            q.Proj_Maint_Charges_Desc_2__c = chargeDescriptionMap.get('Maintenance Charges 2').Remarks__c;
            q.Project_Maintenance_Charges_Category_2__c = chargeDescriptionMap.get('Maintenance Charges 2').S_Charge_Bucket__c;
            q.Project_Maintenance_Charges_Amount_2__c = allChargesMap.get('Maintenance Charges 2');
        }
        if(allChargesMap.containsKey('Maintenance Charges 3')) {
            q.Proj_Maint_Charges_Desc_3__c = chargeDescriptionMap.get('Maintenance Charges 3').Remarks__c;
            q.Project_Maintenance_Charges_Category_3__c = chargeDescriptionMap.get('Maintenance Charges 3').S_Charge_Bucket__c;
            q.Project_Maintenance_Charges_Amount_3__c = allChargesMap.get('Maintenance Charges 3');
        }
        
        // Project specific charges
        if(allChargesMap.containsKey('Project Specific Charges 1')) {
            q.Project_Specific_Charges_Description_1__c = chargeDescriptionMap.get('Project Specific Charges 1').Remarks__c;
            q.Project_Specific_Charges_Category_1__c = chargeDescriptionMap.get('Project Specific Charges 1').S_Charge_Bucket__c;
            q.Project_Specific_Charges_Amount_1__c = allChargesMap.get('Project Specific Charges 1');
        }
        if(allChargesMap.containsKey('Project Specific Charges 2')) {
            q.Project_Specific_Charges_Description_2__c = chargeDescriptionMap.get('Project Specific Charges 2').Remarks__c;
            q.Project_Specific_Charges_Category_2__c = chargeDescriptionMap.get('Project Specific Charges 2').S_Charge_Bucket__c;
            q.Project_Specific_Charges_Amount_2__c = allChargesMap.get('Project Specific Charges 2');
        }
        if(allChargesMap.containsKey('Project Specific Charges 3')) {
            q.Project_Specific_Charges_Description_3__c = chargeDescriptionMap.get('Project Specific Charges 3').Remarks__c;
            q.Project_Specific_Charges_Category_3__c = chargeDescriptionMap.get('Project Specific Charges 3').S_Charge_Bucket__c;
            q.Project_Specific_Charges_Amount_3__c = allChargesMap.get('Project Specific Charges 3');
        }
        
        // Other charges        
        if(allChargesMap.containsKey('Ultimate Organization formation & related charges')) {
            q.Other_Charges_Category_1__c = chargeDescriptionMap.get('Ultimate Organization formation & related charges').S_Charge_Bucket__c;
            q.Other_Charges_Desc_1__c = chargeDescriptionMap.get('Ultimate Organization formation & related charges').Remarks__c;
            q.Other_Charges_Amount_1__c = allChargesMap.get('Ultimate Organization formation & related charges');
        }
        if(allChargesMap.containsKey('Legal Charges')) {
            q.Other_Charges_Category_2__c = chargeDescriptionMap.get('Legal Charges').S_Charge_Bucket__c;
            q.Other_Charges_Desc_2__c = chargeDescriptionMap.get('Legal Charges').Remarks__c;
            q.Other_Charges_Amount_2__c = allChargesMap.get('Legal Charges');
        }
        if(allChargesMap.containsKey('Electric & Water connection & related infrastructure')) {
            q.Other_Charges_Category_3__c = chargeDescriptionMap.get('Electric & Water connection & related infrastructure').S_Charge_Bucket__c;
            q.Other_Charges_Desc_3__c = chargeDescriptionMap.get('Electric & Water connection & related infrastructure').Remarks__c;
            q.Other_Charges_Amount_3__c = allChargesMap.get('Electric & Water connection & related infrastructure');
        }
        if(allChargesMap.containsKey('Piped Gas Connection & related infrastructure')) {
            q.Other_Charges_Category_4__c = chargeDescriptionMap.get('Piped Gas Connection & related infrastructure').S_Charge_Bucket__c;
            q.Other_Charges_Desc_4__c = chargeDescriptionMap.get('Piped Gas Connection & related infrastructure').Remarks__c;
            q.Other_Charges_Amount_4__c = allChargesMap.get('Piped Gas Connection & related infrastructure');
        }
        if(allChargesMap.containsKey('Club Membership Charges')) {
            q.Other_Charges_Category_5__c = chargeDescriptionMap.get('Club Membership Charges').S_Charge_Bucket__c;
            q.Other_Charges_Desc_5__c = chargeDescriptionMap.get('Club Membership Charges').Remarks__c;
            q.Other_Charges_Amount_5__c = allChargesMap.get('Club Membership Charges');
        }
        if(allChargesMap.containsKey('Annual Club Membership Charges')) {
            q.Other_Charges_Category_6__c = chargeDescriptionMap.get('Annual Club Membership Charges').S_Charge_Bucket__c;
            q.Other_Charges_Desc_6__c = chargeDescriptionMap.get('Annual Club Membership Charges').Remarks__c;
            q.Other_Charges_Amount_6__c = allChargesMap.get('Annual Club Membership Charges');
        }
        if(allChargesMap.containsKey('Electricity Deposit Reimbursement')) {
            q.Other_Charges_Category_7__c = chargeDescriptionMap.get('Electricity Deposit Reimbursement').S_Charge_Bucket__c;
            q.Other_Charges_Desc_7__c = chargeDescriptionMap.get('Electricity Deposit Reimbursement').Remarks__c;
            q.Other_Charges_Amount_7__c = allChargesMap.get('Electricity Deposit Reimbursement');
        }
        if(allChargesMap.containsKey('Land Under Construction (LUC) Reimbursement')) {
            q.Other_Charges_Category_8__c = chargeDescriptionMap.get('Land Under Construction (LUC) Reimbursement').S_Charge_Bucket__c;
            q.Other_Charges_Desc_8__c = chargeDescriptionMap.get('Land Under Construction (LUC) Reimbursement').Remarks__c;
            q.Other_Charges_Amount_8__c = allChargesMap.get('Land Under Construction (LUC) Reimbursement');
        }
        if(allChargesMap.containsKey('Advance Property Charges')) {
            q.Other_Charges_Category_9__c = chargeDescriptionMap.get('Advance Property Charges').S_Charge_Bucket__c;
            q.Other_Charges_Desc_9__c = chargeDescriptionMap.get('Advance Property Charges').Remarks__c;
            q.Other_Charges_Amount_9__c = allChargesMap.get('Advance Property Charges');
        }
        if(allChargesMap.containsKey('Building Protection Deposit')) {
            q.Other_Charges_Category_10__c = chargeDescriptionMap.get('Building Protection Deposit').S_Charge_Bucket__c;
            q.Other_Charges_Desc_10__c = chargeDescriptionMap.get('Building Protection Deposit').Remarks__c;
            q.Other_Charges_Amount_10__c = allChargesMap.get('Building Protection Deposit');
        }
        if(allChargesMap.containsKey('Corpus Fund')) {
            q.Other_Charges_Category_11__c = chargeDescriptionMap.get('Corpus Fund').S_Charge_Bucket__c;
            q.Other_Charges_Desc_11__c = chargeDescriptionMap.get('Corpus Fund').Remarks__c;
            q.Other_Charges_Amount_11__c = allChargesMap.get('Corpus Fund');
        }
        if(allChargesMap.containsKey('Allotment Charges1')) {
            q.Parking_Infra_Charges__c = allChargesMap.get('Allotment Charges1');
            q.Parking_Infra_Charges_ST__c = allChargesMap.get('Allotment Charges1 TAX AMT');
        }
        if(allChargesMap.containsKey('MSEB,Infrastructure & Development charges')) {
            q.MSEB_Infrastructure_Development_charge__c = allChargesMap.get('MSEB,Infrastructure & Development charges');
            q.MSEB_Infrastructure_Development_cha__c = allChargesMap.get('MSEB,Infrastructure & Development charges CGST TAX AMT') + allChargesMap.get('MSEB,Infrastructure & Development charges SGST TAX AMT');
        }
        if(allChargesMap.containsKey('MSEB & Development Charges')) {
            q.MSEB_Infrastructure_Development_charge__c = allChargesMap.get('MSEB & Development Charges');
            q.MSEB_Infrastructure_Development_cha__c = allChargesMap.get('MSEB & Development Charges CGST TAX AMT') + allChargesMap.get('MSEB & Development Charges SGST TAX AMT');
        }
        if(allChargesMap.containsKey('Amenity charge')) {
            q.Amenity_Charge__c = allChargesMap.get('Amenity charge');
            q.Amenity_Charge_ST__c = allChargesMap.get('Amenity charge CGST TAX AMT') + allChargesMap.get('Amenity charge SGST TAX AMT');
        }
        
        // totals
        for(QuotationManagementServices.QuoteUIWrapper qw : quoteUIMap.get('RIGHTTOP')) {
            if(qw.chargeName != null) {
                if(qw.ChargeName.equals('STAMPDUTYREGISTRATIONTOTAL')) {
                    q.Stamp_Duty_and_Registration_Total__c = qw.Amount;
                }
                if(qw.ChargeName.equals('SERVICETAXESTOTAL')) {
                    q.Service_Taxes_Total__c = qw.Amount;
                }
                if(qw.ChargeName.equals('MAINTEANCECHARGESTOTAL')) {
                    q.Society_Charges_Total__c = qw.Amount;
                }
                if(qw.ChargeName.equals('OTHERCHARGESTOTAL')) {
                    q.Other_Charges_Total__c = qw.Amount;
                }
                if(qw.ChargeName.equals('GRANDTOTAL')) {
                    q.Grand_Total__c = qw.Amount;
                }
            }
        }
        
        // rates after discounts
        if(allChargesMapDisc != null && quoteUIMapDisc != null) {
            q.Discount_Applied__c = true;
            q.Agreement_Value_D__c = allChargesMapDisc.get('AGREEMENTVALUE');
            if(allChargesMapDisc.get('AGREEMENTVALUE TAX AMT') != null)
                q.Agreement_Value_ST_D__c = allChargesMapDisc.get('AGREEMENTVALUE TAX AMT');
            if(allChargesMapDisc.get('Stamp Duty') != null)
                q.Stamp_Duty_D__c = allChargesMapDisc.get('Stamp Duty');
            if(allChargesMapDisc.get('MVAT') != null)
                q.MVAT_D__c = allChargesMapDisc.get('MVAT');
            if(allChargesMapDisc.get('MVAT TOTAL TAX AMT') != null)
                q.MVAT_ST_D__c = allChargesMapDisc.get('MVAT TOTAL TAX AMT');
            
            for(QuotationManagementServices.QuoteUIWrapper qw : quoteUIMapDisc.get('RIGHTTOP')) {
                if(qw.chargeName != null) {
                    if(qw.ChargeName.equals('STAMPDUTYREGISTRATIONTOTAL')) {
                        q.Stamp_Duty_and_Registration_Total_D__c = qw.Amount;
                    }
                    if(qw.ChargeName.equals('SERVICETAXESTOTAL')) {
                        q.Service_Taxes_Total_D__c = qw.Amount;
                    }
                    if(qw.ChargeName.equals('GRANDTOTAL')) {
                        q.Grand_Total_D__c = qw.Amount;
                    }
                }
            }
        } 
        Id qId = null;
        PageReference pref;
        Database.saveResult sr = Database.insert(q);
        if(sr.isSuccess()) {
            qId = sr.getId();
        }
        if(qId != null) {
            Quotation__c qNew = [Select Id, Name from Quotation__c where Id = : qId];
            
            // call the save method of inventory cost services here
            List<InventoryCostServices.PlanDetailWrapper> pdList  = new List<InventoryCostServices.PlanDetailWrapper>();
            for(QPlanDetailWrapper q : qPlanWrapperC) {
                InventoryCostServices.PlanDetailWrapper pdw = new InventoryCostServices.PlanDetailWrapper(q.amount,q.serviceTax,q.payPlanRecord);
                pdList.add(pdw);
            }
            pdList.remove(pdList.size()-1);
            if(allChargesMapDisc != null){
                if(string.isNotBlank(subPlanId))
                    InventoryCostServices.insertCustomerPaymentPlan(pdList, subPlanId,proj,u,o,qNew,allChargesMapDisc,SubCharge);
                else
                    InventoryCostServices.insertCustomerPaymentPlan(pdList, selectedplan,proj,u,o,qNew,allChargesMapDisc,SubCharge);    
            }    
            else{
                if(string.isNotBlank(subPlanId))
                    InventoryCostServices.insertCustomerPaymentPlan(pdList, subPlanId,proj,u,o,qNew,allChargesMap,SubCharge);
                else
                    InventoryCostServices.insertCustomerPaymentPlan(pdList, selectedplan,proj,u,o,qNew,allChargesMap,SubCharge);    
                
            }  
            // redirect to a new page for print
            for(QPlanDetailWrapper q : qPlanWrapperC) {
                q.strAmount = QuotationManagementServices.INFormat(q.Amount);
                q.strServiceTax = QuotationManagementServices.INFormat(q.serviceTax);
            }
            
            // not using this, as we are redirecting to quote detail page now.
            pref = new PageReference('/apex/PrintQuote');
            pref.getParameters().put('id',u.Id);
        } else {
            ApexPages.addMessage((new ApexPages.message(ApexPages.severity.FATAL,'Quotation Could not be saved')));
            return null;
        }
        // changed code to redirect to quote detail page instead of the print quote page
        return new PageReference('/' + qId);
    }
    
    
    //===========END: quote related methods end here
    
    // =============START: WRAPPER classes start here
    
    public class QPlanDetailWrapper {
        
        public Decimal amount  {get; set;}
        public Decimal serviceTax  {get; set;}
        public Decimal totalPay {get;set;}
        public Standard_Customer_Pay_Plan_Detail__c payPlanRecord {get;set;}
        public Map<String,Decimal> taxMap {get;set;}
        public Map<String,String> taxMapStr {get;set;}
        public List<String> taxNames {get;set;}
        public String style  {get; set;}
        public String strAmount {get;set;}
        public String strServiceTax {get;set;}
        public string strTotalPay {get;set;}
        
        // keeping cloned "C" copies of each variable. the cloned ones will remain readonly on the pay plan edit screen 
        // and the actual ones will get updated as user changes the plan.
        // these fields provide a reference to the user on what the original is was while editing
        
        // in the quotation screen we will show values from the original fields as read only
        // cloned fields are not rendered.
        
        public QPlanDetailWrapper(Decimal amount,  Decimal serviceTax, Standard_Customer_Pay_Plan_Detail__c ppR) {
                this.amount = amount.setscale(0, RoundingMode.HALF_UP);
                this.serviceTax  = serviceTax.setscale(0, RoundingMode.HALF_UP);
                this.payplanRecord = ppr;
                this.strAmount = QuotationManagementServices.INFormat(amount);
                this.strServiceTax = QuotationManagementServices.INFormat(serviceTax);
        }

        
        public QPlanDetailWrapper(Decimal amount,  Decimal serviceTax, Decimal totalPay, Standard_Customer_Pay_Plan_Detail__c ppR, Map<String,Decimal> taxSlab) {
                System.debug('QDetail Wrapper:' + ppr + ': totalPay' + totalPay);
                this.amount = amount.setscale(0, RoundingMode.HALF_UP);
                this.serviceTax  = serviceTax.setscale(0, RoundingMode.HALF_UP);
                this.payplanRecord = ppr;
                this.strAmount = QuotationManagementServices.INFormat(amount);
                this.strServiceTax = QuotationManagementServices.INFormat(serviceTax);
                this.strTotalPay = QuotationManagementServices.INFormat(totalPay);
                this.taxMapStr = new Map<String,String>();
                this.taxNames  = new List<String>();
                System.debug('taxMap:' + taxSlab);
                if(!taxSlab.isEmpty()) {
                  for(String taxname: taxSlab.keySet()) {
                    taxMapStr.put(taxName, QuotationManagementServices.InFormat(taxSlab.get(taxName)));
                    taxNames.add(taxName);
                  }
                }
                system.debug('taxMapStr:: '+taxMapStr);
                system.debug('taxMapStr:: '+taxNames);
        }
    }
    
    // ==========END: WRAPPER classes end here
    
     /*  ------------------------------------------- Added by Vikas for Base Rate changes   ---------------------------------*/
    
    Public void changeBaseRate(){
    
   
          system.debug('inside BaseRate Method: '+baseRate + '::: Dis:'+DiscountThreshold);
          if(baseRate != null && u!= null){
          
              if (baseRate < DiscountThreshold){
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Base Rate Is Below Approved Rate'));
              }
          
          else{
          system.debug('discountVal::: '+discountVal);
           Decimal carParkAmount1 = 0;
            Decimal carParkAmount2 = 0;
            Decimal carParkAmount3 = 0;
            Decimal carParkAmount4 = 0;
            Decimal carParkAmount5 = 0;
            Decimal carParkAmount6 = 0;
            Decimal carParkAmount7 = 0;
            
            Decimal car1 = 0;
            Decimal car2 = 0;
            Decimal car3 = 0;
            Decimal car4 = 0;
            Decimal car5 = 0;
            Decimal car6 = 0;
            Decimal car7 = 0;
            
           if(q.single_car_park_additional__c > 0) {
                carParkAmount1 = proj.Allotment_Charges_2__c * q.single_car_park_additional__c;
                car1 = q.single_car_park_additional__c;
                //selectedCarPark1 = Integer.valueOf(q.single_car_park_additional__c);
            }
            if(q.Tandem_car_park_additional__c > 0) {
                carParkAmount2 = proj.allotment_charges_4__c * q.Tandem_car_park_additional__c;
                car2 = q.Tandem_car_park_additional__c;
                //selectedCarPark2 = 2*Integer.valueOf(q.Tandem_car_park_additional__c);
            }
            if(q.Single_Open_additional__c > 0) {
                carParkAmount3 = proj.Allotment_Charges_1__c* q.Single_Open_additional__c;
                car3 = q.Single_Open_additional__c;
                //selectedCarPark3 = Integer.valueOf(q.Single_Open_additional__c);
            }
            if(q.Tandem_Open_additional__c > 0) {
                carParkAmount4 = proj.Allotment_Charges_3__c* q.Tandem_Open_additional__c;
                car4 = q.Tandem_Open_additional__c;
                //selectedCarPark4 = 2*Integer.valueOf(q.Tandem_Open_additional__c);
            }
            if(q.Stack_Additional__c > 0) {
                carParkAmount5 = proj.allotment_charges_5__c * q.Stack_Additional__c;
                car5 = q.Stack_Additional__c;
                //selectedCarPark5 = Integer.valueOf(q.Stack_Additional__c);
            }
            if(q.New_Stack_Additional__c > 0) {
                carParkAmount6 = proj.allotment_charges_6__c * q.New_Stack_Additional__c;
                car6 = q.New_Stack_Additional__c ;
                //selectedCarPark5 = Integer.valueOf(q.Stack_Additional__c);
            }
            if(q.Two_Wheeler_Additional__c> 0) {
                carParkAmount6 = proj.allotment_charges_7__c * q.Two_Wheeler_Additional__c;
                car7 = q.Two_Wheeler_Additional__c;
                //selectedCarPark5 = Integer.valueOf(q.Stack_Additional__c);
            }
           
           q = new Quotation__c();
           selectedPlan = null;
           qPlanWrapper.clear();
           allChargesMapDisc = null;
           quoteUIMapDisc = null;
           quoteApprovalMsg = 'N/A';
           editSchedule = false;
           scheduleEdited = false;
           disableDiscount = false;
           //discountPageMode = '';
           discountLumpsum = 0;
           discountPSF = 0;
           //q.quote_type__c = 'Normal';
            //bankFunded = false;
            //loanError = false;
            //loanErrorMsg = '';
           /* selectedCarPark1 = 0;
            selectedCarPark2 = 0;
            selectedCarPark3 = 0;
            selectedCarPark4 = 0;
            selectedCarPark5 = 0;
            allotmentCharges = 0;*/
            pDisc.clear();
            pDisc1.clear();
            OriginalPlanNPV = 0.0;
            UpdatedPlanNPV = 0.0;
            OriginalNPVPSF = 0.0;
            UpdatedNPVPSF = 0.0;
            NPVDiffLumpsum = 0.0;
            NPVDiffPSF = 0.0;
            SOriginalPlanNPV = '';
            SOriginalNPVPSF = '';
            SUpdatedPlanNPV = '';
            SUpdatedNPVPSF = '';
            SNPVDiffLumpsum = '';
            SNPVDiffPSF = '';
            pDisc = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
            pDisc1 = InventoryCostServices.getProjectLevelDiscounts(u.Project__r.Id, u.Id);
            q.single_car_park_additional__c = car1;
            q.Tandem_car_park_additional__c = car2;
            q.Single_Open_additional__c = car3;
            q.Tandem_Open_additional__c = car4;
            q.Stack_Additional__c = car5;
            q.New_Stack_Additional__c = car6;
            q.Two_Wheeler_Additional__c = car7;
 
            Decimal carParkAmt = carParkAmount1 + carParkAmount2 + carParkAmount3 + carParkAmount4 + carParkAmount5 + carParkAmount6 + carParkAmount7;
          
            InventoryCostServices.baseRateVal = baseRate;
            allChargesMap = InventoryCostServices.getAllCharges(unitId,carParkAmt,0.0,subPlanId, Finished,SubCharge);
             quoteUIMap = QuotationManagementServices.getQuotationUIFormat(unitId,carParkAmt,0.0, selectedCarPark1+selectedCarPark2+selectedCarPark3+selectedCarPark4+selectedCarPark5+selectedCarPark6+selectedCarPark7,subPlanId, Finished,SubCharge);
             
             if(discountVal != null && discountVal > 0){
                 quoteUIMapDisc = QuotationManagementServices.getQuotationUIFormat(unitId,carParkAmt,discountVal, selectedCarPark1 + selectedCarPark2 + selectedCarPark3 + selectedCarPark4 + selectedCarPark5 + selectedCarPark6 + selectedCarPark7, subPlanId, Finished,SubCharge);
             }
             else{
                 quoteUIMapDisc = null;
             }
             StotalRateCardPSF = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDPSF'));
             StotalRateCardLumspum = QuotationManagementServices.INFormat(allChargesMap.get('TOTALRATECARDLUMPSUM'));
             checkCarParkAvailablity();
             //clearDiscount();
             List<Payment_Plan__c> selectedSubventionPlan = new List<Payment_Plan__c>();
             if(string.isNotBlank(subPlanId)){
                    selectedSubventionPlan = [Select Subvention_Base_Rate__c  from Payment_Plan__c where Id =: subPlanId];
                    q.Original_Base_Rate__c = selectedSubventionPlan[0].Subvention_Base_Rate__c;
             }
             else{
                    List<Rate_List__c>rateList = new List<Rate_List__c>();
                    map<string,Rate_List__c> rateMap = new map<string,Rate_List__c>();
                    rateList = [Select Id, Rate__c, ChargeCost__c,Global_Charges__r.Name, Amount__c, Charged_Based_On__c,Project_Unit__r.Name, Project__r.Name, Project_Charges__r.Name
                            from Rate_List__c
                            where Project_Unit__C = :u.id //and Global_Charges__r.Name = 'Basic'
                           and (Effective_Till__c = null or Effective_Till__c <= TODAY)];
                    for(Rate_List__c r : rateList){
                        rateMap.put(r.Global_Charges__r.Name,r);
                    }
                    if(baseRate != rateMap.get('Basic').rate__c){            
                        q.Original_Base_Rate__c = rateMap.get('Basic').rate__c;
                    }    
             }    
                
                q.Modified_Base_Rate__c = baseRate;
                q.IsModified_Base_Rate__c = true; 
                
                //quoteApprovalMsg = 'This quotation will go for an approval as Base Rate value have been changed';
                
                if(discountVal != null && discountVal > 0){
                 system.debug('pDisc1:: '+pDisc1);
                 if(!pDisc1.isEmpty()){
                     for(InventoryCostServices.DiscountWrapper d : pDisc1){
                         if(d.discountType == 'Special Offer'){
                             d.selected = true;
                             d.lumpsum = true;
                             d.lumpsumVal = discountVal;
                             d.applied = true; 
                             if(u.Actual_Area_value__c != null && u.Actual_Area_value__c > 0){
                                 d.PerSqFtVal = (discountVal / u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                             }
                         }
                     }
                     getUpdatedCharges();
                 }
                 
             }
             else{
                 for(InventoryCostServices.DiscountWrapper d : pDisc1){
                         if(d.discountType == 'Special Discount'){
                             d.selected = false;
                             d.lumpsum = false;
                             d.lumpsumVal = discountVal;
                             d.applied = false; 
                             d.PerSqFtVal = 0;
                             
                         }
                 }
             }
             
             //system.debug('pDisc1::: '+pDisc1);
             
             showAddCarPark = false;
             q.Project_Unit__c = u.id;
             q.Project__c = proj.id;  
             q.Opportunity__c = o.Id;
               
          }
          }
          
    }
    
    Public void getOldBaseRate(){
          system.debug('inside getOldBaseRate Method: ');
          
                
                q.Modified_Base_Rate__c = null;
                q.IsModified_Base_Rate__c = false; 
                //quoteApprovalMsg = 'N/A';
           
        
    }
    
    public PageReference reloadURL(){
         String sfdcURL =  System.URL.getSalesforceBaseUrl().toExternalForm() + '/'; 
         PageReference pageRef;
            if(string.isNotBlank(subPlanId) && string.isNotBlank(Finished) && string.isNotBlank(SubCharge))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&subPlanId='+subPlanId+'&Finished='+Finished+'&SubCharge='+SubCharge);
            else if(string.isNotBlank(subPlanId) && string.isNotBlank(Finished))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&subPlanId='+subPlanId+'&Finished='+Finished);
            else if(string.isNotBlank(subPlanId) && string.isNotBlank(SubCharge))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&subPlanId='+subPlanId+'&SubCharge='+SubCharge);
            else if( string.isNotBlank(Finished) && string.isNotBlank(SubCharge))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&SubCharge='+SubCharge+'&Finished='+Finished);
            else if(string.isNotBlank(subPlanId))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&subPlanId='+subPlanId);
            else if(string.isNotBlank(Finished))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&Finished='+Finished);
            else if(string.isNotBlank(SubCharge))
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId+'&SubCharge='+SubCharge);
            else
             pageRef = new PageReference(sfdcURL+'apex/Quotation2?id='+u.id+'&oppId='+oppId);
         
         pageRef.setRedirect(true);
         return pageRef;

    }
    
   /* ---------------------------------------------- Vikas Added End here  -------------------------------------------*/ 
 }