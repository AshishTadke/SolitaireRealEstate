public with sharing class PriceSheetXanadu
 {
    ApexPages.StandardController controller;
    public Quotation__c q {get; set;}
    public Id qid {get;set;}
    public List < Quotation__c > qList {get;set;}
    public Legal_Entity__c le {get;set;}
    public Project__c proj {get; set;}
    public Decimal totalRate{get;set;}
    public Decimal flatCost{get;set;}
    public Decimal total{get;set;}
    public decimal FloorRise{get;set;}
    public Decimal baseRate {get;set;}  
    public Decimal stampDuty {get;set;}
    public Decimal registrationCharges {get;set;}
    public Decimal mVat {get;set;}
    public Decimal infraCharges {get;set;}
    public Decimal developmentCharges {get;set;}
    //public Decimal serviceTax {get;set;}
    public Decimal projectMaintenance {get;set;}
    public Decimal subTotal1 {get;set;}
    public Decimal subTotal2 {get;set;}
    public Decimal subTotal3 {get;set;}
    public Decimal subTotal4 {get;set;}        
    public Decimal discountAmt {get;set;}
    public List <Standard_Customer_Pay_Plan_Detail__c> scppListForBasic {get;set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> scppListForRegst{get;set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> scppListForOther{get;set;}
    public string construction {get;set;}
    public Decimal TotalGSTnAV {get;set;}
    public Decimal GovernmentCharges{get;set;}
    public Decimal totalcost{get;set;}
    public List<Project_Charges__c> projcharges{get;set;}
    public Decimal stamppercentage {get;set;}
    public Decimal MVATpercentage{get;set;}
    public Decimal msebcharges{get;set;}
    public Decimal stampcharge{get;set;}
    public Decimal MVATcharge{get;set;}
    public Decimal AggrementDisvalue{get;set;}
    public List<MainWrapper> mwList{get;set;}  
    public Decimal totalOtherChrgs{get;set;}
    public Decimal stampTotal{get;set;}
    public Decimal basicTotal{get;set;}
    public Decimal otherTotal{get;set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> newRecordList{get;set;}
    public List < wrapperclass > wrapperList{get; set;}
    public string baseRatePsf{get;set;}
    public string floorRisePsf{get;set;}
    public string baseRateString{get;set;}
    public string floorRise_L{get;set;}
    public string floorRisestr{get;set;}
    public string totalInString{get;set;} 
    public string parkingInfraCharges{get;set;} 
    public string agreementValue{get;set;} 
    public string agreementValue_D{get;set;}
    public string stampTotalInString{get;set;} 
    public string stampchargeInString{get;set;} 
    public string MVATchargeInstring{get;set;}  
    public string ServiceTaxesTotal{get;set;} 
    public string RegistrationChargesInstring{get;set;}  
    public string totalcostInstring{get;set;}
    public string AggrementDisvalueInString{get;set;} 
    public string otherTotalInString{get;set;}
    public string CustName {get;set;}
    public string MSEBDevChrge {get;set;}
    public decimal serTax{get;set;}
    Public string CentralGST{get;set;}
    Public string StateGST{get;set;}
    Public string LegalCharges{get;set;} 
    Public string Premiumcharges{get;set;}
    Public string Premiumcharges1{get;set;}
    Public string Premiumcharges2{get;set;}
    Public String SubTotal2New{get;set;}
    Public String SubTotal2New2{get;set;}
    Public String SubTotal2Homes{get;set;}
    Public String SubTotal2Shah{get;set;}
    Public Decimal gstonCV{get;set;}
    Public string gstonCVString{get;set;} 
    Public string subtotal4New{get;set;}
    Public Decimal Actualarea {get;set;}
    Public string subtotal3New{get;set;}
    Public string MaintanceChargeString{get;set;}
    Public String AdvanceMaintance{get;set;}
    Public String ActualAreaMeterString{get;set;}
    Public String totalOtherChrgsString{get;set;}
    Public String OtherchargesGSTString{get;set;}
    Public Decimal OtherchargesGST{get;set;}
    Public Decimal Alltotal{get;set;}
    Public String Alltotalstring{get;set;}
    Public Decimal Alltotal2{get;set;}
    Public String Alltotalstring2{get;set;}
    Public Decimal AlltotalHomes{get;set;}
    Public String AlltotalHomesString{get;set;}
    Public Decimal AlltotalShah{get;set;}
    Public String AlltotalShahString{get;set;}
    Public Decimal Considerationvalue{get;set;}
    Public String Considerationvaluestring{get;set;}
    Public Decimal listsize{get;set;}
    Public String AccountName{get;set;}
    Public String LegalEntityName{get;set;}
    Public Decimal CarpetArea{get;set;}
    Public String InfrastructureCharges{get;set;}
    Public String CgstonCVstring{get;set;}
    Public String SgstonCVstring{get;set;}
    Public String TotalGST{get;set;}
    Public Decimal totalIndependent{get;set;}
    Public Decimal totalDdependent{get;set;}
    Public Decimal totalStack{get;set;}
    Public Decimal totalPuzzle{get;set;}
    Public Decimal totalDependableStack{get;set;}
    Public Decimal totalTwoWheeler{get;set;}
    public Decimal Amenitycharges{get;set;}
    Public String AmenitychargesStr{get;set;}
    public Decimal Subventioncharges{get;set;}
    Public String SubventionchargesStr{get;set;}
    public Decimal Finishedcharges{get;set;}
    Public String FinishedchargesStr{get;set;}public Decimal EOI{get;set;}
    Public String EOIStr{get;set;}
    public Decimal InfrastructureAndDevelopment{get;set;}
    Public String InfrastructureAndDevelopmentStr{get;set;}
   
   
    
    
       // ----- Wrapper Class -----
    public class wrapperclass
    {
         public Standard_Customer_Pay_Plan_Detail__c scppd {get;set;}
         public String isToBePaid1{get;set;}
         public Decimal installment1{get;set;}
         public Decimal percentageval{get;set;}
         public string constructionstage{get;set;}
         public String newvar{get;set;}
         public Decimal GST{get;set;}
         public Decimal TotalGSTnAV{get;set;}
         public String PaidBy{get;set;}
       
         public wrapperclass(Standard_Customer_Pay_Plan_Detail__c newRecord,String isToBePaid,Decimal installment, Decimal percentage, String constructionstageName,Decimal GST,Decimal TotalGSTnAV,String PaidBy)
         {
                 scppd = newRecord;
                 
                 if(constructionstageName != ''){
                 isToBePaid1 = constructionstageName;                
                 }else{
                 system.debug('isToBePaid'+isToBePaid);
                 system.debug('constructionstageName'+constructionstageName);
                 isToBePaid1 = isToBePaid;              
                 }
                 
                 installment1 = installment;
                 percentageval = percentage;              
               //  system.debug('constructionstage'+ constructionstageName);
         } 
    }
    
    
    public PriceSheetXanadu(ApexPages.StandardController controller)
    {
        AggrementDisvalue=0;
        MVATcharge=0;
        stampcharge=0;
        msebcharges=0;
        stamppercentage =0;
        MVATpercentage=0;
        projcharges = new List<Project_Charges__c>();
        System.Debug('Inside Contructor');
        qList = new List < Quotation__c >();
        totalRate = 0;
        GovernmentCharges=0;
        totalcost=0;
        flatCost = 0;
        floorrise=0;
        total =0;
        baseRate = 0;       
        stampDuty = 0;
        registrationCharges = 0;
        mVat = 0;
        infraCharges = 0;
        developmentCharges = 0;
        projectMaintenance = 0;
        subTotal1 = 0;
        subTotal2 = 0;
        subTotal3 = 0;
        subTotal4 = 0;
        discountAmt = 0;
        mwList = new List<MainWrapper>();
        totalOtherChrgs = 0;
        stampTotal = 0;
        basicTotal = 0;
        otherTotal = 0;
        baseRatePsf = '';
        floorRisePsf = '';
        baseRateString = '';
        floorRise_L = '';
        floorrisestr = '';
        totalInString = '';
        parkingInfraCharges = '';
        agreementValue = '';
        agreementValue_D = '';
        stampTotalInString = '';
        stampchargeInString = '';
        MVATchargeInstring = '';
        ServiceTaxesTotal = '';
        RegistrationChargesInstring = '';
        totalcostInstring = '';
        AggrementDisvalueInString = '';
        otherTotalInString = '';
        CustName = '';
        serTax = 0;
        CentralGST='';
        LegalCharges ='';
        StateGST='';
        Premiumcharges='';
        Premiumcharges1='';
        Premiumcharges2='';      
        SubTotal2New='';
        SubTotal2New2='';
        SubTotal2Homes ='';
        SubTotal2Shah =' ';
        gstonCV = 0;
        gstonCVstring = '';
        subtotal4New = '';
        subtotal3New = '';
        MaintanceChargeString='';
        AdvanceMaintance='';
        ActualAreaMeterString='';
        totalOtherChrgsString='';
        OtherchargesGST=0;
        OtherchargesGSTstring= '';
        Alltotal=0;
        Alltotalstring='';
        Alltotal2=0;
        Alltotalstring2='';
        AlltotalHomes=0;
        AlltotalHomesString='';
        Considerationvaluestring = '';
        Considerationvalue = 0;
        listsize=0;
        AccountName='';
        LegalEntityName='';
        CarpetArea=0;
        InfrastructureCharges='';
        TotalGST ='';
        totalIndependent =0;
        totalDdependent =0;
        totalStack =0;       
        totalPuzzle =0;
        totalDependableStack =0;
        totalTwoWheeler =0;
        Amenitycharges =0;
        AmenitychargesStr = '';
        Subventioncharges =0;
        SubventionchargesStr = '';
        Finishedcharges =0;
        FinishedchargesStr = '';
        EOI =0;
        EOIStr = '';
        InfrastructureAndDevelopment =0;
        InfrastructureAndDevelopmentStr = '';
        
        
     //   system.debug('controller : ' + controller);
        this.controller = controller;
      //  system.debug('this.controller : ' + this.controller);
        q = (Quotation__c)controller.getRecord();
      //  system.debug('(Quotation__c)controller.getRecord() : ' + (Quotation__c)controller.getRecord());
       
        qid = ApexPages.currentPage().getParameters().get('qId');
        
       // system.debug('Qtn ID : '  + ApexPages.currentPage().getParameters().get('qId'));
      //  system.debug('qid : ' + qid);
      //  System.debug('Quotation__c cccc:' + q);
      
      
      
      
        if(qid != null || q.Id !=null)
        {
            system.debug('qid  : ' + qid );
            system.debug('ONLY q  : ' + q );
            qList = [SELECT Id,Name,Saleable__c,Project_Unit__r.Id,Project_Unit__r.Chargeable_Area__c,Amenity_Charge__c,Project_Unit__r.Actual_Area_value__c,Project__c,Project__r.Id,Project__r.Name,Prepared_Date__c,Zone__c,Wing__c,Appartment_Configuration__c,FloorNo__c,FloorNo1__c,Project_Unit__c,
                    Project_Unit__r.Name,Base_Rate_PSF__c,Base_Rate_L__c,Premium_Charges_Description_1__c,Premium_Charges_Description_2__c,Premium_Charges_Description_3__c,
                    Premium_Charges_Description_4__c,Premium_Charges_Amount_1__c,Premium_Charges_Amount_2__c,Premium_Charges_Amount_3__c,Premium_Charges_Amount_4__c,Project__r.Tearms_and_Conditions__c,Project__r.Terms_and_Condtitions_New__c,
                    Floor_Rise_PSF__c,Floor_Rise_L__c,Carpet_Area_Sq_Ft__c,Infrastructure_charges__c,Development_Charges_PSF__c,Development_Charges_L__c,
                    Stamp_Duty__c,Stamp_Duty_D__c,Registration_Charges__c,MVAT__c,MVAT_ST__c,MVAT_D__c,MVAT_ST_D__c,Service_Taxes_Total__c,Service_Taxes_Total_D__c,
                    Project_Specific_Charges_Amount_1__c,Project_Specific_Charges_Amount_2__c,Project_Specific_Charges_Amount_3__c,Project_Specific_Charges_Description_1__c,
                    Project_Specific_Charges_Description_2__c,Project_Specific_Charges_Description_3__c,Legal_Charges__c,Legal_Charges_ST__c,Club_Membership_Charges__c,Club_Membership_ST__c,
                    Other_Charges_Amount_1__c,Other_Charges_Amount_2__c,Other_Charges_Amount_3__c,Other_Charges_Category_1__c,Other_Charges_Category_2__c,Other_Charges_Category_3__c,
                    Other_Charges_Desc_1__c,Other_Charges_Desc_2__c,Other_Charges_Desc_3__c,Other_Charges_Desc_4__c,Quote_Status__c,
                    Other_Charges_Desc_5__c,Other_Charges_Desc_6__c,Other_Charges_Desc_7__c,Other_Charges_Desc_8__c,Other_Charges_Desc_9__c,Other_Charges_Desc_10__c,
                    Other_Charges_Desc_11__c,Other_Charges_Desc_12__c,Other_Charges_Desc_13__c,Other_Charges_Desc_14__c,Other_Charges_Amount_4__c,Other_Charges_Amount_5__c,Other_Charges_Amount_6__c,
                    Other_Charges_Amount_7__c,Other_Charges_Amount_8__c,Other_Charges_Amount_9__c,Other_Charges_Amount_10__c,Other_Charges_Amount_11__c,Other_Charges_Amount_12__c,
                    Other_Charges_Amount_13__c,Other_Charges_Amount_14__c,Proj_Maint_Charges_Desc_1__c,Proj_Maint_Charges_Desc_2__c,Proj_Maint_Charges_Desc_3__c,Project_Maintenance_Charges_Amount_1__c,
                    Project_Maintenance_Charges_Amount_2__c,Project_Maintenance_Charges_Amount_3__c,Service_Tax_Total__c,Discount_1_Type__c,Discount_2_Type__c,Discount_1_PSF__c,Discount_1_L__c,Discount_2_PSF__c,Discount_2_L__c,Other_Charges_Category_14__c,Finished_Unfinished__c,
                    Other_Charges_Category_13__c,Other_Charges_Category_12__c,Other_Charges_Category_11__c,Other_Charges_Category_10__c,Other_Charges_Category_9__c,Other_Charges_Category_8__c,Other_Charges_Category_7__c,Other_Charges_Category_6__c,
                    Other_Charges_Category_5__c,Other_Charges_Category_4__c,Opportunity__r.LeadSource,Opportunity__r.Lead_Sub_Source__c,Opportunity__r.Sales_Manager__c,Opportunity__r.Primary_Name__c,Opportunity__r.Name_of_TL__c,
                    Opportunity__c, Opportunity__r.Name,FlatNo__c,Agreement_Value__c,Opportunity__r.Walk_in_Source__c,Opportunity__r.Walk_in_Sub_Source__c,MSEB_Infrastructure_Development_charge__c,   //new added value              
                    Agreement_Value_D__c, Parking_Infra_Charges__c,Project_Unit__r.Carpet_Area__c,Opportunity__r.Account.name,Opportunity__r.Account.Salutation, Opportunity__r.Project_Type__c, Plan_Type__c,Base_Rate_L_D__c, Carpet_Area__c,
                    No_of_parking__c, Agreement_Value_ST__c, Agreement_Value_ST_D__c, Other_Charges_Total__c, Project__r.RDS_Company_Code__r.Account_Name_Flat_Cost__c, Project_Unit__r.Legal_Entity__r.Account_Name_Flat_Cost__c,PaymentPlan__r.Sub_Vention__c,
                    Project__r.RDS_Company_Code__r.Name,Tandem_car_park_Earmarked__c,Tandem_car_park_Additional__c, Project_Unit__r.Legal_Entity__r.Name, Exclusive_Area__c, Total_Discount_L__c, Single_car_park_Earmarked__c, Single_car_park_Additional__c,Two_Wheeler_Additional__c, Single_Open_Earmarked__c,
                    Single_Open_Additional__c, Tandem_Open_Earmarked__c, Tandem_Open_Additional__c, Stack_Earmarked__c, Stack_Additional__c,owner.name,
                    Project_Unit__r.Balcony_Carpet_Area__c,Project_Unit__r.Terrace_Area__c,Project_Unit__r.Mezzanine__c,Project_Unit__r.Passage__c,Project_Unit__r.Exclusive_Area__c
                                                
            FROM Quotation__c WHERE (Id =:qid OR Id =:q.Id) ];
          //  system.debug('qList:: '+qList[0].name);
          //  system.debug('qList Ac name: ' + qList[0].Opportunity__r.Account.name);
            
            if(qList.size() > 0)
            {
              if(qList[0].Quote_Status__c != 'Approval Pending'){
                
               // system.debug('qList[0].Base_Rate_PSF__c :'+qList[0].Base_Rate_PSF__c);
               // system.debug('qList[0].Floor_Rise_PSF__c :'+ qList[0].Floor_Rise_PSF__c);
               
                if(qList[0].Opportunity__r.Account.Salutation != null)
                   CustName = qList[0].Opportunity__r.Account.Salutation + '' + qList[0].Opportunity__r.Account.name;
                else
                   CustName = qList[0].Opportunity__r.Account.name;
                   
                if(qList[0].Agreement_Value_D__c  != null && qList[0].Agreement_Value_D__c > 0)
                {
                    AggrementDisvalue = qList[0].Agreement_Value_D__c.setScale(2);  
                }
                else{
                    AggrementDisvalue = qList[0].Agreement_Value__c.setScale(2);
                }
                AggrementDisvalueInString = INFormat(AggrementDisvalue);
                
                if(qList[0].Agreement_Value__c == null){
                      qList[0].Agreement_Value__c = 0;
                }
                if(qList[0].Agreement_Value__c != null){
                      qList[0].Agreement_Value__c = qList[0].Agreement_Value__c.setScale(2);
                }      
                
                agreementValue = INFormat(qList[0].Agreement_Value__c);
                
                ////// added by priya on 30 dec 2017////////
                
                if(qList[0].Project_Unit__r.Carpet_Area__c == Null)
                {
                     qList[0].Project_Unit__r.Carpet_Area__c =0;
                }
                if(qList[0].Project_Unit__r.Carpet_Area__c != Null)
                {
                     qList[0].Project_Unit__r.Carpet_Area__c =  qList[0].Project_Unit__r.Carpet_Area__c.setScale(2);
                     CarpetArea = qList[0].Project_Unit__r.Carpet_Area__c;
                //     CarpetArea = CarpetArea.setscale(0);
                }
                
                if(qList[0].Amenity_Charge__c != Null)
                {
                       Amenitycharges = qList[0].Amenity_Charge__c;
                       AmenitychargesStr = InFormat(Amenitycharges);
                
                }
                if(qList[0].Project_Maintenance_Charges_Amount_1__c== Null)
                {
                       qList[0].Project_Maintenance_Charges_Amount_1__c= 0;
                }
                  
                if(qList[0].Project_Maintenance_Charges_Amount_1__c!= null){
                       MaintanceChargeString = InFormat(qList[0].Project_Maintenance_Charges_Amount_1__c);
                }
                
                if(qList[0].Project_Maintenance_Charges_Amount_1__c!= Null && qList[0].Base_Rate_L__c != Null){
                  AdvanceMaintance = InFormat(qList[0].Base_Rate_L__c * qList[0].Project_Maintenance_Charges_Amount_1__c*24);
                }
                
                
                
                
                system.debug('qList[0].Agreement_Value__c:: '+qList[0].Agreement_Value__c);
                system.debug('qList[0].Agreement_Value_D__c:: '+qList[0].Agreement_Value_D__c);
               
               
               
                if(qList[0].Agreement_Value_D__c == null){
                      qList[0].Agreement_Value_D__c = 0;
                }
                if(qList[0].Agreement_Value_D__c != null){
                      qList[0].Agreement_Value_D__c = qList[0].Agreement_Value_D__c.setScale(2);
                }      
                
                agreementValue_D = INFormat(qList[0].Agreement_Value_D__c);
               
               
                if(qList[0].Agreement_Value_D__c != 0 && qList[0].Agreement_Value_D__c != 0.00)
                {
                   Considerationvalue = qList[0].Agreement_Value_D__c;
                   Considerationvaluestring = inFormat(qList[0].Agreement_Value_D__c);                
                }else{
                   Considerationvalue = qList[0].Agreement_Value__c;
                   Considerationvaluestring = inFormat(qList[0].Agreement_Value__c);                
                }
              
              
                
                
                              
              
                ///////////// Added by priya on 17 jan 2018 ///////
                
                
                system.debug('Project_Unit__r.Legal_Entity__r.Account_Name_Flat_Cost__c '+qList[0].Project_Unit__r.Legal_Entity__r.Account_Name_Flat_Cost__c);
                if(qList[0].Project_Unit__r.Legal_Entity__c != Null)
                {
                    AccountName = qList[0].Project_Unit__r.Legal_Entity__r.Account_Name_Flat_Cost__c;
                    LegalEntityName = qList[0].Project_Unit__r.Legal_Entity__r.Name;
                }else{
                    AccountName = qList[0].Project__r.RDS_Company_Code__r.Account_Name_Flat_Cost__c;
                    LegalEntityName = qList[0].Project__r.RDS_Company_Code__r.Name;
                }
                
                
                
                
                 if(qList[0].Agreement_Value_ST__c== null){
                      qList[0].Agreement_Value_ST__c= 0;
                }
                if(qList[0].Agreement_Value_ST__c!= null){
                      qList[0].Agreement_Value_ST__c= qList[0].Agreement_Value_ST__c.setScale(2);
                }  
                
                if(qList[0].Agreement_Value_ST_D__c != 0 && qList[0].Agreement_Value_ST_D__c != 0.00){
                      gstonCV = qList[0].Agreement_Value_ST_D__c;
                      gstonCV = gstonCV.setScale(2);
                      gstonCVString = INFormat(gstonCV);
                      cgstonCVString = INFormat(gstonCV/2);
                      sgstonCVString = INFormat(gstonCV/2);
                }else{                
                      gstonCV=  qList[0].Agreement_Value_ST__c;
                      gstonCV = gstonCV.setScale(2);
                      gstonCVString =  INFormat(gstonCV);
                      cgstonCVString = INFormat(gstonCV/2);
                      sgstonCVString = INFormat(gstonCV/2);
                }
                
                
                
                
                
                if(qList[0].Legal_Charges__c == null)
                {
                    qList[0].Legal_Charges__c= 0;  
                }
                if(qList[0].Legal_Charges__c != null)
                {
                    qList[0].Legal_Charges__c= qList[0].Legal_Charges__c.setScale(2);  
                }
                
                LegalCharges = INFormat(qList[0].Legal_Charges__c);
                
                
                
                
                
                if(qList[0].Base_Rate_PSF__c == null)
                {
                    qList[0].Base_Rate_PSF__c = 0;  
                }
                if(qList[0].Base_Rate_PSF__c != null){
                   qList[0].Base_Rate_PSF__c = qList[0].Base_Rate_PSF__c.setScale(2);
                   
                }
                
                baseRatePsf = INFormat(qList[0].Base_Rate_PSF__c);
                
                if(qList[0].MSEB_Infrastructure_Development_charge__c == null){
                   qList[0].MSEB_Infrastructure_Development_charge__c =0;
                }
                
                if(qList[0].MSEB_Infrastructure_Development_charge__c != null){
                   qList[0].MSEB_Infrastructure_Development_charge__c = qList[0].MSEB_Infrastructure_Development_charge__c.setScale(2);
                }
                
                MSEBDevChrge = INFormat(qList[0].MSEB_Infrastructure_Development_charge__c);
               
             
               if(qList[0].Base_Rate_L__c== null){
                   qList[0].Base_Rate_L__c=0;             
                }
                
                if(qList[0].Base_Rate_L__c != null){
                   qList[0].Base_Rate_L__c = qList[0].Base_Rate_L__c.setScale(2);             
                }
                
                if(qList[0].Total_Discount_L__c== null){
                   qList[0].Total_Discount_L__c=0;             
                }
                
                if(qList[0].Total_Discount_L__c != null){
                   qList[0].Total_Discount_L__c = qList[0].Total_Discount_L__c.setScale(2);             
                }
                
                Baserate = (qList[0].Base_Rate_L__c - qList[0].Total_Discount_L__c);
                
                baseRateString = INFormat(Baserate );
                
                
                if(qList[0].Floor_Rise_L__c == null){
                   qList[0].Floor_Rise_L__c =0;             
                }
                
                if(qList[0].Floor_Rise_L__c != null){
                   qList[0].Floor_Rise_L__c = qList[0].Floor_Rise_L__c.setScale(2);             
                }
                floorRise_L = INFormat(qList[0].Floor_Rise_L__c);
              
                if(qList[0].Parking_Infra_Charges__c == null){
                   qList[0].Parking_Infra_Charges__c =0;             
                }
                
                if(qList[0].Parking_Infra_Charges__c != null){
                    qList[0].Parking_Infra_Charges__c = qList[0].Parking_Infra_Charges__c.setScale(2);             
                }
                parkingInfraCharges = INFormat(qList[0].Parking_Infra_Charges__c);
              
              
              
                if(qList[0].Floor_Rise_PSF__c == null)
                {
                    qList[0].Floor_Rise_PSF__c = 0;                    
                }
                if(qList[0].Floor_Rise_PSF__c != null){
                    qList[0].Floor_Rise_PSF__c = qList[0].Floor_Rise_PSF__c.setScale(2);
                }
                
                floorRisePsf = INFormat(qList[0].Floor_Rise_PSF__c);
                
                if(qList[0].Service_Taxes_Total__c == null){
                    qList[0].Service_Taxes_Total__c =0;
                }
                if(qList[0].Service_Taxes_Total__c != null){
                qList[0].Service_Taxes_Total__c = qList[0].Service_Taxes_Total__c.setScale(2);
                }
                
                if(qList[0].Service_Taxes_Total_D__c != null && qList[0].Service_Taxes_Total_D__c > 0){
                     serTax = qList[0].Service_Taxes_Total_D__c.setScale(2);
                }
                else{
                     serTax = qList[0].Service_Taxes_Total__c.setScale(2);
                }
                
                ServiceTaxesTotal = INFormat(serTax);
                
                if(qList[0].Registration_Charges__c == null){
                    qList[0].Registration_Charges__c =0;                    
                }
                
                RegistrationCharges = qList[0].Registration_Charges__c;
                
                system.debug('RegistrationCharges :: '+RegistrationCharges );
               
                if(qList[0].Registration_Charges__c != null){
                    qList[0].Registration_Charges__c = qList[0].Registration_Charges__c.setScale(2);
                }
                
                RegistrationChargesInstring = INFormat(qList[0].Registration_Charges__c);
               
                
                
                if(qList[0].Premium_Charges_Amount_1__c == null)
                {
                    qList[0].Premium_Charges_Amount_1__c = 0;                    
                }
                if(qList[0].Premium_Charges_Amount_1__c != null){
                    qList[0].Premium_Charges_Amount_1__c = qList[0].Premium_Charges_Amount_1__c.setScale(2);
                }
                
               
              
                if(qList[0].Premium_Charges_Amount_2__c == null)
                {
                    qList[0].Premium_Charges_Amount_2__c = 0;                    
                }
                if(qList[0].Premium_Charges_Amount_1__c != null){
                    qList[0].Premium_Charges_Amount_2__c = qList[0].Premium_Charges_Amount_2__c.setScale(2);
                }
                
                
                if(qList[0].Premium_Charges_Amount_3__c == null)
                {
                    qList[0].Premium_Charges_Amount_3__c = 0;       
                }
                if(qList[0].Premium_Charges_Amount_1__c != null){
                    qList[0].Premium_Charges_Amount_3__c = qList[0].Premium_Charges_Amount_3__c.setScale(2);  
                }
                
                
                if(qList[0].Premium_Charges_Amount_4__c == null)
                {
                     qList[0].Premium_Charges_Amount_4__c = 0;   
                }
                if(qList[0].Premium_Charges_Amount_1__c != null){
                     qList[0].Premium_Charges_Amount_4__c = qList[0].Premium_Charges_Amount_4__c.setScale(2); 
                }
                
               
                Premiumcharges = INFormat(qList[0].Project_Unit__r.Actual_Area_value__c * (qList[0].Premium_Charges_Amount_1__c + qList[0].Premium_Charges_Amount_2__c + 
                                          qList[0].Premium_Charges_Amount_3__c + qList[0].Premium_Charges_Amount_4__c));
                
                Premiumcharges1 = INFormat(qList[0].Project_Unit__r.Actual_Area_value__c * (qList[0].Premium_Charges_Amount_1__c ));
                                          
                Premiumcharges2 = INFormat(qList[0].Project_Unit__r.Actual_Area_value__c * (qList[0].Premium_Charges_Amount_2__c));                          
                
               
                
                if(qList[0].Discount_1_PSF__c == null)
                {
                       qList[0].Discount_1_PSF__c = 0;    
                }
              
                if(qList[0].Discount_2_PSF__c == null)
                {
                       qList[0].Discount_2_PSF__c = 0;    
                }
                if( discountAmt != null)
                {
                        discountAmt = (qList[0].Discount_1_PSF__c + qList[0].Discount_2_PSF__c);
                        system.debug('discountAmt : ' + discountAmt);
                }     
                
                
                 if( qList[0].Stamp_Duty__c == null )
                {
                        qList[0].Stamp_Duty__c = 0;
                }
                 if( qList[0].Stamp_Duty__c != null )
                {
                        qList[0].Stamp_Duty__c = qList[0].Stamp_Duty__c.setScale(2);
                }
               
               if(qList[0].Stamp_Duty_D__c == null){
               qList[0].Stamp_Duty_D__c =0;
               }
               
               if(qList[0].Stamp_Duty_D__c == 0 || qList[0].Stamp_Duty_D__c == 0.00){
                   stampcharge = qList[0].Stamp_Duty__c;
               }else{
                   stampcharge = qList[0].Stamp_Duty_D__c;
               }
               
               stampchargeInString = INFormat(stampcharge);
               
              
               
               
                if(qList[0].MVAT__c == null )
                {
                    qList[0].MVAT__c = 0;
                }
                if( qList[0].MVAT__c != null )
                {
                        qList[0].MVAT__c = qList[0].MVAT__c.setScale(2);
                }
                
               if(qList[0].MVAT_D__c == null){
                      qList[0].MVAT_D__c =0;
               }
               if(qList[0].MVAT_D__c != null){
                      qList[0].MVAT_D__c =qList[0].MVAT_D__c.setScale(2);
               }
              
              
               if(qList[0].MVAT_D__c ==0 || qList[0].MVAT_D__c ==0.00){
                   MVATcharge =qList[0].MVAT__c;
               }else{
                   MVATcharge =qList[0].MVAT_D__c;
               }
               
               MVATchargeInstring = INFormat(MVATcharge);
               
               
             
                if(qList[0].Discount_1_L__c== null)
                {
                        qList[0].Discount_1_L__c = 0;
                }
                else
                {
                        EOI = qList[0].Discount_1_L__c;
                        EOIStr = INFormat(EOI);
                }
                
                
                
                if(qList[0].Project_Specific_Charges_Amount_1__c == null)
                {
                        qList[0].Project_Specific_Charges_Amount_1__c = 0;
                }
                else
                {
                        Finishedcharges = qList[0].Project_Specific_Charges_Amount_1__c;
                        FinishedchargesStr = INFormat(Finishedcharges);
                }
                if(qList[0].Project_Specific_Charges_Amount_2__c == null)
                {
                        qList[0].Project_Specific_Charges_Amount_2__c = 0;
                }
                else
                {
                        Subventioncharges = qList[0].Project_Specific_Charges_Amount_2__c;
                        SubventionchargesStr = INFormat(Subventioncharges );
                }
                if(qList[0].Project_Specific_Charges_Amount_3__c == null)
                {
                        qList[0].Project_Specific_Charges_Amount_3__c = 0;
                }
                
                InfrastructureAndDevelopment = (Finishedcharges+ ((qList[0].Infrastructure_charges__c)+(qList[0].Parking_Infra_Charges__c)));               
                InfrastructureAndDevelopmentStr = INFormat(InfrastructureAndDevelopment );
                
                 
               if(qList[0].Project__c != null){

            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_11__c != null ){
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_11__c;
                     mw.chrgDscription = 'k) '+ qList[0].Other_Charges_Desc_11__c;
                     mw.Amount = qList[0].Other_Charges_Amount_11__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                
                }
            }
            else{
                if(qList[0].Other_Charges_Amount_11__c != null){
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_11__c;
                     mw.chrgDscription = 'k) '+ qList[0].Other_Charges_Desc_11__c;
                     mw.Amount = qList[0].Other_Charges_Amount_11__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_9__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_9__c;
                     mw.chrgDscription = 'l) ' + qList[0].Other_Charges_Desc_9__c;
                     mw.Amount = qList[0].Other_Charges_Amount_9__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_9__c != null)
                {
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_9__c;
                     mw.chrgDscription = 'l) ' + qList[0].Other_Charges_Desc_9__c;
                     mw.Amount = qList[0].Other_Charges_Amount_9__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_1__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_1__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_1__c;
                     mw.Amount = qList[0].Other_Charges_Amount_1__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_1__c != null && qList[0].Other_Charges_Amount_1__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_1__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_1__c;
                     mw.Amount = qList[0].Other_Charges_Amount_1__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_2__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_2__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_2__c;
                     mw.Amount = qList[0].Other_Charges_Amount_2__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_2__c != null && qList[0].Other_Charges_Amount_2__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_2__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_2__c;
                     mw.Amount = qList[0].Other_Charges_Amount_2__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_3__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_3__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_3__c;
                     mw.Amount = qList[0].Other_Charges_Amount_3__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_3__c != null && qList[0].Other_Charges_Amount_3__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_3__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_3__c;
                     mw.Amount = qList[0].Other_Charges_Amount_3__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_4__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_4__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_4__c;
                     mw.Amount = qList[0].Other_Charges_Amount_4__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_4__c != null && qList[0].Other_Charges_Amount_4__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_4__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_4__c;
                     mw.Amount = qList[0].Other_Charges_Amount_4__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_5__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_5__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_5__c;
                     mw.Amount = qList[0].Other_Charges_Amount_5__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_5__c != null && qList[0].Other_Charges_Amount_5__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_5__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_5__c;
                     mw.Amount = qList[0].Other_Charges_Amount_5__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_6__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_6__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_6__c;
                     mw.Amount = qList[0].Other_Charges_Amount_6__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_6__c != null && qList[0].Other_Charges_Amount_6__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_6__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_6__c;
                     mw.Amount = qList[0].Other_Charges_Amount_6__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_7__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_7__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_7__c;
                     mw.Amount = qList[0].Other_Charges_Amount_7__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_7__c != null && qList[0].Other_Charges_Amount_7__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_7__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_7__c;
                     mw.Amount = qList[0].Other_Charges_Amount_7__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_8__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_8__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_8__c;
                     mw.Amount = qList[0].Other_Charges_Amount_8__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_8__c != null && qList[0].Other_Charges_Amount_8__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_8__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_8__c;
                     mw.Amount = qList[0].Other_Charges_Amount_8__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_10__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_10__c;
                     mw.chrgDscription = 'm) ' + qList[0].Other_Charges_Desc_10__c;
                     mw.Amount = qList[0].Other_Charges_Amount_10__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_10__c != null)
                {
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_10__c;
                     mw.chrgDscription = 'm) ' + qList[0].Other_Charges_Desc_10__c;
                     mw.Amount = qList[0].Other_Charges_Amount_10__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_12__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_12__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_12__c;
                     mw.Amount = qList[0].Other_Charges_Amount_12__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_12__c != null && qList[0].Other_Charges_Amount_12__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_12__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_12__c;
                     mw.Amount = qList[0].Other_Charges_Amount_12__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_13__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_13__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_13__c;
                     mw.Amount = qList[0].Other_Charges_Amount_13__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_13__c != null && qList[0].Other_Charges_Amount_13__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_13__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_13__c;
                     mw.Amount = qList[0].Other_Charges_Amount_13__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
            
            if(qList[0].Project__c == 'a140K00000A2mah'){
                if(qList[0].Other_Charges_Desc_14__c != null ){
                     
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_14__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_14__c;
                     mw.Amount = qList[0].Other_Charges_Amount_14__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
            }
            else{
                if( qList[0].Other_Charges_Amount_14__c != null && qList[0].Other_Charges_Amount_14__c > 0)
                {    
                     MainWrapper mw = new MainWrapper();
                     mw.chrgCatgory = qList[0].Other_Charges_Category_14__c;
                     mw.chrgDscription = qList[0].Other_Charges_Desc_14__c;
                     mw.Amount = qList[0].Other_Charges_Amount_14__c;
                     mw.AmountInString = INFormat(mw.Amount);
                     mwList.add(mw);
                }
                
            }
    }
                
            
                
                 if(qList[0].Project_Maintenance_Charges_Amount_1__c == null)
                {
                        qList[0].Project_Maintenance_Charges_Amount_1__c = 0;
                }
                if(qList[0].Project_Maintenance_Charges_Amount_2__c == null)
                {
                        qList[0].Project_Maintenance_Charges_Amount_2__c = 0;
                }
                if(qList[0].Project_Maintenance_Charges_Amount_3__c == null)
                {
                        qList[0].Project_Maintenance_Charges_Amount_3__c = 0;
                }
                 if(qList[0].Project_Unit__r.Chargeable_Area__c == null)
                {
                        qList[0].Project_Unit__r.Chargeable_Area__c = 0;
                }
               
                if(qList[0].FloorNo__c == null){
                     qList[0].FloorNo__c=0;
                }
                
                if(qList[0].Project_Unit__r.Actual_Area_value__c == null){
                   qList[0].Project_Unit__r.Actual_Area_value__c = 0;
                } 
               
                if(qList[0].Project_Unit__r.Actual_Area_value__c != null){
                   qList[0].Project_Unit__r.Actual_Area_value__c = qList[0].Project_Unit__r.Actual_Area_value__c.setScale(2); 
                } 
                
                
                
                //////Added by priya on 15 Jan 2018////               
               
                if(qList[0].Project_Unit__r.Actual_Area_value__c != null){
                    Actualarea = qList[0].Project_Unit__r.Actual_Area_value__c;
               //   Actualarea = Actualarea.setScale(0);
                    ActualAreaMeterString = InFormat(qList[0].Project_Unit__r.Actual_Area_value__c * 0.092903);
                }
               
               
                if(qList[0].Project_Unit__r.Actual_Area_value__c != null && qList[0].Base_Rate_PSF__c != null){
                    flatCost = (qList[0].Project_Unit__r.Actual_Area_value__c * qList[0].Base_Rate_PSF__c);
                    //flatCost = ( totalRate * qList[0].Project_Unit__r.Actual_Area_value__c); //vikas changed from Chargeable_Area__c to Actual_Area_value__c on dated 01/09/16 ///
                    //priya commented on 12/6/16                  
                    flatCost = flatCost.setScale(2);
                } 
                
                if(qList[0].Project_Unit__r.Actual_Area_value__c != null && qList[0].Floor_Rise_PSF__c != null){    
                    floorrise = (qList[0].Project_Unit__r.Actual_Area_value__c * qList[0].Floor_Rise_PSF__c);
                    floorrise = floorrise.setScale(2);
                    floorRisestr = InFormat(floorrise);
                }
                
               
               
               
                if(stampcharge != null && MVATcharge  != null){
                    GovernmentCharges = stampcharge+ MVATcharge +qList[0].Registration_Charges__c+serTax;
                }
                
                /////added by Priya on 15 Jan 2018///
                
                if(stampcharge != null && RegistrationCharges != Null && qList[0].Legal_Charges__c != Null){   
                      SubTotal2New= INFormat(stampcharge+RegistrationCharges+ qList[0].Legal_Charges__c);// 
                }
                 if(stampcharge != null && RegistrationCharges != Null){    // && qList[0].Legal_Charges__c != Null
                      SubTotal2New2= INFormat(stampcharge+RegistrationCharges);// + qList[0].Legal_Charges__c
                }
                if(stampcharge != null && RegistrationCharges != Null && qList[0].Legal_Charges__c != Null && gstonCV != null){   
                      SubTotal2Homes = INFormat(stampcharge+RegistrationCharges+ qList[0].Legal_Charges__c+gstonCV);
                }
                if(stampcharge != null && RegistrationCharges != Null && gstonCV != null){   
                      SubTotal2Shah = INFormat(stampcharge+RegistrationCharges+gstonCV);
                }
                
                
                if(qList[0].Other_Charges_Total__c == Null){
                   qList[0].Other_Charges_Total__c =0;
                }
                
                if(qList[0].Other_Charges_Total__c == Null){
                   qList[0].Other_Charges_Total__c = qList[0].Other_Charges_Total__c.setScale(2);
                }
                
                
                OtherchargesGST = ((((qList[0].Other_Charges_Total__c)-((qList[0].Other_Charges_Amount_11__c)+(qList[0].Other_Charges_Amount_10__c)))*18)/100);  //Corpus Fund (At the time of Possession) charge has been substracted cause gst not applied on it
                OtherchargesGST = OtherchargesGST.setScale(2);
                OtherchargesGSTstring = inFormat(OtherchargesGST);
                
if(qList[0].Single_car_park_Earmarked__c != null && qList[0].Single_car_park_Additional__c != Null)
{
totalIndependent= (qList[0].Single_car_park_Earmarked__c + qList[0].Single_car_park_Additional__c); 
} 

if(qList[0].Single_Open_Earmarked__c!= null && qList[0].Single_Open_Additional__c!= Null)
{
totalDdependent= (qList[0].Single_Open_Earmarked__c + qList[0].Single_Open_Additional__c); 
}        

if(qList[0].Tandem_Open_Earmarked__c!= null && qList[0].Tandem_Open_Additional__c!= Null)
{
totalStack= (qList[0].Tandem_Open_Earmarked__c + qList[0].Tandem_Open_Additional__c); 
}        

if(qList[0].Stack_Earmarked__c!= null && qList[0].Stack_Additional__c!= Null)
{
totalPuzzle= (qList[0].Stack_Earmarked__c + qList[0].Stack_Additional__c); 
}

if(qList[0].Tandem_car_park_Earmarked__c!= null && qList[0].Tandem_car_park_Additional__c!= Null)
{
totalDependableStack= (qList[0].Tandem_car_park_Earmarked__c + qList[0].Tandem_car_park_Additional__c); 
}

if(qList[0].Two_Wheeler_Additional__c != Null)
{
totalTwoWheeler = qList[0].Two_Wheeler_Additional__c; 
}                                        
                
                if(!mwList.isEmpty()){
                     decimal amountGov = 0;
                     listsize = mwList.size();
                     for(MainWrapper mw : mwList){
                         if(mw.chrgCatgory == 'Stamp Duty and Registration'){
                             amountGov += mw.Amount;
                         
                         }
                         if(mw.chrgCatgory == 'Other Charges'){
                             totalOtherChrgs += mw.Amount;
                             
                         }
                         
                        
                     }
                     system.debug('totalOtherChrgs :: '+totalOtherChrgs );
                     GovernmentCharges += amountGov;
                     
                     if(totalOtherChrgs != Null){
                         totalOtherChrgs = (totalOtherChrgs-qlist[0].Other_Charges_Amount_10__c).setScale(2);
                     }
                     
                     if(totalOtherChrgs != Null){
                         totalOtherChrgsString = inFormat(totalOtherChrgs);
                     }
                }
                 
                
                if(OtherchargesGST != Null && gstonCV != Null){
                    subtotal4New = inFormat(OtherchargesGST + gstonCV);
                }
                
                
                
                if(considerationvalue != Null && stampcharge != null && RegistrationCharges != Null && qList[0].Legal_Charges__c != Null && totalOtherChrgs != Null &&  OtherchargesGST != Null && gstonCV != Null)
                {
                   system.debug('considerationvalue  :: '+considerationvalue  );
                   system.debug('stampcharge :: '+stampcharge );
                   system.debug('RegistrationCharges :: '+RegistrationCharges );
                   system.debug('qList[0].Legal_Charges__c:: '+qList[0].Legal_Charges__c);
                   system.debug('totalOtherChrgs  :: '+totalOtherChrgs );
                   system.debug('OtherchargesGST :: '+OtherchargesGST );
                   system.debug('gstonCV :: '+gstonCV);
                   
                   Alltotal = considerationvalue  + stampcharge + RegistrationCharges + qList[0].Legal_Charges__c + totalOtherChrgs + OtherchargesGST + gstonCV;
                   AlltotalString = inFormat(Alltotal);
                   
                   Alltotal2 = considerationvalue  + stampcharge + RegistrationCharges + totalOtherChrgs + OtherchargesGST + gstonCV;
                   AlltotalString2 = inFormat(Alltotal2);
                   
                   AlltotalHomes = considerationvalue  + stampcharge + RegistrationCharges + qList[0].Legal_Charges__c + gstonCV;
                   AlltotalHomesString = inFormat(AlltotalHomes);
                   
                   AlltotalShah = considerationvalue  + stampcharge + RegistrationCharges + gstonCV;
                   AlltotalShahString = inFormat(AlltotalShah);
                }
                
                
               
                if(GovernmentCharges != null){
                 GovernmentCharges = GovernmentCharges.setScale(2);
                }
              
                
                
                
                if(qList[0].Development_Charges_PSF__c == null)
                {
                        qList[0].Development_Charges_PSF__c = 0;
                }
                if(qList[0].Infrastructure_charges__c == null )
                {
                        qList[0].Infrastructure_charges__c = 0;
                        
                }
                if(qList[0].Infrastructure_charges__c != null){
                       qList[0].Infrastructure_charges__c =  qList[0].Infrastructure_charges__c.setScale(2);
                        InfrastructureCharges = inFormat((qList[0].Infrastructure_charges__c)+(qList[0].Parking_Infra_Charges__c));
                  }
                  
                 InfrastructureAndDevelopment = (Finishedcharges+ ((qList[0].Infrastructure_charges__c)+(qList[0].Parking_Infra_Charges__c)));               
                InfrastructureAndDevelopmentStr = INFormat(InfrastructureAndDevelopment );
                
                
                //subTotal1 = ( flatCost + qList[0].Infrastructure_charges__c + qList[0].Development_Charges_L__c) ;  /// vikas changed from Development_Charges_PSF__c to Development_Charges_L__c on dated 01/09/16 //// 
                // priya commented on 12/6/16
                    
                if(flatCost != null && floorrise != null){
                    total = ( flatCost + floorrise) ;    
                    system.debug(' Sub Total 1 = ' + subTotal1); 
                    totalInString = INFormat(total);
                }                
                
                if(qList[0].Project__c != Null){
                    projcharges = [select id, Name, S_Charge_Percentage__c,S_Lumpsum_Charge_Amount__c from Project_Charges__c where Project__c =: qList[0].Project__c];
                    system.debug('projcharges '+projcharges );
                }
                
                
                for(Project_Charges__c b: projcharges){
                
                if(b.Name == 'Stamp Duty'){ 
                if(b.S_Charge_Percentage__c != null){           
                    stamppercentage = b.S_Charge_Percentage__c;
                }
                }
                
                if(b.Name == 'MVAT'){  
                if(b.S_Charge_Percentage__c != null){         
                    MVATpercentage = b.S_Charge_Percentage__c;
                }
                }
               
                
                }
              
                if(total != null && msebcharges  != null){
                        subTotal1 = total + msebcharges ;          
                        subTotal1 =subTotal1.setScale(2);
                }
            
            
                if(AggrementDisvalue != null && GovernmentCharges != null){
                    totalcost = AggrementDisvalue + GovernmentCharges + totalOtherChrgs;
                }
                
               
                
                scppListForBasic = new List<Standard_Customer_Pay_Plan_Detail__c>();
                scppListForRegst = new List<Standard_Customer_Pay_Plan_Detail__c>();
                scppListForOther = new List<Standard_Customer_Pay_Plan_Detail__c>();
                newRecordList =  new List< Standard_Customer_Pay_Plan_Detail__c >(); 
                wrapperList = new List<wrapperclass>();             
                scppListForBasic = [SELECT Id, Project_Construction_Stages__c,Project_Construction_Stages__r.Name, Customer_Pay_Plan_Header__c,Is_to_be__c,Days_Months_Value__c ,Installment__c,Amount_Value__c,Is_to_be_Paid__c,Due_Date__c,Original_Percentage__c,
                                    OC_Milestone__c, Contribution_From__c,Service_Tax_Amount_Q__c,Total_of_Tax_Av_Milestone_wise__c,Standard_Pay_Plan_Header__r.Payment_Plan__r.Sub_Vention__c
                                    FROM Standard_Customer_Pay_Plan_Detail__c 
                                    WHERE Customer_Pay_Plan_Header__c != null and Customer_Pay_Plan_Header__r.Quotation__c =: qList[0].id and Customer_Pay_Plan_Header__r.Global_Charge_Name__c = 'Basic'];  /// AND Is_to_be_Paid__c = 'From Dt. of Booking'
                system.debug('scppListForBasic :: '+scppListForBasic);
                 
                 if(scppListForBasic.size() > 0)
                 {
                                   for (integer i = 0 ; i < scppListForBasic.size() ; i++)
                                   {
                                           Standard_Customer_Pay_Plan_Detail__c newSccp = new Standard_Customer_Pay_Plan_Detail__c();
                                           
                                           if(scppListForBasic[i].Is_to_be__c != null){
                                           newSccp.Is_to_be__c = scppListForBasic[i].Is_to_be__c;
                                           }
                                           
                                           if(scppListForBasic[i].Installment__c != null){
                                           newSccp.Installment__c = scppListForBasic[i].Installment__c;
                                           }
                                           
                                           if(scppListForBasic[i].Amount_Value__c != null){
                                           newSccp.Amount_Value__c= scppListForBasic[i].Amount_Value__c;
                                           }
                                           
                                           if(scppListForBasic[i].Service_Tax_Amount_Q__c!= null){
                                           newSccp.Service_Tax_Amount_Q__c = scppListForBasic[i].Service_Tax_Amount_Q__c;
                                           }
                                           
                                           if(!scppListForBasic[i].Standard_Pay_Plan_Header__r.Payment_Plan__r.Sub_Vention__c){
                                           newSccp.Contribution_From__c = 'Customer';
                                           }
                                           
                                           if(scppListForBasic[i].Total_of_Tax_Av_Milestone_wise__c!= null){
                                           TotalGSTnAV = scppListForBasic[i].Total_of_Tax_Av_Milestone_wise__c;
                                           }else{
                                           TotalGSTnAV =0;
                                           }
                                          
                                           if(scppListForBasic[i].Project_Construction_Stages__r.Name != null){ 
                                           construction= scppListForBasic[i].Project_Construction_Stages__r.Name;  
                                           system.debug('if part');                                    
                                           }else{
                                           construction='';
                                           }
                                          
                                           newRecordList.add(newSccp);  
                                           system.debug('newSccp :--------   ' + newSccp);
                                           if(newRecordList[i].Installment__c == null)
                                           {
                                                   newRecordList[i].Installment__c = 0;
                                           }
                                           
                                           wrapperList.add(new wrapperclass(newRecordList[i],newRecordList[i].Is_to_be__c, newRecordList[i].Installment__c, newRecordList[i].Amount_Value__c,construction,newRecordList[i].Service_Tax_Amount_Q__c,newRecordList[i].Total_of_Tax_Av_Milestone_wise__c,newRecordList[i].Contribution_From__c));
                                               
                                   }
                           }    
                
                le = InventoryCostServices.getLegalEntityDetails(qList[0].Project_Unit__r.Id, qList[0].Project__r.Id);
                
                scppListForRegst = [select id,name,Project_Construction_Stages__c,Project_Construction_Stages__r.Name, Customer_Pay_Plan_Header__c,Is_to_be__c,Days_Months_Value__c ,Installment__c,Amount_Value__c,Is_to_be_Paid__c,Due_Date__c,Customer_Pay_Plan_Header__r.Global_Charges__r.name, 
                                 Original_Percentage__c,Standard_Pay_Plan_Header__r.Charge_Code__r.S_Lumpsum_Charge_Amount__c FROM Standard_Customer_Pay_Plan_Detail__c 
                                 WHERE Customer_Pay_Plan_Header__c != null and Customer_Pay_Plan_Header__r.Quotation__c =: qList[0].id and Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c = 'Stamp Duty and Registration'];
                
                if(!scppListForRegst.isEmpty()){
                      for(Standard_Customer_Pay_Plan_Detail__c sc : scppListForRegst){
                           stampTotal += sc.Installment__c;
                           stampTotalInString = INFormat(stampTotal);
                      }
                }
                
                scppListForOther = [select id,name,Project_Construction_Stages__c,Project_Construction_Stages__r.Name, Customer_Pay_Plan_Header__c,Is_to_be__c,Days_Months_Value__c ,Installment__c,Amount_Value__c,Is_to_be_Paid__c,Due_Date__c,Customer_Pay_Plan_Header__r.Global_Charges__r.name,Original_Percentage__c,Customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c
                                 FROM Standard_Customer_Pay_Plan_Detail__c 
                                 WHERE Customer_Pay_Plan_Header__c != null and Customer_Pay_Plan_Header__r.Quotation__c =: qList[0].id and (Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c = 'Other Charges' or Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c = 'Society Charges')];
                if(!scppListForOther.isEmpty()){
                      for(Standard_Customer_Pay_Plan_Detail__c sc : scppListForOther){
                           otherTotal += sc.Installment__c;
                           otherTotalInString = INFormat(otherTotal);
                      }
                }
                
                if(AggrementDisvalue != null && stampTotal != null && otherTotal !=null && OtherchargesGST != Null && gstonCV != null){
                       totalcost = AggrementDisvalue + stampTotal + otherTotal + OtherchargesGST + gstonCV;
                }
                totalcostInstring = INFormat(totalcost);
                
               }
               else{
                   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'This Quotation Approval Pending.'));
               }                          
            }// if qid!=null
            
        }
        else if(qid == null)
        {
            system.debug('qid :' + qid);
        }
    }
    
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
            mf =  mf + '/-';
        else
            mf = '-' + mf + '/-';
        return mf;
    }
    
    public class MainWrapper{
         public String chrgCatgory{get;set;}
         public String chrgDscription{get;set;}
         Public Decimal Amount{get;set;}
         Public String AmountInString{get;set;}
         
    public MainWrapper(){
         chrgCatgory = '';
         chrgDscription = '';
         Amount = 0;
         AmountInString = '';
    
    }
    
  }
    
}