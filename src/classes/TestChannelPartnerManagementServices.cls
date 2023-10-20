@isTest
private class TestChannelPartnerManagementServices{
@isTest 
static void Testchannelpartner(){

    
    
    RecordType rt = [select Id,name from RecordType where Name ='Channel Partner' and SobjectType = 'Account']; 
    
    
    Account ac = new Account(Name='Testcp1',RecordTypeId = rt.Id,Pan_Card_No__c='4569636668',Xcelerate_ID__c='abc',Email_ID_1__c='email1@test.com',
    Email_ID_2__c='email2@test.com',Phone='9541852896',Mobile_No__c='7418529636',Office_No__c='2024567890');
    insert ac;
    
    Channel_Partner__c cp = new Channel_Partner__c(Name='Testcp1',Pan_Card_No__c='4569636668',Xcelerate_ID__c='def',Email_ID_1__c='email1@test.com',
    Email_ID_2__c='email2@test.com',Phone__c='9541852896',Mobile_No__c='7418529636',Office_No__c='2024567890');
    
    
    ChannelPartnerManagementServices cpm = new ChannelPartnerManagementServices();
    
    List<Account> accList = [SELECT Name,Pan_Card_No__c,Xcelerate_ID__c,Email_ID_1__c,Email_ID_2__c,
    Phone,Mobile_No__c,Office_No__c FROM Account WHERE Id =:ac.Id];
    
    System.debug('accList 1'+accList.size());
    
    ChannelPartnerManagementServices.insertChannelPartner(accList);
    ac.Name = 'Testcp1';
    ac.Pan_Card_No__c = '4569636674';
    ac.Xcelerate_ID__c = 'def';
    ac.Email_ID_1__c = 'email1@test.com';
    ac.Email_ID_2__c = 'email2@test.com';
    ac.Phone = '9541852896';
    ac.Mobile_No__c = '7418529636';
    ac.Office_No__c = '2024567890';
    update ac;
    System.debug('accList Size'+accList.size());
    ChannelPartnerManagementServices.updateChannelPartner(accList);
    List<Channel_Partner__c> cList = [SELECT Name,Pan_Card_No__c,Xcelerate_ID__c,Email_ID_1__c,Email_ID_2__c,
    Phone__c,Mobile_No__c,Office_No__c FROM Channel_Partner__c  WHERE Id =:ac.Id];
    System.debug('cList Size'+cList.size());
    ChannelPartnerManagementServices.deleteChannelPartner(accList);
    }
}