public class SendBrochureAttachmentClass {
    
    public List<ProjectAttachments__c> paList {get;set;}
    public ProjectAttachment projAttachment {get;set;}
    public List<Attachment> aList {get;set;}
    public String selectedproject{get;set;} 
    public String isError{get;set;}
    public id objId{get;set;} 
    String objemail = '';
    String objname= '';
    List<Project__c> projList =  new List<Project__c>();
    
    public SendBrochureAttachmentClass()
    {
        system.debug('Inside Constructor...');
         isError = '';
        objId = ApexPages.currentPage().getParameters().get('id');
        String sObjName = objId.getSObjectType().getDescribe().getName();
        system.debug('sObjName: ' + sObjName);
        
        Account objlistAcc = new Account();
        Lead objlistlead = new Lead();
        
        if(sObjName == 'Account')
        {
             objlistAcc = [SELECT Id,Name,PersonEmail FROM Account where Id = : objId];
             objemail = objlistAcc.PersonEmail ;
             objname = objlistAcc.Name;
        }
        else
        {
             objlistlead  = [SELECT Id,Name,Email FROM Lead where Id = : objId];
             objemail = objlistlead.Email ;
             objname = objlistlead.Name;
        }
        
        if(objemail == null)
        {
            isError = 'True';
            ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,'Email Id missing on Lead/Account.');
            ApexPages.addMessage(myMsg1);
        }
        else
        {
            isError = '' ;
        }
    }
    
    public List<SelectOption> getProjects{
        get 
        {        
                    List<SelectOption> optns = new List<Selectoption>();
                    if(objemail != null)
                    {
                            isError = '' ;
                            List<Project__c> queryResult = new List<Project__c>([Select Id, Name,Brochure_Link__c from Project__c]);// where Brochure_Link__c != Null ]);
                            optns.add(new SelectOption('', 'Select a Project'));
                            for(Project__c obj : queryResult)
                            {
                                 optns.add(new SelectOption(obj.Id, obj.Name));
                            } 
                    }
                    else                    
                    {
                            isError = 'True';
                            ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,'Please Select Project Name.');
                            ApexPages.addMessage(myMsg1);    
                    }
                   return optns;   
        }set;            
    }
    public PageReference  getPAT() {
      if(selectedproject != null)
      {
        projList = [Select Id, Name, Brochure_Link__c from Project__c where Id = : selectedproject ];
        system.debug('projList 1st : '+ projList[0].Id);
        system.debug('projList Name : '+ projList[0].Name); 
        paList = [SELECT Id, Name, EmailContent__c,Subject__c FROM ProjectAttachments__c WHERE ProjectName__c = : selectedproject and AttachmentType__c = 'Brochure' and latest__C = true ];
        system.debug('Project Attachement List Netra : ' +  paList); 
        system.debug('Project Attachement Size ' + paList .size());
                if(paList.size() == 1)
                {
                          
                    aList = [SELECT Name, Id, Body, ContentType,ParentId FROM Attachment WHERE  ParentId = :paList[0].Id ];
                    System.debug('aList:' + aList);
                        if(aList == null) 
                        {
                            isError = 'True';
                            ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,' ' +projList[0].Name+ ' has no brochure attached to it.');
                            ApexPages.addMessage(myMsg1);
                            System.debug('Commented error message - (Project Name has no brochure attached to it.)');
                            
                        } 
                        else 
                        {
                                projAttachment = new ProjectAttachment();
                                if(projList.size() > 0)
                                {
                                    projAttachment.projectName = projList[0].Name;
                                    projAttachment.brochureLink = projList[0].Brochure_Link__c;
                                    projAttachment.EmailContentMsg = paList[0].EmailContent__c;
                                    projAttachment.Subject = paList[0].Subject__c; 
                                    System.debug('Project Attachment 111 :' + projAttachment);
                                    system.debug('Email Subject netra : ' + projAttachment.Subject);
                                 }
                                 if(aList.size() > 0)
                                 {   
                                        projAttachment.AttachmentId = aList[0].Id;
                                        projAttachment.AttachmentName = aList[0].Name;
                                        projAttachment.ContentType = aList[0].ContentType;
                                        projAttachment.Body = aList[0].body;  
                                        System.debug('Project Attachment xxx :' + projAttachment);   
                               }     
                        }
                } 
                else 
                {
                        isError = 'True'; 
                        ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,' ' +projList[0].Name+ ' has no brochure attached to it.');
                        ApexPages.addMessage(myMsg1);
                        System.debug('Commented error message - (Project Name has no brochure attached to it.)');
                }
        }
        else
         {
                 isError = 'True';
                 ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,'Please Select Project Name.');
                 ApexPages.addMessage(myMsg1);    
         }
        return null;
    }
    
     public PageReference callSendBrochure()
     {
         objId = ApexPages.currentPage().getParameters().get('id');
         system.debug('Netra : projAttachment :::' + projAttachment );
         if(selectedproject != null)
         {
                     if(projAttachment != null && objId != null)
                     {
                         sendBrochure(projAttachment,objId);
                         isError = 'True'; 
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,' Email Sent Successfully.');
                         ApexPages.addMessage(myMsg);
                     } 
                     else
                     {
                              isError = 'True'; 
                              ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Project Name has no brochure attached to it.');
                              ApexPages.addMessage(myMsg);
                     }  
                 }
                 else
                 {
                          isError = 'True';
                          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error,'Please Select Project Name.');
                          ApexPages.addMessage(myMsg);    
                 }   
         return null;
     }
        
        public void sendBrochure(ProjectAttachment pAttach, Id  objId)
        {
                    String tmp = '' ;
                    tmp = '<html><body> '+ pAttach.EmailContentMsg + '.</body></html>';
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'nishant.garg@stetig.in'];
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    if ( owea.size() > 0 ) 
                    {
                          email.setOrgWideEmailAddressId(owea.get(0).Id);
                    }              
                    email.setUseSignature(false);
                    email.setSaveAsActivity(true);
                    email.setSubject('Brochure for ' + pAttach.projectName);
                    
                    String[] toAddresses =  new String[] {objemail};
                    email.setToAddresses(toAddresses);
                    email.setHtmlBody(tmp);
                    if(pAttach.Subject != null)
                    {
                        email.setSubject(pAttach.Subject);
                    }   
                    else 
                    {
                        email.setSubject('Project Brochure');
                    } 
                    Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                    efa.setBody(pAttach.Body);
                    efa.setFileName(pAttach.AttachmentName);
                    email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
                    Messaging.SingleEmailMessage[] emailList = new Messaging.SingleEmailMessage[] {email};
                    Messaging.sendEmail(emailList);
                    
                   
       }
    
        public Class ProjectAttachment 
        {
                public String ProjectName {get; set;}
                public String brochureLink{get; set;}
                public String AttachmentId {get; set;}
                public String AttachmentName {get; set;}
                public String ContentType {get; set;}
                public string EmailContentMsg {get; set;}
                public string Subject {get;set;}
                public blob Body {get; set;}
        }
}