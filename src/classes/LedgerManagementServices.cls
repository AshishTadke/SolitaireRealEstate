public class LedgerManagementServices {
   /*--------------------------------------------------------------  
        Parameters - Receipt Details
       Purpose - creates credit ledgers for the payment recd
    ----------------------------------------------------------------*/ 
    public static void createCreditLedgers(List<Id> receiptDetailIds){
        List<Receipt_Details__c> rdList = [Select Id, Name, receipts__r.Opportunity__c, receipts__r.Project_Unit__c, receipts__r.Cheque_DD_Date__c, 
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__c,
                                            Receipts__r.Booking__c, Amount__c , For_Service_Tax__c, Standard_Customer_Pay_Plan_Detail__c,Demand_Invoice__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Id, Receipts__c, Receipts__r.Id,
                                            Is_Interest_Settlement_ST__c, Is_interest_settlement__c, is_cheque_dishonour__c, createdDate
                                              from Receipt_Details__c where Id in :receiptDetailIds];
        
        Global_Charges__c objGblchrgBasicServiceTax =[select id from Global_Charges__c where Charge_Type__c ='Tax' and Description__c='SERVICE TAX' limit 1];
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        List<Id>ledgerIdList = new List<Id>();
        for(Receipt_Details__c r : rdList) {
            Ledger__c objLedger;
            objLedger = new Ledger__c();
            objLedger.Opportunity__c= r.receipts__r.Opportunity__c;
            if(r.Standard_Customer_Pay_Plan_Detail__c != null)   {
                objLedger.Standard_Customer_Pay_Plan_Detail__c= r.Standard_Customer_Pay_Plan_Detail__c;
                if(r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                    objLedger.Customer_Pay_Plan_Header__c = r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                }
            }
            if(r.For_Service_Tax__c) {
                objLedger.Global_Charges__c = objGblchrgBasicServiceTax.Id ;
                if(r.Standard_Customer_Pay_Plan_Detail__c != null && r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Tax Received for: ' + r.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
            } else {
                if(r.Standard_Customer_Pay_Plan_Detail__c != null && r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                    objLedger.Global_Charges__c = r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c ;
                objLedger.Remarks__c = 'Installment received for : ' + r.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
            }
            
            objLedger.Project_Unit__c  = r.receipts__r.Project_Unit__c;
            objLedger.Debit_Credit__c='Credit';
            objLedger.Amount__c = r.Amount__c;
            objLedger.Transaction_Date__c= system.today() ;
            if(r.Receipts__r.Booking__c != null)
                objLedger.Booking__c = r.Receipts__r.Booking__c;
            objLedger.Is_ledger_created_through_trigger__c = true;
            objLedger.Reciepts__c = r.Receipts__c;
            objLedger.Receipt_Details__c = r.Id;
            objLedger.Demand_Invoice__c = r.Demand_Invoice__c;
            objLedger.Standard_Customer_Pay_Plan_Detail__c = r.Standard_Customer_Pay_Plan_Detail__c;
            lstLedgerToUpsert.add(objLedger);
        }
        
        if(lstLedgerToUpsert.size() > 0) {
            Database.UpsertResult[] srList1 = Database.upsert(lstLedgerToUpsert);
                for(Database.UpsertResult sr : srList1) {
                    if(sr.isSuccess()) {
                        ledgerIdList.add(sr.getId());
                    }
            }
        }
        List<Ledger__c> ledgerList = new List<Ledger__c>();
        if(ledgerIdList.size() > 0) {
            ledgerList = [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, Global_Charges__c,Global_Charges__r.Name,
                        Standard_Customer_Pay_Plan_Detail__c,Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Paid__c,
                        Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c, Customer_Pay_Plan_Header__c, receipt_details__r.Is_advanced_demand__C 
                        from Ledger__c where Id in :ledgerIdList];
        }
        
        Map<Id, List<Ledger__c>> scppdLedgerMap = new Map<Id, List<Ledger__c>>();
        Map<Id, List<Ledger__c>> cpphLedgerMap = new Map<Id, List<Ledger__c>>();
        
        for(Ledger__c l : ledgerList) {
            if(scppdLedgerMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Id)) {
                scppdLedgerMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Id).add(l);
            } else {
                List<Ledger__c> ll = new List<Ledger__c>();
                ll.add(l);
                scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id,ll);
            }
            if(cpphLedgerMap.containsKey(l.Customer_Pay_Plan_Header__r.Id)) {
                cpphLedgerMap.get(l.Customer_Pay_Plan_Header__r.Id).add(l);
            } else {
                List<Ledger__c> ll = new List<Ledger__c>();
                ll.add(l);
                cpphLedgerMap.put(l.Customer_Pay_Plan_Header__r.Id,ll);
            }
        }
        System.debug('SCPPDMAP:' + scppdLedgerMap);
        System.debug('CPPHMAP:' + cpphLedgerMap);
        Decimal amtPaid = 0;
        Decimal amtSTPaid = 0;
        Decimal amtAdvPaid = 0;
        Decimal amtSTAdvPaid = 0;
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id, Name , Charge_Amount_Paid__c,Service_Tax_Amount_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Amount_Recd_Till_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Service_Tax_Recd_Till_Date__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    PTP_Amount__c,PTP_Date__c,Is_PTP_Partly_Paid__c from 
                                                                    Standard_Customer_Pay_Plan_Detail__c where Id in :scppdLedgerMap.keyset()];
                                                                    
        List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
                                                                    Service_Tax_Recd_Till_Date__c from 
                                                                    Customer_Pay_Plan_Header__C where Id in :cpphLedgerMap.keyset()];                                                       
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList){
            if(s.Charge_Amount_Paid__c != null) {
                amtPaid = s.Charge_Amount_Paid__c;
            }
            if(s.Service_Tax_Amount_Paid__c != null) {
                amtSTPaid = s.Service_Tax_Amount_Paid__c;
            }
            if(s.Charge_Amount_Advance_Recd__c != null) {
                amtAdvPaid = s.Charge_Amount_Advance_Recd__c;
            }
            if(s.Service_Tax_Amount_Advance_Recd__c != null) {
                amtSTAdvPaid = s.Service_Tax_Amount_Advance_Recd__c;
            }
            decimal ledgerAmt = 0;
            for(Ledger__c l : scppdLedgerMap.get(s.Id)) {
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                    amtSTPaid += l.Amount__c;
                else if(!(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')))
                    amtPaid += l.Amount__c;
                    
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
                    amtSTAdvPaid += l.Amount__c;    
                else if(!l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
                    amtAdvPaid += l.Amount__c;
                
                ledgerAmt += l.Amount__c;
            }
            s.Charge_Amount_Paid__c = amtPaid;
            s.Service_Tax_Amount_Paid__c = amtSTPaid;
            s.Service_Tax_Amount_Advance_Recd__c = amtSTAdvpaid;
            s.Charge_Amount_Advance_Recd__c = amtAdvPaid;
            // PTP wipe out
            System.debug('PTP details:PTP AMT:' + S.PTP_Amount__c + ' amt paid:'  + ledgerAmt );
            if(s.PTP_Amount__c != null) {
                if(s.PTP_Amount__c > (ledgerAmt)){
                    System.debug('In part payment loop');
                    s.Is_PTP_Partly_Paid__c = true;
                    s.PTP_Amount__c = s.PTP_Amount__c - (ledgerAmt);
                } else {
                    s.Is_PTP_Partly_Paid__c = false;
                    s.PTP_Amount__c = 0;
                    s.PTP_Date__c = null;
                }
            }
            amtPaid = 0;
            amtSTPaid =0;
            amtAdvPaid = 0;
            amtSTAdvPaid =0;
            ledgerAmt = 0;          
        }   
        if(scppdList.size() > 0)
            update scppdList;
            
        for(Customer_Pay_Plan_Header__c c : cpphList){
            if(c.Amount_Recd_Till_Date__c != null) {
                amtPaid = c.Amount_Recd_Till_Date__c;
            }
            if(c.Service_Tax_Recd_Till_Date__c != null) {
                amtSTPaid = c.Service_Tax_Recd_Till_Date__c;
            }
            for(Ledger__c l : cpphLedgerMap.get(c.Id)) {
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                    amtSTPaid += l.Amount__c;
                else
                    amtPaid += l.Amount__c;
            }
            c.Amount_Recd_Till_Date__c = amtPaid;
            c.Service_Tax_Recd_Till_Date__c = amtSTPaid;
            amtPaid = 0;
            amtSTPaid =0;
        }   
                    
        if(cpphList.size() > 0)
        update cpphList;
        
        // if Efts are entered in the system later than the actual date of receiving them, then that much interest has to be deducted.
        // this happens when on the day the EFT is entered and is apportioned the same day.
        System.debug('Receipt date and id:' + rdList[0].receipts__r.Cheque_DD_Date__c + ':' + rdList[0].createdDate);
        
        if(rdList[0].receipts__r.Cheque_DD_Date__c < System.today() && rdList[0].createdDate == System.today()) {
            System.debug('Receipt date and id:' + rdList[0].receipts__r.Cheque_DD_Date__c + ':' + rdList[0].receipts__r.Id);
            InterestManagementServices.deductInterestForEFT(receiptDetailIds);
        }
        InterestManagementServices.newInterestDetails(rdList);
        
    } 
    
    /*--------------------------------------------------------------  
        Parameters - Receipt Details
       Purpose - creates credit ledgers for the interest payments recd
    ----------------------------------------------------------------*/ 
    public static void createCreditLedgersForInterest(List<Id> receiptDetailIds){
        List<Receipt_Details__c> rdList = [Select Id, Name, receipts__r.Opportunity__c, receipts__r.Project_Unit__c, 
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__c,
                                            Receipts__r.Booking__c, Amount__c , For_Service_Tax__c, Receipts__c,
                                            Is_interest_settlement_ST__c, Is_interest_settlement__c,
                                            Interest_flatcost_waived__c, Interest_servicetax_waived__c,
                                            Standard_Customer_Pay_Plan_Detail__c,Demand_Invoice__c, Charges__r.Name
                                            from Receipt_Details__c where Id in :receiptDetailIds];
        
        Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Interest Installment'];
        Global_Charges__c gST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax'];
        Global_Charges__c gw = [Select Id from Global_Charges__c where Name = 'Interest Installment Waived'];
        Global_Charges__c gwST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax Waived'];
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        List<Id>ledgerIdList = new List<Id>();
        for(Receipt_Details__c r : rdList) {
            Ledger__c objLedger;
            objLedger = new Ledger__c();
            objLedger.Opportunity__c= r.receipts__r.Opportunity__c;
            if(r.Standard_Customer_Pay_Plan_Detail__c != null)   {
                objLedger.Standard_Customer_Pay_Plan_Detail__c= r.Standard_Customer_Pay_Plan_Detail__c;
                if(r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                    objLedger.Customer_Pay_Plan_Header__c = r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                }
            }
            if(r.Is_interest_settlement_ST__c)
                objLedger.Global_Charges__c = gST.Id ;
            else if(r.Is_interest_settlement__c)
                objLedger.Global_Charges__c = g.Id ;
            if(r.Standard_Customer_Pay_Plan_Detail__c != null && r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                objLedger.Remarks__c = 'Interest Received for: ' + r.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
            
            objLedger.Project_Unit__c  = r.receipts__r.Project_Unit__c;
            objLedger.Debit_Credit__c='Credit';
            objLedger.Amount__c = r.Amount__c;
            objLedger.Transaction_Date__c= system.today() ;
            if(r.Receipts__r.Booking__c != null)
                objLedger.Booking__c = r.Receipts__r.Booking__c;
            objLedger.Is_ledger_created_through_trigger__c = true;
            objLedger.Reciepts__c = r.Receipts__c;
            objLedger.Receipt_Details__c = r.Id;
            objLedger.Standard_Customer_Pay_Plan_Detail__c = r.Standard_Customer_Pay_Plan_Detail__c;
            lstLedgerToUpsert.add(objLedger);
        }
        // ledgers for waivers
        for(Receipt_Details__c r : rdList) {
            if(r.Interest_flatcost_waived__c > 0) {
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= r.receipts__r.Opportunity__c;
                if(r.Standard_Customer_Pay_Plan_Detail__c != null)   {
                    objLedger.Standard_Customer_Pay_Plan_Detail__c= r.Standard_Customer_Pay_Plan_Detail__c;
                    if(r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                        objLedger.Customer_Pay_Plan_Header__c = r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                    }
                }
                objLedger.Global_Charges__c = gw.Id ;
                if(r.Standard_Customer_Pay_Plan_Detail__c != null && r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on flatcost waived for: ' + r.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                
                objLedger.Project_Unit__c  = r.receipts__r.Project_Unit__c;
                objLedger.Debit_Credit__c='Credit';
                objLedger.Amount__c = r.Interest_flatcost_waived__c;
                objLedger.Transaction_Date__c= system.today() ;
                if(r.Receipts__r.Booking__c != null)
                    objLedger.Booking__c = r.Receipts__r.Booking__c;
                objLedger.Is_ledger_created_through_trigger__c = true;
                objLedger.Reciepts__c = r.Receipts__c;
                objLedger.Receipt_Details__c = r.Id;
                objLedger.Standard_Customer_Pay_Plan_Detail__c = r.Standard_Customer_Pay_Plan_Detail__c;
                lstLedgerToUpsert.add(objLedger);
            }
            if(r.Interest_servicetax_waived__c > 0) {
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= r.receipts__r.Opportunity__c;
                if(r.Standard_Customer_Pay_Plan_Detail__c != null)   {
                    objLedger.Standard_Customer_Pay_Plan_Detail__c= r.Standard_Customer_Pay_Plan_Detail__c;
                    if(r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                        objLedger.Customer_Pay_Plan_Header__c = r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                    }
                }
                objLedger.Global_Charges__c = gwST.Id ;
                if(r.Standard_Customer_Pay_Plan_Detail__c != null && r.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on Tax waived for: ' + r.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                
                objLedger.Project_Unit__c  = r.receipts__r.Project_Unit__c;
                objLedger.Debit_Credit__c='Credit';
                objLedger.Amount__c = r.Interest_servicetax_waived__c;
                objLedger.Transaction_Date__c= system.today() ;
                if(r.Receipts__r.Booking__c != null)
                    objLedger.Booking__c = r.Receipts__r.Booking__c;
                objLedger.Is_ledger_created_through_trigger__c = true;
                objLedger.Reciepts__c = r.Receipts__c;
                objLedger.Receipt_Details__c = r.Id;
                objLedger.Standard_Customer_Pay_Plan_Detail__c = r.Standard_Customer_Pay_Plan_Detail__c;
                lstLedgerToUpsert.add(objLedger);
            }
        }
        
        if(lstLedgerToUpsert.size() > 0) {
            Database.UpsertResult[] srList1 = Database.upsert(lstLedgerToUpsert);
                for(Database.UpsertResult sr : srList1) {
                    if(sr.isSuccess()) {
                        ledgerIdList.add(sr.getId());
                    }
            }
        }
        List<Ledger__c> ledgerList = new List<Ledger__c>();
        if(ledgerIdList.size() > 0) {
            ledgerList = [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, Global_Charges__c,Global_Charges__r.Name,
                        Standard_Customer_Pay_Plan_Detail__c,Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Paid__c,
                        Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c, Customer_Pay_Plan_Header__c, receipt_details__r.Is_advanced_demand__C 
                        from Ledger__c where Id in :ledgerIdList];
        }
        
        Map<Id, List<Ledger__c>> scppdLedgerMap = new Map<Id, List<Ledger__c>>();
        Map<Id, List<Ledger__c>> cpphLedgerMap = new Map<Id, List<Ledger__c>>();
        
        for(Ledger__c l : ledgerList) {
            if(scppdLedgerMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Id)) {
                scppdLedgerMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Id).add(l);
            } else {
                List<Ledger__c> ll = new List<Ledger__c>();
                ll.add(l);
                scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id,ll);
            }
            if(cpphLedgerMap.containsKey(l.Customer_Pay_Plan_Header__r.Id)) {
                cpphLedgerMap.get(l.Customer_Pay_Plan_Header__r.Id).add(l);
            } else {
                List<Ledger__c> ll = new List<Ledger__c>();
                ll.add(l);
                cpphLedgerMap.put(l.Customer_Pay_Plan_Header__r.Id,ll);
            }
        }
        System.debug('SCPPDMAP:' + scppdLedgerMap);
        System.debug('CPPHMAP:' + cpphLedgerMap);
        Decimal amtPaid = 0;
        Decimal amtSTPaid = 0;
        Decimal amtWaived = 0;
        Decimal amtSTWaived = 0;
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id, Name , Charge_Amount_Paid__c,Service_Tax_Amount_Paid__c,
                                                                    Customer_Pay_Plan_Header__r.Amount_Recd_Till_Date__c,
                                                                    Customer_Pay_Plan_Header__r.Service_Tax_Recd_Till_Date__c,
                                                                    Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
                                                                    PTP_Amount__c,PTP_Date__c,Is_PTP_Partly_Paid__c,
                                                                    Int_Flatcost_Paid__c, Int_Flatcost_Pending__c, Int_Flatcost_Waived__c, 
                                                                    Int_ServiceTax_Paid__c, Int_ServiceTax_Pending__c, Int_ServiceTax_Waived__c
                                                                    from 
                                                                    Standard_Customer_Pay_Plan_Detail__c where Id in :scppdLedgerMap.keyset()];
                                                                    
        List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
                                                                    Service_Tax_Recd_Till_Date__c, 
                                                                    Int_flatcost_Paid_Till_Date__c, Int_flatcost_Waived_Till_Date__c,
                                                                    Int_servicetax_waived_till_date__c, Int_servicetax_paid_till_date__c
                                                                    from 
                                                                    Customer_Pay_Plan_Header__C where Id in :cpphLedgerMap.keyset()];                                                       
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList){
            if(s.Int_Flatcost_Paid__c != null) {
                amtPaid = s.Int_Flatcost_Paid__c;
            }
            if(s.Int_ServiceTax_Paid__c != null) {
                amtSTPaid = s.Int_ServiceTax_Paid__c;
            }
            if(s.Int_Flatcost_Waived__c != null) {
                amtWaived = s.Int_Flatcost_Waived__c;
            }
            if(s.Int_ServiceTax_Waived__c != null) {
                amtSTWaived = s.Int_ServiceTax_Waived__c;
            }
            decimal ledgerAmt = 0;
            for(Ledger__c l : scppdLedgerMap.get(s.Id)) {
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) {
                    amtSTPaid += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) {
                    amtPaid += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax Waived')) {
                    amtSTWaived += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment Waived')) {
                    amtWaived += l.Amount__c;
                }
            }
            s.Int_Flatcost_Paid__c = amtPaid;
            s.Int_ServiceTax_Paid__c = amtSTPaid;
            s.Int_ServiceTax_Waived__c = amtSTWaived;
            s.Int_Flatcost_Waived__c = amtWaived;
          
            amtPaid = 0;
            amtSTPaid =0;
            amtWaived = 0;
            amtSTWaived =0;
        }   
        if(scppdList.size() > 0)
            update scppdList;
            
        for(Customer_Pay_Plan_Header__c c : cpphList){
            if(c.Int_flatcost_Paid_Till_Date__c != null) {
                amtPaid = c.Int_flatcost_Paid_Till_Date__c;
            }
            if(c.Int_servicetax_paid_till_date__c != null) {
                amtSTPaid = c.Int_servicetax_paid_till_date__c;
            }
            if(c.Int_flatcost_Waived_Till_Date__c != null) {
                amtWaived = c.Int_flatcost_Waived_Till_Date__c;
            }
            if(c.Int_servicetax_waived_till_date__c != null) {
                amtSTWaived = c.Int_servicetax_waived_till_date__c;
            }
            for(Ledger__c l : cpphLedgerMap.get(c.Id)) {
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) {
                    amtSTPaid += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) {
                    amtPaid += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax Waived')) {
                    amtSTWaived += l.Amount__c;
                } else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment Waived')) {
                    amtWaived += l.Amount__c;
                }
            }
            c.Int_flatcost_Paid_Till_Date__c = amtPaid;
            c.Int_servicetax_paid_till_date__c = amtSTPaid;
            c.Int_flatcost_Waived_Till_Date__c = amtWaived;
            c.Int_servicetax_waived_till_date__c = amtSTWaived;
            
            amtPaid = 0;
            amtSTPaid =0;
            amtWaived = 0;
            amtSTWaived = 0;
        }   
                    
        if(cpphList.size() > 0)
        update cpphList;
    } 
     /*--------------------------------------------------------------- 
        Parameters - DemAND Details
       Purpose - creates debit ledgers for advance payments recd
       changing the approach to create ledgers with the demand data
    ----------------------------------------------------------------*/ 
    public static void createDebitLedgersForDemands(List<Id> DemandIds){
        List<Demand_Invoice__c> diList = [Select Id, Name, Customer__c, Customer__r.Project_Unit__c, 
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__c,
                                            Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__c, 
                                            Current_Demand_Installment__c , Current_Demand_Service_Tax__c 
                                            from Demand_Invoice__c where Id in :DemandIds];
        
        Global_Charges__c objGblchrgBasicServiceTax =[select id from Global_Charges__c where Charge_Type__c ='Tax' and Description__c='SERVICE TAX' limit 1];
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        List<Id>ledgerIdList = new List<Id>();
        for(Demand_Invoice__c d : diList) {
            Ledger__c objLedger;
            objLedger = new Ledger__c();
            objLedger.Opportunity__c= d.Customer__c;
            if(d.Standard_Customer_Pay_Plan_Detail__c != null)   {
                objLedger.Standard_Customer_Pay_Plan_Detail__c= d.Standard_Customer_Pay_Plan_Detail__c;
                if(d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                    objLedger.Customer_Pay_Plan_Header__c = d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                }
            }
            objLedger.Project_Unit__c  = d.Customer__r.Project_Unit__c;
            objLedger.Debit_Credit__c='Debit';
            objLedger.Amount__c = d.Current_Demand_Installment__c;
            objLedger.Transaction_Date__c= system.today() ;
            if(d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__c != null)
                objLedger.Booking__c = d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__c;
            objLedger.Is_ledger_created_through_trigger__c = true;
            objLedger.Demand_Invoice__c = d.Id;
            objLedger.Standard_Customer_Pay_Plan_Detail__c = d.Standard_Customer_Pay_Plan_Detail__c;
            if(d.Standard_Customer_Pay_Plan_Detail__c != null && d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null)
                    objLedger.Global_Charges__c = d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c ;
            objLedger.Remarks__c = 'Installment Debited for : ' + d.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
            lstLedgerToUpsert.add(objLedger);
             if(d.Current_Demand_Service_Tax__c != null && d.Current_Demand_Service_Tax__c > 0) {
                Ledger__c objLedgerST;
                objLedgerST = new Ledger__c();
                objLedgerST.Opportunity__c= d.Customer__c;
                if(d.Standard_Customer_Pay_Plan_Detail__c != null)   {
                    objLedgerST.Standard_Customer_Pay_Plan_Detail__c= d.Standard_Customer_Pay_Plan_Detail__c;
                    if(d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c != null) {
                        objLedgerST.Customer_Pay_Plan_Header__c = d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                    }
                }
                objLedgerST.Project_Unit__c  = d.Customer__r.Project_Unit__c;
                objLedgerST.Debit_Credit__c='Debit';
                objLedgerST.Amount__c = d.Current_Demand_Service_Tax__c;
                objLedgerST.Transaction_Date__c= system.today() ;
                if(d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__c != null)
                    objLedgerST.Booking__c = d.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__c;
                objLedgerST.Is_ledger_created_through_trigger__c = true;
                objLedgerST.Demand_Invoice__c = d.Id;
                objLedgerST.Standard_Customer_Pay_Plan_Detail__c = d.Standard_Customer_Pay_Plan_Detail__c;
                objLedgerST.Global_Charges__c = objGblchrgBasicServiceTax.Id ;
                objLedgerST.Remarks__c = 'Tax Debited for: ' + d.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                lstLedgerToUpsert.add(objLedgerST);
             }
        }
        if(lstLedgerToUpsert.size() > 0) {
            Database.UpsertResult[] srList1 = Database.upsert(lstLedgerToUpsert);
                for(Database.UpsertResult sr : srList1) {
                    if(sr.isSuccess()) {
                        ledgerIdList.add(sr.getId());
                    }
            }
        }
    }
    
    /*--------------------------------------------------------------- 
        Parameters - Demand Details
       Purpose - create debit ledgers for the payment demanded.
       Changing the approach to use the demand details "current demand" 
       records rather than the demand record for creating ledgers.
    ----------------------------------------------------------------*/ 
    public static void createDebitLedgersForDemandsNew(List<Id> DemandIds){
        List<Demand_Invoice__c> diList = [Select Id, Name, Customer__c, Customer__r.Project_Unit__c, 
                                            Project__c
                                            from Demand_Invoice__c 
                                            where Id in :DemandIds and demand_generated__c = true];
                                            
         Map<String,List<Tax_Breakup__c>>  taxMap = InventoryCostServices.getChildTaxRateForCharges((diList[0].Project__c));
         System.debug('Debit Ledger: tax map:' + taxMap);                                    
        // for all current demnad detail records, create debit ledgers.
        // the tricky part here is if a combined demand is generated for a customer say Milestone 1- Basic 100, Milestone 2 - Basic 200
        // then we make a single entry in the demand detail table for 300 Rs and store the milestone and amt details in the scppd_<number> fields
        // debit ledgers have to be generated one per scppd_<number> fields                                   
        List<Demand_Detail__c> ddList = [Select Id, Name, Type__c, Total_Amount__c, Charge_Name__c, Installment_Amount__c, Total_Tax__c, 
                                                                                Taxable_Amount_1__c, Tax_Amount_1__c, Tax_Breakup_1__c,
                                                                                Taxable_Amount_2__c, Tax_Amount_2__c, Tax_Breakup_2__c,
                                                                                scppd_1__c, scppd_2__c, scppd_3__c, scppd_4__c,
                                                                                scppd_amount_1__c, scppd_amount_2__c,scppd_amount_3__c, scppd_amount_4__c,
                                                                                demand_invoice__r.Customer__c, demand_invoice__r.Customer__r.Project_Unit__c
                                                                                from Demand_Detail__c 
                                                                                where 
                                                                                Type__c = 'Current'
                                                                                and Demand_Invoice__c in :diList
                                                                                and Demand_Invoice__r.demand_generated__c = true
                                                                                ];
        
        Global_Charges__c objGblchrgBasicServiceTax =[select id from Global_Charges__c where Charge_Type__c ='Tax' and Description__c='SERVICE TAX' limit 1];
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        List<Id>ledgerIdList = new List<Id>();
        Set<Id> scppdSet = new Set<Id>();
        Map<Integer, List<Demand_Detail__c>> ddNumberMap = new Map<Integer, List<Demand_Detail__c>>();
        Map<Id, Standard_Customer_Pay_Plan_Detail__c> scppdDetailsMap = new Map<Id, Standard_Customer_Pay_Plan_Detail__c>();
        Decimal taxValue = 0;
        Decimal totalTax = 0;
        for(Demand_Detail__c d : ddList) {
            if(d.scppd_1__c != null) {
                if(ddNumberMap.containskey(1)) 
                    ddNumberMap.get(1).add(d);
                else {
                    List<Demand_Detail__c> tempList = new List<Demand_detail__c>();
                    tempList.add(d);
                    ddNumberMap.put(1, tempList);
                }
                scppdSet.add(d.scppd_1__c);
            }
            if(d.scppd_2__c != null) {
                if(ddNumberMap.containskey(2)) 
                    ddNumberMap.get(2).add(d);
                else {
                    List<Demand_Detail__c> tempList = new List<Demand_detail__c>();
                    tempList.add(d);
                    ddNumberMap.put(2, tempList);
                }
                scppdSet.add(d.scppd_2__c);
            }
            if(d.scppd_3__c != null) {
                if(ddNumberMap.containskey(3)) 
                    ddNumberMap.get(3).add(d);
                else {
                    List<Demand_Detail__c> tempList = new List<Demand_detail__c>();
                    tempList.add(d);
                    ddNumberMap.put(3, tempList);
                }
                scppdSet.add(d.scppd_3__c);
            }
            if(d.scppd_4__c != null) {
                if(ddNumberMap.containskey(4)) 
                    ddNumberMap.get(4).add(d);
                else {
                    List<Demand_Detail__c> tempList = new List<Demand_detail__c>();
                    tempList.add(d);
                    ddNumberMap.put(4, tempList);
                }
                scppdSet.add(d.scppd_4__c);
            }
        }
        if(scppdSet.size() > 0 ){
            scppdDetailsMap = new Map<Id,Standard_Customer_Pay_Plan_Detail__c>([Select Id, Name, Customer_Pay_Plan_Header__c,
                                            Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                            Customer_Pay_Plan_Header__r.Global_Charges__c,
                                            Standard_Pay_Plan_Header__r.Charge_Code__c,
                                            Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c,
                                            Add_Token_GST__c,
                                            Is_To_be__c,
                                            Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c,
                                            Customer_Pay_Plan_Header__r.Booking__c from
                                            Standard_Customer_Pay_Plan_Detail__c where Id in :scppdSet]);
        }
        if(ddNumberMap.size() > 0) {
            System.debug('ddNumberMap:' + ddNumberMap);
            for(Integer i : ddNumberMap.keyset()) {
                for(demand_detail__c d: ddNumberMap.get(i)) {
                    Ledger__c objLedger;
                    objLedger = new Ledger__c();
                    objLedger.Opportunity__c= d.demand_invoice__r.Customer__c;
                    if(i ==1) {
                        if(d.scppd_1__c != null) {
                            objLedger.Standard_Customer_Pay_Plan_Detail__c= d.scppd_1__c;
                            objLedger.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__c;
                            objLedger.Booking__c = scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__r.Booking__c;
                            objLedger.Global_Charges__c = scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__r.Global_Charges__c ;
                            objLedger.Remarks__c = 'Instalment Debited for : ' + scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                            objLedger.Amount__c = d.scppd_Amount_1__c;
                        }
                    }
                    if(i ==2) {
                        if(d.scppd_2__c != null)   {
                            objLedger.Standard_Customer_Pay_Plan_Detail__c= d.scppd_2__c;
                            objLedger.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__c;
                            objLedger.Booking__c = scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__r.Booking__c;
                            objLedger.Global_Charges__c = scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__r.Global_Charges__c ;
                            objLedger.Remarks__c = 'Instalment Debited for : ' + scppdDetailsMap.get(d.scppd_2__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                            objLedger.Amount__c = d.scppd_Amount_2__c;
                        }
                    }
                    if(i==3) {
                        // if i is 3,then the data is in scppd_3__c fields
                        if(d.scppd_3__c != null)   {
                            objLedger.Standard_Customer_Pay_Plan_Detail__c= d.scppd_3__c;
                            objLedger.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__c;
                            objLedger.Booking__c = scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__r.Booking__c;
                            objLedger.Global_Charges__c = scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__r.Global_Charges__c ;
                            objLedger.Remarks__c = 'Instalment Debited for : ' + scppdDetailsMap.get(d.scppd_3__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                            objLedger.Amount__c = d.scppd_Amount_3__c;
                        }
                    }
                    if(i==4){
                        // if i is 4,then the data is in scppd_4__c fields
                        if(d.scppd_4__c != null)   {
                            objLedger.Standard_Customer_Pay_Plan_Detail__c= d.scppd_4__c;
                            objLedger.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__c;
                            objLedger.Booking__c = scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__r.Booking__c;
                            objLedger.Global_Charges__c = scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__r.Global_Charges__c ;
                            objLedger.Remarks__c = 'Instalment Debited for : ' + scppdDetailsMap.get(d.scppd_4__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                            objLedger.Amount__c = d.scppd_Amount_4__c;
                        }
                    }
                    objLedger.Project_Unit__c  = d.Demand_Invoice__r.Customer__r.Project_Unit__c;
                    objLedger.Debit_Credit__c='Debit';
                    objLedger.Transaction_Date__c= system.today() ;
                    objLedger.Is_ledger_created_through_trigger__c = true;
                    objLedger.Demand_Invoice__c = d.Demand_Invoice__r.Id;
                    objLedger.Demand_Detail__c = d.Id;
                    lstLedgerToUpsert.add(objLedger);
                    
                    // checking for service tax
                    if(d.Total_Tax__c != null && d.Total_Tax__c > 0) {
                        Ledger__c objLedgerST;
                        objLedgerST = new Ledger__c();
                        objLedgerST.Opportunity__c= d.Demand_Invoice__r.Customer__c;
                        totalTax = 0;
                        Decimal taxableAmt = 0;
                        if(i ==1) {
                                
                            if(d.scppd_1__c != null)   {
                                    // if i is 1,then the data is in scppd_1__c fields
                                    if(scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && scppdDetailsMap.get(d.scppd_1__c).Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                        // token amount milestone and no gst on token plan
                                        taxableAmt = 0;
                                    } else if(scppdDetailsMap.get(d.scppd_1__c).Add_Token_GST__c) {
                                        taxableAmt = d.scppd_amount_1__c + scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                    } else {
                                        taxableAmt = d.scppd_amount_1__c;
                                    }
                                objLedgerST.Standard_Customer_Pay_Plan_Detail__c= d.scppd_1__c;
                                objLedgerST.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__c;
                                objLedgerST.Booking__c = scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__r.Booking__c;
                                objLedgerST.Remarks__c = 'Tax debited for : ' + scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                                System.debug('In i=1 service tax:' + scppdDetailsMap.get(d.scppd_1__c).Customer_Pay_Plan_Header__r.Global_Charges__c);
                                if(taxMap.containsKey(scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    System.debug('In i=1 service tax:' + scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name);
                                    for(Tax_Breakup__c tb : taxMap.get(scppdDetailsMap.get(d.scppd_1__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                        System.debug('In i=1 tax breakup:' + tb);
                                        taxValue = 0;
                                        taxValue = ((tb.Taxable_Percentage__c * taxableAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                                        totalTax += taxValue;
                                    }
                                }
                                objLedgerST.Amount__c = totalTax;
                            }
                        }
                        if(i ==2) {
                            if(d.scppd_2__c != null)   {
                                    // if i is 2,then the data is in scppd_2__c fields
                                    if(scppdDetailsMap.get(d.scppd_2__c).Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && scppdDetailsMap.get(d.scppd_2__c).Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                        // token amount milestone and no gst on token plan
                                        taxableAmt = 0;
                                    } else if(scppdDetailsMap.get(d.scppd_2__c).Add_Token_GST__c) {
                                        taxableAmt = d.scppd_amount_2__c + scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                    } else {
                                        taxableAmt = d.scppd_amount_2__c;
                                    }
                                objLedgerST.Standard_Customer_Pay_Plan_Detail__c= d.scppd_2__c;
                                objLedgerST.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__c;
                                objLedgerST.Booking__c = scppdDetailsMap.get(d.scppd_2__c).Customer_Pay_Plan_Header__r.Booking__c;
                                objLedgerST.Remarks__c = 'Tax debited for : ' + scppdDetailsMap.get(d.scppd_2__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                                if(taxMap.containsKey(scppdDetailsMap.get(d.scppd_2__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    for(Tax_Breakup__c tb : taxMap.get(scppdDetailsMap.get(d.scppd_2__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                        taxValue = 0;
                                        taxValue = ((tb.Taxable_Percentage__c * taxableAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                                        totalTax += taxValue;
                                    }
                                }
                                objLedgerST.Amount__c = totalTax;
                            }
                        }
                        if(i==3) {
                            // if i is 3,then the data is in scppd_3__c fields
                            if(d.scppd_3__c != null)   {
                                    if(scppdDetailsMap.get(d.scppd_3__c).Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && scppdDetailsMap.get(d.scppd_3__c).Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                        // token amount milestone and no gst on token plan
                                        taxableAmt = 0;
                                    } else if(scppdDetailsMap.get(d.scppd_3__c).Add_Token_GST__c) {
                                        taxableAmt = d.scppd_amount_3__c + scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                    } else {
                                        taxableAmt = d.scppd_amount_3__c;
                                    }
                                objLedgerST.Standard_Customer_Pay_Plan_Detail__c= d.scppd_3__c;
                                objLedgerST.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__c;
                                objLedgerST.Booking__c = scppdDetailsMap.get(d.scppd_3__c).Customer_Pay_Plan_Header__r.Booking__c;
                                objLedgerST.Remarks__c = 'Tax debited for : ' + scppdDetailsMap.get(d.scppd_3__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                                if(taxMap.containsKey(scppdDetailsMap.get(d.scppd_3__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    for(Tax_Breakup__c tb : taxMap.get(scppdDetailsMap.get(d.scppd_3__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                        taxValue = 0;
                                        taxValue = ((tb.Taxable_Percentage__c * taxableAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                                        totalTax += taxValue;
                                    }
                                }
                                objLedgerST.Amount__c = totalTax;
                            }
                        }
                        if(i==4){
                            // if i is 4,then the data is in scppd_4__c fields
                            if(d.scppd_4__c != null)   {
                                    if(scppdDetailsMap.get(d.scppd_4__c).Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c && scppdDetailsMap.get(d.scppd_4__c).Is_to_be__c.equalsIgnorecase('0Day(s) from date of booking.')) {
                                        // token amount milestone and no gst on token plan
                                        taxableAmt = 0;
                                    } else if(scppdDetailsMap.get(d.scppd_4__c).Add_Token_GST__c) {
                                        taxableAmt = d.scppd_amount_4__c + scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__r.Quotation__r.Token_Amount__c;
                                    } else {
                                        taxableAmt = d.scppd_amount_4__c;
                                    }
                                objLedgerST.Standard_Customer_Pay_Plan_Detail__c= d.scppd_4__c;
                                objLedgerST.Customer_Pay_Plan_Header__c = scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__c;
                                objLedgerST.Booking__c = scppdDetailsMap.get(d.scppd_4__c).Customer_Pay_Plan_Header__r.Booking__c;
                                objLedgerST.Remarks__c = 'Tax debited for : ' + scppdDetailsMap.get(d.scppd_4__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                                if(taxMap.containsKey(scppdDetailsMap.get(d.scppd_4__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                    for(Tax_Breakup__c tb : taxMap.get(scppdDetailsMap.get(d.scppd_4__c).Standard_Pay_Plan_Header__r.Charge_Code__r.Name)) {
                                        taxValue = 0;
                                        taxValue = ((tb.Taxable_Percentage__c * taxableAmt/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) ;
                                        totalTax += taxValue;
                                    }
                                }
                                objLedgerST.Amount__c = totalTax;
                            }
                        }
                        objLedgerST.Project_Unit__c  = d.Demand_Invoice__r.Customer__r.Project_Unit__c;
                        objLedgerST.Debit_Credit__c='Debit';
                        objLedgerST.Transaction_Date__c= system.today() ;
                        objLedgerST.Is_ledger_created_through_trigger__c = true;
                        objLedgerST.Demand_Invoice__c = d.Demand_Invoice__r.Id;
                        objLedgerST.Demand_Detail__c = d.Id;
                        objLedgerST.Global_Charges__c = objGblchrgBasicServiceTax.Id ;
                        lstLedgerToUpsert.add(objLedgerST);
                     }                  
                }
            }
        }
        if(lstLedgerToUpsert.size() > 0) {
            Database.UpsertResult[] srList1 = Database.upsert(lstLedgerToUpsert);
                for(Database.UpsertResult sr : srList1) {
                    if(sr.isSuccess()) {
                        ledgerIdList.add(sr.getId());
                    }
            }
        }
    }
    
    /*--------------------------------------------------------------  
           Method to create tax ledgers
           For every ledger of type service tax, we query the tax slabs breakup from
           and create the individual tax amounts. For example the Basic tax of 4.5% is split
           into 4.2% for basic 0.15% for KKC and 0.15 for SBC.
    ----------------------------------------------------------------*/
    public static void createTaxLedgers(List<Ledger__c> ll){
        List<Ledger__c> ledgerList =  new List<Ledger__c>();
        List<Ledger__c> taxChildList =  new List<Ledger__c>();
        Set<Id> ledgerSet = new Set<Id>();
        Set<Id> projectIdset = new Set<Id>();
        Map<Id,Map<String,String>> projTaxRateMap = new Map<Id,Map<String,String>>();
        for(Ledger__c l : ll) {
            ledgerSet.add(l.Id);
        }
        ledgerList = [Select Id, Name,Global_Charges__c, 
                        Global_Charges__r.Name, Amount__c, Debit_Credit__c,
                        Standard_Customer_Pay_Plan_Detail__c, 
                        Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Name, 
                        Standard_Customer_Pay_Plan_Detail__r.Project__c, 
                        Standard_Customer_Pay_Plan_Detail__r.Project__r.Name, 
                        Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                        Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Id,
                        Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                        Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c
                        from Ledger__c where id in : ledgerSet];
        if(!LedgerList.isEmpty() && LedgerList.size() > 0) {
            for(Ledger__c l : ledgerList) {
                projectIdset.add(l.Standard_Customer_Pay_Plan_Detail__r.Project__c);
                if(String.isNotEmpty(l.Global_Charges__c) && l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) {
                    taxChildList.add(l);
                }
            }
        }
        projTaxRateMap = getTaxSlabForCharges(projectIdset);
        System.debug('Project tax rate map:' + projTaxRateMap);
        Set<Id> taxSlabSet = new Set<Id>();
        Map<String, List<Ledger__c>> taxSlabLedgerMap = new Map<String, List<Ledger__c>>();
        if(!taxChildList.isEmpty() && taxChildList.size() != 0) {
            String taxSlab = '';
            for(Ledger__c l : taxChildList) {
                if(projtaxRateMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Project__c) && 
                    (projtaxRateMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Project__c).containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name))) {
                         taxSlab = projtaxRateMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Project__c).get(l.Standard_Customer_Pay_Plan_Detail__r.Standard_Pay_Plan_Header__r.Charge_Code__r.Name);
                        if(String.isNotEmpty(taxSlab)) {
                            taxSlabSet.add(taxSlab);
                            if(taxSlabLedgerMap.containsKey(taxSlab)) {
                                taxSlabLedgerMap.get(taxSlab).add(l);
                            } else {
                                List<Ledger__c> temp = new List<Ledger__c>();
                                temp.add(l);
                                taxSlabLedgerMap.put(taxSlab,temp);
                            }
                        }
                }
                
                taxSlab = '';
                
            }
        }
        List<Tax_Breakup__c> tbList = new List<Tax_Breakup__c>();
        Map<String,List<Tax_Breakup__c>> taxParentChildMap = new Map<String,List<Tax_Breakup__c>>();
        
        System.debug('tax slab set:' + taxSlabSet);
        tbList = [Select Id, Remarks__c, Taxable_Percentage__c, Tax_Code__c, Tax_Name__c, Tax_Percentage__c, Tax_Percentage_On_100__c, Tax_Slab__c, Tax_Type__c,tax_slab__r.Percentage__c from
                    Tax_Breakup__c where Tax_Slab__c in :taxSlabSet];
        for(Tax_Breakup__c tb : tbList) {
            if(taxParentChildMap.containsKey(tb.Tax_Slab__c))
                taxParentChildMap.get(tb.Tax_Slab__c).add(tb);
            else {
                List<Tax_Breakup__c> temp = new List<Tax_Breakup__c>();
                temp.add(tb);
                taxParentChildMap.put(tb.Tax_Slab__c, temp);
            }
        }
        List<Child_Ledgers__c> clList = new List<Child_Ledgers__c>();
        System.debug('taxSlabLedgerMap:' + taxSlabLedgerMap);
        System.debug('taxParentChildMap:' + taxParentChildMap);
        for(String taxSlab : taxSlabLedgerMap.keySet()) {
            if(taxSlabLedgerMap.containsKey(taxSlab)) {
                for(Ledger__c l : taxSlabLedgerMap.get(taxSlab)) {
                    if(taxParentChildMap.containsKey(taxSlab)) {
                        for(Tax_Breakup__c tb : taxParentChildMap.get(taxSlab)) {
                            Child_Ledgers__c cl = new Child_Ledgers__c();
                            cl.Ledger__c = l.Id;
                            cl.Tax_Breakup__c = tb.Id;
                            cl.Tax_Amount__c = ((l.Amount__c * tb.Tax_Percentage_On_100__c/tb.tax_slab__r.Percentage__c)).setscale(2, RoundingMode.HALF_UP);
                            clList.add(cl);
                        }
                    }
                }
            }
        }
        try {
            insert clList;
        } catch (Exception ex) {
            System.debug('Error while creating child ledgers:' + ex.getMessage());
        }
    }
    
    /*--------------------------------------------------------------  
        Get tax slab names for the project charges   
    ----------------------------------------------------------------*/
    public static Map<Id,Map<String,String>> getTaxSlabForCharges(Set<Id> pIdSet) {
        List<Project_Charges__c> projChargesList = [Select Id, Name, 
                                                                Active__c,
                                                                Charge_Code__r.Name,
                                                                S_Charge_Calculated_As__c,
                                                                S_Payable_At__c,
                                                                S_Charge_Bucket__c,
                                                                S_Charge_Percentage__c,
                                                                S_Lumpsum_Charge_Amount__c,
                                                                Service_Tax_Percentage__c,
                                                                Interest_Applicable_on_this_charge__c,
                                                                Service_Tax_Applicable_on_this_charge__c,
                                                                Project__r.Id,
                                                                Payment_Plan_Applicable__c from 
                                                                Project_Charges__c 
                                                                where Project__r.Id in :pIdSet
                                                                and Service_Tax_Applicable_on_this_charge__c = true
                                                                and Service_Tax_Percentage__c != NULL
                                                                ];       
        Map<Id,Map<String,Id>> projTaxSlabMap = new Map<Id,Map<String,Id>>();
        // take slabs data from the global configuration
        Map<String, Id> taxslabsMap = new Map<String, Id>();
        list<Tax_Slab__c>   lstTaxSlab = [select Name,From_Date__c, To_Date__c, Percentage__c from Tax_Slab__c where From_Date__c <= TODAY and (To_Date__c >= TODAY OR To_Date__c = null)];
       // system.debug('lstTaxSlab --- '+lstTaxSlab);
        for(Tax_Slab__c objTS : lstTaxSlab){
            taxslabsMap.put(objTS.Name,objTS.Id);
        }   
        for (Project_Charges__c pc: projChargesList) {
            if(taxslabsMap.containsKey(pc.Service_Tax_Percentage__c)) {
                if(projTaxSlabMap.containsKey(pc.Project__r.Id)) {
                    projTaxSlabMap.get(pc.Project__r.Id).put(pc.Name,taxslabsMap.get(pc.Service_Tax_Percentage__c));
                } else {
                Map<String,Id> tMap = new Map<string,Id>();
                tMap.put(pc.Name,taxslabsMap.get(pc.Service_Tax_Percentage__c));
                projTaxSlabMap.put(pc.Project__r.Id,tMap);
                }
            }
        }
        return projTaxSlabMap;
    }
    /*--------------------------------------------------------------  
            METHOD To GET MAP OF LEDGER
        Parameters:- List of Standard PayPlan Detail Ids.
        Returns:- Map of Ledgers againest St. Pay Plan Detail Ids.   
    ----------------------------------------------------------------*/
    public static map<String,Ledger__c> GetLedgerMap(set<ID> setSCPPDID)
    {
        list<Ledger__c> lstLedger = [select id, Standard_Customer_Pay_Plan_Detail__c, Global_Charges__r.Name 
                                            from Ledger__c 
                                            where Standard_Customer_Pay_Plan_Detail__c in : setSCPPDID];
                                            
        map<String,Ledger__c> mapLedger = new  map<String,Ledger__c>();
        
        for(Ledger__c objLedger : lstLedger)
        {
            if(objLedger.Standard_Customer_Pay_Plan_Detail__c != null && objLedger.Global_Charges__r.Name != null) {
                mapLedger.put(objLedger.Standard_Customer_Pay_Plan_Detail__c+objLedger.Global_Charges__r.Name,objLedger);
            }
        }
        
        return mapLedger;
    }
    /*--------------------------------------------------------------  
        METHOD to create ledgers related to registration milestones.
    ----------------------------------------------------------------*/
    // rchList ->registrationChargesHeader
    public static void createRegistrationLedgers(Set<Id> customerList) {
         list < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = [Select Id,IsSendDemandLetter__c , Customer_Pay_Plan_Header__r.Id, 
                                                Customer_Pay_Plan_Header__r.Customer__r.Id, Project__r.Id,
                                                Customer_Pay_Plan_Header__r.Project_Unit__r.Id,
                                                Customer_Pay_Plan_Header__r.Global_Charges__r.Description__c,
                                                customer_Pay_Plan_Header__r.Global_Charges__r.Name,
                                                Charge_Amount_Advance_Recd__c, Installment__c,Milestone_Demand_Id__c,
                                                Charge_Amount_Billed__c,Service_Tax_Amount_Billed__c,
                                                Charge_Amount_Due__c, Service_Tax_Amount_Due__c, 
                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Applicable_on_this_charge__c,
                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,
                                                customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c 
                                                from  Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__r.Customer__r.Id in :customerList
                                                and  customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c in ('Stamp Duty and Registration')]; 

        // iterate through the list of registration charges records [which is the cpph records of type MVAT and legal charges]
        // create MVAT and legal charges legders.
        // Stamp Duty and REgistration charges are not paid to the builders. hence not creating ledgers for them
        List<ledger__c> lstLedgerForMVAT = new List<ledger__c>();
        List<ledger__c> lstLedgerForLegal = new List<ledger__c>();
        Global_Charges__c objGblchrgBasicServiceTax =[select id from Global_Charges__c where Charge_Type__c ='Tax' and Description__c='SERVICE TAX' limit 1];
        
        if(lstSCPPD.size() > 0) {
            for (Standard_Customer_Pay_Plan_Detail__c rch : lstSCPPD) {
                if(rch.customer_Pay_Plan_Header__r.Global_Charges__r.Name != null &&  rch.customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('MVAT')) {
                    ledger__c objNewMVATLedger =  new ledger__c();
                    objNewMVATLedger.Opportunity__c= rch.Customer_Pay_Plan_Header__r.Customer__r.Id;
                    objNewMVATLedger.Global_Charges__c = rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Id;
                    objNewMVATLedger.Amount__c = rch.Charge_Amount_Billed__c; 
                    objNewMVATLedger.Debit_Credit__c='Debit'; 
                    objNewMVATLedger.Is_ledger_created_through_trigger__c = true; 
                    objNewMVATLedger.Ledger_Type__c = 'Registration';
                    objNewMVATLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewMVATLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewMVATLedger.Transaction_Date__c = system.today();
                    objNewMVATLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewMVATLedger.Remarks__c = 'Registration ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewMVATLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForMVAT.add(objNewMVATLedger);
                }
                if(rch.customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != null &&  rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Legal Charges') && rch.Charge_Amount_Due__c > 0 ) {
                    ledger__c  objNewLegalChargesLedger        = new ledger__c();     
                    objNewLegalChargesLedger.Opportunity__c    = rch.Customer_Pay_Plan_Header__r.Customer__r.Id;   
                    objNewLegalChargesLedger.Global_Charges__c = rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Id; 
                    objNewLegalChargesLedger.Amount__c         = rch.Charge_Amount_Billed__c; 
                    objNewLegalChargesLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewLegalChargesLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewLegalChargesLedger.Debit_Credit__c   = 'Debit';
                    objNewLegalChargesLedger.Ledger_Type__c = 'Registration';
                    objNewLegalChargesLedger.Is_ledger_created_through_trigger__c = true;  
                    objNewLegalChargesLedger.Transaction_Date__c = system.today();
                    objNewLegalChargesLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewLegalChargesLedger.Remarks__c = 'Registration ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewLegalChargesLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForLegal.add(objNewLegalChargesLedger); 
                } 
                if(rch.customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != null &&  rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Stamp Duty') && rch.Charge_Amount_Due__c > 0 ) {
                    ledger__c  objNewLegalChargesLedger        = new ledger__c();     
                    objNewLegalChargesLedger.Opportunity__c    = rch.Customer_Pay_Plan_Header__r.Customer__r.Id;   
                    objNewLegalChargesLedger.Global_Charges__c = rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Id; 
                    objNewLegalChargesLedger.Amount__c         = rch.Charge_Amount_Billed__c; 
                    objNewLegalChargesLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewLegalChargesLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewLegalChargesLedger.Debit_Credit__c   = 'Debit';
                    objNewLegalChargesLedger.Ledger_Type__c = 'Registration';
                    objNewLegalChargesLedger.Is_ledger_created_through_trigger__c = true;  
                    objNewLegalChargesLedger.Transaction_Date__c = system.today();
                    objNewLegalChargesLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewLegalChargesLedger.Remarks__c = 'Registration ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewLegalChargesLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForLegal.add(objNewLegalChargesLedger); 
                }
                if(rch.customer_Pay_Plan_Header__r.Standard_Pay_Plan_Header__r.Charge_Code__r.S_Charge_Bucket__c != null &&  rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Registration Charges') && rch.Charge_Amount_Due__c > 0) {
                    ledger__c  objNewLegalChargesLedger        = new ledger__c();     
                    objNewLegalChargesLedger.Opportunity__c    = rch.Customer_Pay_Plan_Header__r.Customer__r.Id;   
                    objNewLegalChargesLedger.Global_Charges__c = rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Id; 
                    objNewLegalChargesLedger.Amount__c         = rch.Charge_Amount_Billed__c; 
                    objNewLegalChargesLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewLegalChargesLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewLegalChargesLedger.Debit_Credit__c   = 'Debit';
                    objNewLegalChargesLedger.Ledger_Type__c = 'Registration';
                    objNewLegalChargesLedger.Is_ledger_created_through_trigger__c = true;  
                    objNewLegalChargesLedger.Transaction_Date__c = system.today();
                    objNewLegalChargesLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewLegalChargesLedger.Remarks__c = 'Registration ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewLegalChargesLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForLegal.add(objNewLegalChargesLedger); 
                }
                if(rch.Service_Tax_Amount_Billed__c != 0 &&  rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('Legal Charges') &&  rch.Service_Tax_Amount_Due__c > 0) {
                    ledger__c  objNewLegalSTChargesLedger        = new ledger__c();     
                    objNewLegalSTChargesLedger.Opportunity__c    = rch.Customer_Pay_Plan_Header__r.Customer__r.Id;   
                    objNewLegalSTChargesLedger.Global_Charges__c = objGblchrgBasicServiceTax.Id; 
                    objNewLegalSTChargesLedger.Amount__c         = rch.Service_Tax_Amount_Billed__c; 
                    objNewLegalSTChargesLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewLegalSTChargesLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewLegalSTChargesLedger.Debit_Credit__c   = 'Debit';
                    objNewLegalSTChargesLedger.Ledger_Type__c = 'Registration';
                    objNewLegalSTChargesLedger.Is_ledger_created_through_trigger__c = true;  
                    objNewLegalSTChargesLedger.Transaction_Date__c = system.today();
                    objNewLegalSTChargesLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewLegalSTChargesLedger.Remarks__c = 'Registration Service Tax ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewLegalSTChargesLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForLegal.add(objNewLegalSTChargesLedger); 
                }  
                if(rch.Service_Tax_Amount_Billed__c != 0 && rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name.equalsIgnoreCase('MVAT')) {
                    ledger__c  objNewMVATSTLedger        = new ledger__c();     
                    objNewMVATSTLedger.Opportunity__c    = rch.Customer_Pay_Plan_Header__r.Customer__r.Id;   
                    objNewMVATSTLedger.Global_Charges__c = objGblchrgBasicServiceTax.Id; 
                    objNewMVATSTLedger.Amount__c         = rch.Service_Tax_Amount_Billed__c; 
                    objNewMVATSTLedger.Demand_Invoice__c = rch.Milestone_demand_id__c;
                    objNewMVATSTLedger.Standard_Customer_Pay_Plan_Detail__c = rch.Id;
                    objNewMVATSTLedger.Debit_Credit__c   = 'Debit';
                    objNewMVATSTLedger.Ledger_Type__c = 'Registration';
                    objNewMVATSTLedger.Is_ledger_created_through_trigger__c = true;  
                    objNewMVATSTLedger.Transaction_Date__c = system.today();
                    objNewMVATSTLedger.Project_Unit__c = rch.Customer_Pay_Plan_Header__r.Project_Unit__r.Id;
                    objNewMVATSTLedger.Remarks__c = 'Registration Service Tax ledger created for ' + rch.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                    objNewMVATSTLedger.Customer_Pay_Plan_Header__c = rch.Customer_Pay_Plan_Header__r.Id;
                    lstLedgerForMVAT.add(objNewMVATSTLedger); 
                }
           }
        }
        if(lstLedgerForMVAT.size()>0)
        {
            insert lstLedgerForMVAT;
        }
        if(lstLedgerForLegal.size()>0)
        {
            insert lstLedgerForLegal;
        }                                               
    }
    /*--------------------------------------------------------------  
        METHOD To get ledger details for printing the ledger
        Parameters:- customer [opp Id]
        Returns:- LedgerWrapper
    ----------------------------------------------------------------*/
    
     public static List<LedgerPrintWrapper> getCustomerLedgers(Id oppId) {
        List<Ledger__c> lList = [select id, Name,
                                    Transaction_Date__c,
                                    Amount__c,
                                    Reciepts__r.Receipt_No__c,
                                    Reciepts__r.Cheque_DD_Date__c,
                                    Project_Unit__r.id,
                                    Debit_Credit__c,
                                    Associated_Dishonour_Credit_Ledger__c,
                                    ledger_type__c,
                                    Reciepts__c,
                                    Reciepts__r.Name,
                                    Reciepts__r.Mode__c,
                                    Reciepts__r.Cheque_DD__c, 
                                    Reciepts__r.id,
                                    Reciepts__r.Receipt_Date__c,
                                    Reciepts__r.Receipt_Status__c,
                                    Reciepts__r.DraweeBank__c,
                                    Reciepts__r.Currency__c,
                                    Reciepts__r.Amount_Rs__c,
                                    Reciepts__r.Receipt_Number__c,
                                    Reciepts__r.Foreign_Currency_Type__c,
                                    Reciepts__r.Amount_in_Foreign_Currency__c,
                                    Project_Unit__r.Project_Unit_Type__r.Name,
                                    Remarks__c,
                                    Project_Unit__r.Name,
                                    Project_Unit__r.Project__r.Name,
                                    Project_Unit__r.Project__r.Id,
                                    Opportunity__r.Name,
                                    Global_Charges__c,
                                    Global_Charges__r.Name,
                                    Demand_Invoice__r.Name,
                                    Demand_Invoice__r.Id,
                                    Demand_Invoice__r.Milestone_Name__c,
                                    Demand_Invoice__r.Invoice_Date__c,
                                    Demand_Invoice__r.Due_Date__c,
                                    Demand_Invoice__r.Current_Demand_Installment__c,
                                    Demand_Invoice__r.Current_Demand_Service_Tax__c,
                                    Demand_Invoice__r.Is_Advanced_Demand__c,
                                    Standard_Customer_Pay_Plan_Detail__r.Installment_Number__c,
                                    Standard_Customer_Pay_Plan_Detail__r.Id,
                                    Standard_Customer_Pay_Plan_Detail__r.Due_Date__c,
                                    Standard_Customer_Pay_Plan_Detail__r.Project_Construction_Stages__r.Name,
                                    Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c,
                                    Standard_Customer_Pay_Plan_Detail__r.Is_to_be_Paid__c,
                                    Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name
                                    from Ledger__c where  Opportunity__c=:oppId 
                                    and Effect_To_Date__c=:null and Transaction_Date__c <=:system.today() 
                                    order by createdDate asc, Demand_Invoice__r.Name asc, Global_Charges__r.Name asc, Debit_Credit__c desc                          
                            ];  
                            system.debug('lList:::: '+lList);
                            system.debug('lList.size:::: '+lList.size());  
        Integer count = 0;
        Map<String, Integer> debitMap = new Map<String, Integer>();
        Map<String, Integer> chequeDishonourMap = new Map<String, Integer>();
        List<LedgerPrintWrapper> lpwList = new List<LedgerPrintWrapper>();
        Map<Integer,Decimal> refNoDebitAmtMap = new Map<Integer,Decimal>();
        Map<Integer,Decimal> refNoCreditAmtMap = new Map<Integer,Decimal>();
        Map<Integer,Integer> refNoCreditCounterMap = new Map<Integer, Integer>();
        for(Ledger__c l : lList) {
            if(l.Debit_Credit__c.equalsIgnoreCase('Debit') && l.Standard_Customer_Pay_Plan_Detail__c != null && l.Demand_Invoice__c != null) {
                if(l.ledger_type__c == null) {
                    debitMap.put(l.Demand_Invoice__r.Id + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name + l.Global_Charges__r.Name, count);
                    refNoDebitAmtMap.put(count,l.Amount__c);
                    count++;
                }
            } else if(l.Debit_Credit__c.equalsIgnoreCase('Debit') && l.Global_Charges__r.Name.equals('Cheque Dishonor') && l.Associated_Dishonour_Credit_Ledger__c != null) {
                chequeDishonourMap.put(l.Associated_Dishonour_Credit_Ledger__c,count);
                count++;
            }
        }
        System.debug('debitMap:' + debitMap);
        Decimal Balance = 0;
        for(Ledger__c l :lList) {
            if(l.Debit_Credit__c.equalsIgnoreCase('Debit') && l.Standard_Customer_Pay_Plan_Detail__c != null && l.Demand_Invoice__c != null) {
                ledgerPrintWrapper lpw = new LedgerPrintWrapper();
                //ledger 
                lpw.l = l;
                // populating the details of milestone for debit ledger
                
                if(l.Standard_Customer_Pay_Plan_Detail__r.Is_to_be_Paid__c.equals('From Dt. of Booking')  || l.Standard_Customer_Pay_Plan_Detail__r.Is_to_be_Paid__c.equals('From Dt. of Registration')) {
                    if(l.Demand_Invoice__r.Is_Advanced_Demand__c) {
                        lpw.demandFor = 'Advance Demand For ' + l.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                    } else
                        lpw.demandFor = 'Demand For ' + l.Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c;
                    if(lpw.demandFor != null){
                        if(lpw.demandFor.equals('Demand For 0Day(s) from date of booking.'))
                            lpw.demandFor = lpw.demandFor.replace('0Day(s) from date of booking.','Token Amount');
                    }    
                } else if(l.Standard_Customer_Pay_Plan_Detail__r.Is_to_be_Paid__c.equals('Construction Stage')) {
                    String formattedDate = 'NA';
                    if(l.Demand_Invoice__r.Is_Advanced_Demand__c) {
                        lpw.demandFor = 'Advance Demand For ' + l.Standard_Customer_Pay_Plan_Detail__r.Project_Construction_Stages__r.Name;
                    }
                    else if(l.Standard_Customer_Pay_Plan_Detail__r.Due_Date__c != null) {
                        formattedDate = l.Standard_Customer_Pay_Plan_Detail__r.Due_Date__c.Format();
                        lpw.demandFor = 'Demand For ' + l.Standard_Customer_Pay_Plan_Detail__r.Project_Construction_Stages__r.Name + '<br/> completed on ' +  formattedDate;
                    }
                    else
                        lpw.demandFor = 'Demand For ' + l.Standard_Customer_Pay_Plan_Detail__r.Project_Construction_Stages__r.Name; // flow shouldnt come here ideally
                } else if(l.Demand_Invoice__r.Milestone_Name__c != null && l.Demand_Invoice__r.Milestone_Name__c.equalsIgnoreCase('Registration')){
                        lpw.demandFor = 'Demand For Registration';
                }
                else if(l.Demand_Invoice__r.Milestone_Name__c != null && l.Demand_Invoice__r.Milestone_Name__c.equalsIgnoreCase('Registration Intimation')){
                        lpw.demandFor = 'Demand For Registration';
                }
                // populating the demand details for debit Ledger
                if(l.Demand_Invoice__c != null)
                    lpw.DemandDetails = 'Invoice No:' + l.Demand_Invoice__r.Name + '<br/> Invoice Date:' + l.Demand_Invoice__r.Invoice_Date__c.Format() + '<br/> Due Date:' + l.Demand_Invoice__r.Due_Date__c.Format();
                if(l.Ledger_Type__c != null && l.Ledger_Type__c.equals('Credit Reversal'))
                    lpw.DemandDetails  += ' - Credit Reversal Due to Cheque Dishonour';
                // populating the ref no for debit ledger
                if(debitMap.containsKey(l.Demand_Invoice__r.Id + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name + l.Global_Charges__r.Name)) {
                    lpw.refNo = debitMap.get(l.Demand_Invoice__r.Id + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name + l.Global_Charges__r.Name);
                    lpw.refString = String.valueOf(lpw.refNo);
                }
                // populating the charge name
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                    lpw.chargeName = l.Global_Charges__r.Name + ' on ' +l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                else 
                    lpw.chargeName = l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                lpw.chargeName = lpw.chargeName.replace('Basic','Flat Cost');   
                lpw.chargeName = lpw.chargeName.replace('Service Tax','Tax'); 
                // Amount in Rs format
                if(l.Amount__c != null) {
                    lpw.Amount = INFormat(l.Amount__c);
                
                    // Running balance in Rs Format
                    Balance += l.Amount__c;
                    lpw.Balance = INFormat(Balance);
                }
                
                lpwList.add(lpw);
            } else if(l.Debit_Credit__c.equalsIgnoreCase('Credit') && l.Standard_Customer_Pay_Plan_Detail__c != null && l.Demand_Invoice__c != null) {
                ledgerPrintWrapper lpw1 = new LedgerPrintWrapper();
                // ledger
                lpw1.l = l;
                
                // payment for details for the credit ledger
                lpw1.paymentFor = 'Payment received against ' + l.Project_Unit__r.Name + '<br/> Invoice No.:' + l.Demand_Invoice__r.Name;
                
                // instrument details for credit ledger
                if(l.Reciepts__r.Foreign_Currency_Type__c != null)
                    lpw1.paymentDetails =   'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + '<br/> Bank:' + l.Reciepts__r.DraweeBank__c +
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Original Currency:' + l.Reciepts__r.Amount_in_Foreign_Currency__c + ' ' + l.Reciepts__r.Foreign_Currency_Type__c +
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                                '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                else if (l.Reciepts__r.Mode__c.equals('TDS'))
                    lpw1.paymentDetails = 'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + 
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                                '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                else
                    lpw1.paymentDetails = 'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + '<br/> Bank:' + l.Reciepts__r.DraweeBank__c +
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                                '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                // charge name
                if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                    lpw1.chargeName = l.Global_Charges__r.Name + ' on ' + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                else 
                    lpw1.chargeName = l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name;
                lpw1.chargeName = lpw1.chargeName.replace('Basic','Flat Cost');
                lpw1.chargeName = lpw1.chargeName.replace('Service Tax','Tax');
                // amount
                if(l.Amount__c != null) {
                    lpw1.Amount = INFormat(l.Amount__c);
                    // balance
                    Balance -= l.Amount__c;
                    lpw1.Balance = INFormat(Balance);
                }
                
                //matching the ref no with the debit side reference no. this is used for pairing and color coding the debit and credit demand
                if(debitMap.containsKey(l.Demand_Invoice__r.Id + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name + l.Global_Charges__r.Name)) {
                    lpw1.refNo = debitMap.get(l.Demand_Invoice__r.Id + l.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__r.Name + l.Global_Charges__r.Name);
                    if(refNoCreditAmtMap.containsKey(lpw1.refNo)) {
                        refNoCreditAmtMap.put(lpw1.refNo, refNoCreditAmtMap.get(lpw1.refNo) + l.Amount__c);
                    } else {
                        refNoCreditAmtMap.put(lpw1.refNo,l.Amount__c);
                    }
                    if(refNoCreditCounterMap.containsKey(lpw1.refNo)) {
                        refNoCreditCounterMap.put(lpw1.refNo, refNoCreditCounterMap.get(lpw1.refNo) + 1);
                    } else {
                        refNoCreditCounterMap.put(lpw1.refNo,1);
                    }
                    if(refNoCreditAmtMap.containsKey(lpw1.refNo)) {
                        if(refNoCreditAmtMap.get(lpw1.refNo) >= refNoDebitAmtMap.get(lpw1.refNo) && refNoCreditCounterMap.get(lpw1.refNo) == 1 )
                            lpw1.refString += String.valueOf(lpw1.refNo) + ' (Full Payment)';
                        else if(refNoCreditAmtMap.get(lpw1.refNo) >= refNoDebitAmtMap.get(lpw1.refNo) && refNoCreditCounterMap.get(lpw1.refNo) > 1)
                            lpw1.refString += String.valueOf(lpw1.refNo) + ' (PPC)';
                        else if(refNoCreditAmtMap.get(lpw1.refNo) < refNoDebitAmtMap.get(lpw1.refNo))
                            lpw1.refString += String.valueOf(lpw1.refNo) + ' (PP)'; 
                             
                    } else {
                        lpw1.refString += String.valueOf(lpw1.refNo);
                    }
                }
                lpwList.add(lpw1);
            } else if(l.Debit_Credit__c.equalsIgnoreCase('Debit')) {
                ledgerPrintWrapper lpw = new LedgerPrintWrapper();
                //ledger 
                lpw.l = l;
                if(l.Global_Charges__r.Name.contains('Interest')) {
                    lpw.demandFor = 'Interest for late payments';
                    lpw.refNo = 1001;
                    lpw.refString = '1001';
                    lpw.chargeName = 'Interest';
                } else if (l.Global_Charges__r.Name.equals('Cheque Dishonor')) {
                    lpw.demandFor = 'Cheque Dishonour Penalty ';
                    lpw.demandDetails = l.Remarks__c;
                    lpw.ChargeName = l.Global_Charges__r.Name;
                    lpw.refNo = 1002; // as default if matching credit exists then it can color coded as a pair else default color will show
                    lpw.refString = String.valueOf(lpw.refNo);
                    if(chequeDishonourMap.containskey(l.Associated_Dishonour_Credit_Ledger__c)) {
                        lpw.refNo = chequeDishonourMap.get(l.Associated_Dishonour_Credit_Ledger__c);
                        lpw.refString = String.valueOf(lpw.refNo);
                    }
                }
                // Amount in Rs format
                if(l.Amount__c != null) {
                    lpw.Amount = INFormat(l.Amount__c);
                    // Running balance in Rs Format
                    Balance += l.Amount__c;
                    lpw.Balance = INFormat(Balance);
                }
                if(l.Ledger_Type__c != null && l.Ledger_Type__c.equals('Credit Reversal'))
                    lpw.DemandDetails  += ' - Credit Reversal Due to Cheque Dishonour';
                lpwList.add(lpw);
                
            } else  if(l.Debit_Credit__c.equalsIgnoreCase('Credit')) {
                ledgerPrintWrapper lpw1 = new LedgerPrintWrapper();
                // ledger
                lpw1.l = l;
                if(l.Global_Charges__r.Name.contains('Interest')) {
                    lpw1.paymentFor = 'Interest for late payments';
                    lpw1.refNo = 1001;
                    lpw1.refString = '1001';
                    lpw1.chargeName = 'Interest';
                } else if (l.Global_Charges__r.Name.equals('Cheque Dishonor')) {
                    lpw1.paymentFor = 'Cheque Dishonour Penalty ';
                    lpw1.ChargeName = l.Global_Charges__r.Name;
                    lpw1.refNo = 1002; // as default if matching credit exists then it can color coded as a pair else default color will show
                    lpw1.refString = String.valueOf(lpw1.refNo);
                    if(chequeDishonourMap.containskey(l.Id)) {
                        
                        lpw1.refNo = chequeDishonourMap.get(l.Id);
                        lpw1.refString = String.valueOf(lpw1.refNo);
                        
                    }
                }
                
                // instrument details for credit ledger
                if(l.Reciepts__r.Foreign_Currency_Type__c != null)
                    lpw1.paymentDetails =   'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + '<br/> Bank:' + l.Reciepts__r.DraweeBank__c +
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Original Currency:' + l.Reciepts__r.Amount_in_Foreign_Currency__c + ' ' + l.Reciepts__r.Foreign_Currency_Type__c +
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                                '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                else if (l.Reciepts__r.Mode__c.equals('TDS'))
                    lpw1.paymentDetails = 'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + 
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                                '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                else
                    lpw1.paymentDetails = 'Type:' + l.Reciepts__r.Mode__c + '<br/> Date:' + l.Reciepts__r.Cheque_DD_Date__c.Format() + '<br/> Instrument No.' + 
                                                                l.Reciepts__r.Cheque_DD__c + '<br/> Bank:' + l.Reciepts__r.DraweeBank__c +
                                                                '<br/> Currency:' + l.Reciepts__r.Currency__c + 
                                                                '<br/> Amount:' + InFormat(l.Reciepts__r.Amount_Rs__c) + 
                                                                '<br/> Receipt No.:' + l.Reciepts__r.Receipt_Number__c + 
                                                            '<br/> Status:' + l.Reciepts__r.Receipt_Status__c;
                if(l.Amount__c != null)  {  
                    // amount
                    lpw1.Amount = INFormat(l.Amount__c);
                    // balance
                    Balance -= l.Amount__c;
                    lpw1.Balance = INFormat(Balance);
                }
                lpwList.add(lpw1);
            }
        }
        System.debug('lpwList:' + lpwList);
        return lpwList;
    }
    
    public class LedgerPrintWrapper {
        public Ledger__c l {get;set;}
        public Integer refNo {get;set;}
        public String refString {get;set;}
        public String chargeName {get;set;}
        public String Amount {get;set;}
        public String Balance {get;set;}
        public String DemandFor {get;set;}
        public String paymentFor {get;set;}
        public String demandDetails {get;set;}
        public String paymentDetails {get;set;}
        public LedgerPrintWrapper() {
            l = new ledger__c();
            chargeName = '';
            Amount = '';
            Balance = '';
            demandFor = '';
            paymentFor = '';
            demandDetails = '';
            paymentDetails = '';
            refString = '';
        }
    }
    
    
    // method for formatting the currency details to Indian Commas Format
    public static String INFormat(Decimal money) {
        Boolean negative = false;
        if(money < 0) {
            negative = true;
        }
        if(money == null) {
            return 'NIL';
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
}