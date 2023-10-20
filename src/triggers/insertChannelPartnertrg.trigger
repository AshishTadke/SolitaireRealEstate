trigger insertChannelPartnertrg on Account (After insert,After Delete,After Update) {

     If(Trigger.isInsert)
     {
        for(Account accObj : Trigger.new)
        {
            if(accObj.RecordTypeId == '012R0000000DGKA' || accObj.RecordTypeId =='01236000000n2PH')
            {
                 System.debug('inside if recordtypeId is Channel Partner & afterinsert');
                 ChannelPartnerManagementServices.insertChannelPartner(Trigger.new);
            }
        }
     }
     
     If(Trigger.isUpdate)
     {
        for(Account accObj : Trigger.new)
        {
            if(accObj.RecordTypeId == '012R0000000DGKA' || accObj.RecordTypeId =='01236000000n2PH')
            {
                 System.debug('inside if recordtypeId is Channel Partner & afterupdate');
               if(Trigger.newMap.get(accObj.id).Pan_Card_No__c  != Trigger.oldMap.get(accObj.id).Pan_Card_No__c || Trigger.newMap.get(accObj.id).Name != Trigger.oldMap.get(accObj.id).Name || Trigger.newMap.get(accObj.id).Xcelerate_ID__c != Trigger.oldMap.get(accObj.id).Xcelerate_ID__c || Trigger.newMap.get(accObj.id).Email_ID_1__c != Trigger.oldMap.get(accObj.id).Email_ID_1__c 
                  || Trigger.newMap.get(accObj.id).Email_ID_2__c != Trigger.oldMap.get(accObj.id).Email_ID_2__c || Trigger.newMap.get(accObj.id).Phone != Trigger.oldMap.get(accObj.id).Phone || Trigger.newMap.get(accObj.id).Mobile_No__c != Trigger.oldMap.get(accObj.id).Mobile_No__c || Trigger.newMap.get(accObj.id).Office_No__c != Trigger.oldMap.get(accObj.id).Office_No__c)  {
                 ChannelPartnerManagementServices.updateChannelPartner(Trigger.new);
                 }
            }
        }
     }
     
     If(Trigger.isDelete)
     {
        for(Account accObjold : trigger.old)
        {
            if(accObjold.RecordTypeId == '012R0000000DGKA' || accObjold.RecordTypeId =='01236000000n2PH')
            {
                 System.debug('inside if after delete');
                 ChannelPartnerManagementServices.deleteChannelPartner(Trigger.old);
            }
        } 
     }      
        
}