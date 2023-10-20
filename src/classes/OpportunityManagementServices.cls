public class OpportunityManagementServices
{

   public static void updateSLBMFieldsOnAccAI(List<Opportunity> oppList) 
   {
       Map<Id, List<Opportunity> > accOppMap = new Map<Id, List<Opportunity> >();
       List < ID > AccList = new List < ID > ();
       System.debug('Opportunity Data:' + oppList[0].Account);
       for (Opportunity oList: oppList) 
       {
            if(oList.AccountId != null)
            AccList.add(oList.AccountID);
       } 
       System.Debug('ID of AccountList:' + AccList.size());
       
       if(accList.size() > 0) 
       {
           Map < Id, Account > AccMap = new Map < Id, Account > ([SELECT Id,S_Budget_Min__c,S_Budget_Max__c,S_Pr_History__c,S_Cross_Project_Exposure__c,S_Type_of_accomadation__c,S_PReason_for_Purchase__c,S_Possession_Type__c FROM Account WHERE Id IN :AccList]);
           Map < Id, Opportunity > oppProjMap = new Map < Id, Opportunity > ([SELECT Project__r.Name,Unit_type_configuration__c,Purpose__c,Possession_Requirement__c FROM Opportunity WHERE Id IN :oppList]);
           
           for(Opportunity o : oppList) 
           {
               if(accOppMap.containsKey(o.AccountId)) 
               {
                   accOppMap.get(o.accountId).add(o);
               } 
               else 
               {
                   List < Opportunity > oList = new List < Opportunity >();
                   oList.add(o);
                   accOppMap.put(o.AccountId, oList);
               }
           }
           
           if(accOppMap.size() > 0) 
           {
               for(Id accId : accOppMap.keySet()) {
                   for(Opportunity o : accOppMap.get(accId)) 
                   {
                       // ********* for cross project update ********* 
                        if(o.Marketing_sub_source__c != null && o.Marketing_sub_source__c == 'Cross Project') 
                        {
                           if(accMap.get(accId).S_Cross_Project_Exposure__c == null) 
                           {
                               accMap.get(accId).S_Cross_Project_Exposure__c = 1;
                           } 
                           else 
                           {
                               accMap.get(accId).S_Cross_Project_Exposure__c++; 
                           }
                        }
                       
                       // ********* for project history Update *********
                       if(o.Project__c != null) 
                       {
                        
                          System.debug('accMap:' + accMap);
                          if(String.isBlank(accMap.get(accId).S_Pr_History__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Project__r.Name);
                               accMap.get(accId).S_Pr_History__c = oppProjMap.get(o.Id).Project__r.Name;
                          }
                          else 
                          {
                               if(String.isNotBlank(accMap.get(accId).S_Pr_History__c) && !accMap.get(accId).S_Pr_History__c.contains(oppProjMap.get(o.Id).Project__r.Name)) 
                               {
                                   accMap.get(accId).S_Pr_History__c = accMap.get(accId).S_Pr_History__c + ',' + oppProjMap.get(o.Id).Project__r.Name; 
                               }
                          } 
                       } // IF Closed for Project
                       
                       // ********* for Type Of Accomodation Update ********* 
                       if(o.Unit_type_configuration__c != null) 
                       {
                        
                          System.debug('accMap:' + accMap);
                          if(String.isBlank(accMap.get(accId).S_Type_of_accomadation__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Unit_type_configuration__c);
                               accMap.get(accId).S_Type_of_accomadation__c = oppProjMap.get(o.Id).Unit_type_configuration__c;
                          }
                          else 
                          {
                               if(String.isNotBlank(accMap.get(accId).S_Type_of_accomadation__c) && !accMap.get(accId).S_Type_of_accomadation__c.contains(oppProjMap.get(o.Id).Unit_type_configuration__c)) 
                               {
                                   accMap.get(accId).S_Type_of_accomadation__c = accMap.get(accId).S_Type_of_accomadation__c + ',' + oppProjMap.get(o.Id).Unit_type_configuration__c; 
                               }
                          } 
                       } // IF Closed for Unit_type_configuration__c
                       
                       // ********* for Reason For Purchase Update ********* 
                       if(o.Purpose__c != null) 
                       {
                          System.debug('accMap:' + accMap);
                          if(String.isBlank(accMap.get(accId).S_PReason_for_Purchase__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Purpose__c);
                               accMap.get(accId).S_PReason_for_Purchase__c = oppProjMap.get(o.Id).Purpose__c;
                          }
                          else 
                          {
                               if(String.isNotBlank(accMap.get(accId).S_PReason_for_Purchase__c) && !accMap.get(accId).S_PReason_for_Purchase__c.contains(oppProjMap.get(o.Id).Purpose__c)) 
                               {
                                   accMap.get(accId).S_PReason_for_Purchase__c = accMap.get(accId).S_PReason_for_Purchase__c + ',' + oppProjMap.get(o.Id).Purpose__c; 
                               }
                          } 
                       } // IF Closed for Purpose__c  
                       
                       // ********* for Possession Type Update ********* 
                       if(o.Possession_Requirement__c != null) 
                       {
                          System.debug('accMap:' + accMap);
                          if(String.isBlank(accMap.get(accId).S_Possession_Type__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Possession_Requirement__c);
                               accMap.get(accId).S_Possession_Type__c = oppProjMap.get(o.Id).Possession_Requirement__c;
                          }
                          else 
                          {
                               if(String.isNotBlank(accMap.get(accId).S_Possession_Type__c) && !accMap.get(accId).S_Possession_Type__c.contains(oppProjMap.get(o.Id).Possession_Requirement__c)) 
                               {
                                   accMap.get(accId).S_Possession_Type__c = accMap.get(accId).S_Possession_Type__c + ',' + oppProjMap.get(o.Id).Possession_Requirement__c; 
                               }
                          } 
                       } // IF Closed for Possession Type
                       
                       
                       
                       
                   }
               }
           }
           update accMap.values();
       }
   }
   
   /*public static void updateSLBMFieldsOnAccAU(Map<Id,Opportunity> oldMap, Map<Id,Opportunity> newMap) 
   {
       Map<Id,List<Opportunity>> accOppMap = new Map<Id,List<Opportunity>>();
       List < ID > AccList = new List < ID > ();
       for (Opportunity oList: newMap.values()) 
       {
           AccList.add(oList.AccountID);
       }
       
       if(accList.size() > 0) {      
       //System.Debug('ID of AccountList:' + AccList);
       Map < Id, Account > AccMap = new Map < Id, Account > ([SELECT Id,S_Budget_Min__c,S_Budget_Max__c,S_Pr_History__c,S_Cross_Project_Exposure__c,S_Type_of_accomadation__c,S_PReason_for_Purchase__c,S_Possession_Type__c FROM Account WHERE Id IN :AccList]);
       
       for(Opportunity o : newMap.values()) 
       {
           if(accOppMap.containsKey(o.AccountId)) 
           {
               accOppMap.get(o.accountId).add(o);
           } 
           else 
           {
               List<Opportunity> oList = new List<Opportunity>();
               oList.add(o);
               accOppMap.put(o.AccountId, oList);
           }
       }
       Map<Id,Opportunity> oppProjMap = new Map<Id,Opportunity>([Select Project__r.Name,Unit_type_configuration__c,Purpose__c,Possession_Requirement__c from Opportunity where Id in : newMap.values()]);
       
       
       if(accOppMap.size() > 0) 
       {
           for(Id accId : accOppMap.keySet()) 
           {
               for(Opportunity o : accOppMap.get(accId)) 
               {
                   // ********* for cross project update ********* 
                   // if old was something else, and new value is cross project , then increment
                   if(o.Marketing_sub_source__c != null && o.Marketing_sub_source__c == 'Cross Project' && oldMap.get(o.Id).Marketing_sub_source__c != 'Cross Project') 
                   {
                       if(accMap.get(accId).S_Cross_Project_Exposure__c == null) 
                       {
                           accMap.get(accId).S_Cross_Project_Exposure__c = 1;
                       } 
                       else 
                       {
                           accMap.get(accId).S_Cross_Project_Exposure__c++; 
                       }
                   }
                   
                   // ********* for cross project update ********* 
                   // if old was cross project and new is null, then decrement
                   if(o.Marketing_sub_source__c == null && oldMap.get(o.Id).Marketing_sub_source__c == 'Cross Project') 
                   {
                       if(accMap.get(accId).S_Cross_Project_Exposure__c != null) 
                       {
                           accMap.get(accId).S_Cross_Project_Exposure__c--; 
                       }
                   }
                   
                   // ********* for cross project update ********* 
                   // if old was cross project and new is not cross project, then decrement
                   if(o.Marketing_sub_source__c != null && oldMap.get(o.Id).Marketing_sub_source__c == 'Cross Project' && o.Marketing_sub_source__c !=  'Cross Project' ) 
                   {
                       if(accMap.get(accId).S_Cross_Project_Exposure__c != null) 
                       {
                           accMap.get(accId).S_Cross_Project_Exposure__c--; 
                       }
                   }
                   
                   // ********* for project history update ********* 
                   if(o.Project__c != null && oldMap.get(o.Id).Project__c != newMap.get(o.Id).Project__c) 
                   {
                          if(String.isBlank(accMap.get(accId).S_Pr_History__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Project__r.Name);
                               accMap.get(accId).S_Pr_History__c = oppProjMap.get(o.Id).Project__r.Name;
                          } 
                          else 
                          {
                               System.debug('Existing products:' + accMap.get(accId).S_Pr_History__c);
                               System.debug('New product:' + oppProjMap.get(o.Id).Project__r.Name);
                               if(!accMap.get(accId).S_Pr_History__c.contains(oppProjMap.get(o.Id).Project__r.Name)) 
                               {
                                   accMap.get(accId).S_Pr_History__c = accMap.get(accId).S_Pr_History__c + ',' + oppProjMap.get(o.Id).Project__r.Name; 
                               }
                          } 
                   }  // If Project History Closed.
                   
                   // ********* for Type Of Accomodation update ********* 
                   if(o.Unit_type_configuration__c != null && oldMap.get(o.Id).Unit_type_configuration__c != newMap.get(o.Id).Unit_type_configuration__c) 
                   {
                          if(String.isBlank(accMap.get(accId).S_Type_of_accomadation__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Unit_type_configuration__c);
                               accMap.get(accId).S_Type_of_accomadation__c = oppProjMap.get(o.Id).Unit_type_configuration__c;
                          } 
                          else 
                          {
                               System.debug('Existing products:' + accMap.get(accId).S_Pr_History__c);
                               System.debug('New product:' + oppProjMap.get(o.Id).Unit_type_configuration__c);
                               if(!accMap.get(accId).S_Type_of_accomadation__c.contains(oppProjMap.get(o.Id).Unit_type_configuration__c)) 
                               {
                                   accMap.get(accId).S_Type_of_accomadation__c = accMap.get(accId).S_Type_of_accomadation__c + ',' + oppProjMap.get(o.Id).Unit_type_configuration__c; 
                               }
                          } 
                   }  // If Unit_type_configuration__c Closed.
                   
                   
                   // ********* For Reason For Purchase update ********* 
                   if(o.Purpose__c != null && oldMap.get(o.Id).Purpose__c != newMap.get(o.Id).Purpose__c) 
                   {
                          if(String.isBlank(accMap.get(accId).S_PReason_for_Purchase__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Purpose__c);
                               accMap.get(accId).S_PReason_for_Purchase__c = oppProjMap.get(o.Id).Purpose__c;
                          } 
                          else 
                          {
                               System.debug('Existing products:' + accMap.get(accId).S_PReason_for_Purchase__c);
                               System.debug('New product:' + oppProjMap.get(o.Id).Purpose__c);
                               if(!accMap.get(accId).S_PReason_for_Purchase__c.contains(oppProjMap.get(o.Id).Purpose__c)) 
                               {
                                   accMap.get(accId).S_PReason_for_Purchase__c = accMap.get(accId).S_PReason_for_Purchase__c + ',' + oppProjMap.get(o.Id).Purpose__c; 
                               }
                          } 
                   }  // If Reason For Purchase Closed.
                   
                   // ********* For Possession Requirement update ********* 
                   if(o.Possession_Requirement__c != null  && oldMap.get(o.Id).Possession_Requirement__c != newMap.get(o.Id).Possession_Requirement__c) 
                   {
                          if(String.isBlank(accMap.get(accId).S_Possession_Type__c)) 
                          {
                               System.debug('Project Name:' + oppProjMap.get(o.Id).Possession_Requirement__c);
                               accMap.get(accId).S_Possession_Type__c = oppProjMap.get(o.Id).Possession_Requirement__c;
                          } 
                          else 
                          {
                               System.debug('Existing products:' + accMap.get(accId).S_Possession_Type__c);
                               System.debug('New product:' + oppProjMap.get(o.Id).Possession_Requirement__c);
                               if(!accMap.get(accId).S_Possession_Type__c.contains(oppProjMap.get(o.Id).Possession_Requirement__c)) 
                               {
                                   accMap.get(accId).S_Possession_Type__c = accMap.get(accId).S_Possession_Type__c + ',' + oppProjMap.get(o.Id).Possession_Requirement__c; 
                               }
                          } 
                   }  // If Reason For Purchase Closed.
                   
                   
                   
                   
               }// For loop - Opportunity o Closed
           }// for - Id accid closed
       }// If Closed
       update accMap.values();
       }
   }*/
   
   ///////////////////// Created By Vikas On dated 15/07/2016 For SCPPD Updation ////////////////////////////////
   public static void updateSCPPDDueDate(List<Opportunity> oppList){
        
         
         List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
         //List<Standard_Customer_Pay_Plan_Detail__c> scppdList2 = new List<Standard_Customer_Pay_Plan_Detail__c>();
         if(oppList.size() > 0)
         {            
                   
                      scppdList = [select id,Name,Is_to_be_Paid__c,Days_Months_Value__c,Days_Months__c,Customer_Pay_Plan_Header__c,Standard_Pay_Plan_Header__c,Project__c,
                      Is_to_be__c,Value__c,IsSendDemandLetter__c,Demand_Link__c,Registration_Linked__c,Is_Registration_Done__c,Amount__c,Amount_Value__c,
                      Customer_Pay_Plan_Header__r.Customer__c,Due_Date__c,Due_Date_on_Quote__c,Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c 
                      from Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__r.Customer__c =: oppList and 
                      (Is_to_be_Paid__c = 'From Dt. of Registration' OR Registration_Linked__c = true) and IsSendDemandLetter__c = false];
                      
                      ///////// second SCPPD list //////////////////
                      /* scppdList2 = [select id,Name,Is_to_be_Paid__c,Days_Months_Value__c,Days_Months__c,Customer_Pay_Plan_Header__c,Standard_Pay_Plan_Header__c,Project__c,
                      Is_to_be__c,Value__c,IsSendDemandLetter__c,Demand_Link__c,Registration_Linked__c,Is_Registration_Done__c,Amount__c,Amount_Value__c,
                      Customer_Pay_Plan_Header__r.Customer__c,Due_Date__c,Due_Date_on_Quote__c,Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c 
                      from Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__r.Customer__c =: oppList and 
                      Registration_Linked__c = true and IsSendDemandLetter__c = false];*/
                    
          }          
          
          List<Standard_Customer_Pay_Plan_Detail__c> scppdListToUpdate = new List<Standard_Customer_Pay_Plan_Detail__c>();
         // List<Standard_Customer_Pay_Plan_Detail__c> scppdList2ToUpdate = new List<Standard_Customer_Pay_Plan_Detail__c>();
          
          if(scppdList.size() > 0)
          {     
          
             for(Standard_Customer_Pay_Plan_Detail__c scppdObj : scppdList)
             {  
                 Decimal newDays;
                 Integer totalDays;
                 if(scppdObj.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c != null)
                 {
                      Date registrdt = scppdObj.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c;
                      if(scppdObj.Days_Months__c == 'Day(s)')
                      {   
                          
                          newDays = scppdObj.Days_Months_Value__c;
                          if(newDays != null)
                          {
                          totalDays = newDays.intValue();
                          
                          if(scppdObj.Days_Months_Value__c != 0)
                          scppdObj.Due_Date__c = registrdt.addDays(totalDays);
                          else
                          scppdObj.Due_Date__c = registrdt;                          
                          }
                      }
                      if(scppdObj.Days_Months__c == 'Month(s)')
                      {
                          newDays = scppdObj.Days_Months_Value__c;
                          if(newDays != null)
                          {
                          totalDays = newDays.intValue();
                          
                          if(scppdObj.Days_Months_Value__c != 0)
                          scppdObj.Due_Date__c = registrdt.addMonths(totalDays);
                          else
                          scppdObj.Due_Date__c = registrdt;
                          }
                      }
                      if(scppdObj.Registration_Linked__c != null)
                      {
                         scppdObj.Is_Registration_Done__c = true;
                      }
                      scppdListToUpdate.add(scppdObj);
                 }
                 
             }
             try{
             if(!scppdListToUpdate.isEmpty())
                   update scppdListToUpdate;
             }
             catch(Exception e) {
                   System.debug('Exception caught please handle::'+e);
             }    
          
          }
         /* system.debug('scppdList2.size()::: '+scppdList2.size());
          
          if(scppdList2.size() > 0)
          {
               for(Standard_Customer_Pay_Plan_Detail__c scppdObj2 : scppdList2)
               {  
                   if(scppdObj2.Customer_Pay_Plan_Header__r.Customer__r.Registration_Date__c != null)
                   {
                         if(scppdObj2.Registration_Linked__c != null)
                         {
                         scppdObj2.Is_Registration_Done__c = true;
                         //update scppdObj2;
                         scppdList2ToUpdate.add(scppdObj2);
                         }
                   }  
             
               }
          }
          try{
          if(!scppdList2ToUpdate.isEmpty())
              update scppdList2ToUpdate;
          }
          catch(Exception e) {
              System.debug('Exception caught please handle::'+e);
          }    
 
          */
          
   }
   
   public static void updateBasicCharges(List<Customer_Pay_Plan_Header__c> cpphList) {
        Map<Id,Customer_Pay_Plan_Header__c> customerCPPHMap = new Map<Id,Customer_Pay_Plan_Header__c>();
        for(Customer_Pay_Plan_Header__c cpph : cpphList) {
            if(cpph.Global_Charge_Name__c != null && cpph.Global_Charge_Name__c.equalsIgnoreCase('Basic')) {
                customerCPPHMap.put(cpph.customer__c, cpph);
            }
        }
        List<Opportunity> oList = [Select Id, Name from Opportunity where Id in :customerCPPHMap.keySet()];
        for(Opportunity o : oList) {
            o.Flatcost_Demanded__c = customerCPPHMap.get(o.Id).Amount_Demanded_Till_Date__c;
            o.Flatcost_Paid__c = customerCPPHMap.get(o.Id).Amount_Recd_Till_Date__c;
            o.Flatcost_outstanding__c = customerCPPHMap.get(o.Id).Outstanding_Amount__c;
            o.Flatcost_Demanded_Percent__c = customerCPPHMap.get(o.Id).Percent_Demanded__c;
            o.Agreement_Value__c =  customerCPPHMap.get(o.Id).Amount__c;
            o.Flatcost_Paid_Percent_Against_AV__c = customerCPPHMap.get(o.Id).Percent_Paid__c;
            if(customerCPPHMap.get(o.Id).Amount_Recd_Till_Date__c != 0)
                o.Flatcost_Paid_Percent__c  = (customerCPPHMap.get(o.Id).Amount_Recd_Till_Date__c / customerCPPHMap.get(o.Id).Amount_Demanded_Till_Date__c) * 100;
            else 
                o.Flatcost_Paid_Percent__c = 0;
            o.Flatcost_outstanding_percent__c = 100 - o.Flatcost_Paid_Percent__c;
        }
        update oList;
   }
   ////Added by shailesh////
   public static void updateBasicCPPHforRegistration(List<Opportunity> oList)
   {
       System.debug('inside method::'+oList);
       List<Customer_Pay_Plan_Header__c> cpphList = new List<Customer_Pay_Plan_Header__c>();
       List<Customer_Pay_Plan_Header__c> cpphListToupdate = new List<Customer_Pay_Plan_Header__c>();
       Set<Id> optyId = new Set<Id>();
       Set<Id> bookingId = new Set<Id>();
       if(!oList.isEmpty())
       {
           for(Opportunity o : oList)
           {
               if(o.Booking__c != null)
                   bookingId.add(o.Booking__c);
               if(o.Id != null)
                   optyId.add(o.Id);
           }
       }    
           if(!bookingId.isEmpty() &&  !optyId.isEmpty())
           {
                   cpphList =[Select Id,Global_Charges__c,Booking__c,Project__c,Project_Unit__c,Customer__c,Quotation__c,Global_Charge_Name__c,
                                      Registration_Demand_Invoice__c,show_registration_demand__c,Registration_Reached__c,Registration_Intimation_Sent__c
                                      from Customer_Pay_Plan_Header__c where Global_Charge_Name__c = 'Basic' AND Customer__c IN : optyId AND Booking__c IN : bookingId];
                   System.debug('CPPH List:::'+cpphList);
           }
       if(!cpphList.isEmpty())
       {
           for(Customer_Pay_Plan_Header__c c : cpphList )
           {
                   c.show_registration_demand__c = true;
                   c.Registration_Intimation_Sent__c = true;
                   cpphListToupdate.add(c);
           }
       }
       try{
           if(!cpphListToupdate.isEmpty())
               update cpphListToupdate;
       }
       catch(Exception e) {
           System.debug('Exception caught please handle::'+e);
       }
   }
}