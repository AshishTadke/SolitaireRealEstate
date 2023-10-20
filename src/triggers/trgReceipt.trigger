trigger trgReceipt on Receipt__c(after update,before insert) {
    if (trigger.isafter && trigger.isUpdate) {
        for (Receipt__c objReceipt: trigger.new) {
            if (objReceipt.Receipt_Status__c == 'Dishonored' && trigger.oldmap.get(objReceipt.id).Receipt_Status__c != 'Dishonored') {
                trgReceiptHandler objcls = new trgReceiptHandler();
                objcls.dishonour(objReceipt.id);
            } else if (objReceipt.Receipt_Status__c == 'Physical Verification Rejected' && trigger.oldmap.get(objReceipt.id).Receipt_Status__c != 'Physical Verification Rejected') {
                trgReceiptHandler objcls = new trgReceiptHandler();
                objcls.VerificationRejection(objReceipt.id);
            }
        }
    }
    if (trigger.isbefore && trigger.isinsert) {
         list<receipt__c> receiptList = new list<receipt__c>();
        for(Receipt__c objReceipt: trigger.new){
            if(objReceipt.mode__c == 'TDS' && objReceipt.IsTDS_And_NoDemandRaised__c == true && objReceipt.TDS_Amount_In_Rs__c != null){
               receiptList.add(objReceipt);
            }
        }
        
          if(receiptList.size() > 0){
                UpdateTotalTDSAmountOnBooking.calculateTDSAmount(receiptList);
          }
    }
}