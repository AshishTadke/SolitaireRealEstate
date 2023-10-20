public with sharing class S_CollectionsDashboardClass 
{
    public string errorMsg {get;set;}
    public datetime dtSelectedDate {get;set;}
    public string selectedProjectId {get;set;}
    public string selectedDisposition {get;set;}   
    public string selectedRM {get;set;} 
    
    public string selectedConsStageId {get;set;}
    public string selectedCriteria {get;set;}
    public string selectedTowerId {get;set;}
    public Standard_Customer_Pay_Plan_Detail__c objSCPPD {get;set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> objSCPPD2 {get;set;}
    public List<Standard_Customer_Pay_Plan_Detail__c> objSCPPD3 {get;set;}
    public Standard_Customer_Pay_Plan_Detail__c objSCPPD1 {get;set;}
    public list<DemandManagementServices.wrpCustomers> lstCustomers {get;set;} 
    public list<DemandManagementServices.wrpCustomers> pendingDemandsList {get;set;} 
    public Map<String, list<DemandManagementServices.wrpCustomers>> customerTowerMap  {get;set;}
    public Set<String> towerNames {get;set;}
    public list<DemandManagementServices.wrpCustomers> customerTowerList {get;set;}
    public List<Booking__c> lstBooking {get; set;}
    public String strBookingId {get; set;}
    public id selectedPlan {get; set;}
    public List <Demand_Invoice__c> Demand {get; set;}
    
    public String ChargeAmt {get; set;}
    public List <String> ListChargeAmt {get; set;}
    
    public List < wrapperclass> wrapperscppdList{get; set;}
       public class wrapperclass
    {
        public String Amount1{ get; set; }
        public String Amount2{ get; set; }
        public String Amount3{ get; set; }
        public String Amount4{ get; set; }
        public String Amount5{ get; set; }
        public String Amount6{ get; set; }
        public Standard_Customer_Pay_Plan_Detail__c stdCustomerPayPlan {get;set;}
        public wrapperclass(Standard_Customer_Pay_Plan_Detail__c s, Decimal d, Decimal d2, Decimal d3,Decimal d4,Decimal d5, Decimal d6)
        {
            stdCustomerPayPlan = s;
            if(d6!=null) d= d+d6;
            Amount1=QuotationManagementServices.INFormat(d);
            Amount2=QuotationManagementServices.INFormat(d2);
            Amount3=QuotationManagementServices.INFormat(d3);
            if(d4 != null)
            {
                Amount4=QuotationManagementServices.INFormat(d4);
            }
            if(d5 != null)
            {
                Amount5=QuotationManagementServices.INFormat(d5);
            }
        }
    } 
       
    public S_CollectionsDashboardClass()
    {
        errorMsg = '';
        objSCPPD = new Standard_Customer_Pay_Plan_Detail__c();
        objSCPPD1 = new Standard_Customer_Pay_Plan_Detail__c();
        objSCPPD2 = new List<Standard_Customer_Pay_Plan_Detail__c>();
        objSCPPD3 = new List<Standard_Customer_Pay_Plan_Detail__c>();
        lstCustomers = new list<DemandManagementServices.wrpCustomers>();
        Demand = new List<Demand_Invoice__c>();
        pendingDemandsList = null;
        towerNames = null;
     
    }
    
    public pageReference getCollectionsList()
    {
         if(selectedProjectId != null)
        {
            if(selectedDisposition != 'All' && selectedRM == 'All')
            {
                // Fetching the SCPPD records            
                objSCPPD2 = [Select PTP_Date__c,Id,Name,Customer_Pay_Plan_Header__r.Customer__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Account.Id,Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c,Total_Interest_Amount__c,
                Customer_Pay_Plan_Header__r.Customer__r.Account.PersonMobilePhone,Customer_Pay_Plan_Header__r.Booking__r.Unit_No__r.Name,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Relation__c,
                Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Name__c,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Phone__c,
                Customer_Pay_Plan_Header__r.Customer__c, Is_to_be__c, Charge_Amount_Billed__c, Charge_Amount_Due__c, Charge_Amount_Paid__c, 
                 PTP_Amount__c,PTP_Instrument__c, IsPaymentOverdue__c, Last_Call_Disposition__c,Service_Tax_Amount_Billed__c, Service_Tax_Amount_Due__c,Customer_Pay_Plan_Header__r.Quotation__r.Booking__r.Owner.Name,
                Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c,Customer_Pay_Plan_Header__r.Booking__r.Owner.Name, L2__c,L3__c 
                From Standard_Customer_Pay_Plan_Detail__c 
                //where (((Charge_Amount_Due__c >0 and PTP_Date__c = null) or (Charge_Amount_Due__c >0 and PTP_Date__c < :System.today()))
                where ((Charge_Amount_Due__c >0)
                and Project__c =: selectedProjectId and L2__c =:selectedDisposition)];
                //and Project__c =: selectedProjectId and Last_Call_Disposition__c =:selectedDisposition)];
                //System.debug('HHHHHHHHHHHHHHHHHHH' +objSCPPD2[0].Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c);
            }
            else if(selectedDisposition != 'All' && selectedRM != 'All')
            {
                objSCPPD2 = [Select PTP_Date__c,Id,Name,Customer_Pay_Plan_Header__r.Customer__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Account.Id,Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c,Total_Interest_Amount__c,
                Customer_Pay_Plan_Header__r.Customer__r.Account.PersonMobilePhone,Customer_Pay_Plan_Header__r.Booking__r.Unit_No__r.Name,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Relation__c,
                Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Name__c,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Phone__c,
                Customer_Pay_Plan_Header__r.Customer__c, Is_to_be__c, Charge_Amount_Billed__c, Charge_Amount_Due__c, Charge_Amount_Paid__c, 
                 PTP_Amount__c,PTP_Instrument__c, IsPaymentOverdue__c, Last_Call_Disposition__c,Service_Tax_Amount_Billed__c, Service_Tax_Amount_Due__c,Customer_Pay_Plan_Header__r.Quotation__r.Booking__r.Owner.Name,
                Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c,Customer_Pay_Plan_Header__r.Booking__r.Owner.Name, L2__c,L3__c 
                From Standard_Customer_Pay_Plan_Detail__c 
                where ((Charge_Amount_Due__c >0)
                //where (((Charge_Amount_Due__c >0 and PTP_Date__c = null) or (Charge_Amount_Due__c >0 and PTP_Date__c < :System.today()))
                and Project__c =: selectedProjectId and L2__c =:selectedDisposition and Customer_Pay_Plan_Header__r.Booking__r.Owner.Name =:selectedRM)];
            }
            else if(selectedDisposition == 'All' && selectedRM != 'All' )
            {
                objSCPPD2 = [Select PTP_Date__c,Id,Name,Customer_Pay_Plan_Header__r.Customer__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Account.Id,Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c,Total_Interest_Amount__c,
                Customer_Pay_Plan_Header__r.Customer__r.Account.PersonMobilePhone,Customer_Pay_Plan_Header__r.Booking__r.Unit_No__r.Name,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Relation__c,
                Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Name__c,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Phone__c,
                Customer_Pay_Plan_Header__r.Customer__c, Is_to_be__c, Charge_Amount_Billed__c, Charge_Amount_Due__c, Charge_Amount_Paid__c, 
                PTP_Amount__c,PTP_Instrument__c, IsPaymentOverdue__c, Last_Call_Disposition__c,Service_Tax_Amount_Billed__c, Service_Tax_Amount_Due__c,Customer_Pay_Plan_Header__r.Quotation__r.Booking__r.Owner.Name,
                Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c,Customer_Pay_Plan_Header__r.Booking__r.Owner.Name, L2__c,L3__c 
                From Standard_Customer_Pay_Plan_Detail__c 
                where ((Charge_Amount_Due__c >0)
                //where (((Charge_Amount_Due__c >0 and PTP_Date__c = null) or (Charge_Amount_Due__c >0 and PTP_Date__c < :System.today()))
                and Project__c =: selectedProjectId and Customer_Pay_Plan_Header__r.Booking__r.Owner.Name =:selectedRM)];
            }
            else
            {
                objSCPPD2 = [Select PTP_Date__c,Id,Name,Customer_Pay_Plan_Header__r.Customer__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Account.Id,Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c,Total_Interest_Amount__c,
                Customer_Pay_Plan_Header__r.Customer__r.Account.PersonMobilePhone,Customer_Pay_Plan_Header__r.Booking__r.Unit_No__r.Name,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Relation__c,
                Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Name__c,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Phone__c,
                Customer_Pay_Plan_Header__r.Customer__c, Is_to_be__c, Charge_Amount_Billed__c, Charge_Amount_Due__c, Charge_Amount_Paid__c, 
                PTP_Amount__c,PTP_Instrument__c, IsPaymentOverdue__c, Last_Call_Disposition__c,Service_Tax_Amount_Billed__c, Service_Tax_Amount_Due__c,Customer_Pay_Plan_Header__r.Quotation__r.Booking__r.Owner.Name,
                Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c,Customer_Pay_Plan_Header__r.Booking__r.Owner.Name, L2__c,L3__c 
                From Standard_Customer_Pay_Plan_Detail__c 
                where ((Charge_Amount_Due__c >0)
                //where (((Charge_Amount_Due__c >0 and PTP_Date__c = null) or (Charge_Amount_Due__c >0 and PTP_Date__c < :System.today()))
                and Project__c =: selectedProjectId )];
            
            }

            if(objSCPPD2.size() > 0)
            {
                for(Standard_Customer_Pay_Plan_Detail__c  ss :  objSCPPD2)
                {
                    if( ss.Total_Interest_Amount__c != null){
                        ss.Total_Interest_Amount__c = ss.Total_Interest_Amount__c.setScale(0); 
                    }
                     //ChargeAmt  = QuotationManagementServices.INFormat(ss.Charge_Amount_Billed__c);
                     //ListChargeAmt.add(ChargeAmt);
                }
            }
            
                            
         }
        // Documentcheck list page sends Booking id here.
        if(ApexPages.currentPage().getParameters().get('bookingId') != null && ApexPages.currentPage().getParameters().get('bookingId') != '')
        {
            strBookingId = ApexPages.currentPage().getParameters().get('bookingId');        
            lstBooking = [Select Id, Project__c, Project__r.Name, Customer__c from Booking__c Where Id =: strBookingId];
            //if(lstBooking != null && lstBooking.size() > 0)
              //  search();
        }
      //  getTowerNames();
      
      
            wrapperscppdList = new List<wrapperclass>();
            for (integer i = 0 ; i < objSCPPD2.size() ; i++)
            {
               wrapperscppdList.add(new wrapperclass(objSCPPD2[i], objSCPPD2[i].Charge_Amount_Billed__c, objSCPPD2[i].Charge_Amount_Due__c,objSCPPD2[i].Service_Tax_Amount_Due__c,objSCPPD2[i].PTP_Amount__c ,objSCPPD2[i].Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c, objSCPPD2[i].Service_Tax_Amount_Billed__c ));//,objSCPPD2[i].Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c
               
            } 
      
            System.debug('wrapperscppdList' +wrapperscppdList);
            
            return null;
    
    }
    
    public pageReference getDemandReciepts(){
    
    System.debug('selectedPlan  ' +selectedPlan);
    Customer_Pay_Plan_Header__c CPPH3  =  new  Customer_Pay_Plan_Header__c();
    CPPH3  = [Select id, Name,Customer__c from Customer_Pay_Plan_Header__c where id =: selectedPlan];
    Demand = [Select id, Name,Customer__c From Demand_Invoice__c  Where Customer__c =: CPPH3.Customer__c];
    return null;
    }
   
   /* public list<SelectOption> searchOptions
    {
        get
        {
          list<SelectOption> searchOptions = new list<SelectOption>();
             searchOptions.add(new SelectOption('Construction Stage', 'Construction Stage'));
             searchOptions.add(new SelectOption('Due Date', 'Due Date'));
            return searchOptions;
        }
        set;
    }*/
    
    

    public list<SelectOption> lstProjects 
    {
        get
        {
          lstProjects = null;
            list<SelectOption> lstTempProjects = new list<SelectOption>();
            lstTempProjects.add(new SelectOption('', '--Select Project--'));
            for(Project__c objProj : [select id, name from Project__c])
            {
                if(objProj.name != null)
                    lstTempProjects.add(new SelectOption(objProj.id, objProj.name));
            }
            return lstTempProjects;
        }
        set;
    }
    
   /* public list<SelectOption> lstStructionStages
    {
        get
        {
            errorMsg = '';
            list<SelectOption> lstTempStructionStages = new list<SelectOption>();
            lstTempStructionStages.add(new SelectOption('', '--None--'));
            if(selectedProjectId != null && selectedProjectId != '')
            {
                list<Project_Construction_Stages__c> lstConsStage = [select id, name, Sequence_No__c 
                                                                        from Project_Construction_Stages__c  
                                                                        where Project__c =: selectedProjectId 
                                                                        and tower__c = :selectedTowerId
                                                                        order by Sequence_No__c ];
                if(lstConsStage != null && lstConsStage.size() > 0)
                {
                    for(Project_Construction_Stages__c objPCS : lstConsStage )
                    {
                        if(objPCS.name != null)
                            lstTempStructionStages.add(new SelectOption(objPCS.id, objPCS.name));
                    }
                }
                else
                    errorMsg = 'Project Construction Stage not found.';
                
            }
            return lstTempStructionStages;
        }
        set;
    }
     */ 
    public list<SelectOption> lstTower
    {
        get
        {
            Set<String> stString = new Set<String>();
            errorMsg = '';
            list<SelectOption> lstTempTower = new list<SelectOption>();
            lstTempTower.add(new SelectOption('', '--None--'));
            if(selectedProjectId != null && selectedProjectId != '')
            {
                List<Tower__c> lstTowerName = new List<Tower__c>([Select Id, Name from  Tower__c where  ProjectName__c =:selectedProjectId order by Name]);
                if(lstTowerName != null && lstTowerName.size() > 0)
                {
                    for(Tower__c obj1 : lstTowerName ){
                       lstTempTower.add(new SelectOption(obj1.Id, obj1.Name));
                    }
                }
                else
                    errorMsg = 'Project Tower not found.';
                
            }
            return lstTempTower;
        }
        set;
    }
    
    public list<SelectOption> getRMs
    {
        get
        {
            Set<String> stRMs = new Set<String>();
            errorMsg = '';
            list<SelectOption> lstTempRM = new list<SelectOption>();
            lstTempRM.add(new SelectOption('All', 'Select a RM'));
            if(selectedProjectId != null && selectedProjectId != '')
            {
                
                objSCPPD3 = [Select PTP_Date__c,Id,Name,Customer_Pay_Plan_Header__r.Customer__r.Name,Customer_Pay_Plan_Header__r.Customer__r.Account.Id,Customer_Pay_Plan_Header__r.Customer__r.Total_Interest_Waiver__c,Total_Interest_Amount__c,
                Customer_Pay_Plan_Header__r.Customer__r.Account.PersonMobilePhone,Customer_Pay_Plan_Header__r.Booking__r.Unit_No__r.Name,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Relation__c,
                Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Name__c,Customer_Pay_Plan_Header__r.Booking__r.Future_Correspondence_Contact_Phone__c,
                Customer_Pay_Plan_Header__r.Customer__c, Is_to_be__c, Charge_Amount_Billed__c, Charge_Amount_Due__c, Charge_Amount_Paid__c, 
                 PTP_Amount__c,PTP_Instrument__c, IsPaymentOverdue__c, Last_Call_Disposition__c,Service_Tax_Amount_Billed__c, Service_Tax_Amount_Due__c,Customer_Pay_Plan_Header__r.Quotation__r.Booking__r.Owner.Name,
                Customer_Pay_Plan_Header__r.Booking__r.Funding_Status__c,Customer_Pay_Plan_Header__r.Booking__r.Owner.Name
                From Standard_Customer_Pay_Plan_Detail__c 
                where (((Charge_Amount_Due__c >0 and PTP_Date__c = null) or (Charge_Amount_Due__c >0 and PTP_Date__c < :System.today()))
                and Project__c =: selectedProjectId )];
                
              
                if(objSCPPD3 != null && objSCPPD3.size() > 0)
                {
                    for(Standard_Customer_Pay_Plan_Detail__c y : objSCPPD3)
                    {
                        if(y.Customer_Pay_Plan_Header__r.Booking__r.Owner.Name != null)
                        {
                           stRMs.add(y.Customer_Pay_Plan_Header__r.Booking__r.Owner.Name);
                        }
                    }
                    System.Debug('RM set'+stRMs);
                }
                else
                    errorMsg = 'No RMs found.';
               
               for (String r : stRMs) 
               {
                    lstTempRM.add(new SelectOption(r, r));
               }
                    
                    
                
            }
            return lstTempRM;
        }
        set;
    }
    
    
    public void dummy(){
      
    }
    
    // retrieves the row wrapper containing the wrapped tower name headings
   /** public Set<String> getTowerNames()
    {
      
        if(pendingDemandsList == null)  {
          towerNames = new Set<String>();
          customerTowerMap = new Map<String, list<DemandManagementServices.wrpCustomers>>();
          pendingDemandsList = new list<DemandManagementServices.wrpCustomers>(); 
          pendingDemandsList = DemandManagementServices.searchAllPendingDemands();
          for(DemandManagementServices.wrpCustomers pdc : pendingDemandsList) {
            System.debug('Customer details:' + pdc);
            if(customerTowerMap.containsKey(pdc.projectName + '-' +pdc.towerName))
              customerTowerMap.get(pdc.projectName + '-' +pdc.towerName).add(pdc);
            else {
              list<DemandManagementServices.wrpCustomers> customerTowerWise = new list<DemandManagementServices.wrpCustomers>();
              customerTowerWise.add(pdc);
              customerTowerMap.put(pdc.projectName + '-' +pdc.towerName, customerTowerWise);
            }
            towerNames.add(pdc.projectName + '-' +pdc.towerName);
          }
        }
        System.debug('Tower Names:' + towernames);
        System.debug('customerTowerMap:' + customerTowerMap);
        if(pendingDemandsList.size()  >0){
          return towerNames;
        }

        return null;
    }
    
    public void getCustomersTowerWise() {
      customerTowerList = new list<DemandManagementServices.wrpCustomers>();
      String towerName = Apexpages.currentPage().getParameters().get('towerName');
      System.debug('Tower Name in get customers : customerTowerMap' + towerName + customerTowerMap);
      if(pendingDemandsList == null)  {
      getTowerNames();
      } 
      if(customerTowerMap.containsKey(towerName))
        customerTowerList = customerTowerMap.get(towerName);
      System.debug('Customer Tower List:' + customerTowerList);
    } **/
 
   
}