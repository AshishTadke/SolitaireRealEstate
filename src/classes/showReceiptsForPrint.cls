public with sharing class showReceiptsForPrint {
    public Id strreceiptId {get;set;}
    public Boolean letterHead {get;set;}
    public showReceiptsForPrint()
    {
	    if(ApexPages.currentPage().getParameters().get('receiptId') != null && ApexPages.currentPage().getParameters().get('receiptId') != '') {
	    	strreceiptId = Id.valueOf(ApexPages.currentPage().getParameters().get('receiptId'));
	    }
	    if(ApexPages.currentPage().getParameters().get('letterHead') != null && ApexPages.currentPage().getParameters().get('letterHead') != ''){
	    	String lh = ApexPages.currentPage().getParameters().get('letterHead');
	    	if(String.isNotBlank(lh) && lh.equalsIgnoreCase('true'))
	        	letterHead = true;
	        else 
	        	letterHead = false;
	    }
    }
}