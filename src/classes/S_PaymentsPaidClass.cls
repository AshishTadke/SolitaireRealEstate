public class S_PaymentsPaidClass
{
    public string errorMsg {get;set;}
    public List<Receipt__c> objR {get;set;}
    public id bid {get;set;}
    public S_PaymentsPaidClass()
    {
        errorMsg = '';
        if(ApexPages.currentPage().getParameters().get('Bookingid')!='')
        bid = ApexPages.currentPage().getParameters().get('Bookingid');
        objR = new List<Receipt__c>();                   
        objR = [Select id, Name,DraweeBank__c,Booking__c, On_Account_Money__c, Currency__c, Receipt_Date__c, Receipt_Status__c, Mode__c, Token_Amount_Receipt__c, Token_Amount_ST__c, 
        Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c, Total_Amount__c, Cheque_DD__c, Cheque_DD_Date__c ,Opportunity__c, Booking_Status__c, Drawn_in_favour_of__c, Print_Receipt__c, Manual_Receipt_Date__c, Print_Receipt_On_Letterhead__c
        From Receipt__c where Booking__c = : bid];
        
       
      
    }
    
   
 
   
}