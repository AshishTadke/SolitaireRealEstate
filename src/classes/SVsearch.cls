public class SVsearch
{
     public List < SelectOption > lstProjectList {
        get;
        set;
    }
    public List<RecordType> SRVType{
        get;set;
    }
    public List<RecordType> SVType{
        get;set;
    }
    public String RecordTypeId{get;set;}
    
    public Lead NewLead {
        get;
        set;
    }
    public string strProjectId {
        get;
        set;
    }
    public string strError {
        get;
        set;
    }
    public list < Lead > lstDuplicateLeads {
        get;
        set;
    }
    public list < Lead > lstDuplicateLeadsEmail {
        get;
        set;
    }
    public list < Opportunity > lstDuplicateOpty {
        get;
        set;
    }
    public list < Account > lstDuplicateAccount {
        get;
        set;
    }
    public list < Account > lstDuplicateAccountEmail {
        get;
        set;
    }
    
    public Boolean isDuplicateLeadExist {
        get;
        set;
    }
    public Boolean isDuplicateAccountExist {
        get;
        set;
    }
    public Boolean isDuplicateAccountExistEmail {
        get;
        set;
    }
    
    public Boolean isDuplicateOptyExist {
        get;
        set;
    }
    public Boolean isMailDuplicateLeadExist{
        get;
        set;
    }
    public Boolean isNew {
        get;
        set;
    }
    public String OpportunityId {
        get;
        set;
    }
   
    
    public SVsearch()
    {
         NewLead = new Lead();
        lstProjectList = new List < SelectOption > ();
        strError = '';
        isDuplicateLeadExist = false;
        isDuplicateAccountExist = false;
        isDuplicateOptyExist = false;
        isNew = true;
        
        
        List < Project__c > lstProj = [select Id, name from Project__c]; //
        System.debug('lstProj ::' + lstProj);
        lstProjectList.add(new SelectOption('', '---Please Select Project---'));
        if (lstProj != null && lstProj.size() > 0) {
            for (Project__c EachProj: lstProj) {
                lstProjectList.add(new SelectOption(EachProj.id, EachProj.name));
            }
        }
    }
    
    public pagereference saveMethod()
    {
        
        strError = '';
        Savepoint sp = Database.setSavepoint();
        try {
            if (strProjectId == null || strProjectId == '') {
                strError = 'Please select the Project to proceed.';
                return null;
            }
            if (NewLead.MobilePhone == null || NewLead.MobilePhone == '') {
                strError = 'Please enter the Contact No to proceed.';
                return null;
            }
            list < Lead > lstLead = [Select Id, Name, MobilePhone, RDS_Alternate_Mobile_No__c,Phone, RDS_Project__r.Name,Owner.Name  
                                     from Lead where(mobilephone = : NewLead.MobilePhone OR Phone= : NewLead.MobilePhone) and isConverted = false]; //and RW_Project__c =: strProjectId
                System.debug(+lstLead);
            
            List < Account > lstAccount = [Select Id, Name, PersonMobilePhone, Alternate_Mobile_No__c,Phone, PersonEmail, Owner.Name from Account
                where(PersonMobilePhone = : NewLead.MobilePhone OR Phone= : NewLead.MobilePhone)
            ]; //
                System.debug(lstAccount);
            List < opportunity > lstOpp = new List < opportunity > ();
            if (lstLead != null && lstLead.size() > 0) {
                Pagereference objReference = new Pagereference('/apex/VisitFormEditPage2?Leadid=' + lstLead[0].id + '&projectId=' + strProjectId);
                objReference.setRedirect(true);
                return objReference;
            } else if (lstAccount != null && lstAccount.size() > 0) {
                lstOpp = [select id, Name, Project__r.Name, Account.PersonMobilePhone, Owner.Name, Account.Name, 
                          LeadSource, Lead_Sub_Source__c,Project__c,Booking__c, AccountId, Sales_Manager__c, Date_Of_Visit__c, Unique_SVF_Number__c  from Opportunity
                          where AccountId = : lstDuplicateAccount[0].Id and Project__c = : strProjectId  and Booking__c =: null
                ];
                System.debug(+lstOpp);
                Pagereference objReference;
                if (lstOpp != null && lstOpp.size() > 0) {
                    //lstOpp[0].Is_Revisit_done__c = true;
                    //lstOpp[0].Revisit_Date_Time__c = System.now();
                    update lstOpp;
                    
                    objReference = new Pagereference('/'+lstOpp[0].Id);
                    objReference.setRedirect(true);
                    //return objReference;
                } else {
                    objReference = new Pagereference('/apex/VisitFormEditPage2?Accid=' + lstAccount[0].id + '&projectId=' + strProjectId );
                    objReference.setRedirect(true);
                    
                }
                return objReference;
            } else {
                NewLead.RDS_Project__c = strProjectId;
                //insert NewLead;

                Pagereference objReference = new Pagereference('/apex/VisitFormEditPage2?mobile=' + NewLead.mobilephone + '&projectId=' + strProjectId + '&email='+ NewLead.Email );
                objReference.setRedirect(true);
                return objReference;
            }
        } catch (exception ex) {
            Database.rollback(sp);
            string strTempError = '';
            if (ex.getMessage() != null && ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION') == true) {
                strTempError = ((ex.getMessage().split('FIELD_CUSTOM_VALIDATION_EXCEPTION,')[1]).split(':')[0]).trim();
            }

            if (ex.getMessage() != null && ex.getMessage().contains('INVALID_EMAIL_ADDRESS,') == true) {
                strTempError = ((ex.getMessage().split('INVALID_EMAIL_ADDRESS,')[1]).split(':')[0]).trim() + ' : ' + ((ex.getMessage().split('INVALID_EMAIL_ADDRESS,')[1]).split(':')[1]).trim();
            }
            strError = strTempError != '' ? strTempError : ex.getMessage();

            return null;
        }
    }
    
   
    //on cancel button
    public PageReference goBack() {
            Pagereference objReference = new Pagereference('/');
            objReference.setRedirect(true);
            return objReference;
        }
    
    public pagereference updateRevisitOnOpty () {
        Opportunity OppOBJ = [select id, Name, Project__r.Name, Owner.Name, Account.Name,Account.PersonMobilePhone,Account.PersonEmail,
        LeadSource,Lead_Sub_Source__c, Project__c, AccountId, Sales_Manager__c, Date_Of_Visit__c, Unique_SVF_Number__c from Opportunity where id =:OpportunityId];
                                    
        
        SRVType =[SELECT Id,Name FROM RecordType WHERE SobjectType='Site_Visit__c'AND Name='Site revisit'];
        SVType=[SELECT Id,Name FROM RecordType WHERE SobjectType='Site_Visit__c'AND Name='Site Visit Form'];
        System.debug(+SVType);
        System.debug(+SRVType);
                if(OppOBJ.Unique_SVF_Number__c==null)
                {
                    System.debug('Opportunity Without site visit');
                    RecordTypeId=SVType[0].Id;
                    Pagereference objReference = new Pagereference('/apex/VisitFormEditPage2?RecordTypeId=' +RecordTypeId+'&projectId='+OppOBJ.Project__c+'&optyid='+OppOBJ.Id);
                    objReference.setRedirect(true);
                    return objReference;
                    //SVType[0].Id;
                    
                }
                else
                {
                    System.debug('Opportunity With site visit');
                    //OppOBJ.Is_Revisit_done__c = true;
                    //OppOBJ.Revisit_Date_Time__c = System.now();
                    update OppOBJ;
                    Site_Visit__c sv=new Site_Visit__c();
                    sv.RecordTypeId=SRVType[0].Id;
                    sv.Customer_Name__c =OppOBJ.Id;
                    sv.Project__c=OppOBJ.Project__c;
                    sv.Type_of_Visit__c = 'Revisit';
                    sv.Source1__c = OppOBJ.LeadSource;
                    sv.Sub_Source2__c = OppOBJ.Lead_Sub_Source__c;
                    sv.Mobile_No2__c = OppOBJ.Account.PersonMobilePhone;
                    sv.Email2__c = OppOBJ.Account.PersonEmail;
                    //sv.Date_Of_Site_Visit__c = System.today();    
                    insert sv;
                    
                }
                           
        Pagereference objReference = new Pagereference('/'+OppOBJ.id);
        objReference.setRedirect(true);
        return objReference;
    }
    
    
    public pagereference searchAllLead()
    {
        
        Set<Id> leadId = new Set<Id> ();
        Set<Id> accountId = new Set<Id> ();
        lstDuplicateLeadsEmail = new list < Lead > ();
        lstDuplicateLeads = new list < Lead > ();
        lstDuplicateOpty = new list < Opportunity > ();
        lstDuplicateAccount = new list < Account > ();
        strError = '';
        isDuplicateLeadExist = false;
        isDuplicateAccountExist = false;
        isDuplicateOptyExist = false;
        isMailDuplicateLeadExist = false;
        isDuplicateAccountExistEmail = false;
        if (strProjectId == null || strProjectId == '') {
            strError = 'Please select the Project to proceed.';
            return null;
        }

        if (NewLead.MobilePhone == null || NewLead.MobilePhone == '') {
            strError = 'Please enter the Mobile No to proceed.';
            return null;
        }

        /*if (NewLead.MobilePhone.length() != 10) {
            strError = 'Please enter the mobile number of 10 digit.';
            return null;
        }*/

        isNew = false;
        lstDuplicateLeads = [Select Id, Name, MobilePhone, RDS_Alternate_Mobile_No__c,Phone, RDS_Project__r.Name ,Email,
                             RDS_Alternate_Email_Id__c,Owner.Name
                             from Lead where(MobilePhone = : NewLead.MobilePhone OR Phone = : NewLead.MobilePhone) and isConverted = false]; //and RDS_Project__c =: strProjectId
        
        if(NewLead.Email != '')
        {
            
         system.debug('Email Field is not empty');   
            
        lstDuplicateLeadsEmail = [select Id, Name, MobilePhone,Phone,RDS_Alternate_Mobile_No__c, RDS_Project__r.Name,
                                  Email,RDS_Alternate_Email_Id__c,Owner.Name
                                  from Lead where (Email =:NewLead.Email OR RDS_Alternate_Email_Id__c =: NewLead.Email)  and isConverted = false
                                 ];
        
           System.debug(+lstDuplicateLeadsEmail); 
        for(Lead lmdupes : lstDuplicateLeads)
        {
            leadId.add(lmdupes.Id);
        }
        
        for(Lead lEdupes : lstDuplicateLeadsEmail)
        {
            leadId.add(lEdupes.Id);
        }
        
        if(leadId.size()>1)
        {
            strError= 'More Than One leads found';
            //return null;
        }
        
        System.debug(+lstDuplicateLeads);
        if ((lstDuplicateLeads != null && lstDuplicateLeads.size() > 0)) {
            system.debug('Duplicate mobile list found');
            isDuplicateLeadExist = true;
            if(lstDuplicateLeadsEmail.size()!=0)
            {
                system.debug('Duplicate mobile and Email list found');
            if(lstDuplicateLeadsEmail[0].Id != lstDuplicateLeads[0].Id)
            {
                isMailDuplicateLeadExist = true;
            }
            }
        }    
        else {
            isDuplicateLeadExist = false;
        }
        }
        if (lstDuplicateLeads != null && lstDuplicateLeads.size() > 0) {
            isDuplicateLeadExist = true;
        } 
        else {
            isDuplicateLeadExist = false;
        }
        if(lstDuplicateLeads.isEmpty() && lstDuplicateLeads.size() == 0)
        {
         if(lstDuplicateLeadsEmail != null && lstDuplicateLeadsEmail.size() > 0)
        {
            system.debug('Duplicate Email list found');
            isDuplicateLeadExist = true;
            
            isMailDuplicateLeadExist = true;
        }
        }
        
        
        lstDuplicateAccount = [Select Id, Name, PersonMobilePhone, Alternate_Mobile_No__c,Phone, PersonEmail,Alternate_Email__c,Owner.Name from Account
            where(PersonMobilePhone = : NewLead.MobilePhone OR Phone = : NewLead.MobilePhone)
        ]; 
        
        System.debug(+lstDuplicateAccount);
        
        if(NewLead.Email != '')
        {
            
            system.debug('Email is not empty');
            lstDuplicateAccountEmail = [Select Id, Name, PersonMobilePhone,Phone ,Alternate_Mobile_No__c, PersonEmail,
                                        Alternate_Email__c,Owner.Name from Account
                                        where (PersonEmail =: NewLead.Email OR Alternate_Email__c =: NewLead.Email)
                                       ];
            system.debug(+lstDuplicateAccountEmail);
            for(Account AccEmaildupes : lstDuplicateAccountEmail)
            {
                accountId.add(AccEmaildupes.Id);
            }
            
            for(Account AccMobdupes : lstDuplicateAccount)
            {
                accountId.add(AccMobdupes.Id);
            }
            
            if(accountId.size()>1)
            {
                strError='More Than One Account found';
                //return null;
            }
            if (!lstDuplicateAccount.isEmpty() && lstDuplicateAccount.size() > 0)
            {
                system.debug('Mobile List is present');
                isDuplicateAccountExist = true;
                
                system.debug(+lstDuplicateAccountEmail);
                
                if(lstDuplicateAccountEmail.size()!= 0)
                {
                    system.debug('email list is present');
                    
                    if( lstDuplicateAccount[0].Id != lstDuplicateAccountEmail[0].Id)
                    {
                        system.debug('For Mobile And Email Account found');
                        isDuplicateAccountExistEmail = true;
                        return null;
                    }
                }
            }
        }    
        if (!lstDuplicateAccount.isEmpty() && lstDuplicateAccount.size() > 0) {
            lstDuplicateOpty = [select id, Name, Project__r.Name, Account.PersonMobilePhone, Owner.Name, Account.Name,
                                LeadSource, Lead_Sub_Source__c,Project__c, AccountId, Sales_Manager_lookup__r.Name,
                                Booking__c, Sales_Manager__c, Date_Of_Visit__c, Unique_SVF_Number__c
                                from Opportunity where AccountId = : lstDuplicateAccount[0].Id and
                Project__c = :  strProjectId and Booking__c =: null]; 
            
            System.debug(+lstDuplicateOpty);
            
            if (!lstDuplicateOpty.isEmpty() && lstDuplicateOpty.size() > 0) {
                isDuplicateOptyExist = true;
                isDuplicateAccountExist = false;
            } else {
                isDuplicateAccountExist = true;
                isDuplicateOptyExist = false;
            }
        }
        
        if(lstDuplicateAccount.isEmpty() && lstDuplicateAccount.size() == 0)
        {
            system.debug('Mobile empty found');
            if(lstDuplicateAccountEmail != null  && lstDuplicateAccountEmail.size() > 0 )
            {
                system.debug('email duplicate exist');
                lstDuplicateOpty = [select id, Name, Project__r.Name, Account.PersonMobilePhone, Owner.Name, Account.Name, 
                                    LeadSource, Lead_Sub_Source__c,Project__c, AccountId,Sales_Manager_lookup__r.Name,Booking__c, Sales_Manager__c, Date_Of_Visit__c, Unique_SVF_Number__c
                                    from Opportunity where AccountId = : lstDuplicateAccountEmail[0].Id and
                                    Project__c = :  strProjectId and Booking__c =: null];
                
                if (!lstDuplicateOpty.isEmpty() && lstDuplicateOpty.size() > 0) {
                    isDuplicateOptyExist = true;
                    isDuplicateAccountExist = false;
                }
                else {
                    isDuplicateAccountExistEmail = true;
                    isDuplicateAccountExist = true;
                    isDuplicateOptyExist = false;
                }
            }
        }
        return null;
    }        
    
    /*public List<SelectOption> getprojectList()
    {
        List<SelectOption> options=new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        for(Project__c plist:[Select Id,Name from Project__c])
        {
            options.add(new SelectOption(plist.Id,plist.Name));
        }
        return options;
    }*/ 
}