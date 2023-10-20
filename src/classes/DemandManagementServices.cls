public with sharing class DemandManagementServices {
    
    public static void createDINew(List<wrpCustomersNew> lstCustomers){
        List < Demand_Invoice__c > lstDemandInvoice = new List < Demand_Invoice__c > ();
        Map<String,List<Tax_Breakup__c>> taxSlabMap = InventoryCostServices.getChildTaxSlabs();
        Map<Id,Map<String, Map<String,Decimal>>> summaryMap = new Map<Id,Map<String, Map<String,Decimal>>>();
        Map<Id, Set<String>> chargeNamesMap = new Map<Id , Set<String>>();
        Set<Id> oppIdSet = new Set<Id>();
        Set<String> uniqueKeySet = new Set<String>();
        for(wrpCustomersNew o : lstCustomers) {
            oppIdSet.add(o.OpportunityId);
            uniqueKeySet.add(o.uniqueKey);
        }
        // this is for creating the current demand details in the demand details table
        Map<String, wrpDemand> wdMap = getCurrentDemandDetailsB(lstCustomers);
        System.debug('List of customer in createDI:' + lstCustomers.size());
        Integer loopCounter = 1;
        if (lstCustomers != null && lstCustomers.size() > 0) {
            for (wrpCustomersNew objWRP: lstCustomers) {
                System.debug(LoopCounter + ':customer:' + objWRP);
                Demand_Invoice__c objDemInvoice = new Demand_Invoice__c();
                objDemInvoice.Customer__c = objWRP.OpportunityId;
                
                if (objWRP.EmailId != null && objWRP.EmailId != '') objDemInvoice.Email__c = objWRP.EmailId;
                if(objWRP.RMEmail != null && objWRP.RMEmail != '') objDemInvoice.Booking_Owner_Email__c = objWRP.RMEmail;  
                if (objWRP.OthersEmailId != null && objWRP.OthersEmailId != '')  {
                     String[] objEmailList = objWRP.OthersEmailId.split(',');
                        for(Integer i=0; i< objEmailList.size(); i++) {
                            if(i == 0)
                                objDemInvoice.cc1_Email__c = objEmailList[0];
                            if(i==1)
                                objDemInvoice.cc2_Email__c =objEmailList[1];
                            if(i==2)
                                objDemInvoice.cc3_Email__c =objEmailList[2];
                            if(i==3)
                                objDemInvoice.cc4_Email__c =objEmailList[3];
                        }
                }
                if (objWRP.FutureCorresEmailId != null && objWRP.FutureCorresEmailId != '')  {
                    objDemInvoice.Future_Correspondence_Email__c = objWRP.FutureCorresEmailId;
                }
               
                if (objWRP.InvoiceDate != null) objDemInvoice.Invoice_Date__c = objWRP.InvoiceDate;
                if (objWRP.InvoiceDueDate != null) objDemInvoice.Due_Date__c = objWRP.InvoiceDueDate;
                if(objWRP.StageName.equalsIgnorecase('0Day(s) from date of booking.'))
                    objDemInvoice.Day_0_demand_generation__c = true;
                
                if(objWRP.RMID != null && string.isNotBlank(objWRP.RMID)) {
                    objDemInvoice.ownerId = objWRP.RMID;
                }
                objDemInvoice.project__c = objWRP.projectID;
                objDemInvoice.unique_key__c = objWRP.uniqueKey;
                objDemInvoice.Milestone_Name__c = objWRP.stageName;
                lstDemandInvoice.add(objDemInvoice);
                loopCounter++;
            }
        }
        
        List<Id> dId = new List<Id>();
        if (lstDemandInvoice.size() > 0) {
            Database.SaveResult[] resultLst = Database.insert(lstDemandInvoice);
            for(Database.SaveResult r : resultLst) {
                if(r.isSuccess()) {
                    dId.add(r.getId());
                }
            }
        }
        List<Demand_Invoice__c> diList = [Select Id, Name, Customer__c,Standard_Customer_Pay_Plan_Detail__c, Standard_Customer_Pay_Plan_Detail__r.Id, 
                                            Customer__r.Id, Project_Construction_Stage__c, Invoice_Date__c,Due_Date__c,
                                            Current_Demand_Installment__c, Current_Demand_Service_Tax__c,unique_key__c
                                            from Demand_Invoice__c where Id in :dId];
        
        Map<String,Id> customerDIMap = new Map<String,Id>();
        Map<String,Id> customerDIMap1 = new Map<String,Id>();
        for(Demand_Invoice__c di : diList) {
            customerDIMap.put(di.unique_key__c, di.Id);
            customerDIMap1.put(di.Customer__c, di.Id);
        }
        System.debug('Customer DI Map:' + customerDIMap);
        System.debug('current demand details:' + wdMap);
        // this is for creating the current demand details.
        List<Demand_Detail__c> ddList = new List<demand_detail__c>();
        Integer count = 1;
        Integer fieldCount = 1;
        Decimal AmountTobeBilled = 0;
        Decimal totalAmt = 0;
        Decimal totalTax = 0;
        Map<String, Decimal> diDDMap = new Map<String, Decimal>();
        // for each Customer
        for(String o : wdMap.keySet()) {
            // for each charge in the demand
            for(String eachCharge : wdMap.get(o).chargenameMap.keySet()){
                Demand_Detail__c dd = new Demand_Detail__c();
                dd.Type__c = 'Current';
                dd.Installment_Amount__c = wdMap.get(o).chargeAmountMapD.get(eachCharge);
                dd.Total_Amount__c = wdMap.get(o).ChargeOverallTotalD.get(eachCharge);
                dd.Demand_Invoice__c = customerDIMap.get(o);
                dd.charge_name__c = eachCharge;
                fieldCount = 1;
                AmounttobeBilled = 0;
                for(Standard_Customer_Pay_Plan_Detail__c scppd : wdMap.get(o).scppdChargeMap.get(eachCharge)) {
                    String fieldSCPPD = 'scppd_' + fieldCount + '__c';
                    String fieldSCPPDAmt = 'scppd_amount_' + fieldCount +  '__c';
                    if(scppd.Charge_Amount_Billed__c != null && scppd.Charge_Amount_Billed__c >0 && scppd.Installment__c != null && scppd.Installment__c >0) {
                        AmountTobeBilled = (scppd.Installment__c - scppd.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                    } else if (scppd.Installment__c != null && scppd.Installment__c >0) {
                        AmountTobeBilled = scppd.Installment__c.setscale(0,RoundingMode.HALF_UP);
                    }
                    dd.put(fieldSCPPD, scppd.Id);
                    dd.put(fieldSCPPDAmt, AmountToBeBilled);
                    fieldCount ++;
                    AmountTobeBilled = 0;
                }
                System.debug('tax names:' + wdMap.get(o).taxNames);
                count = 1;
                for(string t : wdMap.get(o).taxNames) {
                    String fieldTaxableAmount = 'Taxable_Amount_' + count + '__c';
                    String fieldTaxAmount = 'Tax_Amount_' + count  + '__c';
                    String fieldTaxBreakupId = 'Tax_Breakup_' + count  + '__c';
                    dd.put(fieldTaxAmount, wdMap.get(o).chargeTaxMapD.get( eachCharge + ' ' + t + ' TAX AMT'));
                    dd.put(fieldTaxableAmount, wdMap.get(o).chargeTaxMapD.get(eachCharge + ' ' + t + ' TAXABLE AMOUNT'));
                    System.debug('charge tax map for tax breakup:' + wdMap.get(o).chargeTaxMap);
                    dd.put(fieldTaxBreakupId, wdMap.get(o).chargeTaxMap.get(eachCharge + ' ' + t + ' TAXRECORD ID'));
                    count ++;
                }
                dd.Total_Tax__c = wdMap.get(o).chargeTaxMapD.get(eachCharge + ' TOTAL TAX AMT');
                ddList.add(dd);
                totalTax += wdMap.get(o).chargeTaxMapD.get(eachCharge + ' TOTAL TAX AMT');
                totalAmt += wdMap.get(o).chargeAmountMapD.get(eachCharge);
            }
            diDDMap.put(CustomerDIMap.get(o) + ' TOTAL AMT', totalAmt);
            diDDMap.put(CustomerDIMap.get(o) + ' TOTAL TAX', totalTax);
            diDDMap.put(CustomerDIMap.get(o) + ' OVERALL TOTAL', totalAmt + totalTax);
            totalAmt = 0;
            totalTax = 0;
        }
        // this for creating the outstanding details records  in demand details table   
        // provides the map of outstanding charge details group by customer  
        summaryMap = getDemandSoFarSummaryOtherChargesNewB(oppIdSet);
        // names of the charges that are applicable in the outstanding demand list grouped by customer
        chargeNamesMap = getOutstandingChargesNameB(oppIdSet);  
        //we get one outstanding charges per customer.
        // but there could be multiple demands for the same customer if we are generating single demands
        // so attach the list of outstandings to each demand. 
        decimal demanded =0;
        decimal received =0;
        decimal outstanding = 0;
        decimal interest = 0;
        decimal interestST= 0;
        decimal tDemanded = 0;
        decimal tReceived = 0;
        decimal tOutstanding = 0;
        System.debug('oustanding demand details:' + summaryMap);
        if(summaryMap != null && summaryMap.size() > 0) {
            for(String demand : wdMap.keySet())   {                           
                for(Id o : summaryMap.keySet()) {
                    if(summaryMap.containsKey(o)) {
                        System.debug('What is O?:' + o);
                        for(String eachCharge : chargeNamesMap.get(o)) {
                            System.debug('Charge names:'+  eachCharge);
                            Demand_Detail__c dd = new Demand_Detail__c();
                            dd.Type__c = 'Outstanding';
                            dd.Demand_Invoice__c = customerDIMap.get(demand);
                            dd.Amount_Demanded__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' DEMANDED');
                            dd.Amount_Received__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' RECD');
                            dd.Amount_Outstanding__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' OUTSTANDING');
                            dd.Tax_Demanded__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX DEMANDED');
                            dd.Tax_Received__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX RECD');
                            dd.Tax_Outstanding__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX OUTSTANDING');
                            dd.Interest_Outstanding__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' INTEREST OUTSTANDING');
                            dd.Total_Amount__c = summaryMap.get(o).get(eachCharge).get(eachCharge + ' TOTAL OUTSTANDING');
                            dd.charge_name__c = eachCharge;
                            ddList.add(dd);
                            System.debug('in demand oustanding :' + summaryMap.get(o).get(eachCharge));
                            demanded += summaryMap.get(o).get(eachCharge).get(eachCharge + ' DEMANDED');
                            received += summaryMap.get(o).get(eachCharge).get(eachCharge + ' RECD');
                            outstanding += summaryMap.get(o).get(eachCharge).get(eachCharge + ' OUTSTANDING');
                            tDemanded += summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX DEMANDED');
                            tReceived += summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX RECD');
                            tOutstanding += summaryMap.get(o).get(eachCharge).get(eachCharge + ' TAX OUTSTANDING');
                            interest += summaryMap.get(o).get(eachCharge).get(eachCharge + ' INTEREST');
                            interestST += summaryMap.get(o).get(eachCharge).get(eachCharge + ' INTEREST ON ST');
                        }
                        diDDMap.put(CustomerDIMap1.get(o) + ' DEMANDED', demanded);
                        diDDMap.put(CustomerDIMap1.get(o) + ' RECEIVED', received);
                        diDDMap.put(CustomerDIMap1.get(o) + ' OUTSTANDING', outstanding);
                        diDDMap.put(CustomerDIMap1.get(o) + ' TAX DEMANDED', tDemanded);
                        diDDMap.put(CustomerDIMap1.get(o) + ' TAX RECEIVED', tReceived);
                        diDDMap.put(CustomerDIMap1.get(o) + ' TAX OUTSTANDING', tOutstanding);
                        diDDMap.put(CustomerDIMap1.get(o) + ' INTEREST', interest);
                        diDDMap.put(CustomerDIMap1.get(o) + ' INTEREST ON ST', interestst);
                        demanded = 0;
                        received = 0;
                        outstanding = 0;
                        interest = 0;
                        tDemanded = 0;
                        tReceived = 0;
                        tOutstanding = 0;
                        interestST =0;
                    }
                    
                }
            }
            
        }
        if(ddList.size() > 0)
            insert ddList; 
       
        List<standard_customer_pay_plan_detail__c> scppdList = new List<standard_customer_pay_plan_detail__c>();
        for(wrpCustomersNew c : lstCustomers) {
            for(standard_customer_pay_plan_detail__c ppd : c.scppdBundleMap.values()) {
                ppd.IsSendDemandLetter__c = true;
                ppd.Milestone_Demand_Id__c = customerDIMap.get(c.uniquekey);
                ppd.Invoice_Raised_Date__c = c.invoicedate;
                ppd.Payment_Due_Date__c = c.invoiceduedate;
                if(ppd.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c && taxSlabMap.containsKey(ppd.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c))
                scppdList.add(ppd);
            }
            
        }
        update scppdList;
        
        // set this flag to true after all child records are inserted to prevent the demand letters [parent record workflow] from firing before the child records are inserted.
        // change the workflow to on update and look for this flag and then send the demand letters.
        List<Id> dIdList = new List<Id>();
        System.debug('Printing the DDDIMAP:' + diDDMap);
        for (demand_invoice__c d: diList) {
            
            d.demand_generated__c = true;
            d.Current_Demand_Installment__c = diDDMap.get(d.Id + ' TOTAL AMT');
            if (taxSlabMap.containsKey('TDS')) {
                d.TDS_Rate__c = taxSlabMap.get('TDS')[0].Tax_Percentage__c.setscale(1);
                d.TDSAmount__c = (diDDMap.get(d.Id + ' TOTAL AMT') * taxSlabMap.get('TDS')[0].Tax_Percentage__c / 100).setscale(0, RoundingMode.HALF_UP);
            }
            d.Total_Amount__c = diDDMap.get(d.Id + ' OVERALL TOTAL');
            d.Current_Demand_Service_Tax__c = diDDMap.get(d.Id + ' TOTAL TAX');
            d.Total_Demanded_Installment__c = diDDMap.get(d.Id + ' DEMANDED');
            d.Total_Recd_Installment__c =   diDDMap.get(d.Id + ' RECEIVED');
            d.Outstanding_Installment__c=   diDDMap.get(d.Id + ' OUTSTANDING');
            d.Total_Demanded_Service_Tax__c=    diDDMap.get(d.Id + ' TAX DEMANDED');
            d.Total_Recd_Service_Tax__c=    diDDMap.get(d.Id + ' TAX RECEIVED');
            d.Outstanding_Service_Tax__c=   diDDMap.get(d.Id + ' TAX OUTSTANDING');
            d.Service_Tax_on_Interest__c = diDDMap.get(d.Id + ' INTEREST ON ST');
            d.Interest_Amount__c = diDDMap.get(d.Id + ' INTEREST');
            if(diDDMap.get(d.Id + ' TAX OUTSTANDING') != null)
                d.Total_Payable_Service_Tax__c = diDDMap.get(d.Id + ' TOTAL TAX') + diDDMap.get(d.Id + ' TAX OUTSTANDING') ;
            else 
                d.Total_Payable_Service_Tax__c = diDDMap.get(d.Id + ' TOTAL TAX');
            
            if(diDDMap.get(d.Id + ' OUTSTANDING') == null)
                diDDMap.put(d.Id + ' OUTSTANDING', 0);
            if(diDDMap.get(d.Id + ' INTEREST') == null)
                diDDMap.put(d.Id + ' INTEREST', 0);
            if(diDDMap.get(d.Id + ' INTEREST ON ST') == null)
                diDDMap.put(d.Id + ' INTEREST ON ST', 0);
            
            d.Total_Payable_Installment__c = diDDMap.get(d.Id + ' TOTAL AMT') + diDDMap.get(d.Id + ' OUTSTANDING') + diDDMap.get(d.Id + ' INTEREST') + diDDMap.get(d.Id + ' INTEREST ON ST');
            d.Total_Payable_Overall__c = d.Total_Payable_Installment__c + d.Total_Payable_Service_Tax__c;
            dIdList.add(d.Id);
        }
        update diList;
        // post the debit ledgers are created, trigger on ledger would rollup the amount into SCPPD demanded fields 
        // scppd trigger will roll up the amounts into CPPH fields
        LedgerManagementServices.createDebitLedgersForDemandsNew(dIdList);
        
    }
   
       // creates entries in the demand invoice table and updates the pay plan record's demand sent field to true
    // the workflow will trigger and send the email with the demand as an visualforce attachment
    // same demand can be viewed thru show button as well from the record detail page
    // using a customer wrapper class as input param as this wrapper is used for priting the search results
    // the day0 flag indicates whether this is a day 0 demand.
    
    public static void createDIForRegistration(List<wrpCustomers> lstCustomers, String DemandType, Boolean Day0, Boolean Registration) {
        System.debug('lstCustomers in DI method:' + lstCustomers);
        list < Demand_Invoice__c > lstDemandInvoice = new list < Demand_Invoice__c > ();
        List<Id> lstSCPPDId = new List<Id>();
        Map<Id,Map<String,Decimal>> summaryMap = new Map<Id,Map<String,Decimal>>();
        Set<Id> oppIdSet = new Set<Id>();
        List<Id> projectIdList = new List<Id>();
        Map<String,List<Tax_Breakup__c>> projTaxRateMap = new Map<String ,List<Tax_Breakup__c>>();
        String chargeName = 'MVAT';
        String chargeName1 = 'Legal Charges'; 
        for(wrpCustomers o : lstCustomers) {
            oppIdSet.add(o.OpportunityId);
            projectIdList.add(o.ProjectId);
        }
        System.debug('Project Set:' + projectIdList);
        // since we show registrations per tower the project id will be always the same.
        projTaxRateMap = InventoryCostServices.getChildTaxRateForCharges(projectIdList[0]);
        List<Customer_Pay_Plan_Header__c> lstCPPH = [Select Id, Customer__c, Customer__r.Id, Customer__r.Email__c,Project_Unit__r.Name, 
                                                                                                Amount_Demanded_Till_Date__c, Amount__c,
                                                                                                Global_Charges__r.Name
                                                                                                FROM Customer_Pay_Plan_Header__c 
                                                                                                WHERE show_registration_demand__c = true
                                                                                                AND Global_Charges__r.Name = 'Basic'
                                                                                                AND Customer__c  in :oppIdSet];

        list < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [Select Id,IsSendDemandLetter__c , Customer_Pay_Plan_Header__r.Id, 
                                                Customer_Pay_Plan_Header__r.Customer__r.Id, Project__r.Id, Project__r.S_Ready_Reckoner_Rate__c,
                                                Customer_Pay_Plan_Header__r.Global_Charges__r.Description__c,
                                                customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                Charge_Amount_Advance_Recd__c, Installment__c,
                                                Charge_Amount_Billed__c,Service_Tax_Amount_Billed__c,Is_to_be_Paid__c ,
                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c 
                                                from  Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__r.Customer__r.Id in :oppIdSet
                                                and Is_to_be_Paid__c = 'Registration']; //customer_Pay_Plan_Header__r.Global_Charges__r.Name in ('MVAT', 'Legal Charges', 'Registration Charges','Stamp Duty')];
        Map<String,Decimal> customerRegChargeMap = new Map<String,Decimal>();
        for(Standard_Customer_Pay_Plan_Detail__c scppd : lstSCPPD) {
            customerRegChargeMap.put(scppd.Customer_Pay_Plan_Header__r.Customer__r.Id+ scppd.customer_Pay_Plan_Header__r.Global_Charges__r.Name,scppd.Installment__c - scppd.Charge_Amount_Billed__c);
        }
        // getting the basic charges value for storing the registration demand
        for(Customer_Pay_Plan_header__c cpph : lstCPPH) {
            customerRegChargeMap.put(cpph.Customer__r.Id+ cpph.Global_Charges__r.Name,cpph.Amount__c);
        }   
        System.debug('customerRegChargeMap:' + customerRegChargeMap);                                           
        if (lstCustomers != null && lstCustomers.size() > 0) {
            for (wrpCustomers objWRP: lstCustomers) {
                Demand_Invoice__c objDemInvoice = new Demand_Invoice__c();
                objDemInvoice.Customer__c = objWRP.OpportunityId;
                if( objWRP.stageID != null && objWRP.stageID != '') objDemInvoice.Project_Construction_Stage__c = objWRP.stageID;
                if (objWRP.EmailId != null && objWRP.EmailId != '') objDemInvoice.Email__c = objWRP.EmailId;
                if(objWRP.RMEmail != null && objWRP.RMEmail != '') objDemInvoice.Booking_Owner_Email__c = objWRP.RMEmail;
                if (objWRP.OthersEmailId != null && objWRP.OthersEmailId != '')  {
                     String[] objEmailList = objWRP.OthersEmailId.split(',');
                        for(Integer i=0; i< objEmailList.size(); i++) {
                            if(i == 0)
                                objDemInvoice.cc1_Email__c = objEmailList[0];
                            if(i==1)
                                objDemInvoice.cc2_Email__c =objEmailList[1];
                            if(i==2)
                                objDemInvoice.cc3_Email__c =objEmailList[2];
                            if(i==3)
                                objDemInvoice.cc4_Email__c =objEmailList[3];
                        }
                }
                if (objWRP.FutureCorresEmailId != null && objWRP.FutureCorresEmailId != '')  {
                    objDemInvoice.Future_Correspondence_Email__c = objWRP.FutureCorresEmailId;
                }
                
                if (objWRP.InvoiceDate != null) objDemInvoice.Invoice_Date__c = objWRP.InvoiceDate;
                if (objWRP.InvoiceDueDate != null) objDemInvoice.Due_Date__c = objWRP.InvoiceDueDate;
                objDemInvoice.Day_0_demand_generation__c = Day0;
                objDemInvoice.Registration_Demand_Generation__c = Registration;
                // in case of group demands we are just updating the first milestone against the demand record
                objDemInvoice.Standard_Customer_Pay_Plan_Detail__c = objWRP.SCPPDId[0];
                objDemInvoice.Milestone_Name__c = 'Registration Intimation'; 
                if(customerRegChargeMap.containsKey(objWRP.OpportunityId+'Legal Charges') && customerRegChargeMap.get(objWRP.OpportunityId+'Legal Charges') != null)
                    objDemInvoice.Legal_Charges_Amount__c = customerRegChargeMap.get(objWRP.OpportunityId+'Legal Charges');
                if(customerRegChargeMap.containsKey(objWRP.OpportunityId+'MVAT') && customerRegChargeMap.get(objWRP.OpportunityId+'MVAT') != null)
                    objDemInvoice.MVAT_Amount__c = customerRegChargeMap.get(objWRP.OpportunityId+'MVAT');
                Decimal totalTax = 0;
                Decimal taxValue = 0;
                objDemInvoice.Legal_Charges_Service_Tax_Basic__c = 0;
                objDemInvoice.Legal_Charges_Service_Tax_KKC__c = 0;
                objDemInvoice.Legal_Charges_Service_Tax_SBC__c = 0;
                
                if(projTaxRateMap.containsKey('Legal Charges') && objDemInvoice.Legal_Charges_Amount__c != null) {  
                    for(Tax_Breakup__c tb : projTaxRateMap.get('Legal Charges')) {
                        taxValue = ((tb.Taxable_Percentage__c * objDemInvoice.Legal_Charges_Amount__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                        totalTax += taxValue;
                        objDemInvoice.Legal_Charges_Service_Tax_Basic__c=  0;
                        if(tb.Tax_Split_Type__c == 'SGST')
                            objDemInvoice.Legal_Charges_Service_Tax_SBC__c = taxValue;
                        if(tb.Tax_Split_Type__c == 'CGST')
                            objDemInvoice.Legal_charges_Service_Tax_KKC__c = taxValue;
                    }
                    objDemInvoice.Legal_Charges_Service_Tax__c = totalTax;
                }
                if(customerRegChargeMap.containsKey(objWRP.OpportunityId+'Stamp Duty') && customerRegChargeMap.get(objWRP.OpportunityId+'Stamp Duty') != null)
                    objDemInvoice.Stamp__c = customerRegChargeMap.get(objWRP.OpportunityId+'Stamp Duty');
                if(customerRegChargeMap.containsKey(objWRP.OpportunityId+'Registration Charges') && customerRegChargeMap.get(objWRP.OpportunityId+'Registration Charges') != null)
                    objDemInvoice.Registration_Charges_Amount__c = customerRegChargeMap.get(objWRP.OpportunityId+'Registration Charges');
                objDemInvoice.Current_Demand_Installment__c =objWRP.InstallAmt;    // sum of legal + MVAT
                objDemInvoice.Ready_Reckoner_Value__c = lstSCPPD[0].Project__r.S_Ready_Reckoner_Rate__c;
                objDemInvoice.Agreement_Value__c = customerRegChargeMap.get(objWRP.OpportunityId+'Basic');
                objDemInvoice.project__c = objWRP.projectID;
                lstDemandInvoice.add(objDemInvoice);
            }
        }    
        List<Id> dId = new List<Id>();
        if (lstDemandInvoice.size() > 0) {
            Database.SaveResult[] resultLst = Database.insert(lstDemandInvoice);
            for(Database.SaveResult r : resultLst) {
                if(r.isSuccess()) {
                    dId.add(r.getId());
                }
            }
        }
        List<Demand_Invoice__c> diList = [Select Id, Name, Customer__c,Standard_Customer_Pay_Plan_Detail__c, Standard_Customer_Pay_Plan_Detail__r.Id, 
                                            Customer__r.Id, Project_Construction_Stage__c, Invoice_Date__c,Due_Date__c,Stamp__c,
                                            Current_Demand_Installment__c, Current_Demand_Service_Tax__c,Registration_Charges_Amount__c,
                                            MVAT_Amount__c, Legal_Charges_Amount__c, Legal_Charges_Service_Tax__c
                                            from Demand_Invoice__c where Id in :dId];
        
        Map<Id,Demand_Invoice__c> customerDIMap = new Map<Id,Demand_Invoice__c>();
        
        for(Demand_Invoice__c di : diList) {
            customerDIMap.put(di.Customer__r.Id, di);
        }
        System.debug('Customer DI Map:' + customerDIMap);
        // updating the payment plan records with the demand invoice # and flagging the fact that
        System.debug('List of scppd:' + lstSCPPD.size());
        for (Standard_Customer_Pay_Plan_Detail__c ppd: lstSCPPD) {
            if(ppd.customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('MVAT') && customerDIMap.containsKey(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id) && customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).MVAT_Amount__c != null) {
                ppd.Charge_Amount_Billed__c = customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).MVAT_Amount__c;
                ppd.Service_Tax_Amount_Billed__c = 0;  
            }
            // updating SCPPD records for Stamp Duty and Registration charges, as in this case the customer makes all the payments
            // to the builder 
           /** commented on 1st June 18, don't roll up stamp duty and registration on the scppd. Only legal debit ledgers and scppd to be raised----Changed By Ashish Added Stampduty And Registartion**/
           if(ppd.customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Stamp Duty') && customerDIMap.containsKey(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id) && customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Stamp__c != null) {
                ppd.Charge_Amount_Billed__c = customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Stamp__c;
                ppd.Service_Tax_Amount_Billed__c = 0;  
            } 
            if(ppd.customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Registration Charges') && customerDIMap.containsKey(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id) && customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Registration_Charges_Amount__c != null) {
                ppd.Charge_Amount_Billed__c = customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Registration_Charges_Amount__c;
                ppd.Service_Tax_Amount_Billed__c = 0;  
            } 
            if(ppd.customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Legal Charges') &&  customerDIMap.containsKey(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id) && customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Legal_Charges_Amount__c != null  ) {
                if(ppd.Charge_Amount_Billed__c != null)
                    ppd.Charge_Amount_Billed__c += customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Legal_Charges_Amount__c;
                else
                    ppd.Charge_Amount_Billed__c = customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Legal_Charges_Amount__c;
                if(ppd.Service_Tax_Amount_Billed__c != null )
                    ppd.Service_Tax_Amount_Billed__c += customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Legal_Charges_Service_Tax__c;  
                else
                    ppd.Service_Tax_Amount_Billed__c = customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Legal_Charges_Service_Tax__c; 
            } 
            
            ppd.Is_MileStone_Achieved__c  =  true;
            ppd.IsSendDemandLetter__c     =  true;
            ppd.Milestone_Demand_Id__c    =  customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Id;
            ppd.Due_Date__c = system.today();
            ppd.Invoice_Raised_Date__c    =  customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Invoice_Date__c;
            ppd.Payment_Due_Date__c       =  customerDIMap.get(ppd.Customer_Pay_Plan_Header__r.Customer__r.Id).Due_Date__c;
        }
        System.debug('updated scppd:' + lstscppd);
        update lstSCPPD;
        
        // updating the header records back with the total demand amount raised for each type of charge.
        // this is to keep track of the amount demanded so far and check if 19.9% basic has been demanded /paid.
        // if yes, then a trigger on the header record will create demands and ledgers for registration
        
        List<Customer_Pay_Plan_Header__c> cpphList  = [ SELECT Id, Amount__c, Customer__c,customer__r.Id,Global_Charges__r.Id,Global_Charges__r.Name  
                                                        FROM   Customer_Pay_Plan_Header__c 
                                                        WHERE  customer__c in : oppIdSet and 
                                                               Global_Charges__r.Name in ('MVAT', 'Legal Charges') and
                                                               Effect_To_Date__c = null
                                                        ];
        for(Customer_Pay_Plan_Header__c cpph : cpphList) {
            if(cpph.Global_Charges__r.Name.equalsIgnoreCase('MVAT') && customerDIMap.containskey(cpph.Customer__r.Id) && customerDIMap.get(cpph.Customer__r.Id).MVAT_Amount__c != null) {
                cpph.Amount_Demanded_Till_Date__c = customerDIMap.get(cpph.Customer__r.Id).MVAT_Amount__c;
            }
            if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Legal Charges')) {
                cpph.Amount_Demanded_Till_Date__c = customerDIMap.get(cpph.Customer__r.Id).Legal_Charges_Amount__c;
                cpph.Service_Tax_Demanded_Till_Date__c = customerDIMap.get(cpph.Customer__r.Id).Legal_Charges_Service_Tax__c;
            }
        }
        if(cpphList.size() > 0)
            update cpphList;

        // create ledger for charges and service taxes if any
        LedgerManagementServices.createRegistrationLedgers(oppIdset);
        
        if(Registration) {
            // find the basic charge header record where the registration reached flag is set and set the
            // show registration demand to false.
            // registration is one such demand which can be sent and the process can be abandoned and restarted.
            // so we should be able to show this demand in the demand pools any number of times based on the setting and unsetting of this flag
            for(Customer_Pay_Plan_Header__c cpph : lstCPPH) {
                cpph.show_registration_demand__c = false;
                cpph.Registration_Demand_Invoice__c = customerDIMap.get(cpph.Customer__c).Id;
            }
            if(lstCPPH.size() > 0)
                update lstCPPH;
        }
    }
    
    public static void sendCancellations(List<wrpCustomersCan> cancelList) {
        Set<Id> ciSet = new Set<Id>();
        Map<Id, Cancellation_Intimation__c> oppCanMap = new Map<Id, Cancellation_Intimation__c>();
        Map<Id, wrpCustomersCan> wrpMap = new Map<Id, wrpCustomersCan>();
        List<cancellation_intimation__C> intimationList = new List<cancellation_intimation__c>();
        List<cancellation_intimation__C> intimationListUpdated = new List<cancellation_intimation__c>();
        List<Cancellation_References__C> cRefList = new List<Cancellation_References__c>();
        List<SMS_Schedule_SMS_c__c> smsList = new List<SMS_Schedule_SMS_c__c>();
        S_cancellationLetter sc = new S_cancellationLetter();
        for(wrpCustomersCan cList : cancelList) {
            ciSet.add(cList.intimationrec.Id);
            oppCanMap.put(cList.intimationrec.Customer__c, cList.intimationrec);
            wrpMap.put(cList.intimationrec.Customer__c, cList);
        }
        intimationList = [Select Id, Name, Customer__c from cancellation_intimation__c where Id in :ciSet];
        if(intimationList.size() > 0) {
            for(cancellation_intimation__c cList : intimationList) {
                cList.Letter_sent_date__c = system.today();
                cList.Sent_By_User__c =  userinfo.getUserId();
                cList.Is_Letter_Sent__c = true;
                cList.Primary_Applicant_Email__c = wrpMap.get(cList.customer__c).EmailId;
                if (wrpMap.get(cList.customer__c).OthersEmailId != null && wrpMap.get(cList.customer__c).OthersEmailId != '')  {
                     String[] objEmailList = wrpMap.get(cList.customer__c).OthersEmailId.split(',');
                        for(Integer i=0; i< objEmailList.size(); i++) {
                            if(i == 0)
                                cList.cc1_Email__c = objEmailList[0];
                            if(i==1)
                                cList.cc2_Email__c =objEmailList[1];
                            if(i==2)
                                cList.cc3_Email__c =objEmailList[2];
                            if(i==3)
                                cList.cc4_Email__c =objEmailList[3];
                        }
                }
                if (wrpMap.get(cList.customer__c).FutureCorresEmailId != null && wrpMap.get(cList.customer__c).FutureCorresEmailId != '')  {
                    cList.Future_Correspondence_Email__c = wrpMap.get(cList.customer__c).FutureCorresEmailId;
                }
            }
        }
        update intimationList;
        intimationListUpdated = [Select Id, Name,Customer__c, Letter_sent_date__c,Letter_Category__c,  Sent_By_User__r.Name, Amount_Demanded__c,
                                    Previous_Letter__r.Letter_sent_date__c, Previous_Letter__c, Previous_Letter__r.Amount_Demanded__c
                                    from cancellation_intimation__c 
                                    where id in :ciSet];
    
        for(cancellation_intimation__c cList : intimationListUpdated) {
            oppCanMap.put(cList.Customer__c, cList);
        }
        String legalEntity = '';
        String AmountDemanded = '';
        String reminderDate = '';
        List<Opportunity> oppList = [Select Id, Primary_Phone__c, Primary_name__c, 
                                    Project_Unit__r.Legal_Entity__c, Project_Unit__r.Legal_Entity__r.Name, 
                                    Project__r.RDS_Company_Code__r.Name, Project__r.Name, Project_Unit__r.Name,
                                    cancellation_remarks__c, latest_letter__c, cancellation_initiation_record__c, 
                                    unit_release_date__c from Opportunity  where Id in :oppCanMap.keySet()];
        for(Opportunity o : oppList) {
            SMS_Schedule_SMS_c__c sms = new SMS_Schedule_SMS_c__c();
            sms.sender_mobile__c = o.Primary_Phone__c;
            sms.immediate__c= true;
            sms.context_record__c =  oppCanMap.get(o.Id).Id;
            if(o.Project_Unit__r.Legal_Entity__c != null)
                legalEntity = o.Project_Unit__r.Legal_Entity__r.Name;
            else
                legalEntity = o.Project__r.RDS_Company_Code__r.Name;
            if(oppCanMap.get(o.Id).Previous_Letter__c != null)
                amountDemanded = QuotationManagementServices.InFormat(oppCanMap.get(o.Id).Previous_Letter__r.Amount_Demanded__c);
            else if(oppCanMap.get(o.Id).Amount_Demanded__c != null)
                amountDemanded = QuotationManagementServices.InFormat(oppCanMap.get(o.Id).Amount_Demanded__c);
            
            if(oppCanMap.get(o.Id).Previous_Letter__c != null)  
                reminderDate = oppCanMap.get(o.Id).Previous_Letter__r.Letter_sent_date__c.format();
            if(oppCanMap.get(o.Id).Letter_Category__c != null){
            if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L1')) {
                o.unit_release_date__c = system.today().addDays(1);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Termination Letter sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Unit will be realeased on ' + o.unit_release_date__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.First_Letter_Sent_On__c = system.today();
                o.Is_Final_Intimation_Sent__c = true;
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L2')) {
                o.L2_to_be_sent_on__c = system.today().addDays(30);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':First and Final Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Termination letter to be sent on ' + o.L2_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                cancellation_references__c c = sc.getCancellationDemandDetails(o.cancellation_initiation_record__c);
                o.First_Letter_Sent_On__c = system.today();
                if (c != null) {
                    c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                    cRefList.add(c);
                    oppCanMap.get(o.Id).Amount_Demanded__c = c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                }
            } else if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L3')) {
                o.unit_release_date__c = system.today().addDays(3);
                o.Second_Letter_Sent_On__c = system.today();
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Termination Letter sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Unit will be realeased on ' + o.unit_release_date__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Is_Final_Intimation_Sent__c = true;
                                    
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L4') || oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L8')) {
                o.L2_to_be_sent_on__c = system.today().addDays(13);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':First Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Second Reminder to be sent on ' + o.L2_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.First_Letter_Sent_On__c = system.today();
                cancellation_references__c c = sc.getCancellationDemandDetails(o.cancellation_initiation_record__c);
                if (c != null) {
                    c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                    cRefList.add(c);
                    oppCanMap.get(o.Id).Amount_Demanded__c = c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                }                                   
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L5')) {
                o.L3_to_be_sent_on__c = system.today().addDays(13);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Second Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Final Reminder to be sent on ' + o.L3_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Second_Letter_Sent_On__c = system.today();
                List<cancellation_references__c> cList = sc.getOutstandingDemandDetails(o.Id);
                if (cList != null) {
                    for(cancellation_references__c c : cList) {
                        c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                        oppCanMap.get(o.Id).Amount_Demanded__c += c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                        cRefList.add(c);
                    }
                }                                   
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L9')) {
                o.L3_to_be_sent_on__c = system.today().addDays(30);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Second Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Final Reminder to be sent on ' + o.L3_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Second_Letter_Sent_On__c = system.today();
                List<cancellation_references__c> cList = sc.getOutstandingDemandDetails(o.Id);
                if (cList != null) {
                    for(cancellation_references__c c : cList) {
                        c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                        oppCanMap.get(o.Id).Amount_Demanded__c += c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                        cRefList.add(c);
                    }
                }
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L6')) {
                o.L4_to_be_sent_on__c = system.today().addDays(30);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Final Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Terimation Letter to be sent on ' + o.L4_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Third_Letter_Sent_On__c = system.today();
                List<cancellation_references__c> cList = sc.getOutstandingDemandDetails(o.Id);
                if (cList != null) {
                    for(cancellation_references__c c : cList) {
                        c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                        oppCanMap.get(o.Id).Amount_Demanded__c += c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                        cRefList.add(c);
                    }
                }                                   
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L10')) {
                o.L4_to_be_sent_on__c = system.today().addDays(45);
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Final Reminder sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Terimation to be sent on ' + o.L4_to_be_sent_on__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Third_Letter_Sent_On__c = system.today();
                List<cancellation_references__c> cList = sc.getOutstandingDemandDetails(o.Id);
                if (cList != null) {
                    for(cancellation_references__c c : cList) {
                        c.cancellation_intimation__c = oppCanMap.get(o.Id).Id;
                        oppCanMap.get(o.Id).Amount_Demanded__c += c.Flat_Cost_Outstanding__c + c.Service_Tax_Oustanding__c + c.Interest__c;
                        cRefList.add(c);
                    }
                }
            } else  if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L7') || oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L11')) {
                o.unit_release_date__c = system.today().addDays(30);
                o.is_final_intimation_sent__c = true;
                o.cancellation_remarks__c += 
                                    '\n' + System.today().format() + ':Terimation Leter sent on ' + oppCanMap.get(o.Id).Letter_sent_date__c.format() + ' by ' + 
                                    oppCanMap.get(o.Id).Sent_By_User__r.Name + '\n' + System.today().format() + ':Unit to be relased on ' + o.unit_release_date__c.format();
                o.latest_letter__c = oppCanMap.get(o.Id).Id;
                o.Fourth_Letter_Sent_On__c = system.today();
            } 
            if(oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L1') || oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L3') ||
                oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L7') || oppCanMap.get(o.Id).Letter_Category__c.equalsIgnoreCase('L11')   )  {
                    sms.sms_long_text__c = 'Dear ' + o.Primary_Name__c +',  This is an important information regarding your ' + o.Project_Unit__r.Name + ' at ' + o.Project__r.Name +'. We regret to inform you that since you have neglected to honour the outstanding payment of ' + amountDemanded + ' along with penalties before ' + reminderDate + ' we have terminated the said booking with immediate effect. The termination notice for the same has been sent to you via registered post. Regards, ' + legalEntity;
            }   else {
                    sms.sms_long_text__c =  'Dear ' + o.Primary_Name__c + ',  This is an important information regarding your' + o.Project_Unit__r.Name + ' at ' + o.Project__r.Name + '. We wish to remind you that there is an  outstanding payment against your unit which is beyond the due date for which we have sent you a reminder notice on your registered address. Request you to pay the outstanding amount urgently to avoid further penalty / action. Please get in touch with your RM for any further clarification or information. Regards, ' + legalEntity;
            }
          }  
            smsList.add(sms);
            legalEntity = '';
            amountDemanded = '';
            reminderDate = '';                      
        }
        update oppList;
        if(cRefList.size() > 0) {
            insert cRefList;
        }
        if(smsList.size() > 0) {
            insert smsList;
        }
        update intimationListUpdated;
     }
    public static List < wrpCustomers >  searchAllPendingDemands(){
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        
        list < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,Installment_Number__c, Inst_No__c,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Project_Construction_Stages__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Basic__c,
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    TDS__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__c != null
                                                                    and Customer_Pay_Plan_Header__r.Customer__c != null
                                                                    and Customer_Pay_Plan_Header__r.Booking__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name != null
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and IsSendDemandLetter__c = false
                                                                    and ( 
                                                                        (is_milestone_achieved__c = true and Due_Date__c != null and Due_Date__c <= TODAY and Registration_Linked__c = false) 
                                                                        or
                                                                        (is_milestone_achieved__c = true and Due_Date__c != null and Due_Date__c <= TODAY and Registration_Linked__c = true and Is_Registration_Done__c = true)
                                                                        or 
                                                                        (Is_to_be_Paid__c = 'From Dt. Of Booking' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = false) 
                                                                        or
                                                                        (Is_to_be_Paid__c = 'From Dt. Of Booking' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = true and Is_Registration_Done__c = true) 
                                                                        or
                                                                        (Is_to_be_Paid__c = 'From Dt. of Registration' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = true and Is_Registration_Done__c = true) 
                                                                        )
                                                                    and Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != 'Stamp Duty and Registration'
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold' 
                                                                    order by Customer_Pay_Plan_Header__r.Customer__c, due_date__c asc];
        lstCustomers = CreateCustomerWrapperNoGrouping(lstSCPPD);
        return lstCustomers;
    }
    
    public static List < wrpCustomersNew >  searchAllPendingDemands(String tName, String pName, Integer list_size, Integer counter){
        List < wrpCustomersNew > lstCustomers = new List < wrpCustomersNew > ();
        
        list < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Project_Construction_Stages__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Basic__c,
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    TDS__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__c != null
                                                                    and Customer_Pay_Plan_Header__r.Customer__c != null
                                                                    and Customer_Pay_Plan_Header__r.Booking__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name != null
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and IsSendDemandLetter__c = false
                                                                    and ( 
                                                                        (is_milestone_achieved__c = true and Due_Date__c != null and Due_Date__c <= TODAY and Registration_Linked__c = false) 
                                                                        or
                                                                        (is_milestone_achieved__c = true and Due_Date__c != null and Due_Date__c <= TODAY and Registration_Linked__c = true and Is_Registration_Done__c = true)
                                                                        or 
                                                                        (Is_to_be_Paid__c = 'From Dt. Of Booking' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = false) 
                                                                        or
                                                                        (Is_to_be_Paid__c = 'From Dt. Of Booking' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = true and Is_Registration_Done__c = true) 
                                                                        or
                                                                        (Is_to_be_Paid__c = 'From Dt. of Registration' and Due_Date__c != null and Due_Date__c <= NEXT_N_DAYS:15 and Registration_Linked__c = true and Is_Registration_Done__c = true) 
                                                                        )
                                                                    and Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != 'Stamp Duty and Registration'
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold' 
                                                                    and Project__r.Name = :pName
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name = :tName
                                                                    order by Customer_Pay_Plan_Header__r.Customer__c, due_date__c, Is_to_be__c  asc
                                                                    limit :list_size
                                                                    offset :counter];
        lstCustomers = CreateCustomerWrapperNew(lstSCPPD);
        return lstCustomers;
    }
    
    // searches customer's pay plan detail records based on the construction stage
    // returns the response as a customer wrapper class list
    public static List < wrpCustomers > searchCustomersBasedOnStage(Set < Id > consStageIdList) {
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        
        list < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Project_Construction_Stages__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Basic__c,Installment_Number__c,Inst_No__c, 
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Project_Construction_Stages__c in : consStageIdList
                                                                    and Customer_Pay_Plan_Header__c != null
                                                                    and Customer_Pay_Plan_Header__r.Customer__c != null
                                                                    and Customer_Pay_Plan_Header__r.Booking__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and Due_Date__c != null and Due_Date__c <= TODAY and IsSendDemandLetter__c = false
                                                                    and is_milestone_achieved__c = true
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold'
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'];
        
        lstCustomers = createCustomerWrapper(lstSCPPD);
        return lstCustomers;
    }
    
    // searches customer's pay plan detail records based on the due dates on the pay plan detail record
    // returns the response as a customer wrapper class list
    // this is for searching due dates that are based on the booking date
    public static List < wrpCustomers > searchCustomersBasedOnDates(Date FromDate, Date ToDate, Id pId, Id tId) {
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        List < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,
                                                                    Project_Construction_Stages__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Revised_Invoice_Date__c,Installment_Number__c, Inst_No__c,
                                                                    Reason_for_deferment__c,
                                                                    Basic__c,
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__r.Project__c = :pId
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__c =: tId
                                                                    and Customer_Pay_Plan_Header__c != null
                                                                    and Customer_Pay_Plan_Header__r.Customer__c != null
                                                                    and Customer_Pay_Plan_Header__r.Booking__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    and Due_Date__c >= :FromDate and Due_Date__c <= :ToDate and IsSendDemandLetter__c = false
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and Is_to_be_Paid__c = 'From Dt. Of Booking'
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold' 
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'];

        lstCustomers = createCustomerWrapperNoGrouping(lstSCPPD);
        return lstCustomers;
    }
    
    // though it accepts a list , the query only fetches data for a single customer
    // this will suffice as day 0 demand generation is done for one customer at a time
    public static List < wrpCustomers > searchCustomersForDay0Demand(List<Booking__c> Booking) {
        
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        List<Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, Customer_Pay_Plan_Header__r.Customer__r.Email__c, 
                                                                    Project_Construction_Stages__c, Is_to_be__c,
                                                                    Project__r.Days_to_Send_Demand__c, Charge_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Service_Tax_Amount_Advance_Recd__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c ,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Basic__c,
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,Installment_Number__c, Inst_No__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c                                                                 
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__r.Project__c =: Booking[0].Project__c
                                                                    AND Customer_Pay_Plan_Header__r.Customer__c =: Booking[0].Customer__c
                                                                    and Customer_Pay_Plan_Header__r.Booking__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    and Customer_Pay_Plan_Header__c != null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__c != null
                                                                    AND Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'
                                                                    AND Is_to_be__c = '0Day(s) from date of booking.'
                                                                    AND IsSendDemandLetter__c = false
                                                                    AND Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold' 
                                                                    ORDER BY Project_Construction_Stages__r.Sequence_No__c 
                                                                    limit 1
                                                                    ];
        lstCustomers = CreateCustomerWrapper(lstSCPPD);    
        return lstCustomers;                                                     
    } 
    
    // select all the customers from the customer pay plan header record where Registration Milestone is reached
    // filter using the tower and project criteria selected
    // from the customer pay plan record, create a list of customer Ids, for those ids, fetch all the registration milestone related charges
    // Legal,MVAT, SD and Registration Fees.
    // out of this only for MVAT and Legal we have to create Demands and ledgers, rest are paid to the govt.
    // the show invoice link for this specific situation is different that the regular show invoice link. [it contains the initimation letter etc.,]
    public static List<wrpCustomers> searchCustomersForRegistration() {
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        // we look for all customer where 19.9% basic payment has been made
        List<Customer_Pay_Plan_Header__c> lstCPPD = [Select Id, Customer__c, Customer__r.Email__c, Project_Unit__r.Name, Project_Unit__r.Id,
                                                                                                Amount_Demanded_Till_Date__c, Amount__c 
                                                                                                FROM Customer_Pay_Plan_Header__c 
                                                                                                WHERE show_registration_demand__c = true
                                                                                                AND Global_Charges__r.Name = 'Basic'
                                                                                                and Customer__r.status__c = 'Active'
                                                                                                and Customer__c != null
                                                                                                and Booking__c != null
                                                                                                and Project_Unit__c != null
                                                                                                and Project_Unit__r.Unit_Status__c = 'Sold'
                                                                                                and Registration_Intimation_Sent__c = true];
        List<Id> customerId = new List<Id>();                                                                                   
        for(Customer_Pay_Plan_Header__c cpph :lstCPPD)   {
            customerId.add(cpph.Customer__r.Id);
        }
                                                                                            
        List < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,
                                                                    Project__r.Days_to_Send_Demand__c,
                                                                    Project_Construction_Stages__c, Charge_Amount_Advance_Recd__c,
                                                                    Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Basic__c,Installment_Number__c, Inst_No__c,
                                                                    Development_Charges__c,
                                                                    Floor_Rise__c,
                                                                    Infrastructure_Charges__c,
                                                                    Premium_1__c,
                                                                    Premium_2__c,
                                                                    Premium_3__c,
                                                                    Premium_4__c,
                                                                    TDS__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,Is_to_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__r.Customer__c = :customerId
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold'
                                                                    and Is_to_be_Paid__c = 'Registration'
                                                                    ];
                                                                    //and Customer_Pay_Plan_Header__r.Global_Charges__r.Name in ('MVAT', 'Legal Charges','Stamp Duty','Registration Charges')
                                                                            
        lstCustomers = CreateCustomerWrapper(lstSCPPD);
        return lstCustomers;
    }
    
    // utility method for creating the wrapper class used by the search results of the demand invoice page
    // In this it if there are multiple milestones per customer, it groups the customers and sends a single combined record per customer.
     // grouping of customer demands is either for several milestones of the same charge [like multiple flat cost demands]
    // or multiple charges for the same milestone. like registration milestone for MVAT , legal etc,
    // or Final possession for all society charges
    public static List < wrpCustomersNew >    createCustomerWrapperNew(list<Standard_Customer_Pay_Plan_Detail__c > lstSCPPD ){
        System.debug('Pay Plan Records:' + lstSCPPD);   
        Boolean noGrouping = true;
        Boolean groupByMilestone = false;
        Boolean groupByCustomer = false;
        Set<String> stageNames = new Set<String>();
        
        List < wrpCustomersNew > lstCustomers = new List < wrpCustomersNew > ();
        if (lstSCPPD != null && lstSCPPD.size() > 0) {
            map < String, list < Standard_Customer_Pay_Plan_Detail__c >> mapSCPPD = new map < String, list < Standard_Customer_Pay_Plan_Detail__c >> ();
            for (Standard_Customer_Pay_Plan_Detail__c objSCPPDTemp: lstSCPPD) {
                if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null && groupByCustomer) {
                    // for group by customer we are using customer / oppId as they key
                    list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                    if (mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c) != null) 
                        tempListSCPPD = mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c);
                    tempListSCPPD.add(objSCPPDTemp);
                    mapSCPPD.put(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c, tempListSCPPD);
                } else if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null && groupByMilestone ) {
                    // for group by milestone, we are using oppId + milestone desc as the key
                    list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                    if((mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Is_to_be__c) != null ) ) 
                        tempListSCPPD = mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Is_to_be__c);
                    tempListSCPPD.add(objSCPPDTemp);
                    mapSCPPD.put(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Is_to_be__c, tempListSCPPD);
                    System.debug('mapSCPPD: group by milestone' +mapSCPPD);
                } else {
                    // no grouping scenario, we will use customer id and scppd id as they key.
                    list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                    if((mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Id) != null ) ) 
                        tempListSCPPD = mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Id);
                    tempListSCPPD.add(objSCPPDTemp);
                    mapSCPPD.put(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c + ' ' + objSCPPDTemp.Id, tempListSCPPD);
                }
            }
            Decimal AmountToBeBilled = 0;
            if (mapSCPPD.size() > 0) {
                for (String objId: mapSCPPD.keyset()) {
                    if (mapSCPPD.get(objId).size() > 0) {
                        wrpCustomersNew objwrpCustomers = new wrpCustomersNew();
                        String tempStageName = '' ;
                        for (Standard_Customer_Pay_Plan_Detail__c objSCPPDTemp: mapSCPPD.get(objId)) {
                            if(objSCPPDTemp.Charge_Amount_Billed__c != null && objSCPPDTemp.Charge_Amount_Billed__c >0 && objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                                AmountTobeBilled = (objSCPPDTemp.Installment__c - objSCPPDTemp.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                            } else if (objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                                AmountTobeBilled = objSCPPDTemp.Installment__c.setscale(0,RoundingMode.HALF_UP);
                            }
                            System.debug('Amount to be billed:' + AmountToBeBilled);
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c != null) 
                                objwrpCustomers.Name = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c != null) 
                                objwrpCustomers.Name += ','+ objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c;
                            
                            if (AmountTobeBilled != 0) {
                                objwrpCustomers.InstallAmt += AmountTobeBilled;
                            }
                            objwrpCustomers.InvoiceDate = system.today();
                            System.debug('Invoice due date:');
                            /**if(objSCPPDTemp.Project__r.Days_To_Send_Demand__c != null)
                                objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                            else
                                objwrpCustomers.InvoiceDueDate = (system.today()).addDays(10);
                            **/
                            /********************** Added by Shailesh on 31.10.17 ********************/
                            Date bookingDate = Date.valueof(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c);
                            if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Booking') {
                                if(objSCPPDTemp.Days_Months_Value__c == 0)
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(0);
                                else
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c - 1));
                            }
                            else if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Registration') {
                                objwrpCustomers.InvoiceDueDate = (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c).addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c));
                            }
                            else {
                                if(objSCPPDTemp.Project__r.Days_To_Send_Demand__c != null) 
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                                else
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(10);
                            }
                            System.debug('Invoice due date:' + objwrpCustomers.InvoiceDueDate);
                            /************************ Ends Here **************************************/
                            
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name != null) 
                                objwrpCustomers.ProjectUnit = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null) 
                                objwrpCustomers.OpportunityId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c != null) 
                                objwrpCustomers.EmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c != null) 
                                objwrpCustomers.OthersEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email != null) 
                                objwrpCustomers.RMEmail = objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c != null &&  objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c.equals('Other')) 
                                    objwrpCustomers.FutureCorresEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c;
                            if(objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name != null) 
                                objwrpCustomers.towerName = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name;
                            if(objSCPPDTemp.Project__r.Name != null) 
                                objwrpCustomers.projectName = objSCPPDTemp.Project__r.Name;
                            objwrpCustomers.scppdBundleMap.put(objSCPPDTemp.Id, objSCPPDTemp);
                            objwrpCustomers.scppd = objSCPPDTemp;
                            objwrpCustomers.projectId = objSCPPDTemp.Project__r.Id;
                            objwrpCustomers.DemandDueDate = objSCPPDTemp.due_date__c;
                            AmountToBeBilled = 0;
                            if(objSCPPDTemp.Is_to_be__c != null)
                                stageNames.add(objSCPPDTemp.Is_to_be__c);
                        }
                        objwrpCustomers.strInstallAmt = QuotationManagementServices.INFormat(objwrpCustomers.InstallAmt);
                        objwrpCustomers.uniqueKey = objId;
                        for(String stage: stageNames) {
                            tempStageName += stage + ',';
                        }
                        if(tempStageName != null && tempStageName.length() > 0 && tempStageName.substring(tempStageName.length() -1).equals(','))
                            tempStageName = tempStageName.substring(0,tempStageName.length() -1);
                        objwrpCustomers.stageName = tempStageName;
                                        
                        lstCustomers.add(objwrpCustomers);
                        stageNames = new Set<String>();
                        tempStageName = '';
                    }
                }
            }
        }
        System.debug('objWrappers : demands to be created for:' + lstCustomers);
        System.debug('objWrappers : size:' + lstCustomers.size());
        if (lstCustomers != null && lstCustomers.size() > 0) {
            return lstCustomers;
        }
        return lstCustomers;
    }
    
    // utility method for creating the wrapper class used by the search results of the demand invoice page
    // In this it if there are multiple milestones per customer, it groups the customers and sends a single combined record per customer.
     // grouping of customer demands is either for several milestones of the same charge [like multiple flat cost demands]
    // or multiple charges for the same milestone. like registration milestone for MVAT , legal etc,
    // or Final possession for all society charges
    public static List < wrpCustomers >    createCustomerWrapper(list<Standard_Customer_Pay_Plan_Detail__c > lstSCPPD ){
        System.debug('Pay Plan Records:' + lstSCPPD);   
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        if (lstSCPPD != null && lstSCPPD.size() > 0) {
            map < id, list < Standard_Customer_Pay_Plan_Detail__c >> mapSCPPD = new map < id, list < Standard_Customer_Pay_Plan_Detail__c >> ();
            for (Standard_Customer_Pay_Plan_Detail__c objSCPPDTemp: lstSCPPD) {
                if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null) {
                    list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                    if (mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c) != null) tempListSCPPD = mapSCPPD.get(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c);
                    tempListSCPPD.add(objSCPPDTemp);
                    mapSCPPD.put(objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c, tempListSCPPD);
                }
            }
            Decimal AmountToBeBilled = 0;
            if (mapSCPPD.size() > 0) {
                for (Id objId: mapSCPPD.keyset()) {
                    if (mapSCPPD.get(objId).size() > 0) {
                        wrpCustomers objwrpCustomers = new wrpCustomers();
                        List<Id> lstscppdIdTemp = new List<Id>();
                        
                        for (Standard_Customer_Pay_Plan_Detail__c objSCPPDTemp: mapSCPPD.get(objId)) {
                            System.debug('Installment: Advance ' + objSCPPDTemp.Installment__c  + ':' + objSCPPDTemp.Charge_Amount_Advance_Recd__c);                            
                            if(objSCPPDTemp.Charge_Amount_Billed__c != null && objSCPPDTemp.Charge_Amount_Billed__c >0 && objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                                AmountTobeBilled = (objSCPPDTemp.Installment__c - objSCPPDTemp.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                            } else if (objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                                AmountTobeBilled = objSCPPDTemp.Installment__c.setscale(0,RoundingMode.HALF_UP);
                            }
                            System.debug('Amount to be billed:' + AmountToBeBilled);
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c != null) 
                                objwrpCustomers.Name = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c != null) 
                                objwrpCustomers.Name += ','+ objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c;
                            
                            if (AmountTobeBilled != 0) {
                                objwrpCustomers.InstallAmt += AmountTobeBilled;
                            }
                            objwrpCustomers.InvoiceDate = system.today();
                            System.debug('Invoice due date:');
                           /** objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                            System.debug('Invoice due date:' + objwrpCustomers.InvoiceDueDate);
                            **/
                            /********************** Added by Shailesh on 31.10.17 ********************/
                            Date bookingDate = Date.valueof(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c);
                            if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Booking') {
                                if(objSCPPDTemp.Days_Months_Value__c == 0)
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(0);
                                else
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c - 1));
                            }
                            else if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Registration') {
                                objwrpCustomers.InvoiceDueDate = (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c).addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c));
                            }
                            else {
                                if(objSCPPDTemp.Project__r.Days_To_Send_Demand__c != null) 
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                                else
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(10);
                            }
                            System.debug('Invoice due date:' + objwrpCustomers.InvoiceDueDate);
                            /************************ Ends Here **************************************/
                            
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name != null) objwrpCustomers.ProjectUnit = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null) objwrpCustomers.OpportunityId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c;
                            if (objSCPPDTemp.Project_Construction_Stages__c != null) objwrpCustomers.stageId = objSCPPDTemp.Project_Construction_Stages__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c != null) objwrpCustomers.EmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c != null) objwrpCustomers.OthersEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email != null) objwrpCustomers.RMEmail = objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email;
                            if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c != null &&  objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c.equals('Other')) 
                                    objwrpCustomers.FutureCorresEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c;
                            if(objSCPPDTemp.Is_to_be__c != null)
                                objwrpCustomers.StageName += objSCPPDTemp.Is_to_be__c ;
                            if(objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name != null) objwrpCustomers.towerName = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name;
                            if(objSCPPDTemp.Project__r.Name != null) objwrpCustomers.projectName = objSCPPDTemp.Project__r.Name;
                            lstscppdIdTemp.add(objSCPPDTemp.Id);
                            objwrpCustomers.projectId = objSCPPDTemp.Project__r.Id;
                            objwrpCustomers.DemandDueDate = objSCPPDTemp.due_date__c;
                            AmountToBeBilled = 0;
                        }
                        objwrpCustomers.strInstallAmt = QuotationManagementServices.INFormat(objwrpCustomers.InstallAmt);
                        // comma separated values of all milestones and list of all the milestones
                        if(objwrpCustomers.StageName != null && objwrpCustomers.StageName.length() > 0 && objwrpCustomers.StageName.substring(objwrpCustomers.StageName.length() -1).equals(','))
                            objwrpCustomers.StageName = objwrpCustomers.StageName.substring(0,objwrpCustomers.StageName.length() -1);
                            // for registration, the stage name when concatinating various milestones will show up as "On Registration On Registration etc.,". hardcoding it to show registration
                        if(objwrpCustomers.StageName != null && objwrpCustomers.StageName.contains('Registration')) {
                            objwrpCustomers.StageName = 'Registration Intimation';
                        }
                        objwrpCustomers.SCPPDId.addAll(lstscppdIdTemp);
                        lstCustomers.add(objwrpCustomers);
                    }
                }
            }
        }
        System.debug('objWrappers : demands to be created for:' + lstCustomers);
        System.debug('objWrappers : size:' + lstCustomers.size());
        if (lstCustomers != null && lstCustomers.size() > 0) {
            return lstCustomers;
        }
        return lstCustomers;
    } 
    
    public static List<wrpCustomersCan> searchCustomersForCancellation() {
        List<Cancellation_Intimation__c> cancelList = new List<Cancellation_Intimation__c>();
        cancelList  = [Select Id, Name, Customer__c,Unit__r.TowerName__r.Name, 
                                        Customer__r.Primary_Name__c, Customer__r.Other_Applicants_Name__c, 
                                        Customer__r.Primary_Email__c, Customer__r.Other_Applicants_Email__c,
                                        Customer__r.Future_Correspondence_Contact__c,Customer__r.Future_Correspondence_Contact_Email__c,
                                        Unit__r.Project__r.Name, Letter_Category__c, Customer__r.Cancellation_Type__c 
                                    from cancellation_intimation__c 
                                    where Is_Letter_Sent__c = false];
        List<wrpCustomersCan> wcList = new List<wrpCustomersCan>();
        for(Cancellation_Intimation__c cancel : cancelList) {
            wrpCustomersCan wc = new wrpCustomersCan();
            wc.IntimationRec = cancel;
            if (cancel.Customer__r.Primary_Name__c != null) 
                wc.Name = cancel.Customer__r.Primary_Name__c;
            if (cancel.Customer__r.Other_Applicants_Name__c != null) 
                wc.Name += ',' + cancel.Customer__r.Other_Applicants_Name__c; 
            if (cancel.Customer__r.Primary_Email__c != null) wc.EmailId = cancel.Customer__r.Primary_Email__c;
            if (cancel.Customer__r.Other_Applicants_Email__c != null) wc.OthersEmailId = cancel.Customer__r.Other_Applicants_Email__c;
            if (cancel.Customer__r.Future_Correspondence_Contact__c != null &&  cancel.Customer__r.Future_Correspondence_Contact__c.equals('Other')) 
                wc.FutureCorresEmailId = cancel.Customer__r.Future_Correspondence_Contact_Email__c;
            wcList.add(wc);
        }
        
        return wcList;
    }
    // utility method for creating the wrapper class used by the search results of the demand invoice page
   
    public static List < wrpCustomers >    createCustomerWrapperNoGrouping(list<Standard_Customer_Pay_Plan_Detail__c > lstSCPPD ){
       
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
        if (lstSCPPD != null && lstSCPPD.size() > 0) {
            Decimal AmountToBeBilled = 0;
            for (Standard_Customer_Pay_Plan_Detail__c objSCPPDTemp: lstSCPPD) {
                wrpCustomers objwrpCustomers = new wrpCustomers();
                    if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null) {
                        objwrpCustomers.scppd = objSCPPDTemp;
                        if(String.isNotBlank(objSCPPDTemp.Reason_for_deferment__c))
                            objwrpCustomers.scppd.Reason_for_deferment__c = objSCPPDTemp.Reason_for_deferment__c;
                        else 
                            objwrpCustomers.scppd.Reason_for_deferment__c = '';
                        if(objSCPPDTemp.Revised_Invoice_Date__c != null) {
                            objwrpCustomers.scppd.Revised_Invoice_Date__c = objSCPPDTemp.Revised_Invoice_Date__c;
                            if(objSCPPDTemp.Revised_Invoice_Date__c <= system.today()) {
                                objwrpCustomers.style1 = 'blinkMe';
                            }
                        }
                        if(objSCPPDTemp.Charge_Amount_Billed__c != null && objSCPPDTemp.Charge_Amount_Billed__c >0 && objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                            AmountTobeBilled = (objSCPPDTemp.Installment__c - objSCPPDTemp.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                        } else if (objSCPPDTemp.Installment__c != null && objSCPPDTemp.Installment__c >0) {
                            AmountTobeBilled = objSCPPDTemp.Installment__c.setscale(0,RoundingMode.HALF_UP);
                        }
                        if(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Name != null) {
                            objwrpCustomers.RM = objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Name;
                            objwrpCustomers.RMID = objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Id;
                        }
                        if(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email != null) {    
                            objwrpCustomers.RMEmail = objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Owner.Email;
                        }
                        if(String.isNotBlank(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c) && objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c.equalsIgnoreCase('Soft copy via email and hardcopy'))
                            objwrpCustomers.PhysicalDemand = true;  
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c != null) 
                            objwrpCustomers.Name = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c;
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c != null) 
                            objwrpCustomers.Name += ',' + objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c;
                        if (objSCPPDTemp.Installment__c != null) {
                            objwrpCustomers.InstallAmt += AmountToBeBilled;
                            
                            objwrpCustomers.strInstallAmt = QuotationManagementServices.INFormat(objwrpCustomers.InstallAmt);
                        }
                        objwrpCustomers.InvoiceDate = system.today();
                        //if (objSCPPDTemp.Due_Date__c != null) objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                        /********************** Added by Shailesh on 31.10.17 ********************/
                            Date bookingDate = Date.valueof(objSCPPDTemp.Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c);
                            if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Booking') {
                                if(objSCPPDTemp.Days_Months_Value__c == 0)
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(0);
                                else
                                    objwrpCustomers.InvoiceDueDate = bookingDate.addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c - 1));
                            }
                            else if(objSCPPDTemp.Is_to_be_Paid__c == 'From Dt. of Registration') {
                                objwrpCustomers.InvoiceDueDate = (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c).addDays(Integer.valueOf(objSCPPDTemp.Days_Months_Value__c));
                            }
                            else {
                                if(objSCPPDTemp.Project__r.Days_To_Send_Demand__c != null) 
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(Integer.valueOf(objSCPPDTemp.Project__r.Days_To_Send_Demand__c));
                                else
                                    objwrpCustomers.InvoiceDueDate = (system.today()).addDays(10);
                            }
                            System.debug('Invoice due date:' + objwrpCustomers.InvoiceDueDate);
                        /************************ Ends Here **************************************/
                            
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name != null) objwrpCustomers.ProjectUnit = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.Name;
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c != null) objwrpCustomers.OpportunityId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__c;
                        if (objSCPPDTemp.Project_Construction_Stages__c != null) objwrpCustomers.stageId = objSCPPDTemp.Project_Construction_Stages__c;
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c != null) objwrpCustomers.EmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c;
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c != null) objwrpCustomers.OthersEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c;
                        if (objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c != null &&  objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c.equals('Other')) 
                            objwrpCustomers.FutureCorresEmailId = objSCPPDTemp.Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c;
                        if(objSCPPDTemp.Is_to_be__c != null)
                            objwrpCustomers.StageName = objSCPPDTemp.Is_to_be__c ;
                        if(objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name != null) objwrpCustomers.towerName = objSCPPDTemp.Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name;
                        if(objSCPPDTemp.Project__r.Name != null) objwrpCustomers.projectName = objSCPPDTemp.Project__r.Name;
                        objwrpCustomers.projectId = objSCPPDTemp.Project__r.Id;
                        objwrpCustomers.DemandDueDate = objSCPPDTemp.due_date__c;
                        objwrpCustomers.SCPPDId.add(objSCPPDTemp.Id);
                        AmountTobeBilled = 0;
                }
                        lstCustomers.add(objwrpCustomers);
            }
        }
        System.debug('objWrappers : demands to be created for:' + lstCustomers);
        if (lstCustomers != null && lstCustomers.size() > 0) {
            return lstCustomers;
        }
        return lstCustomers;
    } 
   
    // for previewing the demands of various type. 
    // this has been modified to handle combined demands as well.
    public static wrpDemand getCurrentDemandDetails(list<Id> scppdIds, string type) {
        List<Standard_Customer_Pay_Plan_Detail__C> scppdList = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,Is_To_be_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c,Service_Tax_Amount_Billed__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Reason_for_deferment__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Project_Construction_Stages__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                                    Standard_Customer_Pay_Plan_Detail__c.TDS__c,
                                                                    Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                                                    Add_Token_GST__c,
                                                                    Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where id in :scppdIds
                                                                ];
                                                                
                                                                
        //based on the milestones sent, it could be a single or combined demand
        // for two or three milestones.
        List<wrpCustomersNew> objWRP = new List<wrpCustomersNew>();
        decimal grandAmtTotal = 0;
        decimal grandTaxTotal = 0;
        if (scppdList != null && type.equalsIgnoreCase('FlatCost')) {
            
            if(scppdList.size() > 0) {
                objWRP = createCustomerWrapperNew(scppdList);
            }
            
            if(objWRP != null && objWRP.size() ==1) {
                wrpDemand wd = new wrpDemand();
                wd.OpportunityId = objWRP[0].OpportunityId;
                wd.CurrentDemandAmount = (objWRP[0].InstallAmt).setscale(0,RoundingMode.HALF_UP);
                wd.InvoiceDate = objWRP[0].InvoiceDate;
                wd.InvoiceDueDate = objWRP[0].InvoiceDueDate;
                wd.projectId = objWRP[0].projectId;
                wd.projectUnit = objWRP[0].projectUnit;
                wd.milestoneName = objWRP[0].stageName;
                Map<String, List<Standard_Customer_Pay_Plan_Detail__C>> chargeMap = new Map<String,List<Standard_Customer_Pay_Plan_Detail__C>>();
                
               if(objWRP[0].scppdBundleMap != null && objWRP[0].scppdBundleMap.size() > 0) {
                    // we want to handle both single and combined demands here
                    for(Standard_Customer_Pay_Plan_Detail__C s : objWRP[0].scppdBundleMap.values()) {
                        list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                        if(chargeMap.containsKey(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) 
                            tempListSCPPD = chargeMap.get(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name);
                        tempListSCPPD.add(s);
                        chargeMap.put(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name, tempListSCPPD);
                    }
                } 
                // Since we handle combined and single demands through the same method, 
                // we group the list of scppds by charge (basic: 1000 , Water: 200, Electricity : 50 etc.,)
                // then calculate taxes on them.
                Decimal totalAmt = 0;
                Decimal totalTaxableAmount = 0;
                Decimal AmountTobeBilled = 0;
                Decimal totalTDS = 0;
                Integer counter = 1;
                Set<String> taxNames = new Set<String>();
                    
                Map<String,List<Tax_Breakup__c>>  taxMap = InventoryCostServices.getChildTaxRateForCharges((objWRP[0].projectId));
                for(String eachCharge : chargeMap.keyset() ) {
                    totalAmt = 0;
                    for(Standard_Customer_Pay_Plan_Detail__c s : chargeMap.get(eachCharge)){
                        if(s.Charge_Amount_Billed__c != null && s.Charge_Amount_Billed__c >0 && s.Installment__c != null && s.Installment__c >0) {
                            AmountTobeBilled = (s.Installment__c - s.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                        } else if (s.Installment__c != null && s.Installment__c >0) {
                            AmountTobeBilled = s.Installment__c.setscale(0,RoundingMode.HALF_UP);
                        }
                        totalAmt +=AmountTobeBilled;
                        // if token amount milestone and no gst on token plan, then set the taxable amount to 0
                        if(s.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && s.Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                totalTaxableAmount = 0;
                                System.debug('No Token ON GST Debug:' + s.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c + ':' + s.Is_to_be__c + ':' + totalTaxableAmount);
                        }
                            else if(s.Add_Token_GST__c) {
                                totalTaxableAmount = totalAmt + s.Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                System.debug('Add Token GST Debug:' + s.Add_Token_GST__c + ':' + totalTaxableAmount);
                            } else
                                totalTaxableAmount = totalAmt;
                        AmountToBeBilled = 0;  
                        
                    } 
                    
                    // tax calculation for that specific charge
                    Decimal totalTax = 0;
                    Map<String,String> taxDetailsMap = new Map<String, String>();
                    Map<String,Decimal> taxDetailsMapD = new Map<String, Decimal>();
                    decimal taxValue = 0;
             
                    if(taxMap.containsKey(eachCharge)) {
                        for(Tax_Breakup__c tb : taxMap.get(eachCharge)) {
                            taxValue = 0;
                            taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAX RATE' , string.valueOf(tb.tax_percentage__c) + '%' );
                            taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat((tb.Taxable_Percentage__c * totalTaxableAmount/100).setscale(0,RoundingMode.HALF_UP)));
                            // Added by shailesh
                            taxDetailsMap.put(eachCharge + ' TAXABLE VALUE' , QuotationManagementServices.INFormat((tb.Taxable_Percentage__c * totalTaxableAmount/100).setscale(0,RoundingMode.HALF_UP)));
                            taxDetailsMapD.put(eachCharge + ' TAXABLE VALUE D' , (tb.Taxable_Percentage__c * totalTaxableAmount/100).setscale(0,RoundingMode.HALF_UP));
                            taxDetailsMap.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT' , QuotationManagementServices.INFormat(((tb.Taxable_Percentage__c * totalTaxableAmount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ));
                            taxDetailsMapD.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT D' , ((tb.Taxable_Percentage__c * totalTaxableAmount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                            taxValue = ((tb.Taxable_Percentage__c * totalTaxableAmount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                            totalTax += taxValue;
                            taxnames.add(tb.Tax_Name__c);
                            wd.taxRateMap.put(tb.Tax_Name__c, string.valueOf(tb.Tax_Percentage__c.setscale(0,RoundingMode.HALF_UP)) + '%');
                            grandTaxTotal += taxValue;
                        }
                        taxDetailsMap.put(eachCharge + ' TOTAL TAX AMT', QuotationManagementServices.INFormat(totalTax));
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT D', totalTax);
                        wd.ChargeOverallTotal.put(eachCharge, QuotationManagementServices.INFormat(totalAmt + totalTax));
                        wd.ChargeOverallTotalD.put(eachCharge, (totalAmt + totalTax));
                        wd.ChargeOverallTotalWords.put(eachCharge, S_NumberToWord.convertNumbertoWords(totalAmt + totalTax));
                    } else {
                        taxDetailsMap.put(eachCharge + ' TOTAL TAX AMT', QuotationManagementServices.INFormat(0));
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT D', 0);
                        wd.ChargeOverallTotal.put(eachCharge, QuotationManagementServices.INFormat(totalAmt));
                        wd.ChargeOverallTotalD.put(eachCharge, totalAmt);
                        wd.ChargeOverallTotalWords.put(eachCharge, S_NumberToWord.convertNumbertoWords(totalAmt));
                    }
                    
                    wd.ChargeNameMap.put(eachCharge, counter);
                    wd.chargeAmountMap.put(eachCharge, QuotationManagementServices.INFormat(totalAmt));
                    //Added by shailesh to get Amount in decimal
                    wd.chargeAmountMapD.put(eachCharge, totalAmt);
                    wd.ChargeTaxMap.putAll(taxDetailsMap);
                    wd.ChargeTaxMapD.putAll(taxDetailsMapD);
                    wd.taxNames = taxNames;
                    
                    grandAmtTotal += totalAmt;
                    counter++;
                }
                wd.tdsAmount = totalTDS;
                // if a specific tax is not applicable for a particular charge, then put the tax names and empty values
                // this is required so that the demand printing doesn't throw NPE
                for(String t: wd.taxnames){
                    for(string c: wd.ChargeNameMap.keyset()) {
                        if(!wd.ChargeTaxMap.containsKey(c + ' '+  t + ' TAX RATE')) {
                            wd.ChargeTaxMap.put(c + ' '+ t +  ' TAX RATE' , QuotationManagementServices.INFormat(0) );
                            wd.ChargeTaxMap.put(c + ' '+ t +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat(0));
                            wd.ChargeTaxMap.put(c + ' '+  t + ' TAX AMT' , QuotationManagementServices.INFormat(0) );
                        }
                        if(!wd.ChargeTaxMap.containsKey(c + ' TAXABLE VALUE')) {
                            wd.ChargeTaxMap.put(c + ' TAXABLE VALUE' , QuotationManagementServices.INFormat(0));
                        }
                        if(!wd.ChargeTaxMapD.containsKey(c + ' TAXABLE VALUE D')) {
                            wd.ChargeTaxMapD.put(c + ' TAXABLE VALUE D' , 0);
                        }
                        if(!wd.ChargeTaxMapD.containsKey(c + ' '+  t + ' TAX AMT D')) {
                            wd.ChargeTaxMapD.put(c + ' '+  t + ' TAX AMT D' , 0);
                        }
                    }
                }
                wd.totalCurrentCharges.put('CURRENT TAX TOTAL', grandTaxTotal);
                wd.totalCurrentCharges.put('CURRENT AMT TOTAL', grandAmtTotal);
                wd.totalCurrentCharges.put('CURRENT TOTAL', grandAmtTotal+grandTaxTotal);
                System.debug('each charge:' + wd.ChargeNameMap);
                System.debug('Tax Details:' + wd.ChargeTaxMap);
                return wd;
            }
            return null;
        }else {
            return null;
        }
    }
    
    // bulkified version of the current demand details, this is called from the createDINew
    public static Map<String, wrpDemand> getCurrentDemandDetailsB(List<wrpCustomersNew> objWRPList) {
        Map<String, wrpDemand> wdMap = new Map<String, wrpDemand>();           
        Set<String> taxNames = new Set<String>();
        // using any one project from the list of customers as all customers coming into this we will be from the same project as we show demands tower wise.
        Map<String,List<Tax_Breakup__c>>  taxMap = InventoryCostServices.getChildTaxRateForCharges((objWRPList[0].projectId));
        Integer loopCounter = 1;       
        if(objWRPList != null && objWRPList.size() > 0) {
            for (wrpCustomersNew objWRP : objWRPList) {
                wrpDemand wd = new wrpDemand();
                wd.OpportunityId = objWRP.OpportunityId;
                wd.CurrentDemandAmount = (objWRP.InstallAmt).setscale(0,RoundingMode.HALF_UP);
                wd.InvoiceDate = objWRP.InvoiceDate;
                wd.InvoiceDueDate = objWRP.InvoiceDueDate;
                wd.projectId = objWRP.projectId;
                wd.projectUnit = objWRP.projectUnit;
                wd.milestoneName = objWRP.stageName;
                Map<String, List<Standard_Customer_Pay_Plan_Detail__C>> chargeMap = new Map<String,List<Standard_Customer_Pay_Plan_Detail__C>>();
                
                if(objWRP.scppdBundleMap != null && objWRP.scppdBundleMap.size() > 0) {
                    // we want to handle both single and combined demands here
                    for(Standard_Customer_Pay_Plan_Detail__C s : objWRP.scppdBundleMap.values()) {
                        list < Standard_Customer_Pay_Plan_Detail__c > tempListSCPPD = new list < Standard_Customer_Pay_Plan_Detail__c > ();
                        if(chargeMap.containsKey(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) 
                            tempListSCPPD = chargeMap.get(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name);
                        tempListSCPPD.add(s);
                        chargeMap.put(s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name, tempListSCPPD);
                    }
                }
                // Since we handle combined and single demands through the same method, 
                // we group the list of scppds by charge (basic: 1000 , Water: 200, Electricity : 50 etc.,)
                // then calculate taxes on them.
                Decimal totalAmt = 0;
                Decimal totalTaxableAmount = 0;
                Decimal AmountTobeBilled = 0;
                Decimal totalTDS = 0;
                Integer counter = 1;
                for(String eachCharge : chargeMap.keyset() ) {
                    totalAmt = 0;
                    for(Standard_Customer_Pay_Plan_Detail__c s : chargeMap.get(eachCharge)){
                        if(s.Charge_Amount_Billed__c != null && s.Charge_Amount_Billed__c >0 && s.Installment__c != null && s.Installment__c >0) {
                            AmountTobeBilled = (s.Installment__c - s.Charge_Amount_Billed__c).setscale(0,RoundingMode.HALF_UP);
                        } else if (s.Installment__c != null && s.Installment__c >0) {
                            AmountTobeBilled = s.Installment__c.setscale(0,RoundingMode.HALF_UP);
                        }
                        // though we are generating one record to represent a single charge, we want to store the indivual amounts 
                        // that added up to the total as ledgers are generated for each milestone amount.
                        
                        totalAmt +=AmountTobeBilled;
                        // if token amount milestone and no gst on token plan, then set the taxable amount to 0
                        if(s.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && s.Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                totalTaxableAmount = 0;
                                System.debug('No Token ON GST Debug:' + s.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c + ':' + s.Is_to_be__c + ':' + totalTaxableAmount);
                        }
                            else if(s.Add_Token_GST__c) {
                                totalTaxableAmount = totalAmt + s.Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                System.debug('Add Token GST Debug:' + s.Add_Token_GST__c + ':' + totalTaxableAmount);
                            } else
                                totalTaxableAmount = totalAmt;
                        AmountToBeBilled = 0;  
                    } 
                    // tax calculation for that specific charge
                    Decimal totalTax = 0;
                    Map<String,Decimal> taxDetailsMapD = new Map<String, Decimal>();
                    decimal taxValue = 0;
                    if(taxMap.containsKey(eachCharge)) {
                        for(Tax_Breakup__c tb : taxMap.get(eachCharge)) {
                            taxValue = 0;
                            taxDetailsMapD.put(eachCharge + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c);
                            taxDetailsMapD.put(eachCharge + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * totalTaxableAmount/100).setscale(0,RoundingMode.HALF_UP));
                            taxDetailsMapD.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * totalTaxableAmount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                            taxValue = ((tb.Taxable_Percentage__c * totalTaxableAmount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                            totalTax += taxValue;
                            taxnames.add(tb.Tax_Name__c);
                            wd.ChargeTaxMap.put(eachCharge + ' ' + tb.tax_name__c + ' TAXRECORD ID', tb.Id);
                            wd.taxRateMapD.put(tb.Tax_Name__c, tb.Tax_Percentage__c.setscale(0,RoundingMode.HALF_UP));
                        }
                        
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT', totalTax);
                        wd.ChargeOverallTotalD.put(eachCharge,totalAmt + totalTax);
                    } else {
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT', 0);
                        wd.ChargeOverallTotalD.put(eachCharge, totalAmt);
                    }
                    
                    wd.ChargeNameMap.put(eachCharge, counter);
                    wd.chargeAmountMapD.put(eachCharge, totalAmt);
                    wd.ChargeTaxMapD.putAll(taxDetailsMapD);
                    wd.taxNames = taxNames;
                    wd.scppdChargeMap.put(eachCharge, chargeMap.get(eachCharge)); 
                    counter++;
                }
                wd.tdsAmount = totalTDS;
                // if a specific tax is not applicable for a particular charge, then put the tax names and empty values
                // this is required so that the demand printing doesn't throw NPE
                for(String t: wd.taxnames){
                    for(string c: wd.ChargeNameMap.keyset()) {
                        if(!wd.ChargeTaxMapD.containsKey(c + ' '+  t + ' TAX RATE')) {
                            wd.ChargeTaxMapD.put(c + ' '+ t +  ' TAX RATE' , 0 );
                            wd.ChargeTaxMapD.put(c + ' '+ t +  ' TAXABLE AMOUNT' , 0);
                            wd.ChargeTaxMapD.put(c + ' '+  t + ' TAX AMT' , 0 );
                        }
                    }
                }
                System.debug('Current Demand Details Bulk : each charge:' + loopCounter + wd.ChargeNameMap);
                System.debug('Current Demand Details Bulk : Tax Details Decimal:' + loopCounter + wd.ChargeTaxMapD);
                System.debug('Current Demand Details Bulk : Tax Details String:' + loopCounter + wd.ChargeTaxMap);
               
                wdMap.put(objWRP.uniqueKey, wd);
                loopCounter++;
        } //end for loop
        return wdMap;
    }else {
            return null;
    }
}
    
    
    
    // for previewing advance demands 
    // what the RM wants to raise, is decided by the RM, we take the amt and service tax and create the demand wrapper for it
    public static wrpDemand getAdvanceDemandDetails(list<Id> scppdIds, string type, Decimal advAmount, Decimal stAmt) {
        List<Standard_Customer_Pay_Plan_Detail__C> scppdList = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,Is_To_be_Paid__c,Installment_Number__c,Inst_No__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,Project__r.Days_to_Send_Demand__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Standard_Pay_Plan_Header__r.Charge_code__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    TDS__c ,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,
                                                                    Project_Construction_Stages__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where id in :scppdIds
                                                                ];
        List<wrpCustomersNew> objWRP = new List<wrpCustomersNew>();
        decimal grandAmtTotal = 0;
        decimal grandTaxTotal = 0;
        if (scppdList != null && type.equalsIgnoreCase('advance')) {
            
            if(scppdList.size() > 0) {
                objWRP = createCustomerWrapperNew(scppdList);
            }
            if(objWRP != null && objWRP.size() ==1) {
                wrpDemand wd = new wrpDemand();
                wd.OpportunityId = objWRP[0].OpportunityId;
                wd.CurrentDemandAmount = advAmount;
                wd.InvoiceDate = objWRP[0].InvoiceDate;
                wd.InvoiceDueDate = objWRP[0].InvoiceDueDate;
                wd.projectId = objWRP[0].projectId;
                wd.projectUnit = objWRP[0].projectUnit;
                wd.milestoneName = objWRP[0].stageName +  ' (Advanced Demand) ';
                Map<String, List<Standard_Customer_Pay_Plan_Detail__C>> chargeMap = new Map<String,List<Standard_Customer_Pay_Plan_Detail__C>>();
                
                chargeMap.put(scppdList[0].Standard_Pay_Plan_Header__r.Charge_Code__r.Name, scppdList);
                
                Decimal totalAmt = 0;
                Decimal AmountTobeBilled = 0;
                Decimal totalTDS;
                Integer counter = 1;
                Set<String> taxNames = new Set<String>();
                    
                Map<String,List<Tax_Breakup__c>>  taxMap = InventoryCostServices.getChildTaxRateForCharges((wd.projectId));
                for(String eachCharge : chargeMap.keyset() ) {
                    totalAmt = 0;
                    totalTDS = 0;
                    for(Standard_Customer_Pay_Plan_Detail__c s : chargeMap.get(eachCharge)){
                        AmountTobeBilled = advAmount;
                        totalAmt +=AmountTobeBilled;
                        if(s.TDS__c != null) 
                            totalTDS  += s.TDS__c;
                        AmountToBeBilled = 0;  
                    } 
                    // tax calculation for that specific charge
                    Decimal totalTax = 0;
                    Map<String,String> taxDetailsMap = new Map<String, String>();
                    Map<String,Decimal> taxDetailsMapD = new Map<String, Decimal>();
                    decimal taxValue = 0;
             
                    if(taxMap.containsKey(eachCharge)) {
                        for(Tax_Breakup__c tb : taxMap.get(eachCharge)) {
                            taxValue = 0;
                            taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAX RATE' , string.valueOf(tb.tax_percentage__c) + '%' );
                            taxDetailsMap.put(eachCharge + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat((tb.Taxable_Percentage__c * totalAmt/100).setscale(0,RoundingMode.HALF_UP)));
                            // Added by shailesh
                            taxDetailsMap.put(eachCharge + ' TAXABLE VALUE' , QuotationManagementServices.INFormat((tb.Taxable_Percentage__c * totalAmt/100).setscale(0,RoundingMode.HALF_UP)));
                            taxDetailsMapD.put(eachCharge + ' TAXABLE VALUE D' , (tb.Taxable_Percentage__c * totalAmt/100).setscale(0,RoundingMode.HALF_UP));
                            taxDetailsMap.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT' , QuotationManagementServices.INFormat(((tb.Taxable_Percentage__c * totalAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ));
                            taxDetailsMapD.put(eachCharge + ' '+  tb.tax_name__c + ' TAX AMT D' , ((tb.Taxable_Percentage__c * totalAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                            taxValue = ((tb.Taxable_Percentage__c * totalAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                            totalTax += taxValue;
                            taxnames.add(tb.Tax_Name__c);
                            wd.taxRateMap.put(tb.Tax_Name__c, string.valueOf(tb.Tax_Percentage__c.setscale(0,RoundingMode.HALF_UP)) + '%');
                            grandTaxTotal += taxValue;
                        }
                        taxDetailsMap.put(eachCharge + ' TOTAL TAX AMT', QuotationManagementServices.INFormat(totalTax));
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT D', totalTax);
                        wd.ChargeOverallTotal.put(eachCharge, QuotationManagementServices.INFormat(totalAmt + totalTax));
                        wd.ChargeOverallTotalD.put(eachCharge, (totalAmt + totalTax));
                        wd.ChargeOverallTotalWords.put(eachCharge, S_NumberToWord.convertNumbertoWords(totalAmt + totalTax));
                    } else {
                        wd.ChargeOverallTotal.put(eachCharge, QuotationManagementServices.INFormat(totalAmt));
                        wd.ChargeOverallTotalD.put(eachCharge, totalAmt);
                        wd.ChargeOverallTotalWords.put(eachCharge, S_NumberToWord.convertNumbertoWords(totalAmt));
                        taxDetailsMap.put(eachCharge + ' TOTAL TAX AMT', QuotationManagementServices.INFormat(0));
                        taxDetailsMapD.put(eachCharge + ' TOTAL TAX AMT D', 0);
                    }
                    
                    wd.ChargeNameMap.put(eachCharge, counter);
                    wd.chargeAmountMap.put(eachCharge, QuotationManagementServices.INFormat(totalAmt));
                    //Added by shailesh to get Amount in decimal
                    wd.chargeAmountMapD.put(eachCharge, totalAmt);
                    wd.ChargeTaxMap.putAll(taxDetailsMap);
                    wd.ChargeTaxMapD.putAll(taxDetailsMapD);
                    wd.taxNames = taxNames;
                    wd.tdsAmount = totalTDS;
                    grandAmtTotal += totalAmt;
                    counter++;
                }
                // if a specific tax is not applicable for a particular charge, then put the tax names and empty values
                // this is required so that the demand printing doesn't throw NPE
                for(String t: wd.taxnames){
                    for(string c: wd.ChargeNameMap.keyset()) {
                        if(!wd.ChargeTaxMap.containsKey(c + ' '+  t + ' TAX RATE')) {
                            wd.ChargeTaxMap.put(c + ' '+ t +  ' TAX RATE' , QuotationManagementServices.INFormat(0) );
                            wd.ChargeTaxMap.put(c + ' '+ t +  ' TAXABLE AMOUNT' , QuotationManagementServices.INFormat(0));
                            wd.ChargeTaxMap.put(c + ' '+  t + ' TAX AMT' , QuotationManagementServices.INFormat(0) );
                        }
                        if(!wd.ChargeTaxMap.containsKey(c +' TAXABLE VALUE')) {
                            wd.ChargeTaxMap.put(c +' TAXABLE VALUE' , QuotationManagementServices.INFormat(0));
                        }
                        if(!wd.ChargeTaxMapD.containsKey(c +' TAXABLE VALUE D')) {
                            wd.ChargeTaxMapD.put(c +' TAXABLE VALUE D' , 0);
                        }
                        if(!wd.ChargeTaxMapD.containsKey(c + ' '+  t + ' TAX AMT D')) {
                            wd.ChargeTaxMapD.put(c + ' '+  t + ' TAX AMT D' , 0);
                        }
                    }
                }
                wd.totalCurrentCharges.put('CURRENT TAX TOTAL', grandTaxTotal);
                wd.totalCurrentCharges.put('CURRENT AMT TOTAL', grandAmtTotal);
                wd.totalCurrentCharges.put('CURRENT TOTAL', grandAmtTotal+grandTaxTotal);
                System.debug('each charge:' + wd.ChargeNameMap);
                System.debug('Tax Details:' + wd.ChargeTaxMap);
                return wd;
            }
            return null;
        } else {
            return null;
        }
    }
   
    // we need a list of all the outstanding charges for the customer to use as the key of the map.
    public static Set<String> getOutstandingChargesName(Id oppId) {
         List<Customer_Pay_Plan_Header__c> cList = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Customer__r.Total_Interest_Waiver__c,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,
                                                         Booking__r.Owner.email,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE Customer__r.Id = :oppId
                                                         and ( (Amount_Demanded_Till_Date__c > 0 and Outstanding_Amount__c > 0) OR
                                                         (Service_Tax_Demanded_Till_Date__c > 0 and Outstanding_Service__c > 0))
                                                         and Customer__r.status__c = 'Active'];
       Set<String> outstandingChargesSet = new Set<String>();
       if(cList != null && cList.size() > 0) {
            for(Customer_Pay_Plan_Header__c c : cList) {
                outstandingChargesSet.add(c.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c);
            }
       }
       return   outstandingChargesSet;                           
    }
    
    // we need a list of all the outstanding charges for the customer to use as the key of the map.
    // this is the bulkified version used in createDINew
    public static Map<Id,Set<String>> getOutstandingChargesNameB(Set<Id> oppIdSet) {
         List<Customer_Pay_Plan_Header__c> cList = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Customer__r.Total_Interest_Waiver__c,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,
                                                         Booking__r.Owner.email,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE Customer__r.Id = :oppIdSet  and (Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != 'Stamp Duty and Registration')
                                                         and ( (Amount_Demanded_Till_Date__c > 0 and Outstanding_Amount__c > 0) OR
                                                         (Service_Tax_Demanded_Till_Date__c > 0 and Outstanding_Service__c > 0))
                                                         and Customer__r.status__c = 'Active'];
       Map<Id,Set<String>> oppOutstandingChargeSet = new Map<Id,Set<String>>();
       if(cList != null && cList.size() > 0) {
            for(Customer_Pay_Plan_Header__c c : cList) {
                if(oppOutstandingChargeSet.containsKey(c.Customer__c)) {
                    oppOutstandingChargeSet.get(c.customer__c).add(c.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c);
                } else {
                    Set<String> outstandingChargesSet = new Set<String>();
                    outstandingChargesSet.add(c.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c);
                    oppOutstandingChargeSet.put(c.customer__c, outstandingChargesSet);
                }
            }
       }
       return   oppOutstandingChargeSet;                           
    } 
                                                        
    // this version of the other charges summary creates one record per other charge
    // this is used for printing the other charges in the demand preview
    // the getDemandSoFarSummaryOtherCharges method is a summary which adds up all the other charges outstanding 
    // and creates a total value which is used in ledger printing
    public static Map<String,Decimal> getDemandSoFarSummaryOtherChargesNew(Id oppId) {
         List<Customer_Pay_Plan_Header__c> cList = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Customer__r.Total_Interest_Waiver__c,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,
                                                         Booking__r.Owner.email,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE Customer__r.Id = :oppId and (Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != 'Stamp Duty and Registration')
                                                         and ( (Amount_Demanded_Till_Date__c > 0 and Outstanding_Amount__c > 0) OR
                                                         (Service_Tax_Demanded_Till_Date__c > 0 and Outstanding_Service__c > 0))
                                                         and Customer__r.status__c = 'Active'];
         System.debug('charge summary map: oppId : chargeName:  ' + oppId);
         system.debug('cList::: '+cList);
         system.debug('cList.size():: '+cList.size());
         
         Decimal outstandingTotal = 0;
         Decimal interestTotal = 0;
         String chargename = '';
         Decimal amtTotal = 0;
         Decimal TaxTotal = 0;
         Map<String,Decimal> chargeSummaryMap = new Map<String,Decimal>();
         if(cList != null && cList.size() > 0) {
            for(Customer_Pay_Plan_Header__c c : cList) {
                outstandingTotal = 0;
                interestTotal = 0;
                chargeName = c.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c;
                
                if(NULL != c.Amount_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , c.Amount_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , 0);
                if(NULL != c.Service_Tax_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , c.Service_Tax_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else 
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , 0);
                if(NULL != c.Amount_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' RECD' , c.Amount_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' RECD' , 0);
                if(NULL != c.Service_Tax_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , c.Service_Tax_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , 0);
                if(NULL != c.Outstanding_Amount__c) {
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP);
                    amtTotal += c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , 0);
                if(NULL != c.Outstanding_Service__c) {
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP);
                    taxTotal += c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP);
                }
                else 
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , 0);
                if(NULL != c.Amount__c)
                    chargeSummaryMap.put(chargeName + ' TOTAL' , c.Amount__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TOTAL' , 0);
                // interest outstanding
                if(NULL != c.Int_Flatcost_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST' , c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    interestTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    amtTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST' , 0);
                if(NULL != c.Int_Servicetax_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST' , c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    interestTotal += c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    amtTotal +=  c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST' , 0);
               
                // interest due
                if(NULL != c.Int_Flatcost_Due__c) 
                    chargeSummaryMap.put( chargeName + ' INTEREST DUE' , c.Int_Flatcost_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST DUE' , 0);
                if(NULL != c.Int_Servicetax_Due__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST DUE' , c.Int_Servicetax_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST DUE' , 0);
                    
                // interest paid
                if(NULL != c.Int_flatcost_Paid_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST PAID' , c.Int_flatcost_Paid_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST PAID' , 0);
                if(NULL != c.Int_servicetax_paid_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST PAID' , c.Int_servicetax_paid_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST PAID' , 0);
                
                // interest waived
                if(NULL != c.Int_flatcost_Waived_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST WAIVED' , c.Int_flatcost_Waived_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST WAIVED' , 0);
                if(NULL != c.Int_servicetax_waived_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST WAIVED' , c.Int_servicetax_waived_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST WAIVED' , 0);
                // total outstanding in formatted number and words
                chargeSummaryMap.put(chargeName + ' TOTAL OUTSTANDING' , outstandingTotal);  
                chargeSummaryMap.put(chargeName + ' INTEREST OUTSTANDING' , interestTotal);  
                chargeSummaryMap.put('OUTSTANDING AMT' , amtTotal);
                chargeSummaryMap.put('OUTSTANDING TAX', taxTotal);
            }
            System.debug('charge summary map:' + chargeSummaryMap);
            return chargeSummaryMap;
         }          
         return null;                                      
    }
    
    // Bulkified version of this method for calling from createDI 
    public static Map<Id ,Map<String, Map<String,Decimal>>> getDemandSoFarSummaryOtherChargesNewB(Set <Id> oppIdSet) {
         List<Customer_Pay_Plan_Header__c> cList = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Customer__r.Total_Interest_Waiver__c,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,
                                                         Booking__r.Owner.email,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                         Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE Customer__r.Id = :oppIdSet and (Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != 'Stamp Duty and Registration')
                                                         and ( (Amount_Demanded_Till_Date__c > 0 and Outstanding_Amount__c > 0) OR
                                                         (Service_Tax_Demanded_Till_Date__c > 0 and Outstanding_Service__c > 0))
                                                         and Customer__r.status__c = 'Active'];
         System.debug('charge summary map: oppId : chargeName:  ' + oppIdSet);
         system.debug('cList::: '+cList);
         system.debug('cList.size():: '+cList.size());
         
         Decimal outstandingTotal = 0;
         Decimal interestTotal = 0;
         String chargename = '';
         Map<Id,Map<String, Map<String,Decimal>>> oppChargeSummaryMap = new Map<Id, Map<String, Map<String, Decimal>> >();
         if(cList != null && cList.size() > 0) {
            for(Customer_Pay_Plan_Header__c c : cList) {
                outstandingTotal = 0;
                interestTotal = 0;
                chargeName = c.Standard_Pay_Plan_Header__r.Charge_Code__r.Remarks__c;
                Map<String,Decimal> chargeSummaryMap = new Map<String,Decimal>();
                if(NULL != c.Amount_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , c.Amount_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , 0);
                if(NULL != c.Service_Tax_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , c.Service_Tax_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else 
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , 0);
                if(NULL != c.Amount_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' RECD' , c.Amount_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' RECD' , 0);
                if(NULL != c.Service_Tax_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , c.Service_Tax_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , 0);
                if(NULL != c.Outstanding_Amount__c) {
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , 0);
                if(NULL != c.Outstanding_Service__c) {
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP);
                }
                else 
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , 0);
                if(NULL != c.Amount__c)
                    chargeSummaryMap.put(chargeName + ' TOTAL' , c.Amount__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TOTAL' , 0);
                // interest outstanding
                if(NULL != c.Int_Flatcost_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST' , c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    interestTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST' , 0);
                if(NULL != c.Int_Servicetax_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST' , c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                    interestTotal += c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST' , 0);
               
                // interest due
                if(NULL != c.Int_Flatcost_Due__c) 
                    chargeSummaryMap.put( chargeName + ' INTEREST DUE' , c.Int_Flatcost_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST DUE' , 0);
                if(NULL != c.Int_Servicetax_Due__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST DUE' , c.Int_Servicetax_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST DUE' , 0);
                    
                // interest paid
                if(NULL != c.Int_flatcost_Paid_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST PAID' , c.Int_flatcost_Paid_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST PAID' , 0);
                if(NULL != c.Int_servicetax_paid_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST PAID' , c.Int_servicetax_paid_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST PAID' , 0);
                
                // interest waived
                if(NULL != c.Int_flatcost_Waived_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST WAIVED' , c.Int_flatcost_Waived_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST WAIVED' , 0);
                if(NULL != c.Int_servicetax_waived_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST WAIVED' , c.Int_servicetax_waived_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST WAIVED' , 0);
                // total outstanding in formatted number and words
                chargeSummaryMap.put(chargeName + ' TOTAL OUTSTANDING' , outstandingTotal);  
                chargeSummaryMap.put(chargeName + ' INTEREST OUTSTANDING' , interestTotal);  
                if(oppChargeSummaryMap.containsKey(c.Customer__c)) {
                    oppChargeSummaryMap.get(c.customer__c).put(chargeName, chargeSummaryMap);
                } else {
                    Map<String, Map<String, Decimal>> tempMap = new Map<String, Map<String,Decimal>>();
                    tempMap.put(chargeName, chargeSummaryMap);
                    oppChargeSummaryMap.put(c.customer__c, tempMap);
                }
                
            }
            System.debug('charge summary map in bulk get other charges Map:' + oppChargeSummaryMap);
            return oppChargeSummaryMap;
         }          
         return null;                                      
    }
    
    // get all other charges paid by a customer, needed for printing ledger
    // other charges bundles everthing but flat cost, stamp duty and registration 
    // takes a single customer as bulkified version will be lot of unnecessary data fetching 
    public static Map<String,Decimal> getDemandSoFarSummaryOtherCharges(Id oppId) {
         List<Customer_Pay_Plan_Header__c> cpphList = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,Booking__r.Owner.email,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE (Global_Charges__r.Name != 'Stamp Duty' AND Global_Charges__r.Name != 'Registration Charges' AND Global_Charges__r.Name != 'Basic')
                                                         and Customer__r.Id = :oppId
                                                         and Customer__r.status__c = 'Active'];
         string chargeName = 'Other';
         System.debug('charge summary map: oppId : chargeName:  ' + oppId + ' : ' + chargeName);
         Decimal outstandingTotal = 0;
         if(cpphList != null && cpphList.size() > 0) {
            Map<String,Decimal> chargeSummaryMap = new Map<String,Decimal>();
           
            for(Customer_pay_plan_Header__c c : cpphList) {
                 outstandingTotal = 0;
                if(NULL != c.Amount_Demanded_Till_Date__c && chargeSummaryMap.containsKey(chargeName + ' DEMANDED')) 
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , chargeSummaryMap.get(chargeName + ' DEMANDED') + c.Amount_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else if (NULL != c.Amount_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , c.Amount_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' DEMANDED' , 0);
                
                if(NULL != c.Service_Tax_Demanded_Till_Date__c &&  chargeSummaryMap.containsKey(chargeName + ' TAX DEMANDED'))
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , chargeSummaryMap.get(chargeName + ' TAX DEMANDED') + c.Service_Tax_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else if(NULL != c.Service_Tax_Demanded_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' ,c.Service_Tax_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else 
                    chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , 0);
                
                if(NULL != c.Amount_Recd_Till_Date__c && chargeSummaryMap.containsKey(chargeName + ' RECD'))
                    chargeSummaryMap.put(chargeName + ' RECD' , chargeSummaryMap.get(chargeName + ' RECD') + c.Amount_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else if(NULL != c.Amount_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' RECD' , c.Amount_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' RECD' , 0);
                    
                if(NULL != c.Service_Tax_Recd_Till_Date__c && chargeSummaryMap.containsKey(chargeName + ' TAX RECD'))
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , chargeSummaryMap.get(chargeName + ' TAX RECD') + c.Service_Tax_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else if(NULL != c.Service_Tax_Recd_Till_Date__c)
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , c.Service_Tax_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TAX RECD' , 0);
                
                if(NULL != c.Outstanding_Amount__c && chargeSummaryMap.containsKey(chargeName + ' OUTSTANDING')) {
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , chargeSummaryMap.get(chargeName + ' OUTSTANDING') + c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP);
                }
                else if(NULL != c.Outstanding_Amount__c)
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , 0);
                    
                if(NULL != c.Outstanding_Service__c && chargeSummaryMap.containsKey(chargeName + ' TAX OUTSTANDING')) {
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , chargeSummaryMap.get(chargeName + ' TAX OUTSTANDING') + c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP);
                }
                else if(NULL != c.Outstanding_Service__c)
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , 0);
                    
                if(NULL != c.Amount__c && chargeSummaryMap.containsKey(chargeName + ' TOTAL'))
                    chargeSummaryMap.put(chargeName + ' TOTAL' , chargeSummaryMap.get(chargeName + ' TOTAL') + c.Amount__c.setscale(0,RoundingMode.HALF_UP));
                else if(NULL != c.Amount__c)
                    chargeSummaryMap.put(chargeName + ' TOTAL' , c.Amount__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' TOTAL' , 0);
                // interest outstanding
                if(NULL != c.Int_Flatcost_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST' , c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST' , 0);
                if(NULL != c.Int_Servicetax_Pending__c) {
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST' , c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP));
                    outstandingTotal += c.Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP);
                }
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST' , 0);
               
                // interest due
                if(NULL != c.Int_Flatcost_Due__c) 
                    chargeSummaryMap.put( chargeName + ' INTEREST DUE' , c.Int_Flatcost_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST DUE' , 0);
                if(NULL != c.Int_Servicetax_Due__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST DUE' , c.Int_Servicetax_Due__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST DUE' , 0);
                    
                // interest paid
                if(NULL != c.Int_flatcost_Paid_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST PAID' , c.Int_flatcost_Paid_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST PAID' , 0);
                if(NULL != c.Int_servicetax_paid_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST PAID' , c.Int_servicetax_paid_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST PAID' , 0);
                
                // interest waived
                if(NULL != c.Int_flatcost_Waived_Till_Date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST WAIVED' , c.Int_flatcost_Waived_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST WAIVED' , 0);
                if(NULL != c.Int_servicetax_waived_till_date__c)
                    chargeSummaryMap.put( chargeName + ' INTEREST ON ST WAIVED' , c.Int_servicetax_waived_till_date__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' INTEREST ON ST WAIVED' , 0);
                    
                chargeSummaryMap.put(chargeName + ' TOTAL OUTSTANDING' , outstandingTotal);  
                }
            System.debug('charge summary map:' + chargeSummaryMap);
            return chargeSummaryMap;
         }          
         return null;                                      
    }
    
    public static void createRegistrationDetails(set<Id> customerSet) {
        List<Customer_Pay_Plan_Header__c> cpphList = new List<Customer_Pay_Plan_Header__c>();
        List<Id> customerList = new List<Id>();
        cpphList = [Select Id, Registration_Reached__c,Customer__r.Id,
                            Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, Outstanding_Amount__c,
                            Service_Tax_Demanded_Till_Date__c,Service_Tax_Recd_Till_Date__c,Outstanding_Service__c 
                            from Customer_Pay_Plan_Header__c where customer__c in :customerSet 
                            and Booking__c != null
                            and Project_Unit__r.Unit_Status__c = 'Sold'];
        if(cpphList.size() != 0) {
            
            for(Customer_Pay_Plan_Header__c cpph : cpphList) {
                customerList.add(cpph.Customer__r.Id);
            }
        }
        Map<Id,Opportunity> accOppMap = new Map<Id, Opportunity>();
        Map<Id,Id> personAccMap = new Map<Id, Id>();
        
        List<Opportunity> oList = [Select Id,Project_Unit__c, Account.Id from Opportunity where Id in :customerList];
        if(oList.size() > 0) {
            for(Opportunity  o : oList) {
                accOppMap.put(o.Account.Id,o);
            }
            List<Account> accList = [Select Id, PersonContactId, OwnerId from Account where id in : accOppMap.keySet()];
            if(accList.size() > 0) {
                for(Account a : accList) {
                    personAccMap.put(a.Id, a.PersonContactId);
                }
            }
        }
        List<task> tList = new List<task>();
        for(Opportunity o : oList) {
            Task t = new Task(Subject = 'Registration', task_type__c = 'Registration', Registraion_Status__c = 'Agreement Pending', status = 'Open', ActivityDate = system.today().addDays(30) , 
                        Call_Time__c = formatTime(system.now()), whatId = o.Id, whoId = personAccMap.get(o.AccountId));
            tList.add(t);
        }
        if(tList.size() > 0)
            insert tList;
    }
    
    // called from the registration task, when the intimation letter is sent to the customer
  /*  public static void updateRegistrationDetails(Id oppId, Id taskId) {
        List<Customer_Pay_Plan_Header__c> cpphList = new List<Customer_Pay_Plan_Header__c>();
        List<Id> customerList = new List<Id>();
        cpphList = [Select Id, Registration_Reached__c, Registration_Intimation_Sent__c, Customer__r.Id,Amount__c,
                            Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, Outstanding_Amount__c,
                            Service_Tax_Demanded_Till_Date__c,Service_Tax_Recd_Till_Date__c,Outstanding_Service__c,
                            Customer_Pay_Plan_Header__c.Global_Charges__r.Name
                            from Customer_Pay_Plan_Header__c where customer__c = :oppId
                            and Project_Unit__r.Unit_Status__c = 'Sold'
                            and Booking__c != null
                            and Global_Charges__r.Name in ('Stamp Duty', 'MVAT', 'Basic')];
        task t = [select Id, MVAT_to_be_Paid__c, Registration_charges_to_be_paid__c, Stamp_duty_charges_to_be_paid__c from task where Id = : taskId];
        if(cpphList != null && cpphList.size() != 0) {
            for(Customer_Pay_Plan_Header__c cpph : cpphList) {
                if(cpph.Global_Charges__r.Name.equalsIgnoreCase('MVAT')) {
                    cpph.Amount__c = t.MVAT_to_be_Paid__c;
                } else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Stamp Duty')) {
                    cpph.Amount__c = t.Stamp_duty_charges_to_be_paid__c;
                }  else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Basic')) {
                    cpph.Registration_Intimation_Sent__c = true;
                    cpph.show_registration_demand__c = true;
                }
            }
            update cpphList;
        }
        
        List<Standard_Customer_Pay_Plan_detail__c> scppdList = [Select Id, Installment__c,Customer_Pay_Plan_Header__r.Global_Charges__R.Name
                                                                    from Standard_Customer_Pay_Plan_detail__c  
                                                                    where Customer_Pay_Plan_Header__c in: cpphList 
                                                                    and Customer_Pay_Plan_Header__r.Global_Charges__R.Name in ('MVAT', 'Stamp Duty')];
        if(ScppdList != null && scppdList.size() != 0) {
            for(Standard_Customer_Pay_Plan_detail__c scppd : scppdList) {
                if(Scppd.Customer_Pay_Plan_Header__r.Global_Charges__R.Name.equalsIgnoreCase('MVAT')) {
                    Scppd.Installment__c = t.MVAT_to_be_Paid__c;
                } else if (Scppd.Customer_Pay_Plan_Header__r.Global_Charges__R.Name.equalsIgnoreCase('Stamp Duty')) {
                    Scppd.Installment__c = t.Stamp_duty_charges_to_be_paid__c;
                }
            }
            update scppdList;
        }
    }     */
    
    // clear MVAT ledger when registration is abandoned
    // put the MVAT money back into account, if it has already been paid
    public static void clearMVATLedgers(Id oppId) {
        
        List<Customer_Pay_Plan_Header__c> cpphList = [Select Id, Registration_Reached__c, Registration_Intimation_Sent__c, Customer__r.Id,Amount__c,
                            Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, Outstanding_Amount__c,
                            Service_Tax_Demanded_Till_Date__c,Service_Tax_Recd_Till_Date__c,Outstanding_Service__c 
                            from Customer_Pay_Plan_Header__c where customer__c = :oppId
                            and Project_Unit__r.Unit_Status__c = 'Sold'
                            and Booking__c != null
                            and Global_Charges__r.Name in ('MVAT')];
        if(cpphList != null && cpphList.size() > 0) {
            cpphList[0].Amount_Demanded_Till_Date__c = 0;
            cpphList[0].Amount_Recd_Till_Date__c = 0;
            cpphList[0].Service_Tax_Demanded_Till_Date__c = 0;
            cpphList[0].Service_Tax_Recd_Till_Date__c = 0;
            
            update cpphList[0];
        }
        List<Standard_Customer_Pay_Plan_detail__c> scppdList = [Select Id, Charge_Amount_Billed__c,Charge_Amount_Paid__c,Installment_Number__c,Inst_No__c,  
                                                                    Service_Tax_Amount_Billed__c,Service_Tax_Amount_Paid__c,
                                                                    Installment__c,Customer_Pay_Plan_Header__r.Global_Charges__R.Name
                                                                    from Standard_Customer_Pay_Plan_detail__c  
                                                                    where Customer_Pay_Plan_Header__c in: cpphList 
                                                                    and Customer_Pay_Plan_Header__r.Global_Charges__R.Name in ('MVAT')];
        if(ScppdList != null && scppdList.size() > 0) {
            scppdList[0].Charge_Amount_Billed__c = 0;
            scppdList[0].Charge_Amount_Paid__c = 0;
            scppdList[0].Service_Tax_Amount_Billed__c = 0;
            scppdList[0].Service_Tax_Amount_Paid__c= 0;
            
            update scppdList[0];
        }
        
        List<Ledger__c> lList = [Select Id, Amount__c, Reciepts__r.Id, Receipt_Details__r.Id, Debit_Credit__c from Ledger__c where Global_Charges__r.Name = 'MVAT' and Opportunity__r.Id = :oppId and 
                                                                Standard_Customer_Pay_Plan_Detail__r.Id in :scppdList];
        if(lList != null && lList.size() > 0) {
            for(ledger__c l : lList) {
                if(l.Debit_Credit__c.equals('Credit')) {
                    Receipt__c r = [Select Id, On_Account_Money__c from Receipt__c where id = :l.Reciepts__r.Id];
                    if(r != null) {
                        r.On_Account_Money__c += l.Amount__c;
                        update r;
                    }
                    Receipt_Details__c rd = [Select Id from Receipt_Details__c where id = :l.Receipt_Details__r.Id];
                    if(rd != null)
                        delete rd;
                }
            }
            delete lList;
        }
    }
    
    public static Boolean isMVATPaid(Id oppId) {
        List<Customer_Pay_Plan_Header__c> cpphList = [Select Id, Registration_Reached__c, Registration_Intimation_Sent__c, Customer__r.Id,Amount__c,
                            Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, Outstanding_Amount__c, Percent_Paid__c,
                            Service_Tax_Demanded_Till_Date__c,Service_Tax_Recd_Till_Date__c,Outstanding_Service__c 
                            from Customer_Pay_Plan_Header__c where customer__c = :oppId
                            and Project_Unit__r.Unit_Status__c = 'Sold'
                            and Booking__c != null
                            and Global_Charges__r.Name in ('MVAT')];
        if(cpphList!= null && cpphList.size() > 0) {
            if(cpphList[0].Percent_Paid__c != null && cpphList[0].Percent_Paid__c == 100.00){
                return true;
            }
        }
        System.debug('Before returning false:');
        return false;
    }
    
    //used by S_DemandLetter class for generating the registration demand preview
    public static wrpDemand getDemandDetailsRegistration(Id oppId) {
        List < wrpCustomers > lstCustomers = new List < wrpCustomers > ();
      List < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [select id, Due_Date__c, Customer_Pay_Plan_Header__r.Customer__r.Name, 
                                                                    Installment__c, Customer_Pay_Plan_Header__r.Project_Unit__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Project_Unit__r.TowerName__r.Name,
                                                                    Project__r.Name,Installment_Number__c,Inst_No__c, 
                                                                    Project__r.Id,
                                                                    Customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                                    Customer_Pay_Plan_Header__r.Customer__c, 
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Email__c, Is_To_be__c,
                                                                    Project__r.Days_to_Send_Demand__c,
                                                                    Project_Construction_Stages__c, Charge_Amount_Advance_Recd__c,
                                                                    Service_Tax_Amount_Advance_Recd__c,
                                                                    Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Name__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Primary_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Other_Applicants_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact_Email__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Future_Correspondence_Contact__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Name,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.Id,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Owner.email,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Booking_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c,Days_Months_Value__c,Is_to_be_Paid__c,
                                                                    Revised_Invoice_Date__c,
                                                                    Reason_for_deferment__c,
                                                                    Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c
                                                                    from Standard_Customer_Pay_Plan_Detail__c
                                                                    where Customer_Pay_Plan_Header__r.Customer__c = :oppId
                                                                    and Customer_Pay_Plan_Header__r.Customer__r.status__c = 'Active'
                                                                    and Customer_Pay_Plan_Header__r.Effect_To_Date__c = null
                                                                    and Customer_Pay_Plan_Header__r.Project_Unit__r.Unit_Status__c = 'Sold'
                                                                    and Is_to_be_Paid__c = 'Registration'];
                                                                    //and Customer_Pay_Plan_Header__r.Global_Charges__r.Name in ('Stamp Duty', 'Registration Charges', 'Legal Charges')];
                                                                            
        lstCustomers = CreateCustomerWrapper(lstSCPPD);
        System.debug('create customer size::'+lstCustomers.size());
        wrpDemand wd = new wrpDemand();
        if(lstCustomers != null && lstCustomers.size() ==1) {
            wd.OpportunityId = lstCustomers[0].OpportunityId;
            wd.InvoiceDate = lstCustomers[0].InvoiceDate;
            wd.InvoiceDueDate = lstCustomers[0].InvoiceDueDate;
            //wd.InvoiceNumber = lstCustomers[0].InvoiceNumber;
            wd.projectId = lstCustomers[0].projectId;
            wd.projectUnit = lstCustomers[0].projectUnit;
            wd.mileStoneName = 'Registration';
        }
        return wd;
    }
    
    public static Map<String,Decimal> getChargesForRegistration(Id oppId){
        List<Customer_Pay_Plan_Header__c> cpphList = [Select Id, Registration_Reached__c, Registration_Intimation_Sent__c, Customer__r.Id,Amount__c,
                            Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, Outstanding_Amount__c,Global_Charges__r.Name,
                            Service_Tax_Demanded_Till_Date__c,Service_Tax_Recd_Till_Date__c,Outstanding_Service__c , Project__r.Id, Project__r.S_Ready_Reckoner_Rate__c
                            from Customer_Pay_Plan_Header__c where customer__c = :oppId
                            and Project_Unit__r.Unit_Status__c = 'Sold'
                            and Booking__c != null
                            and Global_Charges__r.Name in ('Basic','Stamp Duty', 'Legal Charges', 'Registration Charges')]; ///'MVAT',
        Map<String, Decimal> chargeAmountMap = new Map<String, Decimal>();
                       
        if(cpphList != null && cpphList.size() != 0) {
            
            Map<String,List<Tax_Breakup__c>> projTaxRateMap = InventoryCostServices.getChildTaxRateForCharges(cpphList[0].Project__R.Id);
            Decimal LegalTax = 0;
            Decimal taxValue = 0;
            for(Customer_Pay_Plan_Header__c cpph : cpphList) {
                if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Basic')) {
                    chargeAmountMap.put('Basic TOTAL',cpph.Amount__c);
                } else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('MVAT')) {
                    chargeAmountMap.put('MVAT',cpph.Amount__c);
                } else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Stamp Duty')) {
                    chargeAmountMap.put('Stamp Duty',cpph.Amount__c);
                } else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Legal Charges') ) {
                    if (cpph.Amount_Demanded_Till_Date__c != null &&  cpph.Amount_Demanded_Till_Date__c!= 0)  {
                        // if registration process has hapened once and then stopped, then check if legal has been paid.
                        chargeAmountMap.put('Legal Charges',cpph.Outstanding_Amount__c);
                        chargeAmountMap.put('Legal Charges TAX',cpph.Outstanding_Service__c);
                    } else {
                        if(projTaxRateMap.containsKey('Legal Charges') && cpph.Amount__c != null) {  
                            for(Tax_Breakup__c tb : projTaxRateMap.get('Legal Charges')) {
                                taxValue = ((tb.Taxable_Percentage__c * cpph.Amount__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                                LegalTax += taxValue;
                            }
                        }
                        chargeAmountMap.put('Legal Charges',cpph.Amount__c);
                        chargeAmountMap.put('Legal Charges TAX',LegalTax);
                    }
                } else if(cpph.Global_Charges__r.Name.equalsIgnoreCase('Registration Charges')) {
                    chargeAmountMap.put('Registration Charges',cpph.Amount__c);
                }
            }
        }
        chargeAmountMap.put('Ready Reckoner', cpphList[0].Project__r.S_Ready_Reckoner_Rate__c);
        return chargeAmountMap;
    }
    // returns the time from the datetime field in the user's locale
    // if the input was 17/1/2016 12:30 AM, returns 12:30 AM as a string
    public static String  formatTime(DateTime input) {
      String dt = input.format();
    Integer s = dt.indexOf(' ');
    return dt.substring(s+1);
    }
    
    public class wrpCustomersNew {
        // we have the provision for grouping of demands, hence the customer wrapper can contain more than
        // one scppd. To accommodate that scppdBundle map has been introduce.
        // the below scppd is used for capturing the deferrment details from UI and then we use the bundle map to update all affected scppds
        public Standard_Customer_Pay_Plan_Detail__c scppd {
            get;
            set;
        }
        public string Name {
            get;
            set;
        }
        public string EmailID {
            get;
            set;
        }
        public string OthersEmailID {
            get;
            set;
        }
        public string FutureCorresEmailID {
            get;
            set;
        }
        public decimal InstallAmt {
            get;
            set;
        }
        
       public String strInstallAmt {
            get;
            set;
        }
        
        public string ProjectUnit {
            get;
            set;
        }
        public string OpportunityId {
            get;
            set;
        }
        
        public Boolean Selected {
            get;
            set;
        }
        
        public String towerName {
            get;
            set;
        }
        public String projectName {
            get;
            set;
        }
        public Id projectId {
            get;
            set;
        }
        public string InvoiceNumber {
            get;
            set;
        }
        public Date InvoiceDate {
            get;
            set;
        }
        public Date InvoiceDueDate {
            get;
            set;
        }
        public Date DemandDueDate {
            get;
            set;
        }
        public String RM {
            get;
            set;
        }
        public String RMID {
            get;
            set;
        }
        public String RMEmail {
            get;
            set;
        }
        public boolean physicalDemand {
            get;
            set;
        }
        public String style {
            get;
            set;
        }
        public String style1 {
            get;
            set;
        }
       
        public Map<Id, Standard_Customer_Pay_Plan_Detail__c> scppdBundleMap {
            get;
            set;
        }
        public String stagename {
            get;
            set;
        }
        // this is required for identifying the record while grouping again in createDINew
        // for group by customer its is the oppId, for groupby milestone its the oppId+milestonename , for no grouping its the oppId + scppid
        public String uniqueKey {
            get;
            set;
        }
        public wrpCustomersNew() {
            Name = '';
            ProjectUnit = '';
            OpportunityId = '';
            InstallAmt = 0;
            Selected = false;
            projectName = null;
            towerName = null;
            InvoiceNumber = '';
            InvoiceDate = null;
            InvoiceDueDate = null;
            demandDueDate = null;
            projectId = null;
            othersEmailId = null;
            FutureCorresEmailID = null;
            scppdBundleMap = new Map<Id,Standard_Customer_Pay_Plan_Detail__c>();
            scppd = new Standard_Customer_Pay_Plan_Detail__c();
            RM = '';
            RMID='';
            RMEmail = '';
            physicalDemand = false;
            strInstallAmt = '';
            style = '';
            style1 = '';
        }
    }
    
    
    public class wrpCustomers {
        public Standard_Customer_Pay_Plan_Detail__c scppd {
            get;
            set;
        }
        public string Name {
            get;
            set;
        }
        public string EmailID {
            get;
            set;
        }
        public string OthersEmailID {
            get;
            set;
        }
        public string FutureCorresEmailID {
            get;
            set;
        }
        public decimal InstallAmt {
            get;
            set;
        }
        
       public String strInstallAmt {
            get;
            set;
        }
        
        public string ProjectUnit {
            get;
            set;
        }
        public string OpportunityId {
            get;
            set;
        }
        public List<Id> SCPPDId {
            get;
            set;
        }
        public string stageID {
            get;
            set;
        }
        public Boolean Selected {
            get;
            set;
        }
        public String stagename {
            get;
            set;
        }
        public String towerName {
            get;
            set;
        }
        public String projectName {
            get;
            set;
        }
        public Id projectId {
            get;
            set;
        }
        public string InvoiceNumber {
            get;
            set;
        }
        public Date InvoiceDate {
            get;
            set;
        }
        public Date InvoiceDueDate {
            get;
            set;
        }
        public Date DemandDueDate {
            get;
            set;
        }
        public String RM {
            get;
            set;
        }
        public String RMID {
            get;
            set;
        }
        public String RMEmail {
            get;
            set;
        }
        public boolean physicalDemand {
            get;
            set;
        }
        public String style {
            get;
            set;
        }
        public String style1 {
            get;
            set;
        }
        public wrpCustomers() {
            Name = '';
            ProjectUnit = '';
            OpportunityId = '';
            SCPPDId = new List<Id>();
            stageID = '';
            InstallAmt = 0;
            Selected = false;
            stageName = '';
            projectName = null;
            towerName = null;
            InvoiceNumber = '';
            InvoiceDate = null;
            InvoiceDueDate = null;
            demandDueDate = null;
            projectId = null;
            othersEmailId = null;
            FutureCorresEmailID = null;
            scppd = new Standard_Customer_Pay_Plan_Detail__c();
            RM = '';
            RMID='';
            RMEmail = '';
            physicalDemand = false;
            strInstallAmt = '';
            style = '';
            style1 = '';
        }
    }
    
    public class wrpCustomersCan {

        public string Name {
            get;
            set;
        }
        public string EmailID {
            get;
            set;
        }
        public string OthersEmailID {
            get;
            set;
        }
        public string FutureCorresEmailID {
            get;
            set;
        }
        public Boolean Selected {
            get;
            set;
        }
        public Cancellation_Intimation__c intimationRec {
            get;
            set;
        }
        public wrpCustomersCan() {
            Name = '';
            EmailID = null;
            Selected = false;
            othersEmailId = null;
            FutureCorresEmailID = null;
            intimationRec = new Cancellation_intimation__c();
        }
    }
    
   
}