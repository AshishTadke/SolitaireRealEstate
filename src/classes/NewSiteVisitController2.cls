public with sharing class NewSiteVisitController2{

    public List<Site_Visit__c> svlist{get;set;}
    public List<Opportunity> oplist{get;set;}
    public List<Task> tlist{get;set;}
    public string opid{get;set;}
    public boolean isError{get;set;}
    public boolean isSaved{get;set;}
    public boolean ShowSection {get; set;}
    public Site_Visit__c sv {get;set;}
    public Task TK {get;set;}
    public string sss{get;set;}
    Public string Name{get;set;}
    public List<Opportunity> presaleslist;
    public List<Channel_Partner__c> cplist;
    public String getJSStart() { return '<script>document.write('; } 
    public String getJSEnd() { return ')</script>'; }
    
    public NewSiteVisitController2(){
    
    isSaved = false;
    presaleslist = new List<Opportunity>();
    cplist = new List<Channel_Partner__c>();
    ShowSection = false;
    Integer i = 0;
    if(ApexPages.currentPage().getParameters().get('opid') != null && ApexPages.currentPage().getParameters().get('opid') != '')
    {
        opid = ApexPages.currentPage().getParameters().get('opid');
        system.debug('Opportunity ID***'+opid);
    }    
    sv = new Site_Visit__c();
    
    if(opid != null){
         oplist = [Select id, Name, Project__c,Project__r.Name, Walk_in_Sub_Source__c, Sales_Manager__c, AccountId, Account.PersonMobilePhone, 
                   Account.PersonEmail, Account.Ethnicity__c, Account.Address_Local__c, LeadSource, Lead_Sub_Source__c from Opportunity where id =: opid];   
                   
         system.debug('OPLIST**'+oplist);
         if(!oplist.isEmpty()){
             for(Opportunity o : oplist){
                sv.Customer_Name__c= opid;
                sv.Client_Name__c= o.Name;
                sv.Source1__c = o.LeadSource;
                sv.Sub_Source2__c = o.Lead_Sub_Source__c;
                sv.Project__c = o.Project__c;
                //sv.Email_Id__c = o.Account.PersonEmail;
                //sv.Mobile_No__c = o.Account.PersonMobilePhone;
                sv.Ethnicity__c = o.Account.Ethnicity__c;
                //sv.Residential_Address__c = o.Account.Address_Local__c;
                //sv.Type_Of_Visit__c = o.Type_Of_Visit__c;
                //sv.First_Visit_Date__c = o.Last_Visit_Date__c;    
             }    
         }
         //TK = new Task();
         svlist = [select Id,Name,CreatedDate,Budget__c,Purpose_of_Purchase__c,Residentail__c,Type_Of_Visit__c,Source1__c,Sub_Source2__c, 
         Channel_Partner__c,LastActivityDate,Walk_in_Details__c from  Site_Visit__c where Customer_Name__c=: opid ORDER BY CreatedDate DESC];
         if(!svlist.isEmpty() && svlist.Size() > 0){
             sv.Type_Of_Visit__c = 'Revisit';
             sv.Last_Visit_Date__c = svlist[0].CreatedDate;
             //TK.Subject = 'Re-Visit';
         }
         else{
             sv.Type_Of_Visit__c = 'Fresh';
             //TK.Subject = 'Site Visit';
         }
        //TK.Task_Type__c = 'Site Visit'
        //TK.Walk_in_Source__c = sv.Source1__c;
        //TK.Walk_in_Sub_Source__c= sv.Sub_Source2__c ;
        //TK.Sales_Attempted_By__c = sv.Owner.Name;
        //TK.Call_Attempted_By_Name__c = UserInfo.getUserName(); /// UserInfo.getuserId()
        //TK.Call_Rating__c= 'Hot';
        //TK.Channel_Partner__c= sv.Channel_Partner__c;
        //TK.Budget_Site_Visit_In_Lacs__c = sv.Budget1__c;
        //TK.Registraion_Status__c = sv.Purpose_of_Purchase__c;
        //TK.Configuration__c = sv.Residentail__c;
        //TK.WhatId= opid;
        //TK.activityDate = System.today();
        //TK.Call_Time__c = System.Now().format('h:mm a');
        //TK.status = 'Completed';
        //TK.Subject = 'Site Visit';
        //TK.Task_Type__c = sv.Sub_Source2__c
        
      }        
        
        
    
    }
    
    public void Assign(){
    
        system.debug('IN Assign METHOD OBJECT IS**'+sv);
        
        if(sv.Customer_Name__c != null){
         oplist = [Select id,Name,Project__c,Walk_in_Sub_Source__c,Sales_Manager__c,AccountId,Account.PersonMobilePhone,
                  Account.PersonEmail,Account.Ethnicity__c,Account.Address_Local__c from Opportunity where id =: sv.Customer_Name__c];   
                   
         system.debug('OPLIST**'+oplist);
         if(!oplist.isEmpty()){
             for(Opportunity o : oplist){
                //sv.Client_Name__c = o.Name;
                //sv.Walk_In_Source__c = o.Walk_in_Sub_Source__c;
                //sv.Attended_By_Sales__c = o.Sales_Manager__c;
                //sv.Project_Name__c = o.Project__c;
                //sv.Email_Id__c = o.Account.PersonEmail;
                //sv.Mobile_No__c = o.Account.PersonMobilePhone;
                //sv.Ethnicity__c = o.Account.Ethnicity__c;
                //sv.Residential_Address__c = o.Account.Address_Local__c;
                //sv.Type_Of_Visit__c = o.Type_Of_Visit__c;
                //sv.First_Visit_Date__c = o.Last_Visit_Date__c;      
             }    
         }
      }
    
    }
   
    
    
    
    /*public void RegCP(){
    
        system.debug('CHANNEL PARTNER SELECTED**'+sv.Channel_Partner__c);
        if(sv.Channel_Partner__c != null)
        {
            cplist = [select id,Name,Registration_Code__c from Channel_Partner__c where id =: sv.Channel_Partner__c];
            system.debug('CP LIST**'+cplist);
            if(!cplist.isEmpty() || cplist.size() != 0)
            {
                for(Channel_Partner__c c : cplist)
                {
                    if(c.Registration_Code__c != null)
                    {
                        system.debug('inside IF cp');
                        sv.CP_Registration_Number__c = c.Registration_Code__c;
                    }
                    else
                    {
                        system.debug('INside ELSE CP');
                        sv.CP_Registration_Number__c = 'CP Not Registered';
                    }
                }
            }
        }    
    
    }*/
    
    public PageReference Save(){
        isError = false;
             if (sv.Walk_in_Details__c  == null || sv.Walk_in_Details__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Walk-in Details is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (!ShowSection) {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please Fill The Sales Manager Section');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.Location__c == null || sv.Location__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Location is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.City__c == null || sv.City__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field City is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.SM_feedback_on_customer_Remarks__c == null || sv.SM_feedback_on_customer_Remarks__c == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Remarks (Sales Manager Section) is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.Current_House_Ownership__c == null || sv.Current_House_Ownership__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Current House Ownership is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.Occupation__c == null || sv.Occupation__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Occupation is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            /*if (sv.Budget__c == null || sv.Budget__c  == 0) {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Budget is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }*/
             
            if (sv.Desired_Possession__c == null || sv.Desired_Possession__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Desired Possessionis unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.Purpose_of_Purchase__c == null || sv.Purpose_of_Purchase__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Purpose of Purchase is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
             
        try{
            if(!isError) {
                 insert sv;
                 //insert TK;
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Site Visit Submitted Successfully.'));
                 isSaved = true;
                 
            }
            }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error in Site Visit Submission.'));
        }
       
        return null;
    }
}