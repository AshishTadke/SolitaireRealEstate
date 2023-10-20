public with sharing class UserComponentController1
{
    public String strBookingId {get; set;} 
    public List<Booking__c> BookingList {get;set;}
    
    
    public UserComponentController1()
    {
        
    }
    
    public void getUserDetails()
    {
        system.debug('inside Costructor');
        if(strBookingId != null)
        {
            system.debug('inside If Condition');
            BookingList = [SELECT Id,Unit_No__r.Name,Opportunity__c,Opportunity__r.Primary_Name__c,Opportunity__r.Name,Customer__c,Customer__r.Name,Customer__r.Primary_Name__c,Owner.Email,Owner.Name,Owner.Phone,Opportunity__r.Account.Salutation,Opportunity__r.Account.Name
            
            FROM Booking__c WHERE Id =:strBookingId ];
            system.debug('BookingList : ' + BookingList);
            
        }
       
    }
    
}