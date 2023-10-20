Public Class demandInvoicesRecon {
    
public List <Demand_Invoice__c> demandsInvoiceAll {get;set;}
public List <Demand_Invoice__c> demandsInv {get;set;}
public List <Demand_Invoice__c> demandsInvToUpdate {get; set;}


    public demandInvoicesRecon() 
    {
        demandsInv = new List <Demand_Invoice__c>();
        demandsInvoiceAll = [select id, name, Demand_Number__c, Customer__r.project__c, Customer__r.Primary_Name__c, Customer__r.Other_Applicants_Name__c, Customer__r.Project_Unit__c, Owner.name , PO_no__c, Dispatch_date__c, Delivery_status__c, Reason_for_failure__c, Delivery_Return_Date__c, Print_Invoice__c, Is_Printed__c, is_delivered__c, To_Update__c
                      From Demand_Invoice__c 
                      Where is_delivered__c = FALSE and Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Booking__r.Dispatch_Mode__c = 'Soft copy via email and hardcopy' 
                      Order By Due_Date__c DESC limit 50 ];
                      
        for (demand_Invoice__c d : demandsInvoiceAll) {
            d.To_update__c = FALSE;
            demandsInv.add(d);
         }               
       
      }                

    
    public pageReference Save() 
    {
    
    demandsInvToUpdate = new List <Demand_Invoice__c>();
            
    For (Demand_Invoice__c d: demandsInv)    {
            If(d.To_update__c)    {
                demandsInvToUpdate.add(d);         
             }
         }
    
    update demandsInvToUpdate;   
    
    return null;
    
    
   }
    
    
}