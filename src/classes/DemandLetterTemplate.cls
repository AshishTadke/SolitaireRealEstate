public class DemandLetterTemplate 
{
    public String strDemandInvId {get; set;}
    public String strConsStageId {get; set;}
    public String strOppId {get; set;}
    public String strmileStoneList {get;set;}
        public String strMode {get;set;}
        public String strDemandType {get;set;}
        public Decimal advanceAmt {get;set;}
        public Decimal stAmt {get;set;}
        public Boolean letterHead {get;set;}
    public DemandLetterTemplate()
    {
        if(ApexPages.currentPage().getParameters().get('DemandInvId') != null && ApexPages.currentPage().getParameters().get('DemandInvId') != '')
        {
            strDemandInvId = ApexPages.currentPage().getParameters().get('DemandInvId');
        }
        // Not using it in the new version. Leaving it as for the older version to work if need be
        else if(ApexPages.currentPage().getParameters().get('oppid') != null && ApexPages.currentPage().getParameters().get('consid') != null)
        {
            strOppId = ApexPages.currentPage().getParameters().get('oppid');
            strConsStageId = ApexPages.currentPage().getParameters().get('consid');
        }
        if(ApexPages.currentPage().getParameters().get('mileStoneList') != null && ApexPages.currentPage().getParameters().get('mileStoneList') != '')
        {
            strmileStoneList = ApexPages.currentPage().getParameters().get('mileStoneList');
        }
        if(ApexPages.currentPage().getParameters().get('mode') != null && ApexPages.currentPage().getParameters().get('mode') != '')
        {
            strMode = ApexPages.currentPage().getParameters().get('mode');
        }
        if(ApexPages.currentPage().getParameters().get('demandType') != null && ApexPages.currentPage().getParameters().get('demandType') != '')
        {
            strDemandType = ApexPages.currentPage().getParameters().get('demandType');
        }
        if(ApexPages.currentPage().getParameters().get('advanceAmt') != null && ApexPages.currentPage().getParameters().get('advanceAmt') != '')
        {
            advanceAmt = Decimal.valueOf(ApexPages.currentPage().getParameters().get('advanceAmt'));
        }
        if(ApexPages.currentPage().getParameters().get('stAmt') != null && ApexPages.currentPage().getParameters().get('stAmt') != '')
        {
            stAmt = Decimal.valueOf(ApexPages.currentPage().getParameters().get('stAmt'));
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