public class DemandManagementServicesPortal {
    
    public static Map<String,Decimal> getDemandSoFarSummary(String chargeName, Id oppId) {
         List<Customer_Pay_Plan_Header__c> c = [Select Id, Customer__c,
                                                         Customer__r.Email__c, Project_Unit__r.Name, 
                                                         Project_Unit__r.Id,
                                                         Amount_Demanded_Till_Date__c, 
                                                         Service_Tax_Demanded_Till_Date__c,
                                                         Amount_Recd_Till_Date__c,
                                                         Service_Tax_Recd_Till_Date__c,
                                                         Outstanding_Amount__c,
                                                         Outstanding_Service__c,
                                                         Amount__c,
                                                         Int_Servicetax_Pending__c,
                                                         Int_Flatcost_Pending__c,
                                                         Int_Flatcost_Due__c,
                                                         Int_Servicetax_Due__c,
                                                         Int_flatcost_Waived_Till_Date__c,
                                                         Int_servicetax_waived_till_date__c,
                                                         Int_flatcost_Paid_Till_Date__c,
                                                         Int_servicetax_paid_till_date__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE Global_Charges__r.Name = :chargeName
                                                         and Customer__r.Id = :oppId
                                                         and Customer__r.status__c = 'Active'];
         System.debug('charge summary map: oppId : chargeName:  ' + oppId + ' : ' + chargeName + c);
         if(c != null && c.size() == 1) {
            Map<String,Decimal> chargeSummaryMap = new Map<String,Decimal>();
            if(NULL != c[0].Amount_Demanded_Till_Date__c)
                chargeSummaryMap.put(chargeName + ' DEMANDED' , c[0].Amount_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' DEMANDED' , 0);
            if(NULL != c[0].Service_Tax_Demanded_Till_Date__c)
                chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , c[0].Service_Tax_Demanded_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else 
                chargeSummaryMap.put(chargeName + ' TAX DEMANDED' , 0);
            if(NULL != c[0].Amount_Recd_Till_Date__c)
                chargeSummaryMap.put(chargeName + ' RECD' , c[0].Amount_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' RECD' , 0);
            if(NULL != c[0].Service_Tax_Recd_Till_Date__c)
                chargeSummaryMap.put(chargeName + ' TAX RECD' , c[0].Service_Tax_Recd_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' TAX RECD' , 0);
            if(NULL != c[0].Outstanding_Amount__c)
                chargeSummaryMap.put(chargeName + ' OUTSTANDING' , c[0].Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' OUTSTANDING' , 0);
            if(NULL != c[0].Outstanding_Service__c)
                chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , c[0].Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
            else 
                chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , 0);
            if(NULL != c[0].Amount__c)
                chargeSummaryMap.put(chargeName + ' TOTAL' , c[0].Amount__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' TOTAL' , 0);
            // interest outstanding
            if(NULL != c[0].Int_Flatcost_Pending__c)
                chargeSummaryMap.put( chargeName + ' INTEREST' , c[0].Int_Flatcost_Pending__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST' , 0);
            if(NULL != c[0].Int_Servicetax_Pending__c)
                chargeSummaryMap.put( chargeName + ' INTEREST ON ST' , c[0].Int_Servicetax_Pending__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST ON ST' , 0);
           
            // interest due
            if(NULL != c[0].Int_Flatcost_Due__c)
                chargeSummaryMap.put( chargeName + ' INTEREST DUE' , c[0].Int_Flatcost_Due__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST DUE' , 0);
            if(NULL != c[0].Int_Servicetax_Due__c)
                chargeSummaryMap.put( chargeName + ' INTEREST ON ST DUE' , c[0].Int_Servicetax_Due__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST ON ST DUE' , 0);
                
            // interest paid
            if(NULL != c[0].Int_flatcost_Paid_Till_Date__c)
                chargeSummaryMap.put( chargeName + ' INTEREST PAID' , c[0].Int_flatcost_Paid_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST PAID' , 0);
            if(NULL != c[0].Int_servicetax_paid_till_date__c)
                chargeSummaryMap.put( chargeName + ' INTEREST ON ST PAID' , c[0].Int_servicetax_paid_till_date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST ON ST PAID' , 0);
            
            // interest waived
            if(NULL != c[0].Int_flatcost_Waived_Till_Date__c)
                chargeSummaryMap.put( chargeName + ' INTEREST WAIVED' , c[0].Int_flatcost_Waived_Till_Date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST WAIVED' , 0);
            if(NULL != c[0].Int_servicetax_waived_till_date__c)
                chargeSummaryMap.put( chargeName + ' INTEREST ON ST WAIVED' , c[0].Int_servicetax_waived_till_date__c.setscale(0,RoundingMode.HALF_UP));
            else
                chargeSummaryMap.put(chargeName + ' INTEREST ON ST WAIVED' , 0);
                
            System.debug('charge summary map:' + chargeSummaryMap);
            return chargeSummaryMap;
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
                                                         Amount__c
                                                         FROM Customer_Pay_Plan_Header__c 
                                                         WHERE (Global_Charges__r.Name != 'Stamp Duty' AND Global_Charges__r.Name != 'Registration Charges' AND Global_Charges__r.Name != 'Basic' AND Global_Charges__r.Name != 'MVAT')
                                                         and Customer__r.Id = :oppId
                                                         and Customer__r.status__c = 'Active'];
         string chargeName = 'Other';
         System.debug('charge summary map: oppId : chargeName:  ' + oppId + ' : ' + chargeName);
         if(cpphList != null && cpphList.size() > 0) {
            Map<String,Decimal> chargeSummaryMap = new Map<String,Decimal>();
            for(Customer_pay_plan_Header__c c : cpphList) {
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
                
                if(NULL != c.Outstanding_Amount__c && chargeSummaryMap.containsKey(chargeName + ' OUTSTANDING'))
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , chargeSummaryMap.get(chargeName + ' OUTSTANDING') + c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                else if(NULL != c.Outstanding_Amount__c)
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , c.Outstanding_Amount__c.setscale(0,RoundingMode.HALF_UP));
                else
                    chargeSummaryMap.put(chargeName + ' OUTSTANDING' , 0);
                    
                if(NULL != c.Outstanding_Service__c && chargeSummaryMap.containsKey(chargeName + ' TAX OUTSTANDING'))
                    chargeSummaryMap.put(chargeName + ' TAX OUTSTANDING' , chargeSummaryMap.get(chargeName + ' TAX OUTSTANDING') + c.Outstanding_Service__c.setscale(0,RoundingMode.HALF_UP));
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
            }
            System.debug('charge summary map:' + chargeSummaryMap);
            return chargeSummaryMap;
         }          
         return null;                                      
    }
    
    
}