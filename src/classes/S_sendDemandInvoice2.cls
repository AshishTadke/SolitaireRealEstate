public with sharing class S_sendDemandInvoice2 
{
    public string errorMsg {get;set;}
    public datetime dtSelectedDate {get;set;}
    public string selectedProjectId {get;set;}
    public string selectedConsStageId {get;set;}
    public string selectedCriteria {get;set;}
    public string tabName {get;set;}
    public string selectedTowerId {get;set;}
    public String latestTowerName {get;set;}
    public Standard_Customer_Pay_Plan_Detail__c objSCPPD {get;set;}
    public Standard_Customer_Pay_Plan_Detail__c objSCPPD1 {get;set;}
    // pending flat cost demands
    public list<DemandManagementServices.wrpCustomers> lstCustomers {get;set;} 
    public list<DemandManagementServices.wrpCustomers> pendingDemandsList {get;set;} 
    public Map<String, list<DemandManagementServices.wrpCustomers>> customerTowerMap  {get;set;}
    public Set<String> towerNames {get;set;}
    public List<towerWrapper> tw {get;set;}
    public Map<String,Integer> twMap {get;set;}
    
    public list<DemandManagementServices.wrpCustomersNew> customerTowerList {get;set;}
    
    // pending registration demands
    public list<DemandManagementServices.wrpCustomers> pendingDemandsListReg {get;set;} 
    public Map<String, list<DemandManagementServices.wrpCustomers>> customerTowerMapReg  {get;set;}
    public Set<String> towerNamesReg {get;set;}
    public list<DemandManagementServices.wrpCustomers> customerTowerListReg {get;set;}
    
    // pending cancellations
    public list<DemandManagementServices.wrpCustomersCan> pendingCancellationList {get;set;} 
    public Map<String, list<DemandManagementServices.wrpCustomersCan>> customerTowerMapCan  {get;set;}
    public Set<String> towerNamesCan {get;set;}
    public list<DemandManagementServices.wrpCustomersCan> customerTowerListCan {get;set;}
    
    
    public List<Booking__c> lstBooking {get; set;}
    
    public String strBookingId {get; set;}
    
    public wrpDemand wrpDemand {get;set;}
    public String strDemandInvId {get; set;}
    public Integer rowIndex {get;set;}
    public String selectedTab {get;set;}
    public PaginationController.PaginationWrapper pgw;
    public String towerName;
    public String projectName;
    public Boolean showCloseBtn {get;set;}
    
    public S_sendDemandInvoice2()
    {
        errorMsg = '';
        selectedCriteria='';
        objSCPPD = new Standard_Customer_Pay_Plan_Detail__c();
        objSCPPD1 = new Standard_Customer_Pay_Plan_Detail__c();
        lstCustomers = new list<DemandManagementServices.wrpCustomers>();
        pendingDemandsList = null;
        pendingCancellationList = null;
        towerNames = null;
        selectedTab = 'name1';
        tabName = '';
        latestTowerName = '';
        tw = new List<towerWrapper>();
        twMap = new Map<String,integer>();
        showCloseBtn = false;
        
        // Documentcheck list page sends Booking id here.
        if(ApexPages.currentPage().getParameters().get('bookingId') != null && ApexPages.currentPage().getParameters().get('bookingId') != '')
        {
            strBookingId = ApexPages.currentPage().getParameters().get('bookingId');        
            lstBooking = [Select Id, Project__c, Project__r.Name, Customer__c from Booking__c Where Id =: strBookingId];
            if(lstBooking != null && lstBooking.size() > 0) {
                selectedTab = 'name1';
                tabName = '';
                search();
            }
                
        }
        if(ApexPages.currentPage().getParameters().containsKey('pageName')){
                if(ApexPages.currentPage().getParameters().get('pageName') != null){
                       showCloseBtn = true;
                }
        }
        
        if(!Test.isRunningTest())
            getTowerwiseDemandSummary();
        else
            getTowerNamesNew();
        
        getTowerNamesReg();
        getTowerNamesCan();
    }
   
    public list<SelectOption> searchOptions
    {
        get
        {
            list<SelectOption> searchOptions = new list<SelectOption>();
            searchOptions.add(new SelectOption('Construction Stage', 'Construction Stage'));
            searchOptions.add(new SelectOption('Due Date', 'Due Date'));
            return searchOptions;
        }
        set;
    }
    
    

    public list<SelectOption> lstProjects 
    {
        get
        {
            lstProjects = null;
            list<SelectOption> lstTempProjects = new list<SelectOption>();
            lstTempProjects.add(new SelectOption('', '--None--'));
            for(Project__c objProj : [select id, name from Project__c])
            {
                if(objProj.name != null)
                    lstTempProjects.add(new SelectOption(objProj.id, objProj.name));
            }
            return lstTempProjects;
        }
        set;
    }
    
    public list<SelectOption> lstStructionStages
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
    public void dummy(){
        
    }
    
    // retrieves the row wrapper containing the wrapped tower name headings
    public List<towerWrapper> getTowerNamesNew()
    {
        if(pendingDemandsList == null)  {
            customerTowerMap = new Map<String, list<DemandManagementServices.wrpCustomers>>();
            pendingDemandsList = new list<DemandManagementServices.wrpCustomers>(); 
            pendingDemandsList = DemandManagementServices.searchAllPendingDemands();
            Decimal totalAmount = 0;
            String pname = '';
            for(DemandManagementServices.wrpCustomers pdc : pendingDemandsList) {
                System.debug('Customer details:' + pdc);
                if(customerTowerMap.containsKey(pdc.towerName))
                    customerTowerMap.get(pdc.towerName).add(pdc);
                else {
                    list<DemandManagementServices.wrpCustomers> customerTowerWise = new list<DemandManagementServices.wrpCustomers>();
                    customerTowerWise.add(pdc);
                    customerTowerMap.put(pdc.towerName, customerTowerWise);
                }
            }
            for(String towerName : customerTowerMap.keySet()) {
                for(DemandManagementServices.wrpCustomers pdc : customerTowerMap.get(towerName)) {
                    totalAmount += pdc.InstallAmt;
                    pname = pdc.projectName;
                }
                tw.add(new towerWrapper(pname,  towerName, customerTowerMap.get(towerName).size() , QuotationManagementServices.INFormat(totalAmount), S_NumberToWord.convertNumberToWords(totalAmount)) );
                totalAmount = 0;
                pname = '';
                system.debug('twList:' + tw);
            }
        }
        System.debug('customerTowerMap:' + customerTowerMap);
        if(pendingDemandsList.size()  >0){
            pendingDemandsList = null;
            return tw;
        }

        return null;
    }
    
    // retrieves the row wrapper containing the wrapped tower name headings
    // latest method to get the demands that uses pagination
    public List<towerWrapper> getTowerwiseDemandSummary()
    {
        customerTowerMap = new Map<String, list<DemandManagementServices.wrpCustomers>>();
        pendingDemandsList = new list<DemandManagementServices.wrpCustomers>(); 
        pendingDemandsList = DemandManagementServices.searchAllPendingDemands();
        Decimal totalAmount = 0;
        String pname = '';
        for(DemandManagementServices.wrpCustomers pdc : pendingDemandsList) {
            System.debug('Customer details:' + pdc);
            if(customerTowerMap.containsKey(pdc.towerName))
                customerTowerMap.get(pdc.towerName).add(pdc);
            else {
                list<DemandManagementServices.wrpCustomers> customerTowerWise = new list<DemandManagementServices.wrpCustomers>();
                customerTowerWise.add(pdc);
                customerTowerMap.put(pdc.towerName, customerTowerWise);
            }
        }
        for(String towerName : customerTowerMap.keySet()) {
            for(DemandManagementServices.wrpCustomers pdc : customerTowerMap.get(towerName)) {
                totalAmount += pdc.InstallAmt;
                pname = pdc.projectName;
            }
            tw.add(new towerWrapper(pname,  towerName, customerTowerMap.get(towerName).size() , QuotationManagementServices.INFormat(totalAmount), S_NumberToWord.convertNumberToWords(totalAmount)) );
            twMap.put(pname+towerName,customerTowerMap.get(towerName).size() );
            totalAmount = 0;
            pname = '';
            system.debug('twList:' + tw);
        }
        customerTowerMap = null;
        pendingDemandsList = null;
        if(tw.size()  >0){
            return tw;
        }
        return null;
    }
    public void getCustomersTowerWise() {
        customerTowerList = new list<DemandManagementServices.wrpCustomersNew>();
        towerName = Apexpages.currentPage().getParameters().get('towerName');
        projectName = Apexpages.currentPage().getParameters().get('projectName');
        System.debug('Tower Name in get customers : ' + towerName + ':' + projectName);
        pgw = new PaginationController.PaginationWrapper();
        pgw.list_size = 10;
        pgw.counter = 0;
        customerTowerList = DemandManagementServices.searchAllPendingDemands(towerName, projectName, pgw.list_size, pgw.counter); 
        system.debug('customerTowerList:::'+customerTowerList);      
        if(twMap.containsKey(projectName+towerName))
        pgw.total_size = twMap.get(projectName+towerName);
        latestTowerName = towerName;
    }
 
  // retrieves the row wrapper containing the wrapped tower name headings for registration pending tab
    public Set<String> getTowerNamesReg()
    {
        
        if(pendingDemandsListReg == null)  {
            towerNamesReg = new Set<String>();
            customerTowerMapReg = new Map<String, list<DemandManagementServices.wrpCustomers>>();
            pendingDemandsListReg = new list<DemandManagementServices.wrpCustomers>(); 
            pendingDemandsListReg = DemandManagementServices.searchCustomersForRegistration();
            for(DemandManagementServices.wrpCustomers pdc : pendingDemandsListReg) {
                System.debug('Customer details:' + pdc);
                if(customerTowerMapReg.containsKey(pdc.projectName + '-' +pdc.towerName))
                    customerTowerMapReg.get(pdc.projectName + '-' +pdc.towerName).add(pdc);
                else {
                    list<DemandManagementServices.wrpCustomers> customerTowerWiseReg = new list<DemandManagementServices.wrpCustomers>();
                    customerTowerWiseReg.add(pdc);
                    customerTowerMapReg.put(pdc.projectName + '-' +pdc.towerName, customerTowerWiseReg);
                }
                towerNamesReg.add(pdc.projectName + '-' +pdc.towerName);
            }
        }
        System.debug('Tower Names Registration:' + towernamesReg);
        System.debug('customerTowerMap Registration:' + customerTowerMapReg);
        if(pendingDemandsListReg.size()  >0){
            pendingDemandsListReg = null;
            return towerNamesReg;
        }

        return null;
    }
    
    public void getCustomersTowerWiseReg() {
        customerTowerListReg = new list<DemandManagementServices.wrpCustomers>();
        String towerNameReg = Apexpages.currentPage().getParameters().get('towerNameReg');
        System.debug('Tower Name in get customers for registration : customerTowerMapReg' + towerNameReg + customerTowerMapReg);
        if(pendingDemandsListReg == null)  {
            getTowerNamesReg();
        } 
        if(customerTowerMapReg.containsKey(towerNameReg))
            customerTowerListReg = customerTowerMapReg.get(towerNameReg);
        System.debug('Customer Tower List:' + customerTowerListReg);
    }

    // retrieves the row wrapper containing the wrapped tower name headings for pending cancellation tab
    public Set<String> getTowerNamesCan()
    {
        if(pendingCancellationList == null)  {
            towerNamesCan = new Set<String>();
            customerTowerMapCan = new Map<String, list<DemandManagementServices.wrpCustomersCan>>();
            pendingCancellationList = new list<DemandManagementServices.wrpCustomersCan>(); 
            pendingCancellationList = DemandManagementServices.searchCustomersForCancellation();
            for(DemandManagementServices.wrpCustomersCan cancel : pendingCancellationList) {
                System.debug('Customer details:' + cancel);
                if(customerTowerMapCan.containsKey(cancel.intimationRec.Unit__r.Project__r.Name + '-' +cancel.intimationRec.Unit__r.TowerName__r.Name))
                    customerTowerMapCan.get(cancel.intimationRec.Unit__r.Project__r.Name + '-' +cancel.intimationRec.Unit__r.TowerName__r.Name).add(cancel);
                else {
                    list<DemandManagementServices.wrpCustomersCan> customerTowerWiseCan = new list<DemandManagementServices.wrpCustomersCan>();
                    customerTowerWiseCan.add(cancel);
                    customerTowerMapCan.put(cancel.intimationRec.Unit__r.Project__r.Name + '-' +cancel.intimationRec.Unit__r.TowerName__r.Name, customerTowerWiseCan);
                }
                towerNamesCan.add(cancel.intimationRec.Unit__r.Project__r.Name + '-' +cancel.intimationRec.Unit__r.TowerName__r.Name);
            }
        }
        System.debug('Tower Names Cancellation:' + towernamesCan);
        System.debug('customerTowerMap Cancellation:' + customerTowerMapCan);
        if(pendingCancellationList.size()  >0){
            pendingCancellationList = null;
            return towerNamesCan;
        }

        return null;
    }

    public void getCustomersTowerWiseCan() {
        customerTowerListCan = new list<DemandManagementServices.wrpCustomersCan>();
        String towerNameCan = Apexpages.currentPage().getParameters().get('towerNameCan');
        System.debug('Tower Name in get customers for cancellation : customerTowerMapCan' + towerNameCan + customerTowerMapCan);
        if(pendingCancellationList == null)  {
            getTowerNamesCan();
        } 
        if(customerTowerMapCan.containsKey(towerNameCan))
            customerTowerListCan = customerTowerMapCan.get(towerNameCan);
        System.debug('Customer Tower List Cancel:' + customerTowerListCan);
    }
    
    public void search()
    {
        lstCustomers = new list<DemandManagementServices.wrpCustomers>();
        errorMsg = '';
        if((lstBooking == null || lstBooking.size() > 0) && selectedConsStageId != null && selectedConsStageId != '' && 
                selectedProjectId != null && selectedProjectId != '' && selectedTowerId != null && selectedTowerId != '' && selectedCriteria != null && selectedCriteria.equals('Construction Stage')){
            Set<Id> constStageSet = new Set<Id>();
            constStageSet.add(selectedConsStageId);
            lstCustomers = DemandManagementServices.searchCustomersBasedOnStage(constStageSet);
            if(lstCustomers.size() == 0) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'No customers found matching the criteria selected. Please, REFINE the criteria and search again.'));
            } 
        } else if(selectedCriteria != null &&  selectedCriteria.equals('Due Date') && objSCPPD.Due_Date__c != null &&  objSCPPD1.Due_Date__c != null && selectedProjectId != null && 
                                                                                selectedProjectId != '' && selectedTowerId != null && selectedTowerId != '') {
            lstCustomers = DemandManagementServices.searchCustomersBasedOnDates(objSCPPD.Due_Date__c, objSCPPD1.Due_Date__c, selectedProjectId, selectedTowerId);
            if(lstCustomers.size() == 0) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'No customers found matching the criteria selected. Please, REFINE the criteria and search again.'));
            } 
        }
        else if(lstBooking != null && lstBooking.size() > 0 && (selectedConsStageId == null || selectedConsStageId == '') && (selectedProjectId == null || selectedProjectId == '') 
                                                                                && (selectedTowerId == null || selectedTowerId == '')){
            // Day 0 Demand Customers, shows up in search tab   
            lstCustomers = DemandManagementServices.searchCustomersForDay0Demand(lstBooking);
            if(lstCustomers.size() == 0) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'No customers found matching the criteria selected. Please, REFINE the criteria and search again.'));
            }   
            
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Please select all the required parameters'));
        }
    }

    public PageReference showPreview() {
        String milestoneList = '';
        String demandType = '';
        DemandManagementServices.wrpCustomersNew wrpCustomer = new DemandManagementServices.wrpCustomersNew();
        DemandManagementServices.wrpCustomers wrpCustomerOld = new DemandManagementServices.wrpCustomers();
        DemandManagementServices.wrpCustomersCan wrpCancel = new DemandManagementServices.wrpCustomersCan();
        System.debug('rowIndex:tabName' + rowIndex + ':' + tabName);
        if(tabName.equals('pendingDemands')) {
            demandType = 'FlatCost';
            wrpCustomer=  customerTowerList[rowIndex]; 
        } else if(tabName.equals('pendingRegistrations')) {
            demandType = 'registration';
            wrpCustomerOld = customerTowerListReg[rowIndex]; 
        } else if(tabName.equals('search') && lstBooking != null){
            demandType = 'FlatCost';
            wrpCustomerOld = lstCustomers[rowIndex]; 
        } else if(tabName.equals('pendingCancellations')){
            wrpCancel = customerTowerListCan[rowIndex]; 
            milestoneList = null;
        } 
        for(Id ms : wrpCustomer.scppdBundleMap.keyset()) {
            mileStoneList += ms + ',';
        } 
        // Incase of registration demands, populate the opportunity id as the milestone
        if(demandType.equalsIgnoreCase('registration')) {
            mileStoneList = wrpCustomerOld.OpportunityId;
        }
        // remove the last character only if its a comma.
        if(mileStoneList != null && mileStoneList.length() > 0 && mileStoneList.substring(mileStoneList.length() -1).equals(','))
            mileStoneList = mileStoneList.substring(0,mileStoneList.length() -1);

        if(mileStoneList != null) {
            PageReference pageRef = new PageReference('/apex/DemandLetterTemplate');
            pageRef.getParameters().put('mileStoneList',mileStoneList);
            pageRef.getParameters().put('demandType',demandType);
            pageRef.getParameters().put('mode','preview');
            pageRef.getParameters().put('letterHead','true');
            System.debug('pageref:' + PageRef);
            return pageRef;
        } else if(tabName.equals('pendingCancellations')){
            PageReference pageRef = new PageReference('/apex/S_CancellationPage');
            pageRef.getParameters().put('mode','preview');
            pageRef.getParameters().put('letterHead','true');
            pageRef.getParameters().put('cancelId', wrpCancel.intimationRec.Id );
            System.debug('pageref:' + PageRef);
            return pageRef;
        } else {
            return null;
        }
        return null;
    }

    public void SendMail()
    {
        boolean selected = false;
        boolean error = false;
        string msg = '';
        System.debug('tabName:' + tabName);
        List<DemandManagementServices.wrpCustomersNew> commonList = new List<DemandManagementServices.wrpCustomersNew>();
        List<DemandManagementServices.wrpCustomersNew> selectedList = new List<DemandManagementServices.wrpCustomersNew>();
        List<DemandManagementServices.wrpCustomersNew> notselectedList = new List<DemandManagementServices.wrpCustomersNew>();
        List<DemandManagementServices.wrpCustomers> commonList1 = new List<DemandManagementServices.wrpCustomers>();
        List<DemandManagementServices.wrpCustomersCan> commonListCan = new List<DemandManagementServices.wrpCustomersCan>();
        List<DemandManagementServices.wrpCustomersCan> selectedListCan = new List<DemandManagementServices.wrpCustomersCan>();
        List<DemandManagementServices.wrpCustomersCan> notselectedListCan = new List<DemandManagementServices.wrpCustomersCan>();
        //data is coming from one of three tabs. we need to identify which one , check if any one or more are selected for processing the demand
        // and based on which tab it is coming from, create flat cost demands, registration demands and so on
        if(
            (lstCustomers != null && lstCustomers.size() > 0) || 
            (customerTowerListReg != null && customerTowerListReg.size() > 0) ||
            (customerTowerList != null && customerTowerList.size() > 0) || 
            (customerTowerListCan != null && customerTowerListCan.size() > 0)                       
        ) {
            if(tabName.equals('pendingDemands')) {
                if(customerTowerList.size() > 0) {
                    // commenting this part where we enforce that all demands that are not being raised should be deferred
                     for(DemandManagementServices.wrpCustomersNew wc : customerTowerList) {
                        if(!wc.selected && (string.isBlank(wc.scppd.Reason_For_Deferment__c) || wc.scppd.Revised_Invoice_Date__c == null || wc.scppd.Revised_Invoice_Date__c < system.today())) {
                            if(Test.isRunningTest()) {
                               wc.style = 'error';
                               error = true;
                            }
                        }
                    }
                    if(error) {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'For invoices that are not being raised please select a reason for deferment and revised future invoice date'));
                        return;
                    }
                    commonList = customerTowerList;
                }
            }  else if(tabName.equals('pendingRegistrations')) {
                if(customerTowerListReg.size() > 0) {
                  selected = true;
                    commonList1 = customerTowerListReg;
                } 
            
            } /**else if (lstCustomers.size() > 0 && strBookingId != null && strBookingId != '') {
                commonList = lstCustomers;
            }  **/ else if (tabName.equals('pendingCancellations'))  {
                if(customerTowerListCan.size() > 0) {
                  selected = true;
                    commonListCan = customerTowerListCan;
                }
            }
            else {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error Occurred, Unable to identify the tab from which this demand is being selected'));
            }
            for(DemandManagementServices.wrpCustomersNew wc : commonList) {
                if(wc.selected) {
                    selected = true;
                    selectedList.add(wc);
                } else {
                    // introducing this list , as demands that not selected should be updated with the deferment reason. 
                    notselectedList.add(wc);
                }
            }
            for(DemandManagementServices.wrpCustomersCan wc : commonListCan) {
                if(wc.selected) {
                    selected = true;
                    selectedListCan.add(wc);
                } else {
                    // introducing this list , as demands that not selected should be updated with the deferment reason. 
                    notselectedListCan.add(wc);
                }
            }
            if(!selected && !tabName.equals('pendingDemands') ) {
                // for other tabs if no customer record is selcted for sending the demands out, throw an error. In case of pending demands tab, the logic is different
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'No customer records selected. please select a customer for processing'));
            } else {
                if(tabName.equals('pendingDemands')) {
                    List<DemandManagementServices.wrpCustomersNew> tempList1 = new List<DemandManagementServices.wrpCustomersNew>();
                    List<DemandManagementServices.wrpCustomersNew> tempList2 = new List<DemandManagementServices.wrpCustomersNew>();
                    if(selectedList.size() > 0) {
                        for(DemandManagementServices.wrpCustomersNew wc : selectedList) {
                            if(wc.StageName.equalsIgnorecase('0Day(s) from date of booking.')) {
                                tempList1.add(wc);
                            } else {
                                tempList2.add(wc);
                            }
                        }
                        if(tempList1.size() > 0)
                            DemandManagementServices.createDINew(tempList1);
                        if(tempList2.size() > 0)
                            DemandManagementServices.createDINew(tempList2);
                        msg = 'Demands have been raised for the selected customers';
                    } 
                    if(notselectedList.size() >0) {
                        List<Standard_Customer_Pay_Plan_Detail__c> scppdList  = new List<Standard_Customer_Pay_Plan_Detail__c>();
                        for(DemandManagementServices.wrpCustomersnew wc : notselectedList) {
                          for(Standard_Customer_Pay_Plan_Detail__c s : wc.scppdBundleMap.values()) {
                            s.Revised_Invoice_Date__c = wc.scppd.Revised_Invoice_Date__c;
                            s.Reason_for_deferment__c = wc.scppd.Reason_for_deferment__c;
                            scppdList.add(s);
                          }
                            
                        }
                        update scppdList;
                        if(string.isNotBlank(msg)) {
                            msg += 'and deferment updates have been made';
                        } else  {
                            msg =  'Deferment updates have been made';
                        }
                    }
                } else if(tabName.equals('pendingRegistrations')) {
                    if(commonList1.size() > 0)
                        DemandManagementServices.createDIForRegistration(commonList1,'Registration',false, true);
                    msg = 'Registration Intimations have been sent to the selected customers';
                } else if(tabName.equals('pendingCancellations')) {
                    if(selectedListCan.size() > 0)
                        DemandManagementServices.sendCancellations(selectedListCan);
                    msg = 'Cancellation Intimations have been sent to the selected customers';
                }else {
                    if(selectedList.size() > 0 && strBookingId != null && strBookingId != '')
                        DemandManagementServices.createDINew(selectedList);
                }
            }
        }
        else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error Occurred, No customer data to process'));
        }
        if(tabName.equals('pendingDemands')) {
            pendingDemandsList = null;
            customerTowerList = null;
            towerNames = null;
            tw = new List<towerWrapper>();
            twMap = new Map<String,Integer>();
            getTowerwiseDemandSummary();        
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, msg));
        }
         if(tabName.equals('pendingRegistrations')) {
            pendingDemandsListReg = null;
            customerTowerListReg = null;
            towerNamesReg = null;
            tw = new List<towerWrapper>();
            getTowerNamesReg();
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, msg));
        }
        if(tabName.equals('pendingCancellations')) {
            pendingCancellationList = null;
            customerTowerListCan = null;
            towerNamesCan = null;
            tw = new List<towerWrapper>();
            getTowerNamesCan();
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, msg));
        }
        
    } 
    public class towerWrapper {
        public String project {
            get;
            set;
        }
        public String towerName {
            get;
            set;
        }
        public Integer count {
            get;
            set;
        }
        public string amount {
            get;
            set;
        }
        public string strAmtWords {
            get;
            set;
        }
        public towerWrapper(string pname, string name, integer count, string amount, string words) {
            this.project = pname;
            this.towerName = name;
            this.count = count;
            this.amount = amount;
            this.strAmtWords = words;
        }
    }

    public PageReference Beginning() { //user clicked beginning
        pgw= PaginationController.Beginning(pgw);
        customerTowerList = DemandManagementServices.searchAllPendingDemands(towerName, projectName, pgw.list_size, pgw.counter);  
        return null;
    }

    public PageReference Previous() { //user clicked previous button
       pgw = PaginationController.Previous(pgw);
       customerTowerList = DemandManagementServices.searchAllPendingDemands(towerName, projectName, pgw.list_size, pgw.counter);
       return null;
    }

    public PageReference Next() { //user clicked next button
        pgw = PaginationController.Next(pgw);
        customerTowerList = DemandManagementServices.searchAllPendingDemands(towerName, projectName, pgw.list_size, pgw.counter);
        return null;
    }

    public PageReference End() { //user clicked end
        system.debug('PGW:' + pgw);
        pgw = PaginationController.End(pgw);
        customerTowerList = DemandManagementServices.searchAllPendingDemands(towerName, projectName, pgw.list_size, pgw.counter);
        return null;
    }
    
    public Boolean getDisablePrevious() { //this will disable the previous and beginning buttons
        system.debug('PGW:' + pgw);
        return(PaginationController.DisablePrevious(pgw));
    }

    public Boolean getDisableNext() { //this will disable the next and end buttons
        system.debug('PGW:' + pgw);
       return(PaginationController.DisableNext(pgw));
    }
    
    public Integer getTotal_size() {
        return (PaginationController.getTotal_size(pgw));
    }
    
    public Integer getPageNumber() {
         return (PaginationController.getPageNumber(pgw));
    }

    public Integer getTotalPages() {
        return (PaginationController.getTotalPages(pgw));
    }
}