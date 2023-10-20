public with sharing class QuotationStartController
{
     public string unitId{get;set;}
     public string oppId{get;set;}
     public Project_Unit__c u{get;set;}
     public Project__c proj{get;set;}
     public opportunity opp{get;set;}
     public Quotation__c qObj{get;set;}
     public List<Payment_Plan__c> payPlanList {get;set;}
     public list<SelectOption> getPlans{get;set;}
     public string selectedPlanId{get;set;}
 
     public QuotationStartController(){
            u = new Project_Unit__c ();
            proj = new Project__c();
            opp = new Opportunity();
            qObj = new Quotation__c();
            
            if(ApexPages.currentPage().getParameters().containsKey('id'))       
                unitId = (Id)ApexPages.currentPage().getParameters().get('id');    
            if(ApexPages.currentPage().getParameters().containsKey('oppId') && string.isNotBlank(ApexPages.currentPage().getParameters().get('oppId')))  
                oppId = (Id)ApexPages.currentPage().getParameters().get('oppId'); 
            
            if( string.isNotBlank(unitId)) {
                u = InventoryCostServices.getUnitDetails(unitId);
                //system.debug('u is:: '+u);
                if(u != null){
                    qObj.Project_Unit__c = u.id;
                }
                proj = InventoryCostServices.getProjectDetails(unitId);
                if(proj != null){
                    qObj.Project__c = proj.id;
                    //system.debug('proj is:: '+proj);
                }
            }
            if(string.isNotBlank(oppId)) {
                opp = [Select Id, Name, Account.Name, StageName, Sales_Manager__c from Opportunity where Id = :oppId];
                qObj.Opportunity__c = opp.Id;
            }    
       
     }   
     
     Public void populatePaymentPlan(){
     system.debug('inside plan method');
             getPlans = new list<SelectOption>();
             getPlans.add(new SelectOption('', 'Select a Payment Plan'));
             payPlanList = getPlanList(u.Project__r.Id, u.TowerName__r.Id);
             system.debug('payPlanList:: '+payPlanList);
             if(!payPlanList.isEmpty()){
                 
                  for(Payment_Plan__c pl : payPlanList){
                      getPlans.add(new SelectOption(pl.Id, pl.name));
                  }
             }
     }
     
     public pageReference startQuote(){
         boolean isError = false;
         if(qObj.Opportunity__c == null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please select Opportunity.'));
              isError = true;
         }
         if(qObj.Project__c == null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please select Project.'));
         }
         if(qObj.Project_Unit__c == null){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please select Project Unit.'));
              isError = true;
         }
         if(string.isBlank(qObj.Plan_Type__c)){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please select Plan Type.'));
             isError = true;
         }
         if(string.isNotBlank(qObj.Plan_Type__c) && qObj.Plan_Type__c.equals('Subvention Plan') && string.isBlank(selectedPlanId)){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please select Payment plan.'));
             isError = true;
         }
         
         if(!isError){
             if(string.isNotBlank(selectedPlanId)){
                 PageReference pageRef = new PageReference('/apex/Quotation2');
                 pageRef.getParameters().put('id',qObj.Project_Unit__c);
                 pageRef.getParameters().put('oppId',qObj.Opportunity__c);
                 pageRef.getParameters().put('subPlanId',selectedPlanId); 
                 pageRef.getParameters().put('Finished',qObj.Finished_Unfinished__c);
                 pageRef.getParameters().put('SubCharge',qObj.Subvention_Charge__c);
                 return pageRef;
             }
             else{
                 PageReference pageRef = new PageReference('/apex/Quotation2');
                 pageRef.getParameters().put('id',qObj.Project_Unit__c);
                 pageRef.getParameters().put('oppId',qObj.Opportunity__c);
                 pageRef.getParameters().put('Finished',qObj.Finished_Unfinished__c);
                 pageRef.getParameters().put('SubCharge',qObj.Subvention_Charge__c);
                 return pageRef;
             }
            /* if(qObj.Plan_Type__c.equals('Non Subvention Plan')){
                 PageReference pageRef = new PageReference('/apex/quotation2');
                 pageRef.getParameters().put('id',qObj.Project_Unit__c);
                 pageRef.getParameters().put('oppId',qObj.Opportunity__c);
                 //pageRef.getParameters().put('planType','Non Subvention Plan');
                 return pageRef;
             }
             if(qObj.Plan_Type__c.equals('Subvention Plan')){
                 PageReference pageRef = new PageReference('/apex/QuoteSubvention2');
                 pageRef.getParameters().put('id',qObj.Project_Unit__c);
                 pageRef.getParameters().put('oppId',qObj.Opportunity__c);
                 pageRef.getParameters().put('subPlanId',selectedPlanId); 
                 return pageRef;
             }*/
         }    
     
         return null;
         
     }
     
     public PageReference cancel() {
        pageReference pRef = ApexPages.currentPage();
        pRef.setRedirect(true);
        return pRef;
    }
    
    public static List<Payment_Plan__c> getPlanList(Id projId, Id tId) {
       // System.debug('PID:' + projId + 'Tower Id:' + tID);
        List<Payment_Plan__c> planListNew = [Select Id, Name, Bank_Loan_Self_Funded__c, Plan_Code__c,Sub_Vention__c from Payment_Plan__c where project__r.Id = : projId and tower__r.Id = :tId and Sub_Vention__c = true];
        return planListNew;
    }
    
}