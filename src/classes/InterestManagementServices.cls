public with sharing class InterestManagementServices {
    public static void markForInterestCalculation(List<Standard_Customer_Pay_Plan_Detail__c> scppdList) {
       /** List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id, Charge_Amount_Billed__c, Charge_Amount_Due__c,
                                                                Service_Tax_Amount_Due__c,Service_Tax_Amount_Billed__c,
                                                                Customer_Pay_Plan_Header__r.Customer__c,Payment_Due_Date__c,
                                                                Project__c
                                                                from Standard_Customer_Pay_Plan_Detail__c 
                                                                where IsPaymentOverdue__c = true
                                                                and Customer_Pay_Plan_Header__c != null
                                                                and Customer_Pay_Plan_Header__r.Customer__c != null
                                                                and Customer_Pay_Plan_Header__r.Customer__r.Status__C = 'Active'
                                                                and marked_for_interest__c = false]; 
                                                                **/
        List<Interest_Details__c> idList = new List<Interest_Details__c>();
        if(scppdList != null && scppdList.size() > 0) {
            for (Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
                Interest_Details__c id = new Interest_Details__c();
                id.Installment_Amount__c = scppd.Charge_Amount_Due__c;
                id.Service_Tax_Amount__c = scppd.Service_Tax_Amount_Due__c;
                id.Milestone__c = scppd.Id;
                id.Start_Date__c = scppd.Payment_Due_Date__c;
                id.project__c = scppd.project__c;
                id.Customer__c = scppd.Customer_Pay_Plan_Header__r.Customer__c;
                id.sequence__c = 1;
                scppd.marked_for_interest__c = true;
                
                idList.add(id);
            }
        }
        insert idList;
        update scppdList;
    }
    
    public static void newInterestDetails(List<Receipt_Details__c> rdList) {
        List<interest_details__c> iList = new List<Interest_details__c>();
        Set<Id> scppdIdSet = new Set<Id>();
        Map<Id,Id> rsMap = new Map<Id,Id>();
        Map<Id, Integer> scppdSeqMap = new Map<Id,Integer>();  // to keep track of the latest seq # excluding the EFT delayed interest records
        Map<Id, Integer> scppdSeqMap1 = new Map<Id,Integer>(); // to keep track of the highest sequence # inclusive of all interest records
        for(Receipt_Details__c rd :rdList) {
            if(!rd.Is_interest_settlement_ST__c && !rd.Is_interest_settlement__c && !rd.is_cheque_dishonour__c) {
                scppdIdSet.add(rd.Standard_Customer_Pay_Plan_detail__c);
                rsMap.put(rd.Standard_Customer_Pay_Plan_detail__r.Id, rd.receipts__r.Id);
            }
                
        }
        iList = [Select Id , End_Date__c, Milestone__r.Id, Sequence__c,EFT_delayed__c from Interest_Details__c where Milestone__c in :scppdIdSet];
        if(iList.size() > 0) {
            for(Interest_details__c i : iList) {
                
                if(scppdSeqMap.containsKey(i.milestone__r.Id) && scppdSeqMap.get(i.milestone__r.Id) < integer.valueOf(i.Sequence__c) && !(i.EFT_delayed__c))
                    scppdSeqMap.put(i.Milestone__r.Id, Integer.valueOf(i.Sequence__c));
                else if(!scppdSeqMap.containsKey(i.milestone__r.Id))
                    scppdSeqMap.put(i.Milestone__r.Id, Integer.valueOf(i.Sequence__c));
                
                if(scppdSeqMap1.containsKey(i.milestone__r.Id) && scppdSeqMap1.get(i.milestone__r.Id) < integer.valueOf(i.Sequence__c))
                    scppdSeqMap1.put(i.Milestone__r.Id, Integer.valueOf(i.Sequence__c));
                else if(!scppdSeqMap1.containsKey(i.milestone__r.Id))
                    scppdSeqMap1.put(i.Milestone__r.Id, Integer.valueOf(i.Sequence__c));
            }
            for(Interest_details__c i : iList) {
                // identify the last interest record for that milestone, 
                // using the milestone to sequence map and set the end date of the last record to today's date
                if(i.sequence__c ==scppdSeqMap.get(i.Milestone__r.Id)) {
                    i.end_date__c = system.today();
                }
            }
            update iList;
        }
        
        List<Standard_Customer_Pay_Plan_Detail__c> scppdNewList = [Select Id, Charge_Amount_Billed__c, Charge_Amount_Due__c,
                                                                Service_Tax_Amount_Due__c,Service_Tax_Amount_Billed__c,
                                                                Customer_Pay_Plan_Header__r.Customer__c,
                                                                Project__c
                                                                from Standard_Customer_Pay_Plan_Detail__c 
                                                                where IsPaymentOverdue__c = true
                                                                and Id in :scppdIdSet];
        List<Interest_Details__c> idList = new List<Interest_Details__c>();
        // create the new interest outstanding records for the scppds provided there are still some amount due 
        // either in the installment or service tax
        if(scppdNewList != null && scppdNewList.size() > 0) {
            for (Standard_Customer_Pay_Plan_Detail__c scppd : scppdNewList) {
                if(scppd.Charge_Amount_Due__c > 0 || scppd.Service_Tax_Amount_Due__c > 0) {
                    Interest_Details__c id = new Interest_Details__c();
                    id.Installment_Amount__c = scppd.Charge_Amount_Due__c;
                    id.Service_Tax_Amount__c = scppd.Service_Tax_Amount_Due__c;
                    id.Milestone__c = scppd.Id;
                    id.Start_Date__c = System.today();
                    id.project__c = scppd.project__c;
                    id.Customer__c = scppd.Customer_Pay_Plan_Header__r.Customer__c;
                    id.Receipt__c = rsMap.get(scppd.Id);
                    if(scppdSeqMap1.containsKey(scppd.Id) )
                        id.Sequence__c = scppdSeqMap1.get(scppd.Id) + 1;
                    else
                        id.Sequence__c =1;
                    idList.add(id);
                }
            }
        }
        insert idList;      
    }
    
    public static void calculateInterest(List<Interest_Details__c> idList) {
      /**  List<Interest_Details__c> idList = new List<Interest_Details__c>();
        idList = [Select Id, Name, Installment_Amount__c, Service_Tax_Amount__c, Milestone__c, project__r.RDS_Interest_Rate__c, 
                        Aging_System__c, Corrected_Age__c from Interest_Details__c where active__C = true];
                **/        
        Map<Id, Map<String,Decimal>> scppdIMap = new Map<Id, Map<String,Decimal>>();
        integer age = 0;
        if(idList != null && idList.size() > 0) {
            for(Interest_Details__c id : idList) {
                if(id.corrected_age__c != null && id.corrected_age__c > 0) {
                    age = Integer.valueOf(id.corrected_age__c);
                } else {
                    age = Integer.valueOf(id.Aging_System__c);
                }
                if(id.Installment_Amount__c > 0) {
                    id.Interest_On_Flatcost__c = (id.Installment_Amount__c * age * id.Project__r.RDS_Interest_Rate__c/36500).setscale(0, RoundingMode.HALF_UP); 
                } else {
                    id.Interest_On_Flatcost__c = 0;
                }
                if(id.Service_Tax_Amount__c > 0) {
                    id.Interest_On_Servicetax__c = (id.Service_Tax_Amount__c * age* id.Project__r.RDS_Interest_Rate__c/36500).setscale(0,RoundingMode.HALF_UP); 
                }   else {
                    id.Interest_On_Servicetax__c = 0;
                }
                // for each milestone record we want to create a map like 
                //                                      < scppdId, 
                //                                      <FLATCOST, TotalInterestAmount> 
                //                                      <SERVICETAX, TotalServiceTax> >
                if(scppdIMap.containsKey(id.Milestone__c)) {
                    if(scppdIMap.get(id.Milestone__c).containsKey('FLATCOST')) {
                        scppdIMap.get(id.Milestone__c).put(('FLATCOST') , scppdIMap.get(id.Milestone__c).get('FLATCOST') + id.Interest_On_Flatcost__c);
                    } else {
                        scppdIMap.get(id.Milestone__c).put('FLATCOST', id.Interest_On_Flatcost__c);
                    }
                    if(scppdIMap.get(id.Milestone__c).containsKey('SERVICETAX')) {
                        scppdIMap.get(id.Milestone__c).put(('SERVICETAX') ,scppdIMap.get(id.Milestone__c).get('SERVICETAX') + id.Interest_On_Servicetax__c);
                    } else {
                        scppdIMap.get(id.Milestone__c).put('SERVICETAX', id.Interest_On_Servicetax__c);
                    }
                } else {
                    Map<String,Decimal> tempMap = new Map<String,Decimal>();
                    tempMap.put('FLATCOST', id.Interest_On_Flatcost__c);
                    tempMap.put('SERVICETAX', id.Interest_On_Servicetax__c);
                    scppdIMap.put(id.Milestone__c, tempMap);
                }       
            }
            age = 0;
        }
        update idList;
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id,Customer_Pay_Plan_Header__r.Id,
                                                                Customer_Pay_Plan_Header__c,Customer_Pay_Plan_Header__r.Customer__c,
                                                                Int_Flatcost_Total__c, Int_Servicetax_Total__c,
                                                                Standard_Pay_Plan_Header__c, 
                                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Name 
                                                                from Standard_Customer_Pay_Plan_Detail__c 
                                                                where Id in :scppdIMap.keySet() and dont_override__c = false];
        for(Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
            scppd.Int_Flatcost_Total__c = scppdIMap.get(scppd.Id).get('FLATCOST');
            scppd.Int_Servicetax_Total__c = scppdIMap.get(scppd.Id).get('SERVICETAX');
        }
        if(scppdList != null && scppdList.size() > 0 )
            update scppdList;
        Map<Id, Map<String, Decimal> > cpphScppdMap = new Map<Id, Map<String,Decimal> >();
        
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList) {
            if(cpphScppdMap.containsKey(s.Customer_Pay_Plan_Header__r.Id)) {
                    if(cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).containsKey('FLATCOST')) {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put(('FLATCOST') , cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).get('FLATCOST') + s.Int_Flatcost_Total__c);
                    } else {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put('FLATCOST', s.Int_Flatcost_Total__c);
                    }
                    if(cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).containsKey('SERVICETAX')) {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put(('SERVICETAX') ,cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).get('SERVICETAX') + s.Int_Servicetax_Total__c);
                    } else {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put('SERVICETAX', s.Int_Servicetax_Total__c);
                    }
                } else {
                    Map<String,Decimal> tempMap = new Map<String,Decimal>();
                    tempMap.put('FLATCOST', s.Int_Flatcost_Total__c);
                    tempMap.put('SERVICETAX', s.Int_Servicetax_Total__c);
                    cpphScppdMap.put(s.Customer_Pay_Plan_Header__r.Id, tempMap);
                }
        }
        
        List<Ledger__c> lList = new List<Ledger__c>();
        lList =  [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, 
                        Global_Charges__c,Global_Charges__r.Name,
                        Standard_Customer_Pay_Plan_Detail__c,
                        Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                        Customer_Pay_Plan_Header__c
                        from Ledger__c where Standard_Customer_Pay_Plan_Detail__c in :scppdList
                        and Ledger_Type__c = 'Interest' 
                        and Debit_Credit__c = 'Debit'];
                        
        Map<String, Ledger__c> scppdLedgerMap = new Map<String, Ledger__c>();
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        for(Ledger__c l : lList) {
            scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id+'-'+l.Global_Charges__r.Name , l);
        }
        
        Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Interest Installment'];
        Global_Charges__c gST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax'];
        
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList) {
            if(scppdLedgerMap.containsKey(s.Id+'-Interest Installment')) {
                scppdLedgerMap.get(s.Id+'-Interest Installment').Amount__c = s.Int_flatcost_total__c;
                lstLedgerToUpsert.add(scppdLedgerMap.get(s.Id+'-Interest Installment'));
            } else {
                // create a new ledger entry for that mile stone interest value flatcost
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= s.Customer_Pay_Plan_Header__r.Customer__c;
                objLedger.Standard_Customer_Pay_Plan_Detail__c= s.Id;
                if(s.Customer_Pay_Plan_Header__c != null) 
                        objLedger.Customer_Pay_Plan_Header__c = s.Customer_Pay_Plan_Header__c;
                objLedger.Global_Charges__c = g.Id ;
                if(s.Standard_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on flatcost due for: ' + s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                objLedger.Debit_Credit__c='Debit';
                objLedger.Ledger_Type__c = 'Interest';
                objLedger.Amount__c = s.Int_flatcost_total__c;
                objLedger.Transaction_Date__c= system.today() ;
                objLedger.Is_ledger_created_through_trigger__c = true;
                lstLedgerToUpsert.add(objLedger);
            }
            if(scppdLedgerMap.containsKey(s.Id+'-Interest Servicetax')) {
                scppdLedgerMap.get(s.Id+'-Interest Servicetax').Amount__c = s.Int_servicetax_total__c;
                lstLedgerToUpsert.add(scppdLedgerMap.get(s.Id+'-Interest Servicetax'));
            } else {
                // create a new ledger entry for that mile stone interest value on servicetax
                // create a new ledger entry for that mile stone interest value flatcost
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= s.Customer_Pay_Plan_Header__r.Customer__c;
                objLedger.Standard_Customer_Pay_Plan_Detail__c= s.Id;
                if(s.Customer_Pay_Plan_Header__c != null) 
                   objLedger.Customer_Pay_Plan_Header__c = s.Customer_Pay_Plan_Header__c;
                objLedger.Global_Charges__c = gst.Id ;
                if(s.Standard_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on Servicetax due for: ' + s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                objLedger.Debit_Credit__c='Debit';
                objLedger.Ledger_Type__c = 'Interest';
                objLedger.Amount__c = s.Int_servicetax_total__c;
                objLedger.Transaction_Date__c= system.today() ;
                objLedger.Is_ledger_created_through_trigger__c = true;
                lstLedgerToUpsert.add(objLedger);
            }
        }
        if(lstLedgerToUpsert != null && lstLedgerToUpsert.size() >0 )
            upsert lstLedgerToUpsert;
        List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
                                                                    Service_Tax_Recd_Till_Date__c, 
                                                                    Int_Flatcost_Due__c, Int_Servicetax_Due__c,
                                                                    Int_flatcost_Paid_Till_Date__c, Int_flatcost_Waived_Till_Date__c,
                                                                    Int_servicetax_waived_till_date__c, Int_servicetax_paid_till_date__c
                                                                    from 
                                                                    Customer_Pay_Plan_Header__c where Id in :cpphScppdMap.keyset()]; 
        if(cpphList != null && cpphList.size() > 0)  {
            for(Customer_Pay_Plan_Header__c cpph : cpphList) {
                cpph.Int_Flatcost_Due__c = cpphScppdMap.get(cpph.Id).get('FLATCOST');
                cpph.Int_Servicetax_Due__c = cpphScppdMap.get(cpph.Id).get('SERVICETAX');
            }
            update cpphList;
        }
    }
    
    public static void reverseInterestDetails(Id receiptId){
        List<Interest_Details__c> idList = [Select Id, Name, Active__c, Sequence__c from Interest_Details__c where receipt__c = :receiptId order by Sequence__c desc];
        
        // make the interest records belonging to these receipts inactive. 
        if(idList != null && idList.size() > 0) {
            for(Interest_details__c i : idList) {
                i.Active__c = false;
                i.end_date__c = System.today();
            }
            update idList;
        }
        List<Receipt_Details__c> detailsList = new List<Receipt_Details__c>();
        detailsList = [Select Id, Name, Amount__c , For_Service_Tax__c , Standard_Customer_Pay_Plan_Detail__r.Id, createdDate,Project__c,Receipts__r.Opportunity__r.Id, receipts__r.Cheque_DD__c
                                                                from Receipt_Details__c where Receipts__r.Id = :receiptId 
                                                                and Is_Cheque_Dishonour__c = false 
                                                                and Is_Interest_Settlement_ST__c = false
                                                                and Is_Interest_Settlement__c = false];
        Set<Id> scppdSet = new Set<Id>();
        for(Receipt_Details__c r : detailsList) {
            scppdSet.add(r.Standard_Customer_Pay_Plan_Detail__r.Id);
        }
        // get all interest records belonging to the milestones against which the specific receipt was apportioned
        List<Interest_Details__c> idList1 = [Select Id, Name, Start_Date__c, End_Date__c , Sequence__c, Milestone__c from Interest_Details__c where milestone__c in : scppdSet];
        
        Map<Id,Interest_Details__c> miMap = new Map<Id,Interest_Details__c>();
        Map<Id,Decimal> miSeqMap = new Map<Id,Decimal>();
        //this will give the last interest entry for each milestone.
        if(idList != null && idList.size() >0) {
            for(Interest_Details__c i : idList1) {
                if(miMap.containsKey(i.Milestone__c) && miMap.get(i.Milestone__c).sequence__c < i.sequence__c) {
                    miMap.put(i.Milestone__c, i);
                    miSeqMap.put(i.Milestone__c, i.sequence__c);
                } else if(!miMap.containsKey(i.Milestone__c)) {
                    miMap.put(i.Milestone__c, i);
                    miSeqMap.put(i.Milestone__c, i.sequence__c);
                }
            }
        }
        
        // make the last interest record for these milestone close by setting the end date.
        List<Interest_Details__c> iUpdateList = new List<Interest_Details__c>();
        if(miMap.size() > 0) {
            for(Interest_Details__c i  : miMap.values()){
                i.End_Date__c = System.today();
                iUpdateList.add(i);
            }
            update iUpdateList;
        }
        
        // make an interest record entry for each receipt detail amount to calculate the difference in interest that should have been accrued due to cheque bounce.                                                     
        List<Interest_Details__c> idListInsert = new List<Interest_Details__c>();                                                       
        if(detailsList.size() > 0) {
            for(Receipt_Details__c r : detailsList){
                Interest_Details__c id = new Interest_Details__c();
                if(!r.For_Service_Tax__c) {
                    id.Installment_Amount__c = r.Amount__c;
                    id.Service_Tax_Amount__c = 0;
                }
                else {  
                    id.Service_Tax_Amount__c = r.Amount__c;
                    id.Installment_Amount__c = 0;
                }
                id.Milestone__c = r.Standard_Customer_Pay_Plan_Detail__r.Id;
                id.Start_Date__c = Date.valueOf(r.createdDate); // will give the date of apportionment
                id.project__c = r.Project__c;
                id.Customer__c = r.Receipts__r.Opportunity__r.Id;
                id.End_Date__c = System.today(); // from date of apportionment to today we have been calculating less interest of receipt detail amount. Now we need to add it back
                id.sequence__c = miSeqMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id) + 1;
                id.receipt_details__c = r.Id;
                id.remarks__c = 'Interest entry added due to cheque bounce:' + r.receipts__r.Cheque_DD__c; 
                idListInsert.add(id);
                miSeqMap.put(r.Standard_Customer_Pay_Plan_Detail__r.Id, miSeqMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id) + 1);
            }
            insert idListInsert;
        }
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
        scppdList = [Select Id, Charge_Amount_Billed__c, Charge_Amount_Due__c,
                                                                Service_Tax_Amount_Due__c,Service_Tax_Amount_Billed__c,
                                                                Customer_Pay_Plan_Header__r.Customer__c,
                                                                Project__c
                                                                from Standard_Customer_Pay_Plan_Detail__c 
                                                                where IsPaymentOverdue__c = true
                                                                and Id in :scppdSet];
                                                                
        List<Interest_Details__c> idList3 = new List<Interest_Details__c>();
        if(scppdList != null && scppdList.size() > 0) {
            for (Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
                Interest_Details__c id = new Interest_Details__c();
                id.Installment_Amount__c = scppd.Charge_Amount_Due__c;
                id.Service_Tax_Amount__c = scppd.Service_Tax_Amount_Due__c;
                id.Milestone__c = scppd.Id;
                id.Start_Date__c = System.today();
                id.project__c = scppd.project__c;
                id.Customer__c = scppd.Customer_Pay_Plan_Header__r.Customer__c;
                id.sequence__c = miSeqMap.get(scppd.Id) + 1; // the previous record would have made it +1 hence making it +2 here.
                id.remarks__c = 'Creating a new entry for this milestone post the cheque bounce';
                idList3.add(id);
            }
        }
        insert idList3;
        recalculateInterest(scppdSet);
    }
    
    /** deduct interest amount for X number of days based on the delay in transaction entry into SFDC for EFT receipts
    /** In case of Electronic funds transfer, the funds would have come into the accounts many days prior to when its actually
    /** entered in SFDC. to account for this, whenever these receipts are apportioned we look for the date of EFT and
    /** deduct interest worth so many days from the account  **/
    public static void deductInterestForEFT(List<Id> receiptDetailIds){
        List<Receipt_Details__c> detailsList = new List<Receipt_Details__c>();
        detailsList = [Select Id, Name, Amount__c , For_Service_Tax__c , Standard_Customer_Pay_Plan_Detail__r.Id, createdDate,Receipts__r.Cheque_DD_Date__c,Project__c,Receipts__r.Opportunity__r.Id, receipts__r.Cheque_DD__c
                                                                from Receipt_Details__c where Id in :receiptDetailIds 
                                                                and Is_Cheque_Dishonour__c = false 
                                                                and Is_Interest_Settlement_ST__c = false
                                                                and Is_Interest_Settlement__c = false];
        
        Set<Id> scppdSet = new Set<Id>();
        for(Receipt_Details__c r : detailsList) {
            scppdSet.add(r.Standard_Customer_Pay_Plan_Detail__r.Id);
        }
        // get all interest records belonging to the milestones against which the specific receipt was apportioned
        List<Interest_Details__c> idList1 = [Select Id, Name, Start_Date__c, End_Date__c , Sequence__c, Milestone__c from Interest_Details__c where milestone__c in : scppdSet];
        
        Map<Id,Interest_Details__c> miMap = new Map<Id,Interest_Details__c>();
        Map<Id,Decimal> miSeqMap = new Map<Id,Decimal>();
        //this will give the last interest entry for each milestone.
        if(idList1 != null && idList1.size() >0) {
            for(Interest_Details__c i : idList1) {
                if(miMap.containsKey(i.Milestone__c) && miMap.get(i.Milestone__c).sequence__c < i.sequence__c) {
                    miMap.put(i.Milestone__c, i);
                    miSeqMap.put(i.Milestone__c, i.sequence__c);
                } else if(!miMap.containsKey(i.Milestone__c)) {
                    miMap.put(i.Milestone__c, i);
                    miSeqMap.put(i.Milestone__c, i.sequence__c);
                }
            }
        }
            
        // make an interest record entry for each receipt detail amount to calculate the difference in interest that should have been deducted due to the EFT delayed posting       
        // do this if that milestone has any interest record which has an outstanding                                               
        List<Interest_Details__c> idListInsert = new List<Interest_Details__c>();                                                       
        if(detailsList.size() > 0 && (idList1 != null && idList1.size() >0 )) {
            for(Receipt_Details__c r : detailsList){
                Interest_Details__c id = new Interest_Details__c();
                if(!r.For_Service_Tax__c) {
                    id.Installment_Amount__c = r.Amount__c;
                    id.Service_Tax_Amount__c = 0;
                }
                else {  
                    id.Service_Tax_Amount__c = r.Amount__c;
                    id.Installment_Amount__c = 0;
                }
                id.Milestone__c = r.Standard_Customer_Pay_Plan_Detail__r.Id;
                if(Date.valueOf(r.receipts__r.Cheque_DD_Date__c) < miMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id).start_date__c)
                    id.End_Date__c = miMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id).start_date__c; // if the date of EFT is much earlier than when the interest became outstanding then take the start date as when the latest amount became outstanding
                else
                    id.End_Date__c = Date.valueOf(r.receipts__r.Cheque_DD_Date__c);
                id.project__c = r.Project__c;
                id.Customer__c = r.Receipts__r.Opportunity__r.Id;
                id.Start_Date__c = System.today(); // Due to delayed apportionment we have calculating extra interest, now we make an -ve entry to reduce the excess interest amount
                id.sequence__c = miSeqMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id) + 1;
                id.receipt_details__c = r.Id;
                id.remarks__c = 'Interest entry added due to delayed EFT apportionment:' + r.receipts__r.Cheque_DD__c; 
                id.EFT_delayed__c = true;
                idListInsert.add(id);
                miSeqMap.put(r.Standard_Customer_Pay_Plan_Detail__r.Id, miSeqMap.get(r.Standard_Customer_Pay_Plan_Detail__r.Id) + 1);
            }
            insert idListInsert;
            recalculateInterest(scppdSet);
        }
        
    }
    
    public static void recalculateInterest (Set<Id> scppdSet) {
        List<Interest_Details__c> idList = new List<Interest_Details__c>();
        idList = [Select Id, Name, Installment_Amount__c, Service_Tax_Amount__c, Milestone__c, project__r.RDS_Interest_Rate__c, 
                        Aging_System__c, Corrected_Age__c from Interest_Details__c where active__c = true and Milestone__c in :scppdSet];
                        
        Map<Id, Map<String,Decimal>> scppdIMap = new Map<Id, Map<String,Decimal>>();
        integer age = 0;
        if(idList != null && idList.size() > 0) {
            for(Interest_Details__c id : idList) {
                if(id.corrected_age__c != null && id.corrected_age__c > 0) {
                    age = Integer.valueOf(id.corrected_age__c);
                } else {
                    age = Integer.valueOf(id.Aging_System__c);
                }
                if(id.Installment_Amount__c > 0) {
                    id.Interest_On_Flatcost__c = (id.Installment_Amount__c * age * id.Project__r.RDS_Interest_Rate__c/36500).setscale(0, RoundingMode.HALF_UP); 
                } else {
                    id.Interest_On_Flatcost__c = 0;
                }
                if(id.Service_Tax_Amount__c > 0) {
                    id.Interest_On_Servicetax__c = (id.Service_Tax_Amount__c * age* id.Project__r.RDS_Interest_Rate__c/36500).setscale(0,RoundingMode.HALF_UP); 
                }   else {
                    id.Interest_On_Servicetax__c = 0;
                }
                // for each milestone record we want to create a map like 
                //                                      < scppdId, 
                //                                      <FLATCOST, TotalInterestAmount> 
                //                                      <SERVICETAX, TotalServiceTax> >
                if(scppdIMap.containsKey(id.Milestone__c)) {
                    if(scppdIMap.get(id.Milestone__c).containsKey('FLATCOST')) {
                        scppdIMap.get(id.Milestone__c).put(('FLATCOST') , scppdIMap.get(id.Milestone__c).get('FLATCOST') + id.Interest_On_Flatcost__c);
                    } else {
                        scppdIMap.get(id.Milestone__c).put('FLATCOST', id.Interest_On_Flatcost__c);
                    }
                    if(scppdIMap.get(id.Milestone__c).containsKey('SERVICETAX')) {
                        scppdIMap.get(id.Milestone__c).put(('SERVICETAX') ,scppdIMap.get(id.Milestone__c).get('SERVICETAX') + id.Interest_On_Servicetax__c);
                    } else {
                        scppdIMap.get(id.Milestone__c).put('SERVICETAX', id.Interest_On_Servicetax__c);
                    }
                } else {
                    Map<String,Decimal> tempMap = new Map<String,Decimal>();
                    tempMap.put('FLATCOST', id.Interest_On_Flatcost__c);
                    tempMap.put('SERVICETAX', id.Interest_On_Servicetax__c);
                    scppdIMap.put(id.Milestone__c, tempMap);
                }       
            }
            age = 0;
        }
        update idList;
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id,Customer_Pay_Plan_Header__r.Id,
                                                                Customer_Pay_Plan_Header__c,Customer_Pay_Plan_Header__r.Customer__c,
                                                                Int_Flatcost_Total__c, Int_Servicetax_Total__c,
                                                                Standard_Pay_Plan_Header__c, 
                                                                Standard_Pay_Plan_Header__r.Charge_Code__r.Name 
                                                                from Standard_Customer_Pay_Plan_Detail__c 
                                                                where Id in :scppdIMap.keySet() and dont_override__c = false];
        for(Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
            scppd.Int_Flatcost_Total__c = scppdIMap.get(scppd.Id).get('FLATCOST');
            scppd.Int_Servicetax_Total__c = scppdIMap.get(scppd.Id).get('SERVICETAX');
        }
        if(scppdList != null && scppdList.size() > 0 )
            update scppdList;
        Map<Id, Map<String, Decimal> > cpphScppdMap = new Map<Id, Map<String,Decimal> >();
        
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList) {
            if(cpphScppdMap.containsKey(s.Customer_Pay_Plan_Header__r.Id)) {
                    if(cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).containsKey('FLATCOST')) {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put(('FLATCOST') , cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).get('FLATCOST') + s.Int_Flatcost_Total__c);
                    } else {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put('FLATCOST', s.Int_Flatcost_Total__c);
                    }
                    if(cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).containsKey('SERVICETAX')) {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put(('SERVICETAX') ,cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).get('SERVICETAX') + s.Int_Servicetax_Total__c);
                    } else {
                        cpphScppdMap.get(s.Customer_Pay_Plan_Header__r.Id).put('SERVICETAX', s.Int_Servicetax_Total__c);
                    }
                } else {
                    Map<String,Decimal> tempMap = new Map<String,Decimal>();
                    tempMap.put('FLATCOST', s.Int_Flatcost_Total__c);
                    tempMap.put('SERVICETAX', s.Int_Servicetax_Total__c);
                    cpphScppdMap.put(s.Customer_Pay_Plan_Header__r.Id, tempMap);
                }
        }
        
        List<Ledger__c> lList = new List<Ledger__c>();
        lList =  [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, 
                        Global_Charges__c,Global_Charges__r.Name,
                        Standard_Customer_Pay_Plan_Detail__c,
                        Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,
                        Customer_Pay_Plan_Header__c
                        from Ledger__c where Standard_Customer_Pay_Plan_Detail__c in :scppdList];
                        
        Map<String, Ledger__c> scppdLedgerMap = new Map<String, Ledger__c>();
        List<Ledger__c> lstLedgerToUpsert = new List<Ledger__c>();
        for(Ledger__c l : lList) {
            scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id+'-'+l.Global_Charges__r.Name , l);
        }
        
        Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Interest Installment'];
        Global_Charges__c gST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax'];
        
        for(Standard_Customer_Pay_Plan_Detail__c s : scppdList) {
            if(scppdLedgerMap.containsKey(s.Id+'-Interest Installment')) {
                scppdLedgerMap.get(s.Id+'-Interest Installment').Amount__c = s.Int_flatcost_total__c;
                lstLedgerToUpsert.add(scppdLedgerMap.get(s.Id+'-Interest Installment'));
            } else {
                // create a new ledger entry for that mile stone interest value flatcost
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= s.Customer_Pay_Plan_Header__r.Customer__c;
                objLedger.Standard_Customer_Pay_Plan_Detail__c= s.Id;
                if(s.Customer_Pay_Plan_Header__c != null) 
                        objLedger.Customer_Pay_Plan_Header__c = s.Customer_Pay_Plan_Header__c;
                objLedger.Global_Charges__c = g.Id ;
                if(s.Standard_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on flatcost due for: ' + s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                objLedger.Debit_Credit__c='Debit';
                objLedger.Ledger_Type__c = 'Interest';
                objLedger.Amount__c = s.Int_flatcost_total__c;
                objLedger.Transaction_Date__c= system.today() ;
                objLedger.Is_ledger_created_through_trigger__c = true;
                lstLedgerToUpsert.add(objLedger);
            }
            if(scppdLedgerMap.containsKey(s.Id+'-Interest Servicetax')) {
                scppdLedgerMap.get(s.Id+'-Interest Servicetax').Amount__c = s.Int_servicetax_total__c;
                lstLedgerToUpsert.add(scppdLedgerMap.get(s.Id+'-Interest Servicetax'));
            } else {
                // create a new ledger entry for that mile stone interest value on servicetax
                // create a new ledger entry for that mile stone interest value flatcost
                Ledger__c objLedger;
                objLedger = new Ledger__c();
                objLedger.Opportunity__c= s.Customer_Pay_Plan_Header__r.Customer__c;
                objLedger.Standard_Customer_Pay_Plan_Detail__c= s.Id;
                if(s.Customer_Pay_Plan_Header__c != null) 
                   objLedger.Customer_Pay_Plan_Header__c = s.Customer_Pay_Plan_Header__c;
                objLedger.Global_Charges__c = gst.Id ;
                if(s.Standard_Pay_Plan_Header__c != null)
                    objLedger.Remarks__c = 'Interest on Servicetax due for: ' + s.Standard_Pay_Plan_Header__r.Charge_Code__r.Name;
                objLedger.Debit_Credit__c='Debit';
                objLedger.Ledger_Type__c = 'Interest';
                objLedger.Amount__c = s.Int_servicetax_total__c;
                objLedger.Transaction_Date__c= system.today() ;
                objLedger.Is_ledger_created_through_trigger__c = true;
                lstLedgerToUpsert.add(objLedger);
            }
        }
        if(lstLedgerToUpsert != null && lstLedgerToUpsert.size() >0 )
            upsert lstLedgerToUpsert;
        List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
                                                                    Service_Tax_Recd_Till_Date__c, 
                                                                    Int_Flatcost_Due__c, Int_Servicetax_Due__c,
                                                                    Int_flatcost_Paid_Till_Date__c, Int_flatcost_Waived_Till_Date__c,
                                                                    Int_servicetax_waived_till_date__c, Int_servicetax_paid_till_date__c
                                                                    from 
                                                                    Customer_Pay_Plan_Header__c where Id in :cpphScppdMap.keyset()]; 
        if(cpphList != null && cpphList.size() > 0)  {
            for(Customer_Pay_Plan_Header__c cpph : cpphList) {
                cpph.Int_Flatcost_Due__c = cpphScppdMap.get(cpph.Id).get('FLATCOST');
                cpph.Int_Servicetax_Due__c = cpphScppdMap.get(cpph.Id).get('SERVICETAX');
            }
            update cpphList;
        }
        
    }
}