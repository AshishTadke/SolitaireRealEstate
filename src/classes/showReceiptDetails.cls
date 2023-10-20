public class showReceiptDetails
{
    public Id receiptId {get;set;}
    public String reasonForRejection {get;set;}
    public Receipt__c rd {get;set;}
    public string paymentTowards {get;set;}
    public string bankAccount {get;set;}
    public Boolean letterH { get; set; }
    public String CustomerPrimaryName {
        get;
        set;
    }
    public String CustomerOtherApplicantName {
        get;
        set;
    }
    public String CustomerMailingAddress {
        get;
        set;
    }
    public List<Receipt__c> receiptList {
    	get;
    	set;
    }
     public String CustomerMobilePhone {
        get;
        set;
    }

    public void getReceiptDetails()
    {
    	bankAccount = '';
    	paymentTowards = '';
         receiptList = new List<Receipt__c>(); 
         rd = new Receipt__c();
         system.debug('Inside getReceiptDetails Method');
         system.debug('Receipt Id : '+receiptId);
         
		         receiptList = [SELECT id, Name,Mode__c,
		         Bank__c,Project__c,Project__r.Name,
		         Project_Unit__c,Project_Unit__r.Name,
		         Cheque_DD__c,Opportunity__c,
		         Opportunity__r.Name,Cheque_DD_Date__c,
		         Amount_Rs__c,
		         Reason_for_Reject__c,
		         Drawn_in_favour_of__c,
		         Banking__c,
		         DraweeBank__c,
		         Reason_for_rejection_new__c,
		         receipt_status__c,
		         Project__r.Cheque_Dishonour__c,
		         Opportunity__r.Primary_Name__c,
		         Opportunity__r.Primary_Phone__c,
		         Opportunity__r.Other_Applicants_Name__c,
		         Opportunity__r.Mailing_Address__C,
		         Project__r.Project_Image__c,
		         Project__r.Footer_Image__c,
		         Receipt_Date__c
		         FROM Receipt__c WHERE id = :receiptId];
		         
		         if(receiptList != null && receiptList.size() == 1) {
		         	if(string.IsNotBlank(receiptList[0].receipt_status__c)  && receiptList[0].receipt_status__c.equalsIgnoreCase('Physical Verification Rejected'))
		         		reasonForRejection = receiptList[0].Reason_for_rejection_new__c;
		         	else if (string.IsNotBlank(receiptList[0].receipt_status__c)  && receiptList[0].receipt_status__c.equalsIgnoreCase('Dishonored'))
		       			reasonForRejection = receiptList[0].Banking__c;
		       		if(string.IsNotBlank(receiptList[0].Drawn_in_favour_of__c)) {
		       			List<String> sList = receiptList[0].Drawn_in_favour_of__c.split('\\|', 5); 
		       			system.debug(sList);
		       			if(sList != null && sList.size() > 0) {
		       				paymentTowards = sList[0];
		       			}
		       			Integer count = 0;
		       			for(String s: sList) {
		       				if(count != 0) {
		       					bankAccount += sList[count] + ',';
		       				}
		       				count ++;
		       			}
		       			// remove the last character only if its a comma.
						if(bankAccount.length() > 0 && bankAccount.substring(bankAccount.length() -1).equals(','))
							bankAccount = bankAccount.substring(0,bankAccount.length() -1);
		       			system.debug('bank account:' + bankAccount);
		       			system.debug('payment towards:' + paymentTowards);
		       			
		       			CustomerPrimaryName  = receiptList[0].Opportunity__r.Primary_Name__c;
                    	CustomerOtherApplicantName = receiptList[0].Opportunity__r.Other_Applicants_Name__c;
                    	CustomerMailingAddress = receiptList[0].Opportunity__r.Mailing_Address__c;
                    	CustomerMobilePhone  =  receiptList[0].Opportunity__r.Primary_Phone__c;
		       		}
		       		
		       		
		         }
         if(receiptList != null && receiptList.size() ==1) {
         	rd= receiptList[0];
         }
    }
}