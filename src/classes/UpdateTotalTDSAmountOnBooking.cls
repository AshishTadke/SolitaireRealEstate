Public class UpdateTotalTDSAmountOnBooking{

public Static void calculateTDSAmount(List<receipt__c> rList){
         set<id> bookIdSet = new set<id>();
         map<id,Booking__c> bookingMap = new map<id,Booking__c>();
         decimal Amount;
         map<id,Decimal> amountMap = new map<id,Decimal>();
         list<Booking__c> bListForUpdate = new list<Booking__c>();
         
         
         
         if(rList.size() > 0){
            for(receipt__c r : rList){
                bookIdSet.add(r.Booking__c);
            }
         }
         list<Booking__c> bList = new list<Booking__c>();
         
         blist = [select id,name,Customer__c,Unit_No__c,Receipts__c,Total_TDS_Amount_Paid_In_Rs__c from booking__c where id IN : bookIdSet];   
         if(bList.size() > 0){
              for(Booking__c b : blist){
                  bookingMap.put(b.id,b);
              
              }
         }
           if(bookingMap.size() > 0){ 
               for(id key : bookingMap.keySet()){
                   Amount = 0;
                   if(rList.size() > 0){  
                     for(receipt__c r : rList){
                            if(key == r.Booking__c && r.mode__c == 'TDS' && r.IsTDS_And_NoDemandRaised__c == true && r.TDS_Amount_In_Rs__c != null){
                               Amount += r.TDS_Amount_In_Rs__c;    
                         }
                     }
                     
                 }    
                   amountMap.put(key,Amount);
               }
           }     
            if(amountMap.size() > 0){  
              for(Booking__c bObj : blist){
                    if(amountMap.containsKey(bObj.id)){
                       if(bObj.Total_TDS_Amount_Paid_In_Rs__c == null){
                          bObj.Total_TDS_Amount_Paid_In_Rs__c = 0;
                       }   
                          bObj.Total_TDS_Amount_Paid_In_Rs__c += amountMap.get(bObj.id);
                          bListForUpdate.add(bObj);
                       
                    }
              }
            }  
            if(bListForUpdate.size() > 0){
               update bListForUpdate;
            }
                   
   }
}