Public class ChannelPartnerManagementServices{

    public static void insertChannelPartner(List<Account> accList)
    {
        System.debug('inside insertChannelPartner method');
        Channel_Partner__c channelObj = new Channel_Partner__c ();
        List<Channel_Partner__c> channelList = new List <Channel_Partner__c>();
        for(Account accobj : accList)
        {
             channelObj.Name = accObj.Name;
             channelObj.Channel_Partner__c = accObj.Id;
             channelObj.Pan_Card_No__c = accObj.Pan_Card_No__c;
             channelObj.Xcelerate_ID__c = accObj.Xcelerate_ID__c;
             channelObj.Email_ID_1__c = accObj.Email_ID_1__c;
             channelObj.Email_ID_2__c = accObj.Email_ID_2__c;
             channelObj.Phone__c = accObj.Phone;
             channelObj.Mobile_No__c = accObj.Mobile_No__c;
             channelObj.Office_No__c = accObj.Office_No__c;
             channelList.add(channelObj);   
        }
        if(!channelList.isEmpty())
        {
            try
            {
                insert channelList;
            }
            catch(Exception e)
            {
                System.debug('Exception::'+e);
            }
        }
    }
    
    
    public static void updateChannelPartner(List<Account> accList)
    {
        System.debug('inside updateChannelPartner method');
        List<Channel_Partner__c> channelObj = new List<Channel_Partner__c> ();
        channelObj =[select Id,Name,Channel_Partner__c ,Pan_Card_No__c,Xcelerate_ID__c,Email_ID_1__c,Email_ID_2__c,Phone__c,Mobile_No__c,Office_No__c from Channel_Partner__c where Channel_Partner__c IN:accList];
        List<Channel_Partner__c> channelList = new List <Channel_Partner__c>();
        for(Account accobj : accList)
        {
        for(Channel_Partner__c ch : channelObj ){
        
             ch.Name = accObj.Name;
             ch.Channel_Partner__c = accObj.Id;
             ch.Pan_Card_No__c = accObj.Pan_Card_No__c;
             ch.Xcelerate_ID__c = accObj.Xcelerate_ID__c;
             ch.Email_ID_1__c = accObj.Email_ID_1__c;
             ch.Email_ID_2__c = accObj.Email_ID_2__c;
             ch.Phone__c = accObj.Phone;
             ch.Mobile_No__c = accObj.Mobile_No__c;
             ch.Office_No__c = accObj.Office_No__c;
             channelList.add(ch);   
           }  
        }
        if(!channelList.isEmpty())
        {
            try
            {
                update channelList;
            }
            catch(Exception e)
            {
                System.debug('Exception::'+e);
            }
        }
    }
    
    public static void deleteChannelPartner(List<Account> accList)
    {
        System.debug('inside deletechannelPartner accountList:::'+accList);
        List<Channel_Partner__c> ChannelTobedeleteList = new List<Channel_Partner__c>();
        ChannelTobedeleteList = [Select Id,Name,Channel_Partner__c from Channel_Partner__c where Channel_Partner__c = null];
        System.debug('ChannelTobedeleteList::'+ChannelTobedeleteList);
        
        if(!ChannelTobedeleteList.isEmpty())
        {
            try
            {
                delete ChannelTobedeleteList;
            }
            catch(Exception e)
            {
                System.debug('Exception::'+e);
            }
        }
        
    }

}