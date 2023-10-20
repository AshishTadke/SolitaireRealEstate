public with sharing class S_ReceiptDashboardClass 
{
    public string errorMsg {get;set;}
    public string infavourtoken1 {get;set;}
    public List<Receipt__c> objR {get;set;}
    public List<Applicant_Details__c> listApp {get;set;} 
    public List <Id> bookingids {get;set;} 
    public List < wrapperclass> wrapperscppdList{get; set;}
       public class wrapperclass
    {
        public String Amount1{ get; set; }
        public String Amount2{ get; set; }
        public Receipt__c ReceiptR {get;set;}
        public wrapperclass(Receipt__c s, Decimal d, Decimal d1)
        {
           
            ReceiptR = s;
            Amount1=QuotationManagementServices.INFormat(d);
            Amount1=Amount1.replace('Rs ','');
            Amount1=Amount1.replace('/-','');
            Amount2=QuotationManagementServices.INFormat(d1);
            
        }
    }     
    public S_ReceiptDashboardClass()
    {
        errorMsg = '';
        infavourtoken1 ='';
        objR = new List<Receipt__c>();                   
        objR = [Select id,Receipt_Number__c,Cheque_DD__c,NEFT__c,Challan_No__c,Opportunity__r.Other_Applicants_Name__c , 
                                Opportunity__r.Primary_Name__c,Cheque_DD_Date__c,Booking__c,
                                Total_Amount__c,Project__r.Name,Project_Unit__r.Name,
                                Drawn_in_favour_of__c, Name,DraweeBank__c, 
                                On_Account_Money__c, Currency__c, 
                                Receipt_Date__c, Receipt_Status__c, 
                                Mode__c, Token_Amount_Receipt__c, 
                                PAN_no_of_TDS_Deductor__c,Token_Amount_ST__c, 
                                Standard_Customer_Pay_Plan_Detail__r.Is_to_be__c From Receipt__c 
                                                        where On_Account_Money__c > 0 
                                                        and (Receipt_Status__c != 'Dishonored' and Receipt_status__c != 'Physical Verification Rejected')
                                                        ORDER BY Name DESC];
          
            wrapperscppdList = new List<wrapperclass>();
            for (integer i = 0 ; i < objR.size() ; i++)
            {
               wrapperscppdList.add(new wrapperclass(objR[i], objR[i].Total_Amount__c, objR[i].On_Account_Money__c));
               
            } 
     
           
    }
    
  
}