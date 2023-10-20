global class CalculateInterestSchedular implements Schedulable{ 
  global void execute(SchedulableContext sc)
  {
        system.debug('Here in Schedular class');
        List <Standard_Customer_Pay_Plan_Detail__c> ListSCPPDobj = new List<Standard_Customer_Pay_Plan_Detail__c>();
        ListSCPPDobj = [Select Id,Name,IsPaymentOverdue__c,Total_Interest_Amount__c,Customer_Pay_Plan_Header__c,Customer_Pay_Plan_Header__r.Customer__c,
        Customer_Pay_Plan_Header__r.Project__r.RDS_Interest_Rate__c,Charge_Amount_Due__c,Service_Tax_Amount_Due__c,Charge_Amount_Billed__c,Service_Tax_Amount_Billed__c from Standard_Customer_Pay_Plan_Detail__c  Where IsPaymentOverdue__c =: True And Customer_Pay_Plan_Header__c != null];
        System.debug('List Of SCPPD:' +ListSCPPDobj);
        if(ListSCPPDobj.size()>0)
        {
            System.Debug('Call the CalculateInterest Class');
            CalculateInterestClass.CalculateInterest(ListSCPPDobj);
        }
        else
        {
            System.Debug('Do Nothing.');
        }
    }
}