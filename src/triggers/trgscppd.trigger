trigger trgscppd on Standard_Customer_Pay_Plan_Detail__c (after delete, after insert, after undelete, after update) {
    //update the cpph roll ups everytime the scppd record is touched.
    
    Set<Id> cpphSet = new Set<Id>();
    List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
    
    if(Trigger.isUndelete) {
        // identify the cpph list, which is part of the scppd that are inserted/updated/undeleted.
        for(Standard_Customer_Pay_Plan_Detail__c s : Trigger.new) {
            if(s.Customer_Pay_Plan_Header__c != null)
            cpphSet.add(s.Customer_Pay_Plan_Header__c);
        }
        
        if(cpphSet.size() > 0)
                reconcileSCPPD();
    }   
    if(Trigger.isUpdate ) {
        // identify the cpph list, which is part of the scppd that are inserted/updated/undeleted.
        for(Standard_Customer_Pay_Plan_Detail__c s : Trigger.new) {
            if(s.Customer_Pay_Plan_Header__c != null && (s.Charge_Amount_Billed__c >= 0 || s.Charge_Amount_Paid__c >= 0 || s.Service_Tax_Amount_Billed__c >= 0 || s.Service_Tax_Amount_Paid__c >= 0) )
            cpphSet.add(s.Customer_Pay_Plan_Header__c);
        }
        
        if(cpphSet.size() > 0) {
            // dont add recursion check here, it upsets the way the roll up happen when demands are raised
            // if(checkRecursion.isFirstRun()) {
                System.debug('First run: calling update method:');
                if(!test.isRunningTest())
                    reconcileSCPPD();
            // }
        } 
    }
    
    if(Trigger.isDelete) {
        // identify the cpph list, which is part of the scppd that are deleted.
        for(Standard_Customer_Pay_Plan_Detail__c s : Trigger.old) {
            if(s.Customer_Pay_Plan_Header__c != null)
            cpphSet.add(s.Customer_Pay_Plan_Header__c);
        }
        if(checkRecursion.isFirstRunA()) {
            System.debug('First run: calling update method:');
            reconcileSCPPD();
        }
         else
            System.debug('Recursing update: hence not proceeding to update method:');
    }
    
    public static void reconcileSCPPD() {
        Map<Id, Customer_Pay_Plan_Header__c> cpphMap = new Map<Id,Customer_Pay_Plan_Header__c> ([Select Id, Amount_Demanded_Till_Date__c, Amount_Recd_Till_Date__c, 
                                                                    Service_Tax_Demanded_Till_Date__c, Service_Tax_Recd_Till_Date__c
                                                        from  Customer_Pay_Plan_Header__c where id in : cpphSet]);
                                                        
        // then query all the scppd belonging to the cpph. so that we can redo the complete roll ups.
        scppdList = [Select Id, Customer_Pay_Plan_Header__c, Charge_Amount_Billed__c, Charge_Amount_Paid__c, Service_Tax_Amount_Billed__c, Service_Tax_Amount_Paid__c from
                        Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__c in :  cpphMap.keySet()];
        Map<Id, Map<String, Decimal>> rollupMap  = new Map<Id, Map<String, Decimal>>();
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList) {
            if(rollupMap.containsKey(s.Customer_Pay_Plan_Header__c)){
                Map<String, Decimal> temp = rollupMap.get(s.Customer_Pay_Plan_Header__c);
                if(s.Charge_Amount_Billed__c != null)
                    temp.put('DEMANDED', temp.get('DEMANDED') +s.Charge_Amount_Billed__c);
                if(s.Charge_Amount_Paid__c != null) 
                    temp.put('RECEIVED', temp.get('RECEIVED') + s.Charge_Amount_Paid__c);
                if(s.Service_Tax_Amount_Billed__c != null)  
                    temp.put('STDEMANDED',temp.get('STDEMANDED') + s.Service_Tax_Amount_Billed__c);
                if(s.Service_Tax_Amount_Paid__c != null)
                    temp.put('STRECEIVED', temp.get('STRECEIVED') + s.Service_Tax_Amount_Paid__c);
                rollupMap.put(s.Customer_Pay_Plan_Header__c, temp);
            } else {
                Map<String, Decimal> temp = new Map<String, Decimal>();
                if(s.Charge_Amount_Billed__c != null)
                    temp.put('DEMANDED', s.Charge_Amount_Billed__c);
                else
                    temp.put('DEMANDED', 0);
                if(s.Charge_Amount_Paid__c != null)
                    temp.put('RECEIVED', s.Charge_Amount_Paid__c);
                else
                    temp.put('RECEIVED', 0);
                if(s.Service_Tax_Amount_Billed__c != null)
                    temp.put('STDEMANDED', s.Service_Tax_Amount_Billed__c);
                else
                    temp.put('STDEMANDED', 0);
                if(s.Service_Tax_Amount_Paid__c != null)
                    temp.put('STRECEIVED', s.Service_Tax_Amount_Paid__c);
                else
                    temp.put('STRECEIVED', 0);
                rollupMap.put(s.Customer_Pay_Plan_Header__c, temp);
            }
        }
        if(!cpphMap.isEmpty()) {
            for(Customer_Pay_Plan_Header__c c : cpphMap.values()) {
                if(rollUpMap.containsKey(c.Id)) {
                    c.Amount_Demanded_Till_Date__c = rollUpMap.get(c.Id).get('DEMANDED');
                    c.Amount_Recd_Till_Date__c = rollUpMap.get(c.Id).get('RECEIVED');
                    c.Service_Tax_Demanded_Till_Date__c = rollUpMap.get(c.Id).get('STDEMANDED');
                    c.Service_Tax_Recd_Till_Date__c = rollUpMap.get(c.Id).get('STRECEIVED');
                }
                else {
                    // if there are no scppd records
                    c.Amount_Demanded_Till_Date__c = 0;
                    c.Amount_Recd_Till_Date__c = 0;
                    c.Service_Tax_Demanded_Till_Date__c = 0;
                    c.Service_Tax_Recd_Till_Date__c = 0;
                }
            }
            System.debug('before CPPH update :' + rollUpMap);
            System.debug('before CPPH update :' + cpphMap.values());
            update cpphMap.values();
        }
    }
}