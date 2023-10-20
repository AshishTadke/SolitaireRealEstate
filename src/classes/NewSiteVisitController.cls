public with sharing class NewSiteVisitController{

    public List<Site_Visit__c> svlist{get;set;}
    public List<Opportunity> oplist{get;set;}
    public List<Account> Acclist{get;set;}
    public string opid{get;set;}
    public boolean isError{get;set;}
    public boolean isSaved{get;set;}
    public boolean ShowSection {get; set;}
    public Site_Visit__c sv {get;set;}
    public Task TK {get;set;}
    public string sss{get;set;}
    Public Integer i {get;set;}
    public Lead objLead {get;set;}
    public string strRecordTypeId{get;set;}
    Public Project__c projObj {get;set;}
    public Opportunity objOpty {get;set;}
    public Account objAcc {get;set;}
    public List<Opportunity> presaleslist;
    public List<Channel_Partner__c> cplist;
    public string strLeadId {get;set;}
    public string strOptyId {get;set;}
    public string strAccountId {get;set;}
    public String strprojectId {get;set;} 
    public String strMobile {get;set;}
    public String stremail {get;set;}
    
 
    
    public NewSiteVisitController(){
    
      sv = new Site_Visit__c();
      projObj = new Project__c();
      sv.Type_Of_Visit__c = 'Fresh';  
        
        isSaved = false;
        if (Apexpages.Currentpage().getParameters().get('Leadid') != null && Apexpages.Currentpage().getParameters().get('Leadid') != '')
            strLeadId = Apexpages.Currentpage().getParameters().get('Leadid');
        if (Apexpages.Currentpage().getParameters().get('optyid') != null && Apexpages.Currentpage().getParameters().get('optyid') != '')
            strOptyId = Apexpages.Currentpage().getParameters().get('optyid');
        if (Apexpages.Currentpage().getParameters().get('Accid') != null && Apexpages.Currentpage().getParameters().get('Accid') != '')
            strAccountId = Apexpages.Currentpage().getParameters().get('Accid');
        if (Apexpages.Currentpage().getParameters().get('projectId') != null && Apexpages.Currentpage().getParameters().get('projectId') != '')
            strprojectId = Apexpages.Currentpage().getParameters().get('projectId');
        if (Apexpages.Currentpage().getParameters().get('mobile') != null && Apexpages.Currentpage().getParameters().get('mobile') != '')
            strMobile = Apexpages.Currentpage().getParameters().get('mobile');
        
        if (Apexpages.Currentpage().getParameters().get('email') != null && Apexpages.Currentpage().getParameters().get('email') != '')
            stremail = Apexpages.Currentpage().getParameters().get('email');
         strRecordTypeId=Apexpages.Currentpage().getParameters().get('RecordTypeId');
         
         if (strprojectId != null && strprojectId != '') {
            projObj = [Select Id, name from Project__c where id = : strprojectId];
            //strProjectName=projObj.Name;
        }
         if(strMobile != null && strMobile != '') {
            sv.Mobile_No2__c = strMobile;
            sv.Project__c = projObj.Id;
            sv.Email2__c = stremail;
                 
        }
        else if (strLeadId != null && strLeadId != '') {
            
            objLead = [Select Id, firstname,lastname,salutation, MobilePhone, RDS_Alternate_Mobile_No__c,RDS_Project__r.Name,Occupation__c,
                      street,city,state,country,postalcode,Email,RDS_Alternate_Email_Id__c,LeadSource,Phone,Company_Name__c,Lead_Sub_Source__c,
                      Designation__c,RDS_Budget__c,Possession_Requirement__c,Project_Type__c,Budget_In_lacs__c,
                      RDS_Unit_type_configuration__c,Ethnicity__c,Channel_Partner__c
                      from Lead where Id=:strLeadId];
            
            sv.Project__c = projObj.Id;
            sv.Customer_Name1__c=objlead.lastname;
            sv.Mobile_No2__c = objLead.MobilePhone;
            sv.Email2__c = objLead.Email;
            sv.Designation__c=objLead.Designation__c;
            sv.Ethnicity__c=objLead.Ethnicity__c;
            sv.Occupation__c = objLead.Occupation__c;
            
            if (objLead.LeadSource != null && objLead.LeadSource != '') {
            sv.Source1__c = objLead.LeadSource;
            }
            else{
            sv.Source1__c = 'Walk-In';
            }
            
            if (objLead.Lead_Sub_Source__c != null && objLead.Lead_Sub_Source__c != '') {
            sv.Sub_Source2__c = objLead.Lead_Sub_Source__c;
            }
            else{
            sv.Sub_Source2__c = 'Walk-In';
            }
            
            if (objLead.Channel_Partner__c != null) {
            sv.Channel_Partner__c = objLead.Channel_Partner__c;
            }
            
            
           
        }
        else if(strAccountId != null && strAccountId != '') {
            objAcc = [Select Id, PersonMobilePhone,Salutation,Residential_Zip_Postal_Code__c,Residential_Street__c,Alternate_Email__c,Phone,
                                Birth_Date__c,City_R__c,Country_R__c,Residential_State_Province__c, Alternate_Mobile_No__c, PersonEmail,firstname,lastname,
                             billingstreet,billingcity,billingstate,billingcountry,billingpostalcode,Designation_Permanent__c,
                             Suburb_R__c,S_Zone_R__c,Office_Street__c,Office_City__c,Office_State_Province__c,Office_Country__c,Office_Zip_Postal_Code__c,
                             Suburb_O__c,Zones__c,Occupation__c,Company_Name__c,Ethnicity__c 
                             from Account where Id =:strAccountId];
                             
            sv.Project__c = projObj.Id;
            sv.Customer_Name1__c = objAcc.lastname;
            sv.Mobile_No2__c = objAcc.PersonMobilePhone;
            sv.Email2__c = objAcc.personEmail;
            sv.Date_Of_Birth__c= objAcc.Birth_Date__c;
            sv.City__c = objAcc.City_R__c;
            sv.Pin_code__c=objAcc.Residential_Zip_Postal_Code__c;
            sv.Ethnicity__c=objAcc.Ethnicity__c;
            sv.Source1__c = 'Walk-In';
            sv.Sub_Source2__c = 'Walk-In';
                      
        }
    
    
    else if(strOptyId!= null && strOptyId != ''){
         objOpty=[select Name,Account_Mobile_Number__c,Walk_in_Source__c,Walk_in_Sub_Source__c,
                     Account.Alternate_Email__c,LeadSource,Email__c,Project__c,Lead_Sub_Source__c,
                     AccountId,Account.PersonEmail,Budget_Site_Visit_In_Lacs__c,Channel_Partner__c
                     from Opportunity where Id=:strOptyId]; 
                   
                sv.Customer_Name__c= strOptyId;
                sv.Client_Name__c= objOpty.Name;
                sv.Project__c= objOpty.Project__c;
                sv.Mobile_No2__c = objOpty.Account_Mobile_Number__c;
                sv.Email2__c = objOpty.Account.PersonEmail;
            
              
            if (objOpty.LeadSource != null && objOpty.LeadSource != '') {
            sv.Source1__c = objOpty.LeadSource;
            }
            else{
            sv.Source1__c = 'Walk-In';
            }
            
            if (objOpty.Lead_Sub_Source__c != null && objOpty.Lead_Sub_Source__c != '') {
            sv.Sub_Source2__c = objOpty.Lead_Sub_Source__c;
            }
            else{
            sv.Sub_Source2__c = 'Walk-In';
            }
            
            if (objOpty.Channel_Partner__c != null) {
            sv.Channel_Partner__c = objOpty.Channel_Partner__c;
            }
                                  
         
         
         svlist = [select Id,Name,CreatedDate,Budget__c,Purpose_of_Purchase__c,Residentail__c,Type_Of_Visit__c,Source1__c,Sub_Source2__c,
         Channel_Partner__c,LastActivityDate,Walk_in_Details__c from  Site_Visit__c where Customer_Name__c=: strOptyId ORDER BY CreatedDate DESC];
         if(!svlist.isEmpty() && svlist.Size() > 0){
             sv.Type_Of_Visit__c = 'Revisit';
             sv.Last_Visit_Date__c = svlist[0].CreatedDate;
             
         }
         else{
             
             
         }
        
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
                     
             }    
         }
      }
    
    }
    
   public PageReference Save(){
   Savepoint sp = Database.setSavepoint();
        isError = false;
             if (sv.Walk_in_Details__c  == null || sv.Walk_in_Details__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Walk-in Details is unavailable');
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
             
                        
            if (sv.Desired_Possession__c == null || sv.Desired_Possession__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Desired Possessionis unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             if (sv.Source1__c == null || sv.Source1__c== '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Source is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             if (sv.Sub_Source2__c == null || sv.Sub_Source2__c == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Source detail is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
            if (sv.Purpose_of_Purchase__c == null || sv.Purpose_of_Purchase__c  == '') {             
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Required Field Purpose of Purchase is unavailable');
             ApexPages.addMessage(myMsg);
             isError = true;
             }
             
             
        try{
           
            if(strMobile!='' && strMobile!=null)
            {
                
                System.debug('Inside Mobile Check');
                Lead newLead=new Lead();
                newLead.MobilePhone = sv.Mobile_No2__c;
                newLead.Email = sv.Email2__c;
                newLead.LastName = sv.Customer_Name1__c;
                //newLead.Budget_In_lacs__c = sv.Budget1__c;
                newLead.Occupation__c  = sv.Occupation__c;
                newLead.LeadSource=sv.Source1__c;
                newLead.Lead_Sub_Source__c=sv.Sub_Source2__c;
                
                if (sv.Channel_Partner__c != null) {
                newLead.Channel_Partner__c = sv.Channel_Partner__c;
                }
                
                
                insert newLead;
                
                System.debug('Insert Lead Successfull');                
                List < Lead > leadListToconvert = new List < Lead > ();
                List < Lead > ConvertedLeadlist = new List < Lead > ();
                Opportunity optyObjToupdate = new Opportunity();
                
                leadListToconvert.add(newLead);
                System.debug('Added For convert');
                System.debug(+leadListToconvert);
                  if (leadListToconvert != null)
                    convertCIFLeads(leadListToconvert);
                    
                System.debug('Convert Method Call');
                
               ConvertedLeadlist = [select Id, Name, IsConverted,ConvertedAccountId, ConvertedOpportunityId   from Lead
                        where Id = : newLead.Id and Isconverted = true
                        order by LastModifiedDate Desc limit 1];
                
                optyObjToupdate = [Select Id,Name,CloseDate, Project__c,Walk_in_Source__c,Walk_in_Sub_Source__c,
                                   Sales_Manager__c,Unique_SVF_Number__c 
                                   from Opportunity where Id =: ConvertedLeadlist[0].ConvertedOpportunityId];
                //accObjToupdate=[Select Id,Walk_in_Source__c,Walk_in_Sub_Source__c,Sales_Manager__c from Opportunity where Id =: ConvertedLeadlist[0].ConvertedAccountId]
                sv.Customer_Name__c = ConvertedLeadlist[0].ConvertedOpportunityId;
                optyObjToupdate.Name=sv.Customer_Name1__c;
                optyObjToupdate.Project__c=sv.Project__c; 
                optyObjToupdate.Walk_in_Source__c=sv.Source1__c;
                optyObjToupdate.Walk_in_Sub_Source__c=sv.Sub_Source2__c;
                
                if (sv.Channel_Partner__c != null) {
                optyObjToupdate.Channel_Partner__c = sv.Channel_Partner__c;
                }
                
                update optyObjToupdate;
                
                insert sv;
                
                
                
                Pagereference objReference = new Pagereference('/' + sv.Customer_Name__c ); 
                objReference.setRedirect(true);
                return objReference;
                
            }
             else if (strLeadId != null && strLeadId != '') {
                if(objLead.RDS_Project__c == projObj.Id)
                {
                    
                   
                    System.debug('Inside Same Project');
                    
                    objLead.LastName= sv.Customer_Name1__c;
                    objLead.MobilePhone=sv.Mobile_No2__c;
                    objLead.Email=sv.Email2__c;
                    objLead.Occupation__c  = sv.Occupation__c;
                    
            
            if (objLead.LeadSource != null && objLead.LeadSource != '') {
            sv.Source1__c = objLead.LeadSource;
            }
            else{
            sv.Source1__c = 'Walk-In';
            }
            
            if (objLead.Lead_Sub_Source__c != null && objLead.Lead_Sub_Source__c != '') {
            sv.Sub_Source2__c = objLead.Lead_Sub_Source__c;
            }
            else{
            sv.Sub_Source2__c = 'Walk-In';
            }
            
            if (sv.Channel_Partner__c != null) {
                objLead.Channel_Partner__c = sv.Channel_Partner__c;
            }
                    
                    
                    update objLead;
                   
                    
                    System.debug('Insert Lead Successfull');                
                List < Lead > leadListToconvert = new List < Lead > ();
                List < Lead > ConvertedLeadlist = new List < Lead > ();
                Opportunity optyObjToupdate = new Opportunity();
                
                leadListToconvert.add(objLead);
                System.debug('Added For convert');
                System.debug(+leadListToconvert);
                  if (leadListToconvert != null)
                    convertCIFLeads(leadListToconvert);
                    
                System.debug('Convert Method Call');
                
               ConvertedLeadlist = [select Id, Name, IsConverted, ConvertedAccountId, ConvertedOpportunityId,RDS_Project__c from Lead
                        where Id = : objLead.Id and Isconverted = true
                        order by LastModifiedDate Desc limit 1];
                
                optyObjToupdate = [Select Id,Name,Project__c,CloseDate,Walk_in_Sub_Source__c,Channel_Partner__c,Sales_Manager__c,Unique_SVF_Number__c from Opportunity where Id =: ConvertedLeadlist[0].ConvertedOpportunityId];
                
                sv.Customer_Name__c = ConvertedLeadlist[0].ConvertedOpportunityId;
                 optyObjToupdate.Name=sv.Customer_Name1__c;
                optyObjToupdate.Project__c=sv.Project__c; 
                optyObjToupdate.Walk_in_Source__c=sv.Source1__c;
                optyObjToupdate.Walk_in_Sub_Source__c=sv.Sub_Source2__c;
                
                if (sv.Channel_Partner__c != null) {
                optyObjToupdate.Channel_Partner__c = sv.Channel_Partner__c;
                }
                
                update optyObjToupdate;
                
                insert sv;
                
                
                
                Pagereference objReference = new Pagereference('/' + sv.Customer_Name__c ); //objLead.Id
                objReference.setRedirect(true);
                return objReference;
                    
                }
            
            else
                  {                     
                      System.debug('Inside Different Project');
                      
                    objLead.LastName= sv.Customer_Name1__c;
                    objLead.MobilePhone=sv.Mobile_No2__c;
                    objLead.Email=sv.Email2__c;
                    objLead.RDS_Project__c = projObj.Id;
                    objLead.Occupation__c  = sv.Occupation__c;
            if (objLead.LeadSource != null && objLead.LeadSource != '') {
            sv.Source1__c = objLead.LeadSource;
            }
            else{
            sv.Source1__c = 'Walk-In';
            }
            
            if (objLead.Lead_Sub_Source__c != null && objLead.Lead_Sub_Source__c != '') {
            sv.Sub_Source2__c = objLead.Lead_Sub_Source__c;
            }
            else{
            sv.Sub_Source2__c = 'Walk-In';
            }
            
            if (sv.Channel_Partner__c != null) {
            objLead.Channel_Partner__c = sv.Channel_Partner__c;
            }        
                   
                    
                    update objLead;
                     System.debug('Insert Lead Successfull');
                    
                        List < Lead > leadListToconvert = new List < Lead > ();
                        List < Lead > ConvertedLeadlist = new List < Lead > ();
                        Opportunity objOptyToInsert = new Opportunity();
                        leadListToconvert.add(objLead);
                       if (leadListToconvert != null) 
                            convertCIFLeads(leadListToconvert);
                      ConvertedLeadlist = [select Id, Name, IsConverted, ConvertedAccountId, ConvertedOpportunityId,RDS_Project__c,Channel_Partner__c from Lead
                            where Id = : objLead.Id and Isconverted = true
                            order by LastModifiedDate Desc limit 1];
                      objOptyToInsert.Name=sv.Customer_Name1__c;
                      objOptyToInsert.Project__c=sv.Project__c;
                      objOptyToInsert.stagename = 'Opportunity Identified';
                      objOptyToInsert.CloseDate=System.today().addDays(90);
                      objOptyToInsert.AccountId=ConvertedLeadlist[0].ConvertedAccountId;
                      objOptyToInsert.Walk_in_Source__c=sv.Source1__c;
                      objOptyToInsert.Walk_in_Sub_Source__c=sv.Sub_Source2__c;
                      
                      
                      if (sv.Channel_Partner__c != null) {
                      objOptyToInsert.Channel_Partner__c = sv.Channel_Partner__c;
                      } 
                      
                      insert objOptyToInsert;
                      sv.Customer_Name__c = objOptyToInsert.Id;
                      
                      insert sv;
                                       
                  }
               }
               else if(strAccountId != null && strAccountId != '')
             {                                          
                System.debug('Inside Account');
                objAcc.PersonMobilePhone=sv.Mobile_No2__c;
                objAcc.PersonEmail=sv.Email2__c;
                objAcc.Phone=sv.Mobile_No2__c;
                objAcc.Birth_Date__c=sv.Date_Of_Birth__c;
                objAcc.City_R__c=sv.City__c;
                objAcc.Residential_Zip_Postal_Code__c= sv.Pin_code__c;
                objAcc.Ethnicity__c= sv.Ethnicity__c;
                objAcc.Occupation__c=sv.Occupation__c;
                update objAcc;
                
                System.debug('In Account Check Opty insert');
                Opportunity objOptyToInsert = new Opportunity(); 
                objOptyToInsert.Name=sv.Customer_Name1__c;
                objOptyToInsert.Project__c = projObj.Id;
                objOptyToInsert.CloseDate=System.today().addDays(90);
                objOptyToInsert.LeadSource=sv.Source1__c;
                //objOptyToInsert.Budget_Site_Visit_In_Lacs__c = sv.Budget1__c;
                objOptyToInsert.Walk_in_Source__c=sv.Source1__c;
                objOptyToInsert.Walk_in_Sub_Source__c=sv.Sub_Source2__c;
                objOptyToInsert.stagename = 'Opportunity Identified';
                objOptyToInsert.AccountId =objAcc.Id;
                objOptyToInsert.Lead_Source__c = sv.Source1__c;
                objOptyToInsert.Lead_Sub_Source__c = sv.Sub_Source2__c;
              
                if (sv.Channel_Partner__c != null) {
                objOptyToInsert.Channel_Partner__c = sv.Channel_Partner__c;
                } 
                
                insert objOptyToInsert;
                sv.Customer_Name__c = objOptyToInsert.Id;
                insert sv;
               
                
            }
            else if(strOptyId!=null)
            {
                system.debug('---------Inside opty validity check------------');
                sv.Customer_Name__c = strOptyId;
                Opportunity optyObjToupdate = new Opportunity();
                optyObjToupdate=[Select Id,Walk_in_Source__c,Walk_in_Sub_Source__c,
                Sales_Manager__c from Opportunity where Id=:strOptyId];
                optyObjToupdate.Name=sv.Customer_Name1__c;
                optyObjToupdate.Project__c=sv.Project__c;
                optyObjToupdate.Walk_in_Source__c=sv.Source1__c;
                optyObjToupdate.Walk_in_Sub_Source__c=sv.Sub_Source2__c;
                optyObjToupdate.Unique_SVF_Number__c=sv.Name;
                update optyObjToupdate;
                
                
                sv.RecordTypeId=strRecordTypeId;
                insert sv;
                
                //optyObjToupdate.Unique_SVF_Number__c=sv.Name;
                
                
                //optyObjToupdate.Unique_SVF_Number__c=sv.Name;
                
            }
        
            Pagereference objReference = new Pagereference('/' + sv.Customer_Name__c); //objLead.Id
            objReference.setRedirect(true);
            return objReference;
               
            }
            
            
            catch(Exception ex){
            
            
            Database.rollback(sp);
            string strTempError = '';
            System.debug('Exception occured::'+ex);
            if (ex.getMessage() != null && ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') == true) {
                strTempError = ((ex.getMessage().split('FIELD_CUSTOM_VALIDATION_EXCEPTION,')[1]).split(':')[0]).trim();
            }

            if (ex.getMessage() != null && ex.getMessage().contains('INVALID_EMAIL_ADDRESS,') == true) {
                strTempError = ((ex.getMessage().split('INVALID_EMAIL_ADDRESS,')[1]).split(':')[0]).trim() + ' : ' + ((ex.getMessage().split('INVALID_EMAIL_ADDRESS,')[1]).split(':')[1]).trim();
            }
            //strError = strTempError != '' ? strTempError : ex.getMessage();
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error in Site Visit Submission.'));
            
           } 
    
        
        return null;

           }
    public void convertCIFLeads(List < Lead > ll) {
        for (lead myLead: ll) {
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(myLead.id);
                LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
                lc.setConvertedStatus(convertStatus.MasterLabel);
                Database.LeadConvertResult lcr = Database.convertLead(lc);
           
        }
    }
}