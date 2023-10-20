public with sharing class PaymentManagementServices {
    public static List<Standard_Customer_Pay_Plan_Detail__c> getMileStonesToBeAdjusted(Id uId, Id cId) {
        System.debug('UnitId:CustomerId' + uId +':' +cId);
        List<Standard_Customer_Pay_Plan_Detail__c> pdList = [Select Id, Installment_Number__c, Is_to_be_Paid__c, Is_to_be__c,Days_Months__c,Days_Months_Value__c,
                                                            Project_Construction_Stages__r.Name,Project_Construction_Stages__c,
                                                            Project__r.Id, Project__c, Tower__c, Installment__c, Due_Date__c,Value__c,Amount__c,Amount_Value__c, 
                                                            Calculate_Installment_Amount_as__c,Total_Charge_Value_Minus__c,
                                                            Standard_Pay_Plan_Header__r.Name, Standard_Pay_Plan_Header__r.Payment_Plan__r.Name, 
                                                            Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                            Charge_Amount_Due__c,Service_Tax_Amount_Due__c,
                                                            Charge_Amount_Paid__c, Service_Tax_Amount_Paid__c,
                                                            Customer_Pay_Plan_Header__c,Customer_Pay_Plan_Header__r.Id,
                                                            Charge_Amount_Advance_Recd__c, Service_Tax_Amount_Advance_Recd__c,
                                                            Charge_Amount_Billed__c, Milestone_Demand_Id__c,Advance_Demand_Id__c,
                                                            Int_Flatcost_Paid__c, Int_Flatcost_Pending__c, Int_Flatcost_Waived__c, 
                                                            Int_ServiceTax_Paid__c, Int_ServiceTax_Pending__c, Int_ServiceTax_Waived__c
                                                            from  
                                                            Standard_Customer_Pay_Plan_Detail__c where 
                                                            Customer_Pay_Plan_Header__c != null
                                                            // and IsSendDemandLetter__c = true
                                                            and Customer_Pay_Plan_Header__r.Customer__c =:cId
                                                            and Customer_Pay_Plan_Header__r.Booking__c != null
                                                            and Customer_Pay_Plan_Header__r.Project_Unit__c = :uId 
                                                            and (Charge_Amount_Due__c > 0 or Service_Tax_Amount_Due__c > 0 or Int_Flatcost_pending__c > 0 or Int_Servicetax_pending__c > 0)
                                                            ORDER BY Due_Date__c asc  NULLS last, createdDate asc, Integer_Installment_No__c asc];
        System.debug('Dues:' + pdList);                                                 
        return pdList;
    }
    
    public static List<Standard_Customer_Pay_Plan_Detail__c> getUpcomingToBeAdjusted(Id uId, Id cId) {
        System.debug('UnitId:CustomerId' + uId +':' +cId);
        List<Standard_Customer_Pay_Plan_Detail__c> pdList = [Select Id, Installment_Number__c, Is_to_be_Paid__c, Is_to_be__c,Days_Months__c,Days_Months_Value__c,
                                                            Project_Construction_Stages__r.Name,Project_Construction_Stages__c,Milestone_Demand_Id__c,
                                                            Project__r.Id, Project__c, Tower__c, Installment__c, Due_Date__c,Value__c,Amount__c,Amount_Value__c, 
                                                            Calculate_Installment_Amount_as__c,Total_Charge_Value_Minus__c,
                                                            Standard_Pay_Plan_Header__r.Name, Standard_Pay_Plan_Header__r.Payment_Plan__r.Name, 
                                                            Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                            Charge_Amount_Due__c,Service_Tax_Amount_Due__c,
                                                            Charge_Amount_Paid__c, Service_Tax_Amount_Paid__c,
                                                            Customer_Pay_Plan_Header__c,Customer_Pay_Plan_Header__r.Id,
                                                            Charge_Amount_Advance_Recd__c, Service_Tax_Amount_Advance_Recd__c,
                                                            Charge_Amount_Billed__c, Advance_Demand_Id__c
                                                            from  
                                                            Standard_Customer_Pay_Plan_Detail__c where 
                                                            Customer_Pay_Plan_Header__c != null
                                                            and Customer_Pay_Plan_Header__r.Customer__c =:cId
                                                            and Customer_Pay_Plan_Header__r.Project_Unit__c = :uId 
                                                            and (Installment__c > 0)
                                                            and (Charge_Amount_Due__c = 0 and Service_Tax_Amount_Due__c =0)
                                                            and isSendDemandLetter__c = false
                                                            and Standard_Pay_Plan_Header__r.Charge_Code__r.S_Payable_At__c != 'At Registration'
                                                            and Customer_Pay_Plan_Header__r.Booking__c != null
                                                            ORDER BY Due_Date__c asc NULLS last,  createdDate asc, Standard_Pay_Plan_Header__r.Charge_Code__r.Name asc,Integer_Installment_No__c asc NULLS last];
        System.debug('Upcoming:' + pdList);
        return pdList;
    }
    public static Boolean accountHasDues(Id uId, Id cId) {
        System.debug('UnitId:CustomerId' + uId +':' +cId);
        List<Standard_Customer_Pay_Plan_Detail__c> pdList = [Select Id, Installment_Number__c, Is_to_be_Paid__c, Is_to_be__c,Days_Months__c,Days_Months_Value__c,
                                                            Project_Construction_Stages__r.Name,Project_Construction_Stages__c,Milestone_Demand_Id__c,
                                                            Project__r.Id, Project__c, Tower__c, Installment__c, Due_Date__c,Value__c,Amount__c,Amount_Value__c, 
                                                            Calculate_Installment_Amount_as__c,Total_Charge_Value_Minus__c,
                                                            Standard_Pay_Plan_Header__r.Name, Standard_Pay_Plan_Header__r.Payment_Plan__r.Name, 
                                                            Standard_Pay_Plan_Header__r.Charge_Code__r.Name,
                                                            Charge_Amount_Due__c,Service_Tax_Amount_Due__c,
                                                            Charge_Amount_Paid__c, Service_Tax_Amount_Paid__c,
                                                            Charge_Amount_Advance_Recd__c, Service_Tax_Amount_Advance_Recd__c,
                                                            Charge_Amount_Billed__c, Advance_Demand_Id__c,
                                                            Int_Flatcost_Paid__c, Int_Flatcost_Pending__c, Int_Flatcost_Waived__c, 
                                                            Int_ServiceTax_Paid__c, Int_ServiceTax_Pending__c, Int_ServiceTax_Waived__c,
                                                            Customer_Pay_Plan_Header__c
                                                            from  
                                                            Standard_Customer_Pay_Plan_Detail__c where 
                                                            Customer_Pay_Plan_Header__c != null
                                                            and Customer_Pay_Plan_Header__r.Customer__c =:cId
                                                            and Customer_Pay_Plan_Header__r.Project_Unit__c = :uId 
                                                            and ( Charge_Amount_Due__c > 0 or Service_Tax_Amount_Due__c > 0 or Int_Flatcost_pending__c > 0 or Int_Servicetax_pending__c > 0  or (Installment__c > 0 and IsSendDemandLetter__c = false) )
                                                            and Customer_Pay_Plan_Header__r.Booking__c != null
                                                            ORDER BY Due_Date__c asc NULLS last, createdDate asc, Integer_Installment_No__c asc ];
        if(pdList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    public static List<Ledger__c> getChequeDishonours(Id oppId){
        List<Ledger__c> ledgerList = [Select Id, Amount__c, Global_Charges__r.Name, Debit_Credit__c,Remarks__c,
                                        Reciepts__r.Cheque_DD__c,Reciepts__r.Receipt_Date__c,Reciepts__r.Amount_Rs__c
                                        from Ledger__c where Opportunity__r.Id = : oppId
                                        and Global_Charges__r.Name = 'Cheque Dishonor'
                                        and Associated_Dishonour_Credit_Ledger__c = null
                                        and Debit_Credit__c = 'Debit'];
        if(ledgerList.size() > 0) {
            return ledgerList;
        } else {
            return null;
        }
        
    }
    
    public static Map<Id,Decimal> getOnAccountMoney(List<Id> oppIdList) {
        List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id in : oppIdList 
                                        and Currency__c = 'Indian Rupee'
                                        and On_Account_Money__c > 0
                                        and (Receipt_Status__c != 'Dishonored' or Receipt_Status__c != 'Physical Verification Rejected')];
        Map<Id, Decimal> oppMoneyMap = new Map<Id, Decimal>();
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(oppMoneyMap.containsKey(r.Opportunity__r.Id)) {
                    oppMoneyMap.put(r.Opportunity__r.Id, oppMoneyMap.get(r.Opportunity__r.Id)+r.On_Account_Money__c);
                } else {
                    oppMoneyMap.put(r.Opportunity__r.Id, r.On_Account_Money__c);
                }
            }
        }
        return oppMoneyMap;
    }
    
     public static Decimal getOnAccountMoney(Id oppId) {
        List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and On_Account_Money__c > 0
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected')];
        Decimal onAccountMoney = 0;
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                onAccountMoney += r.On_Account_Money__c;
            }
        }
        return onAccountMoney;
    }
    
    public static Decimal getOnAccountMoneyFlatcost(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and On_Account_Money__c > 0
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'Flat Cost')];
        
        Decimal OnAccountMoneyFlatcost = 0;
        
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneyFlatcost += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneyFlatcost;
    }
    
    public static Decimal getOnAccountMoneyGST(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and On_Account_Money__c > 0
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'GST')];
        Decimal OnAccountMoneyGST= 0;
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneyGST += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneyGST ;
    }
    
    public static Decimal getOnAccountMoneySDR(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and On_Account_Money__c > 0
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'Stamp Duty And Registration')];
        Decimal OnAccountMoneySDR = 0;
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneySDR += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneySDR ;
    }
    
    public static Decimal getOnAccountMoneyFlatcost4R(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'Flat Cost')];
        
        Decimal OnAccountMoneyFlatcost4R = 0;
        
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneyFlatcost4R += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneyFlatcost4R;
    }
    
    public static Decimal getOnAccountMoneyGST4R(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'GST')];
        Decimal OnAccountMoneyGST4R= 0;
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneyGST4R += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneyGST4R ;
    }
    
    public static Decimal getOnAccountMoneySDR4R(Id oppId) {
        
         List<Receipt__c> rList = [Select Id, Currency__c, Foreign_Currency_Type__c , On_Account_Money__c 
                                        from Receipt__c 
                                        where Opportunity__r.Id  = : oppId 
                                        and Currency__c = 'Indian Rupee'
                                        and (Receipt_Status__c != 'Dishonored' AND Receipt_Status__c != 'Physical Verification Rejected' AND Receipt_Against__c = 'Stamp Duty And Registration')];
        Decimal OnAccountMoneySDR4R = 0;
        if(rList.size() > 0) {
            for(Receipt__c r : rList) {
                if(r.On_Account_Money__c != null)
                OnAccountMoneySDR4R += r.On_Account_Money__c;
            }
        }
        return OnAccountMoneySDR4R ;
    }
    
}