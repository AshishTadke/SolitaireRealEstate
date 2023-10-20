trigger LedgerTrigger on Ledger__c (after insert, after update, after delete, after undelete) {
 if(Trigger.isInsert)
 {
   if(Trigger.isAfter)
   {
       LedgerManagementServices.createTaxLedgers(Trigger.new);
    } 
   
  }
   Set<Id> scppdSet = new Set<Id>();
   Map<Id, Map<String, Decimal>> rollupMap  = new Map<Id, Map<String, Decimal>>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for(Ledger__c l : Trigger.new) {
            if(l.Standard_Customer_Pay_Plan_Detail__c != null && l.Debit_Credit__c.equalsIgnoreCase('Debit')) {
                scppdSet.add(l.Standard_Customer_Pay_Plan_Detail__c);
            }
        }
        System.debug('SCPPD SET:' + scppdSet);
            if(!test.isRunningTest())
                reconcileSCPPD();
    }
    
    if(Trigger.isDelete) {
        for(Ledger__c l : Trigger.old) {
            System.debug('After delete:' + l);
            if(l.Standard_Customer_Pay_Plan_Detail__c != null && l.Debit_Credit__c.equalsIgnoreCase('Debit')) {
                scppdSet.add(l.Standard_Customer_Pay_Plan_Detail__c);
            }
        }
        System.debug('SCPPD SET:' + scppdSet);
        if(checkRecursion.isFirstRun())
            reconcileSCPPD();
    }
    
    public static void reconcileSCPPD() {
        // requery all the ledgers that are part of the affected SCPPD set.
        List<Ledger__c> lList = [Select Id, Standard_Customer_Pay_Plan_Detail__c, 
                                    Amount__c, Global_Charges__r.Name from Ledger__c where 
                                                Standard_Customer_Pay_Plan_Detail__c in : scppdSet 
                                                and Global_Charges__r.Name NOT in ('Cheque Dishonor', 'Interest Intstallment', 'Interest Servicetax')
                                                and Debit_Credit__c = 'Debit'];   
        
        // then query all the scppd belonging to the scppdSet. so that we can redo the complete roll ups.
        Map<Id,Standard_Customer_Pay_Plan_Detail__c> scppdMap= new Map<Id, Standard_Customer_Pay_Plan_Detail__c>(
                                [Select Id, Customer_Pay_Plan_Header__c, Charge_Amount_Billed__c, Charge_Amount_Paid__c, Service_Tax_Amount_Billed__c, 
                                Service_Tax_Amount_Paid__c from Standard_Customer_Pay_Plan_Detail__c 
                                where Id in :  scppdSet]);
        
        if(!lList.isEmpty()) {
            System.debug('Inside if:');
            for(Ledger__c l : lList) {
                if(rollupMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__c)){
                        Map<String, Decimal> temp = rollupMap.get(l.Standard_Customer_Pay_Plan_Detail__c);
                        if(l.Amount__c != null && !l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                            temp.put('DEMANDED', temp.get('DEMANDED') +l.Amount__c);
                        if(l.Amount__c != null && l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) 
                            temp.put('STDEMANDED',temp.get('STDEMANDED') + l.Amount__c);
                        rollupMap.put(l.Standard_Customer_Pay_Plan_Detail__c , temp);
                } else {
                    Map<String, Decimal> temp = new Map<String, Decimal>();
                    if(l.Amount__c != null && !l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                        temp.put('DEMANDED', l.Amount__c);
                    else
                        temp.put('DEMANDED', 0);
                    if(l.Amount__c != null && l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
                        temp.put('STDEMANDED', l.Amount__c);
                    else
                        temp.put('STDEMANDED', 0);
                    rollupMap.put(l.Standard_Customer_Pay_Plan_Detail__c, temp);
                }
            }
        } 
        if(!scppdMap.isEmpty() && scppdMap.size() > 0) {
            for(Standard_Customer_Pay_Plan_Detail__c s: scppdMap.values() ) {
                if(rollUpMap.containsKey(s.Id)) {
                    s.Charge_Amount_Billed__c = rollUpMap.get(s.Id).get('DEMANDED');
                    s.Service_Tax_Amount_Billed__c = rollUpMap.get(s.Id).get('STDEMANDED');
                } else {
                    // the only ledgers  against this SCPPD has been deleted too
                    s.Charge_Amount_Billed__c = 0;
                    s.Service_Tax_Amount_Billed__c = 0;
                    s.Invoice_Raised_Date__c = null;
                    s.Payment_Due_Date__c = null;
                    s.Milestone_Demand_Id__c = null;
                    s.IsSendDemandLetter__c = false;
                }
            }
            System.debug('before SCPPD update :' + rollUpMap);
            System.debug('before SCPPD update :' + scppdMap.values());
            update scppdMap.values();
        }
    }
}