trigger trgReceiptDetails on Receipt_Details__c (after delete, after undelete, after update) {
    
    // identify the scppd that are part of the receipt details being updated/undeleted.
    Set<Id> scppdSet = new Set<Id>();
    Map<Id, Map<String, Decimal>> rollupMap  = new Map<Id, Map<String, Decimal>>();
    if(Trigger.isUpdate || Trigger.isUndelete) {
        // identify the scppd list, which is part of the scppd that are updated/undeleted.
        for(Receipt_Details__c rd : Trigger.new) {
            if(!rd.On_Account_Money__c && !rd.Is_Cheque_Dishonour__c && !rd.Is_Interest_Settlement__c && !rd.Is_Interest_Settlement_ST__c && rd.Standard_Customer_Pay_Plan_Detail__c != null) {
                scppdSet.add(rd.Standard_Customer_Pay_Plan_Detail__c);
            }
        }
        reconcileSCPPD();
    }
    
    if(Trigger.isDelete) {
        // identify the scppd list, which is part of the scppd that are deleted.
        for(Receipt_Details__c rd : Trigger.old) {
            if(!rd.On_Account_Money__c && !rd.Is_Cheque_Dishonour__c && !rd.Is_Interest_Settlement__c && !rd.Is_Interest_Settlement_ST__c && rd.Standard_Customer_Pay_Plan_Detail__c != null) {
                scppdSet.add(rd.Standard_Customer_Pay_Plan_Detail__c);
            }
        }
        reconcileSCPPD();
    }
    
    public static void reconcileSCPPD() {
        // requery all the receipt details that are part of the affected SCPPD set.
        List<Receipt_Details__c> rdList = [Select Id, Standard_Customer_Pay_Plan_Detail__c, Amount__c,  For_Service_Tax__c from Receipt_Details__c where 
                                                Standard_Customer_Pay_Plan_Detail__c in : scppdSet and Receipts__r.Receipt_Status__c not in ('Dishonored', 'Physical Verification Rejected')];  
        // then query all the scppd belonging to the scppdSet. so that we can redo the complete roll ups.
        Map<Id,Standard_Customer_Pay_Plan_Detail__c> scppdMap= new Map<Id, Standard_Customer_Pay_Plan_Detail__c>(
                                [Select Id, Customer_Pay_Plan_Header__c, Charge_Amount_Billed__c, Charge_Amount_Paid__c, Service_Tax_Amount_Billed__c, 
                                Service_Tax_Amount_Paid__c from Standard_Customer_Pay_Plan_Detail__c 
                                where Id in :  scppdSet]);
        if(!rdList.isEmpty()) {
            for(Receipt_Details__c rd : rdList) {
                if(rollupMap.containsKey(rd.Standard_Customer_Pay_Plan_Detail__c)){
                        Map<String, Decimal> temp = rollupMap.get(rd.Standard_Customer_Pay_Plan_Detail__c);
                        if(rd.Amount__c != null && !rd.For_Service_Tax__c)
                            temp.put('RECEIVED', temp.get('RECEIVED') +rd.Amount__c);
                        if(rd.Amount__c != null && rd.For_Service_Tax__c)   
                            temp.put('STRECEIVED',temp.get('STRECEIVED') + rd.Amount__c);
                        rollupMap.put(rd.Standard_Customer_Pay_Plan_Detail__c , temp);
                } else {
                    Map<String, Decimal> temp = new Map<String, Decimal>();
                    if(rd.Amount__c != null && !rd.For_Service_Tax__c)
                        temp.put('RECEIVED', rd.Amount__c);
                    else
                        temp.put('RECEIVED', 0);
                    if(rd.Amount__c != null && rd.For_Service_Tax__c)
                        temp.put('STRECEIVED', rd.Amount__c);
                    else
                        temp.put('STRECEIVED', 0);
                    rollupMap.put(rd.Standard_Customer_Pay_Plan_Detail__c, temp);
                }
            }
        }
        if(!scppdMap.isEmpty() && scppdMap.size() > 0) {
            for(Standard_Customer_Pay_Plan_Detail__c s: scppdMap.values() ) {
                if(rollUpMap.containsKey(s.Id)) {
                    s.Charge_Amount_Paid__c = rollUpMap.get(s.Id).get('RECEIVED');
                    s.Service_Tax_Amount_Paid__c = rollUpMap.get(s.Id).get('STRECEIVED');
                }
                else {
                    // the only receipt against this SCPPD has been deleted too
                    s.Charge_Amount_Paid__c = 0;
                    s.Service_Tax_Amount_Paid__c = 0;
                }
            }
            update scppdMap.values();
        }
        
    }
}