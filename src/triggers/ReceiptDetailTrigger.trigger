trigger ReceiptDetailTrigger on Receipt_Details__c (After Insert) {  
    List<Id> rdIdList = new List<Id>();
    List<Id> rdIntList = new List<Id>();
    for(  Receipt_Details__c rd : trigger.new) {
        if(!rd.On_Account_Money__c && !rd.Is_Cheque_Dishonour__c && !rd.Is_Interest_Settlement__c && !rd.Is_Interest_Settlement_ST__c) {
           rdIdList.add(rd.Id);
        }
    }
    for(  Receipt_Details__c ri : trigger.new) {
        if(ri.Is_Interest_Settlement__c || ri.Is_Interest_Settlement_ST__c) {
           rdIntList.add(ri.Id);
        }
    }
    if(rdIdList.size() >0 )
        LedgerManagementServices.createCreditLedgers(rdIdList);
    if(rdIntList.size() >0 && !test.isRunningTest())
        LedgerManagementServices.createCreditLedgersForInterest(rdIntList);
    
}