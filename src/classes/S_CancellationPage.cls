public with sharing class S_CancellationPage {
    
    public String strcancelId {get; set;}
 	public String strMode {get;set;}
 	public Boolean letterHead {get;set;}
 	
    public S_CancellationPage()
    {
        if(ApexPages.currentPage().getParameters().get('cancelId') != null && ApexPages.currentPage().getParameters().get('cancelId') != '')
        {
            strcancelId = ApexPages.currentPage().getParameters().get('cancelId');
        }
       
        if(ApexPages.currentPage().getParameters().get('mode') != null && ApexPages.currentPage().getParameters().get('mode') != '')
        {
            strMode = ApexPages.currentPage().getParameters().get('mode');
        }
       
        if(ApexPages.currentPage().getParameters().get('letterHead') != null && ApexPages.currentPage().getParameters().get('letterHead') != '')
        {
            String lh = ApexPages.currentPage().getParameters().get('letterHead');
            if(String.isNotBlank(lh) && lh.equalsIgnoreCase('true'))
            	letterHead = true;
            else 
            	letterHead = false;
        }
    }
}