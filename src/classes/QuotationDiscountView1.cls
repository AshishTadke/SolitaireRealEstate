public class QuotationDiscountView1 {
public list<Quotation__c> quotationList {
        get;
        set;
    }
    public Project_Unit__c u {
        get;
        set;
    }

    public Quotation__c q {
        get;
        set;
    }

    public Project__c proj {
        get;
        set;
    }
    public Map < String, Decimal > allChargesMap {
        get;
        set;
    }
    public Map < String, Decimal > allChargesMapDisc {
        get;
        set;
    }

    public Map < String, List < QuotationManagementServices.QuoteUIWrapper >> quoteUIMap {
        get;
        set;
    }
    public Map < String, List < QuotationManagementServices.QuoteUIWrapper >> quoteUIMapDisc {
        get;
        set;
    }

    public List < Payment_Plan__c > payPlanList {
        get;
        set;
    }

    public Decimal discountPSF {
        get;
        set;
    }
    public Decimal discountLumpsum {
        get;
        set;
    }
    public Decimal agreementValue {
        get;
        set;
    }

    public Id selectedPlan {
        get;
        set;
    }
    public Boolean editSchedule {
        get;
        set;
    }
    public Boolean scheduleEdited {
        get;
        set;
    }
    public String discountPageMode {
        get;
        set;
    }
    public Boolean disableDiscount {
        get;
        set;
    }
    public Decimal OrignalPlanNPV {
        get;
        set;
    } //this is not used, remove
    public Decimal OriginalPlanNPV {
        get;
        set;
    }
    public Decimal UpdatedPlanNPV {
        get;
        set;
    }
    public Decimal NPVDiffLumpsum {
        get;
        set;
    }
    public Decimal NPVDiffPSF {
        get;
        set;
    }
    public Integer rowNumber {
        get;
        set;
    }
    public String addType {
        get;
        set;
    }
    public String quoteValidity {
        get;
        set;
    }
    public String quoteDate {
        get;
        set;
    }
    public String quoteFor {
        get;
        set;
    }

    public Id quotationId {
        get;
        set;
    } //For Getting Quotation Id 
    public Id unitId {
        get;
        set;
    } //For Getting Opprtunity Id 0--0----    public List < Quotation__c > quotationList = new List < Quotation__c > ();
    public List < ProcessInstanceStep > appdtls = new List < ProcessInstanceStep > ();
    public List < Quotation__C > apprId = new List < Quotation__C > ();
    public List < Customer_Pay_Plan_Header__c > customerPayPlan = new List< Customer_Pay_Plan_Header__c > ();
    public List < wrapperclass> wrapperscppdList{get; set;}
    public List < wrapperclass1> wrapperscppdList1{get; set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> stdCustomerPayPlan {get;set;}
    public QuotationManagementServices QuotationManagementServicesObj = new QuotationManagementServices();
    public string status{get;set;}
    public String OtherChargesTotal{ get; set;}
    public string agreementvalue1{get;set;}
    public string agreementvaluestd{get;set;}
    public string agreementvaluest{get;set;}
    public string agreementvalued{get;set;}
    public string agreementValueTotal{get;set;}
    public string agreementValueDTotal{get;set;}
    public string legalCharges{get;set;}
    public string legalChargesST{get;set;}
    public string legalChargesTotal{get;set;}
    public string stampDuty{get;set;}
    public string stampDutyD{get;set;}
    public string registrationCharges{get;set;}
    public string mvat{get;set;}
    public string mvatST{get;set;}
    public string mvatTotal{get;set;}
    public string mvatd{get;set;}
    public string mvatstd{get;set;}
    public string mvatDTotal{get;set;}
    public string totalPayable{get;set;}
    public string totalPayableST{get;set;}
    public string totalPayableTotal{get;set;}
    public string totalPayabled{get;set;}
    public string totalPayablestd{get;set;}
    public string totalPayableDTotal{get;set;}
    public string clubCharges{get;set;}
    public string clubChargesST{get;set;}
    public string clubChargesTotal{get;set;}
    public string infraCharges{get;set;}
    public string infraChargesST{get;set;}
    public string infraChargesTotal{get;set;}
    public string maintenance{get;set;}    
    public string maintenanceST{get;set;}
    public string maintenanceTotal{get;set;}
    public string utilityCharges{get;set;}
    public string utilityChargesST{get;set;}
    public string utilityChargesTotal{get;set;}
    public string sinkingFunds{get;set;}
    public string totalOtherCharges{get;set;}
    public string totalOtherChargesST{get;set;}
    public string totalOtherChargesTotal{get;set;}
    public string totalOtherChargesd{get;set;}
    public string totalOtherChargesstd{get;set;}
    public string totalOtherChargesDTotal{get;set;}
    public string grandTotal{get;set;}
    public string grandTotalST{get;set;}
    public string grandTotalTotal{get;set;}
    public string grandTotald{get;set;}
    public string grandTotalstd{get;set;}
    public string grandTotalDTotal{get;set;}    
    public wrapperclass wrapperobj { get; set; }   
    public wrapperclass1 wrapperobj1 { get; set; }  
    public string servicetax{get;set;}
    public decimal totalservicetax{get;set;}
    public decimal totalinstallment{get;set;}
    public string installment{get;set;}
    
    public string baseRate{get;set;}
    public string floorRise{get;set;}
    public string devtCharges{get;set;}
    public string totalCardRate{get;set;}
    public string appStdDisc{get;set;}
    public string incrDisc{get;set;}
    public string clientRate{get;set;} 
    public string baseRatel{get;set;}
    public string floorRisel{get;set;}
    public string devtChargesl{get;set;}
    public string totalCardRatel{get;set;}
    public string appStdDiscl{get;set;}
    public string incrDiscl{get;set;}
    public string clientRatel{get;set;} 
    
    public string dType1psf{get;set;}
    public string dType2psf{get;set;}
    public string dType3psf{get;set;}
    public string dType4psf{get;set;}
    public string dType5psf{get;set;}
    public string dType6psf{get;set;}
    public string totalDiscpsf{get;set;}
    public string npvpsf{get;set;}
    
    public string dType1L{get;set;}
    public string dType2L{get;set;}
    public string dType3L{get;set;}
    public string dType4L{get;set;}
    public string dType5L{get;set;}
    public string dType6L{get;set;}
    public string totalDiscL{get;set;}
    public string npvL{get;set;}
    public ProcessInstanceStep pinst{get;set;}
    // New 6 Fields Added - Netra
    public String advanceMaintenance2yrs{get;set;}
    public String advanceMaintenance2yrsST{get;set;}    
    public String advanceMaintenance2yrsTotal{get;set;}
    
    public String shareMoney{get;set;}
    public String shareMoneyST{get;set;}
    public String shareMoneyTotal{get;set;}
    
    public String societyFormation{get;set;}
    public String societyFormationST{get;set;}
    public String societyFormationTotal{get;set;}
        
    public String pinstid {
        get;
        set;
    }
                            
    public Legal_Entity__c le {
        get;
        set;
    }
    Public Time mytime {
        get;
        set;
    }
    public Datetime myDateTime1 {
        get;
        set;
    }
    public String ApproverOneDate {
        get;
        set;
    }
    public String ApproverOneTime {
        get;
        set;
    }
    public String ApproverOneStatus {
        get;
        set;
    }

    public Datetime myDateTime2 {
        get;
        set;
    }
    public String ApproverTwoDate {
        get;
        set;
    }
    public String ApproverTwoTime {
        get;
        set;
    }
    public String ApproverTwoStatus {
        get;
        set;
    }

    public Datetime myDateTime3 {
        get;
        set;
    }
    public String ApproverThreeDate {
        get;
        set;
    }
    public String ApproverThreeTime {
        get;
        set;
    }
    public String ApproverThreeStatus {
        get;
        set;
    }
    public string letterhead{get;set;}   
    
    public List<Charges_Details__c> customCharges {get;set;}
    
    public class wrapperclass
    {
        public String installment{ get; set; }
        public String servicetax { get; set; }
        public String wduedate { get; set; }
        public Date dueDate { get;set; }
        //public List < Customer_Pay_Plan_Header__c > customerPayPlan = new List< Customer_Pay_Plan_Header__c > ();
        public Standard_Customer_Pay_Plan_Detail__c stdCustomerPayPlan {get;set;}
        public wrapperclass(Standard_Customer_Pay_Plan_Detail__c s, Decimal d, Decimal st, Date dd, String type)
        {
            stdCustomerPayPlan = s;
            installment=QuotationManagementServices.INFormat(d);
            servicetax=QuotationManagementServices.INFormat(st);
            If (type == 'Construction Stage')
            {
                wduedate = 'CLP';
            }
            else
            {
                //wduedate = String.ValueOf(dd);
                //system.debug('wduedate xxx Due date: ' + wduedate);
                //wduedate = dd.format('DD/MM/YYYY'); // Old - Commented.
                dueDate = dd;
                system.debug('Due Date :' + dueDate);
               
            }
            //wduedate=QuotationManagementServices.INFormat(dd); // Old - Commented
        }
    }     
    
    public class wrapperclass1
    {
        public String pOwnerId{ get; set; }
        public String pstatus{ get; set; }
        public DATETIME pstatusdate{ get; set; }
        public String  statusDate{ get; set; }
        public ProcessInstanceStep pinstNew {get;set;}
        Public String steps {get;set;}
        public wrapperclass1(ProcessInstanceStep  p1)
        {
            pinstNew = p1;
            pOwnerId = p1.OriginalActor.Name;
            pstatus = p1.StepStatus;
            pstatusdate = p1.CreatedDate;
            statusDate = pstatusdate.format('dd/MM/yyyy');
            steps  = p1.StepNodeId;
        }
    }     
    
    
    // on load page, get all the charges, the flat details and render it on the UI.
    public QuotationDiscountView1() {
        
         if(ApexPages.currentPage().getParameters().get('letterhead') != null)
        {    
            letterhead = ApexPages.currentPage().getParameters().get('letterhead');   
            system.debug('letterhead: ' + letterhead);
        }  
        
        q = new Quotation__c();
        //installment = new List<String>();
        system.debug('Inside The Quotation Constructor');
        if (ApexPages.currentPage().getParameters().get('qId') != null && ApexPages.currentPage().getParameters().get('qId') != '') {
            quotationId = ApexPages.currentPage().getParameters().get('qId');
            system.debug(' Quotation Constructor' + quotationId);
        }
        // For Quotation View Page
        system.debug('Before IF Condition.');
        if (quotationId != null || quotationId != '') 
        {
            
            system.debug('Quotation Id :' + quotationId);
            quotationList = [SELECT Id,Name, Base_Rate_PSF__c, Base_Rate_L__c, Floor_Rise_PSF__c, Floor_Rise_L__c, Development_Charges_PSF__c,
            Development_Charges_L__c, Total_Rate_Card_PSF__c, Total_Rate_Card_L__c, Approved_Standard_Discount_PSF__c, Approved_Standard_Discount_L__c,
            Increment_Discount_PSF__c, Increment_Discount_L__c, Base_Rate_PSF_D__c, Base_Rate_L_D__c,Payment_Plan_Modified__c,
            Discount_1_Type__c, Discount_1_PSF__c, Discount_1_L__c,
            Discount_2_Type__c, Discount_2_PSF__c, Discount_2_L__c,
            Discount_3_Type__c, Discount_3_PSF__c, Discount_3_L__c,
            Discount_4_Type__c, Discount_4_PSF__c, Discount_4_L__c,
            Discount_5_Type__c, Discount_5_PSF__c, Discount_5_L__c,
            Discount_6_Type__c, Discount_6_PSF__c, Discount_6_L__c,
            NPV_Type__c, NPV_PSF__c, NPV_L__c,
            Total_Discount_PSF__c, Total_Discount_L__c,
            Level_One_Approver__r.Name, Level_One_Approver__c, Level_Two_Approver__c, Level_Three_Approver__c,
            Level_Three_Approver__r.Name, Level_Two_Approver__r.Name,
            Current_Approval_Status__c,Approval_Required_on_Discount__c,
            X2_Yr_Advance_Maintenance__c,X2_Yr_Advance_Maintenance_ST__c,Share_Money__c,Share_Money_ST__c,Society_Formation__c,Society_Formation_ST__c,
            //Fields for Quotation View Page...
            Opportunity__c, Opportunity__r.Name, Prepared_Date__c, Valid_Till_Date__c, Project__c,Project__r.Name,Project__r.Address__c,
            Project_Unit__c,Project_Unit__r.Name, Project_Unit__r.Carpet_Area__c, Project_Unit__r.View__c,  FloorNo__c,Appartment_Configuration__c,Carpet_Area_Sq_Ft__c,
            Agreement_Value__c,Registration_Charges__c,Legal_Charges__c,Stamp_Duty__c,MVAT__c,Stamp_Duty_and_Registration_Total__c,
            Agreement_Value_ST__c,  Infrastructure_Charges_ST__c,Club_Membership_ST__c,Common_Area_Maintenance_ST__c,
            Legal_Charges_ST__c,Utility_Charges_ST__c,Service_Taxes_Total__c,Society_Charges_Total__c,Other_Charges_Total__c,
            Grand_Total__c, Infrastructure_charges__c,Club_Membership_Charges__c,Common_Area_Maintenance__c,
            Utility_Charges__c,Sinking_Charges__c,Agreement_Value_ST_D__c,View__c,Opportunity__r.Sales_Manager__c,Project__r.Footer_Image__c,Project__r.Footer_Logo__c,
            Project_Unit__r.TowerName__r.Name,Owner.Name,Project_Unit__r.Unit_Status__c,Project__r.Project_Image__c,No_of_parking__c, Quote_Status__c,
            //For Discount
            Discount_Applied__c,Agreement_Value_D__c,Stamp_Duty_D__c,MVAT_D__c,Stamp_Duty_and_Registration_Total_D__c,
            Service_Taxes_Total_D__c,Grand_Total_D__c,MVAT_ST__c,MVAT_ST_D__c,
            // Fields Form Project Newly Added.
            Project__r.Notes_New__c,Project__r.Terms_and_Condtitions_New__c
            
            FROM Quotation__c WHERE Id = : quotationId];
            system.debug('quotationList : ' + quotationList);
            
            if (quotationList.size() > 0) 
            {
                q = quotationList[0]; 
                if(q.Other_Charges_Total__c != null)
                {
                    OtherChargesTotal = QuotationManagementServices.INFormat(q.Other_Charges_Total__c);
                }    
                if(q.Agreement_Value__c != null)
                {
                    agreementvalue1 = QuotationManagementServices.INFormat(q.Agreement_Value__c);
                }
                if(q.Agreement_Value_ST__c != null)
                {
                    agreementvaluest = QuotationManagementServices.INFormat(q.Agreement_Value_ST__c);
                }
                system.debug('before If condition.' + q.Agreement_Value_D__c);     
                if(q.Agreement_Value_D__c != null)
                {
                    system.debug('Inside If condition.' + q.Agreement_Value_D__c);
                    agreementvalued = QuotationManagementServices.INFormat(q.Agreement_Value_D__c);
                }
                if(q.Agreement_Value_ST_D__c != null)
                {
                    agreementvaluestd = QuotationManagementServices.INFormat(q.Agreement_Value_ST_D__c);
                }
                if((q.Agreement_Value__c + q.Agreement_Value_ST__c) != null)
                {
                    agreementValueTotal = QuotationManagementServices.INFormat(q.Agreement_Value__c + q.Agreement_Value_ST__c);
                }
                if((q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c) != null)
                {
                    agreementValueDTotal = QuotationManagementServices.INFormat(q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c);
    
                if(q.Legal_Charges__c!= null)
                {
                    legalCharges = QuotationManagementServices.INFormat(q.Legal_Charges__c);
                }
                if(q.Legal_Charges_ST__c != null)
                {
                    legalChargesST = QuotationManagementServices.INFormat(q.Legal_Charges_ST__c);
                }
                if(q.Legal_Charges__c!= null && (q.Legal_Charges__c + q.Legal_Charges_ST__c) != null)
                {
                    legalChargesTotal = QuotationManagementServices.INFormat(q.Legal_Charges__c + q.Legal_Charges_ST__c);
                }
                if(q.Stamp_Duty__c != null)
                {
                    stampDuty = QuotationManagementServices.INFormat(q.Stamp_Duty__c);
                }
                if(q.Stamp_Duty_D__c != null)
                {
                    stampDutyD = QuotationManagementServices.INFormat(q.Stamp_Duty_D__c);
                }
                if(q.Registration_Charges__c != null)
                {
                    registrationCharges = QuotationManagementServices.INFormat(q.Registration_Charges__c);
                }
                if(q.MVAT__c != null)
                {
                    mvat = QuotationManagementServices.INFormat(q.MVAT__c);
                }
                if(q.MVAT_ST__c != null)
                {
                    mvatST = QuotationManagementServices.INFormat(q.MVAT_ST__c);
                }
                if(q.MVAT__c!= null  && (q.MVAT__c + q.MVAT_ST__c)!= null)
                {
                    mvatTotal = QuotationManagementServices.INFormat(q.MVAT__c + q.MVAT_ST__c);
                }
                if(q.MVAT_D__c != null)
                {
                    mvatd = QuotationManagementServices.INFormat(q.MVAT_D__c);
                }
                if(q.MVAT_ST_D__c != null)
                {
                    mvatstd = QuotationManagementServices.INFormat(q.MVAT_ST_D__c);
                }
                if(q.MVAT_D__c != null && (q.MVAT_D__c + q.MVAT_ST_D__c) != null)
                {
                    mvatDTotal  = QuotationManagementServices.INFormat(q.MVAT_D__c + q.MVAT_ST_D__c);
                }
                System.debug('Agreement Value:' + q.Agreement_Value__c);
                System.debug('Legal Charges:' + q.Legal_Charges__c);
                if((q.Agreement_Value__c +q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c) != null)
                {
                    System.debug('After 429:');
                    totalPayable = QuotationManagementServices.INFormat(q.Agreement_Value__c +q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c);
                }
                if((q.Agreement_Value_ST__c+q.Legal_Charges_ST__c+q.MVAT_ST__c) != null)
                {
                    totalPayableST = QuotationManagementServices.INFormat(q.Agreement_Value_ST__c+q.Legal_Charges_ST__c+q.MVAT_ST__c);
                }
                if((q.Agreement_Value__c + q.Agreement_Value_ST__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c + q.MVAT_ST__c)!= null)
                {
                    totalPayableTotal = QuotationManagementServices.INFormat(q.Agreement_Value__c + q.Agreement_Value_ST__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c + q.MVAT_ST__c);
                }
                if((q.Agreement_Value_D__c+q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c)!= null)
                {
                    totalPayabled = QuotationManagementServices.INFormat(q.Agreement_Value_D__c+q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c);
                }
                if((q.Agreement_Value_ST_D__c+q.Legal_Charges_ST__c+q.MVAT_ST_D__c) != null)
                {
                    totalPayablestd = QuotationManagementServices.INFormat(q.Agreement_Value_ST_D__c+q.Legal_Charges_ST__c+q.MVAT_ST_D__c);
                }
                if((q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c + q.MVAT_ST_D__c) != null)
                {
                    totalPayableDTotal = QuotationManagementServices.INFormat(q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c + q.MVAT_ST_D__c);
                }
                if(q.Club_Membership_Charges__c != null)
                {
                    clubCharges = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c);
                }
                if(q.Club_Membership_ST__c != null)
                {
                    clubChargesST = QuotationManagementServices.INFormat(q.Club_Membership_ST__c);
                }
                if(q.Club_Membership_Charges__c + q.Club_Membership_ST__c != null)
                {
                    clubChargesTotal = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c + q.Club_Membership_ST__c);
                }
                if(q.Infrastructure_charges__c!= null)
                { 
                    infraCharges = QuotationManagementServices.INFormat(q.Infrastructure_charges__c);
                }
                if(q.Infrastructure_Charges_ST__c!= null)
                {
                    infraChargesST = QuotationManagementServices.INFormat(q.Infrastructure_Charges_ST__c);
                }
                if((q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c) != null)
                {
                    infraChargesTotal = QuotationManagementServices.INFormat(q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c);
                }
                if(q.Common_Area_Maintenance__c != null)
                {
                    maintenance = QuotationManagementServices.INFormat(q.Common_Area_Maintenance__c);
                }
                if(q.Common_Area_Maintenance_ST__c != null)
                {
                    maintenanceST = QuotationManagementServices.INFormat(q.Common_Area_Maintenance_ST__c);
                }
                if((q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c)!= null)
                {
                    maintenanceTotal = QuotationManagementServices.INFormat(q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c);
                }
                if(q.Utility_Charges__c !=null)
                {
                    utilityCharges = QuotationManagementServices.INFormat(q.Utility_Charges__c);
                }
                if(q.Utility_Charges_ST__c !=null)
                {
                    utilityChargesST = QuotationManagementServices.INFormat(q.Utility_Charges_ST__c);
                }
                if((q.Utility_Charges__c+q.Utility_Charges_ST__c) !=null)
                {
                    utilityChargesTotal = QuotationManagementServices.INFormat(q.Utility_Charges__c+q.Utility_Charges_ST__c);
                }
                if(q.Sinking_Charges__c !=null)
                {
                    sinkingFunds = QuotationManagementServices.INFormat(q.Sinking_Charges__c);
                }
                if((q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c) !=null)
                {
                    totalOtherCharges = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c);
                }
                if((q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c) !=null)
                { 
                    totalOtherChargesST = QuotationManagementServices.INFormat(q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c);
                }
                if((q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c) !=null)
                {
                    totalOtherChargesTotal = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c);
                }
                if((q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c) !=null)
                {
                    totalOtherChargesd = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c);
                }
                if((q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c) !=null)
                {
                    totalOtherChargesstd = QuotationManagementServices.INFormat(q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c);
                }
                if((q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c) !=null)
                {
                    totalOtherChargesDTotal = QuotationManagementServices.INFormat(q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c);
                }
                if((q.Agreement_Value__c +q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c+q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c) !=null)
                {
                    grandTotal = QuotationManagementServices.INFormat(q.Agreement_Value__c +q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c+q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c);
                }
                if((q.Agreement_Value_ST__c+q.Legal_Charges_ST__c+q.MVAT_ST__c+q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c) !=null)
                {
                    grandTotalST = QuotationManagementServices.INFormat(q.Agreement_Value_ST__c+q.Legal_Charges_ST__c+q.MVAT_ST__c+q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c);
                }
                if((q.Agreement_Value__c + q.Agreement_Value_ST__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c + q.MVAT_ST__c+q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c) !=null)
                {
                    grandTotalTotal = QuotationManagementServices.INFormat(q.Agreement_Value__c + q.Agreement_Value_ST__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT__c + q.MVAT_ST__c+q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c);
                }
                if((q.Agreement_Value_D__c+q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c+q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c) !=null)
                {
                    grandTotald = QuotationManagementServices.INFormat(q.Agreement_Value_D__c+q.Legal_Charges__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c+q.Club_Membership_Charges__c+q.Infrastructure_charges__c+q.Utility_Charges__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c);
                }
                if((q.Agreement_Value_ST_D__c+q.Legal_Charges_ST__c+q.MVAT_ST_D__c+q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c) !=null)
                {
                    grandTotalstd = QuotationManagementServices.INFormat(q.Agreement_Value_ST_D__c+q.Legal_Charges_ST__c+q.MVAT_ST_D__c+q.Club_Membership_ST__c+q.Infrastructure_Charges_ST__c+q.Utility_Charges_ST__c+q.Common_Area_Maintenance_ST__c);
                }
                if((q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c + q.MVAT_ST_D__c+q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c) !=null)
                {    
                    grandTotalDTotal = QuotationManagementServices.INFormat(q.Agreement_Value_D__c + q.Agreement_Value_ST_D__c+q.Legal_Charges__c + q.Legal_Charges_ST__c+q.Stamp_Duty__c+q.Registration_Charges__c+q.MVAT_D__c + q.MVAT_ST_D__c+q.Club_Membership_Charges__c + q.Club_Membership_ST__c+q.Infrastructure_charges__c + q.Infrastructure_Charges_ST__c+q.Utility_Charges__c+q.Utility_Charges_ST__c+q.Sinking_Charges__c+q.Common_Area_Maintenance__c + q.Common_Area_Maintenance_ST__c);
                }
                //For Quotaion Discount View Page  
                if(q.Base_Rate_PSF__c != null)
                {              
                    baseRate = QuotationManagementServices.INFormat(q.Base_Rate_PSF__c);
                }   
                if(q.Floor_Rise_PSF__c != null)
                {
                    floorRise = QuotationManagementServices.INFormat(q.Floor_Rise_PSF__c);
                }   
                if(q.Development_Charges_PSF__c != null)
                { 
                    devtCharges = QuotationManagementServices.INFormat(q.Development_Charges_PSF__c);
                }
                if(q.Total_Rate_Card_PSF__c != null)
                {
                    totalCardRate = QuotationManagementServices.INFormat(q.Total_Rate_Card_PSF__c);
                }
                if(q.Approved_Standard_Discount_PSF__c != null)
                {
                    appStdDisc = QuotationManagementServices.INFormat(q.Approved_Standard_Discount_PSF__c);
                }
                if(q.Increment_Discount_PSF__c != null)
                {    
                    incrDisc = QuotationManagementServices.INFormat(q.Increment_Discount_PSF__c);
                }
                if(q.Base_Rate_PSF_D__c != null)   
                { 
                    clientRate = QuotationManagementServices.INFormat(q.Base_Rate_PSF_D__c);
                }
                
                
                if(q.Base_Rate_L__c != null)
                {              
                    baseRatel = QuotationManagementServices.INFormat(q.Base_Rate_L__c);
                }   
                if(q.Floor_Rise_L__c != null)
                {
                    floorRisel = QuotationManagementServices.INFormat(q.Floor_Rise_L__c);
                }   
                if(q.Development_Charges_L__c != null)
                { 
                    devtChargesl = QuotationManagementServices.INFormat(q.Development_Charges_L__c);
                }
                if(q.Total_Rate_Card_L__c != null)
                {
                    totalCardRatel = QuotationManagementServices.INFormat(q.Total_Rate_Card_L__c);
                }
                if(q.Approved_Standard_Discount_L__c != null)
                {
                    appStdDiscl = QuotationManagementServices.INFormat(q.Approved_Standard_Discount_L__c);
                }
                if(q.Increment_Discount_L__c != null)
                {    
                    incrDiscl = QuotationManagementServices.INFormat(q.Increment_Discount_L__c);
                }
                if(q.Base_Rate_L_D__c != null)   
                { 
                    clientRatel = QuotationManagementServices.INFormat(q.Base_Rate_L_D__c);
                }
                if(q.Discount_1_PSF__c != null)
                {
                    dType1psf = QuotationManagementServices.INFormat(q.Discount_1_PSF__c);
                }
                if(q.Discount_2_PSF__c != null)
                {
                    dType2psf = QuotationManagementServices.INFormat(q.Discount_2_PSF__c);
                }
                if(q.Discount_3_PSF__c != null)
                {
                    dType3psf = QuotationManagementServices.INFormat(q.Discount_3_PSF__c);
                }
                if(q.Discount_4_PSF__c != null)
                {
                    dType4psf = QuotationManagementServices.INFormat(q.Discount_4_PSF__c);
                }
                if(q.Discount_5_PSF__c != null)
                {
                    dType5psf = QuotationManagementServices.INFormat(q.Discount_5_PSF__c);
                }
                if(q.Discount_6_PSF__c != null)
                {
                    dType6psf = QuotationManagementServices.INFormat(q.Discount_6_PSF__c);
                }
                if(q.Total_Discount_PSF__c != null)
                {
                    totalDiscpsf = QuotationManagementServices.INFormat(q.Total_Discount_PSF__c);
                }
                if(q.NPV_PSF__c != null)
                {
                    npvpsf = QuotationManagementServices.INFormat(q.NPV_PSF__c);
                }
                //
                if(q.Discount_1_L__c != null)
                {
                    dType1L = QuotationManagementServices.INFormat(q.Discount_1_L__c);
                }
                if(q.Discount_2_L__c != null)
                {
                    dType2L = QuotationManagementServices.INFormat(q.Discount_2_L__c);
                }
                if(q.Discount_3_L__c != null)
                {
                    dType3L = QuotationManagementServices.INFormat(q.Discount_3_L__c);
                }
                if(q.Discount_4_L__c != null)
                {
                    dType4L = QuotationManagementServices.INFormat(q.Discount_4_L__c);
                }
                if(q.Discount_5_L__c != null)
                {
                    dType5L = QuotationManagementServices.INFormat(q.Discount_5_L__c);
                }
                if(q.Discount_6_L__c != null)
                {
                    dType6L = QuotationManagementServices.INFormat(q.Discount_6_L__c);
                }
                if(q.Total_Discount_L__c != null)
                {
                    totalDiscL = QuotationManagementServices.INFormat(q.Total_Discount_L__c);
                }
                if(q.NPV_L__c != null)
                {
                    npvL = QuotationManagementServices.INFormat(q.NPV_L__c);
                }
                ///////////// New 3 - 3ST Fields added by Netra 23/03/2016
                Decimal twoYrAdvTotalD = 0;
                Decimal shareMoneyTotalD = 0;
                Decimal societyFormationTotalD = 0;
                
                if(q.X2_Yr_Advance_Maintenance__c != null)
                {
                    advanceMaintenance2yrs = QuotationManagementServices.INFormat(q.X2_Yr_Advance_Maintenance__c);
                    twoYrAdvTotalD = q.X2_Yr_Advance_Maintenance__c;
                }
                if(q.X2_Yr_Advance_Maintenance_ST__c != null)
                {
                    advanceMaintenance2yrsST = QuotationManagementServices.INFormat(q.X2_Yr_Advance_Maintenance_ST__c);
                    twoYrAdvTotalD += q.X2_Yr_Advance_Maintenance_ST__c;
                }
                if(twoYrAdvTotalD > 0)
                    advanceMaintenance2yrsTotal = QuotationManagementServices.INFormat(twoYrAdvTotalD);
                    
                if(q.Share_Money__c != null)
                {
                    shareMoney = QuotationManagementServices.INFormat(q.Share_Money__c);
                    shareMoneyTotalD = q.Share_Money__c;
                }
                if(q.Share_Money_ST__c != null)
                {
                    shareMoneyST = QuotationManagementServices.INFormat(q.Share_Money_ST__c);
                    shareMoneyTotalD += q.Share_Money_ST__c;
                }
                
                if(shareMoneyTotalD > 0)
                {
                    shareMoneyTotal = QuotationManagementServices.INFormat(shareMoneyTotalD);
                }

                if(q.Society_Formation__c != null)
                {
                    societyFormation = QuotationManagementServices.INFormat(q.Society_Formation__c);
                    societyFormationTotalD = q.Society_Formation__c;
                }
                if(q.Society_Formation_ST__c != null)
                {
                    societyFormationST = QuotationManagementServices.INFormat(q.Society_Formation_ST__c);
                    societyFormationTotalD += q.Society_Formation_ST__c;
                }
                if(societyFormationTotalD > 0 )
                {
                    societyFormationTotal = QuotationManagementServices.INFormat(societyFormationTotalD);
                }
                
                    
                system.debug('agreementValueTotal: '+agreementValueTotal);
                /*
                if(q.Approval_Required_on_Discount__c == false)
                {
                  q.Current_Approval_Status__c = 'Approval Not Required';  
                }
                */
                system.debug('Outside If');
                if(q.Current_Approval_Status__c == 'Approved' || (q.Approval_Required_on_Discount__c == false && q.Payment_Plan_Modified__c == false))
                {
                    system.debug('inside 1st If');
                    q.Current_Approval_Status__c = 'Approved';
                    system.debug('Status 1 - ' + q.Current_Approval_Status__c);
                }
                if(q.Current_Approval_Status__c != 'Approved' && (q.Approval_Required_on_Discount__c == true || q.Payment_Plan_Modified__c == true))
                {
                    system.debug('inside 2nd If');
                    q.Current_Approval_Status__c = 'Internal Approval Pending on Quotation';
                    system.debug('Status 2 - ' + q.Current_Approval_Status__c);
                }
                
            }
        
             
            system.debug('All Quotation Details : ' + q);
            system.debug('APP Dtls : ' + appdtls);
            Map < Id, ProcessInstanceStep > m = new Map < Id, ProcessInstanceStep > ();
           /* for (ProcessInstanceStep pi: [Select OriginalActorId, CreatedDate, StepStatus
            From ProcessInstanceStep where ProcessInstance.TargetObjectId = : quotationId and StepStatus = 'Approved']) {
                system.debug(pi);
                if (m.get(pi.OriginalActorId) == null) {
                    m.put(pi.OriginalActorId, pi);
                }
            } */
            for (ProcessInstanceStep pi: [Select OriginalActorId, CreatedDate, StepStatus
            From ProcessInstanceStep where ProcessInstance.TargetObjectId = : quotationId ]) {
                system.debug(pi);
                if (m.get(pi.OriginalActorId) == null) {
                    m.put(pi.OriginalActorId, pi);
                }
            }
            
            System.Debug('Before the ifs');
            if (m.get(q.Level_One_Approver__c) != null) {
                System.Debug('inside level 1');
                myDateTime1 = m.get(q.Level_One_Approver__c).CreatedDate;
                ApproverOneDate = myDateTime1.format('dd/MM/yyyy');
                ApproverOneTime = myDateTime1.format('h:mm a', 'GMT+05:30');
                ApproverOneStatus  = m.get(q.Level_One_Approver__c).StepStatus;
                system.debug('ApproverOneTime:' + ApproverOneTime);             
            }
            if (m.get(q.Level_Two_Approver__c) != null) {
                System.Debug('inside level 2');
                myDateTime2 = m.get(q.Level_Two_Approver__c).CreatedDate;
                ApproverTwoDate = myDateTime2.format('dd/MM/yyyy');
                ApproverTwoStatus = m.get(q.Level_Two_Approver__c).StepStatus;
                ApproverTwoTime = myDateTime2.format('h:mm a', 'GMT+05:30');
            }
            if (m.get(q.Level_Three_Approver__c) != null) {
                System.Debug('inside level 3');
                myDateTime3 = m.get(q.Level_Three_Approver__c).CreatedDate;
                System.Debug('MyDateTime3 :' + myDateTime3);
                ApproverThreeDate = myDateTime3.format('dd/MM/yyyy');
                ApproverThreeStatus = m.get(q.Level_Three_Approver__c).StepStatus;
                ApproverThreeTime = myDateTime3.format('h:mm a', 'GMT+05:30');             
            }
            system.debug('MAP: ' + m);
            
            // Customer Payment Plan 
            customerPayPlan = [SELECT Id,Global_Charges__c,Quotation__C FROM Customer_Pay_Plan_Header__c WHERE Quotation__c = :quotationId and Global_Charge_Name__c= 'Basic'];
            system.debug('customerPayPlan : '+customerPayPlan );
            
            wrapperscppdList = new List<wrapperclass>();
            if(customerPayPlan.size()>0)
            {
                stdCustomerPayPlan = [SELECT Is_to_be__c,Due_Date__c,Is_to_be_Paid__c, Amount_Value__c,value__c,Installment__c,Customer_Pay_Plan_Header__c, 
                Service_Tax_Amount_Q__c FROM Standard_Customer_Pay_Plan_Detail__c Where Customer_Pay_Plan_Header__c =:customerPayPlan[0].Id ];                                   
            }
            totalservicetax=0;
            totalinstallment=0;
            for (integer i = 0 ; i < stdCustomerPayPlan.size() ; i++)
            {
                stdCustomerPayPlan[i].value__c = stdCustomerPayPlan[i].value__c.replace(' of Total Charge Value', '');
                wrapperscppdList.add(new wrapperclass(stdCustomerPayPlan[i], stdCustomerPayPlan[i].Installment__c, stdCustomerPayPlan[i].Service_Tax_Amount_Q__c,stdCustomerPayPlan[i].Due_Date__c,stdCustomerPayPlan[i].Is_to_be_Paid__c ));
                totalinstallment += stdCustomerPayPlan[i].Installment__c;
                totalservicetax += stdCustomerPayPlan[i].Service_Tax_Amount_Q__c;
            } 
            system.debug('totalservicetax : '+ totalservicetax);
            servicetax = QuotationManagementServices.INFormat(totalservicetax);
            installment = QuotationManagementServices.INFormat(totalinstallment);
            system.debug(totalinstallment);
            system.debug('servicetax: ' + servicetax);
            if(q.Project_Unit__c != null)
            {
                 le = InventoryCostServices.getLegalEntityDetails(q.Project_Unit__c, q.Project__c);
                 System.debug('leeeeeeee '+le);
                 if(le != null)
                 {
                     system.debug('Inside LE: ' + le);                   
                 }
            }
            ///Anuja Added for fetching approval details///
            LIST <ProcessInstanceStep> pinst = [SELECT OriginalActor.Name ,Actor.Name,StepNodeId,CreatedDate, StepStatus
            FROM ProcessInstanceStep WHERE ProcessInstance.TargetObjectId = : quotationId];
            system.debug('All ProcessInstanceStep  : ' +pinst );     
            wrapperscppdList1 = new List<wrapperclass1>();
            if(pinst.size() > 0)
            {
                for (integer i = 0 ; i < pinst.size() ; i++)
                {
                    wrapperscppdList1.add(new wrapperclass1(pinst[i]));       
                } 
            }  
        }
        
        
        ///Anuja Added for fetching custom names for charges///
        // Custom settings
            customCharges = [SELECT Legal_Charges__c,One_yr_Maintenance__c,Club_Membership__c,Infrastructure_Charges__c,MVAT_1__c,Registration_Charges__c,Sinking_Funds__c,Stamp_Duty_5__c,Utility_Charges__c,X2_Yr_Advance_Maintenance__c,X2_Yr_Advance_Maintenance_ST__c,
                                Share_Money__c,Share_Money_ST__c,Society_Formation__c,Society_Formation_ST__c FROM Charges_Details__c];
         if(customCharges.size() > 0)
         {
               system.debug('size of custom charges:- '+ customCharges.size());
               system.debug('customCharges[0].Legal_Charges__c Netraxxx: ' + customCharges[0].Legal_Charges__c);
               system.debug('customCharges[0].Share_Money__c Netraxxx: ' + customCharges[0].Share_Money__c);
               system.debug('customCharges[0].Society_Formation__c Netraxxx: ' + customCharges[0].Society_Formation__c);
               system.debug('customCharges[0].X2_Yr_Advance_Maintenance__c Netraxxx: ' + customCharges[0].X2_Yr_Advance_Maintenance__c);
               system.debug('customCharges : ' + customCharges);
         }
     }
  }  
}