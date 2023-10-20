Public Class WelcomeCallRejectedPageController{
  public id WCHID {get;set;}
  public List<Welcome_Call_Checklist__c> WCCList {get;set;}
    public WelcomeCallRejectedPageController()
    {
        if(ApexPages.currentPage().getParameters().get('WCHid') != null && ApexPages.currentPage().getParameters().get('WCHid') != '')
        WCHID = ApexPages.currentPage().getParameters().get('WCHid');
        
        WCCList = [Select id,Name,Detail__c,Verify__c,Remarks__c,Welcome_Call_Header__r.Remarks__c,Welcome_Call_Header__c From Welcome_Call_Checklist__c Where Welcome_Call_Header__c =:WCHID and Verify__c =: False];
        system.debug('WCCList Size: ' + WCCList.size());
        if(WCCList.size() == 0)
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'There is no data for this call.');
            ApexPages.addMessage(myMsg);
        }
    
    }  

}