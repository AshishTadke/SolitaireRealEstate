public with sharing class BlockingExtension

{
    ApexPages.StandardController controller;
    public Blocking_Detail__c blockingobj {get; set;}     
    public Id OptyId {get; set;}     
    public Id UnitId {get; set;}    
    public Id optyidparam {get; set;} 
    public Id OptyBlocking {get; set;} 
    public String test{get; set;}       
    public String inputTextErrorMessageQuote {get; set;}
    public List<Opportunity> OptyDetails {get;set;}
    public List<Project_Unit__c> UnitDetails{get;set;}
    public List<Blocking_Detail__c> blockList {get; set;}
    public string optychk{get; set;}
    public string act;
    public string inputTextErrorMessage {get;set;}
    public string errormsgreserved {get;set;}
    public List<Account> AcntDetails {get;set;}
    public string errormsgchanged {get;set;}
    public String userName {get;set;} 
    public String userProfile {get;set;}
    public User activeUser {get;set;}
    public String userEmail {get;set;}
    public String errorMsg {get;set;}
    public Id profileId {get;set;}
    //Constructor Executed at Page Load... 
    //Automatically Executed... 
    public BlockingExtension(ApexPages.StandardController controller)
    {
        this.controller = controller;
        blockingobj = (Blocking_Detail__c)controller.getRecord();
        UnitId = ApexPages.currentPage().getParameters().get('unitid');
        // get('unitid') : Getting from URL...
        system.debug('unitid =' +UnitId);
        blockingobj.Unit__c = UnitId;
        blockingobj.Status__c = 'Blocked';
        //blockingobj.Status__c = 'Reserved';
              
        errormsgchanged ='Changed';
        errormsg = '';
        // Getting optyid from URL when we go to inventory form through selecting opportunity.
        //Opportunities -> Select Opportunity -> click on inventory -> InventoryWadhwa page gets open.
        if(ApexPages.currentPage().getParameters().get('optyid') != '')
        {
            blockingobj.Opportunity__c = ApexPages.currentPage().getParameters().get('optyid');
        }
        else{
            errormsgreserved = 'Please Navigate through Opportunity.';
        }
        //To make some fields readonly at the time of Unblocking...
        inputTextErrorMessage = ApexPages.currentPage().getParameters().get('action');
        system.debug('Error Message' + inputTextErrorMessage);
        
        // To check which page to be open - Block or Unblock...
        act = ApexPages.currentPage().getParameters().get('action');
        system.debug('Action: ' + act);     
        
        if(UnitId != null)
        {   
              if(act == 'Released')       // if(act == 'Unblocked') 
              {   
                    blockList = [SELECT Cheque_Number__c,Comments__c,Token_Amount__c,Instrument_Date__c,Opportunity__c,Status__c,Unit__c,Unit_Number__c,Account_Name__c,Person_Email__c,PersonMobilePhone__c,Company__c,Sales_Manager__c,Sales_Manager_Email__c FROM Blocking_Detail__c WHERE Unit__c =: UnitId AND Status__c = 'Blocked' ];
                    system.debug('BLOCK LIST : ' + blockList);
                    system.debug('BLOCK LIST : ' + blockList[0].Opportunity__c);
                    blockingobj.Opportunity__c = blockList[0].Opportunity__c ;  
                    blockingobj.Cheque_Number__c = blockList[0].Cheque_Number__c;
                    blockingobj.Comments__c = blockList[0].Comments__c;
                    //Account Dtls
                    blockingobj.Account_Name__c = blockList[0].Account_Name__c;
                    blockingobj.Company__c = blockList[0].Company__c;
                    blockingobj.Person_Email__c = blockList[0].Person_Email__c; 
                    blockingobj.PersonMobilePhone__c = blockList[0].PersonMobilePhone__c;
                    blockingobj.Sales_Manager__c =  blockList[0].Sales_Manager__c;
                    blockingobj.Sales_Manager_Email__c = blockList[0].Sales_Manager_Email__c;
                    
                    system.debug('Account Name: ' + blockList[0].Account_Name__c);
                    system.debug('Company__c' + blockList[0].Company__c);
                    system.debug('Person_Email: ' + blockList[0].Person_Email__c);
                    system.debug('PersonMobilePhone: ' + blockingobj.Account_Name__c);  
                                      
                    blockingobj.Status__c = 'Released';
                    system.debug('Status1 : ' + blockingobj.Status__c);   
              }                         
        }
        
        // For Status = Blocked
        if(act == 'Blocked')
        { 
                system.debug('Inside Blocked section : Netra');
                if(ApexPages.currentPage().getParameters().get('optyid')!='')
                {
                    
                    //OptyDetails = [SELECT id,Name,StageName,Reason_for_Booked_Won__c,AccountID   FROM Opportunity WHERE Id =:blockingobj.Opportunity__c];        
                    OptyDetails = [SELECT Name,StageName,Project_Unit__c ,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blockingobj.Opportunity__c];   
                    system.debug('act == Blocked xxx: ' + OptyDetails  );
                    if (OptyDetails[0].StageName == 'Booked' || OptyDetails[0].StageName == 'Sold' || OptyDetails[0].StageName == 'Closed Lost' || OptyDetails[0].StageName == 'Cancelled' ||
                        OptyDetails[0].StageName == 'Booking confirmed' || OptyDetails[0].StageName == 'Closed Lost')
                    {
                           errormsgreserved = 'This Opportunity is already Booked / Sold / Closed / Cancelled  . Please select a New Opportunity.';  
                          //errormsgreserved = OptyDetails[0].Name+ ' :- Opportunity is already Booked . Please select a New Opportunity.';
                    }
                    else if(OptyDetails[0].Project_Unit__c != Null)
                    {
                        errormsgreserved = OptyDetails[0].Name+ ' :- A unit has been already Reserved for this opportunity. Please select a New Opportunity.';
                    }
                    else
                    {
                          OptyDetails = [SELECT Name,AccountID,StageName,Project_Unit__c ,Sales_Manager__c FROM Opportunity WHERE Id = :blockingobj.Opportunity__c]; 
                          system.debug('Else part Netra : ' + OptyDetails );       
                          AcntDetails = [SELECT Id,Name,Company_Name__c,PersonEmail,PersonMobilePhone FROM Account where id = :OptyDetails[0].AccountID ];
                          system.debug('AcntDetails =' +AcntDetails);
                          blockingobj.Account_Name__c = AcntDetails[0].Id;
                          blockingobj.Company__c = AcntDetails[0].Company_Name__c;
                          blockingobj.Person_Email__c = AcntDetails[0].PersonEmail;
                          blockingobj.PersonMobilePhone__c = AcntDetails[0].PersonMobilePhone;
                    }
                 }//if closed
                 
                 if(blockingobj.Opportunity__c != null )
                 {
                    if (OptyDetails[0].StageName == 'Booked' || OptyDetails[0].StageName == 'Sold' || OptyDetails[0].StageName == 'Closed Lost' || OptyDetails[0].StageName == 'Cancelled' ||
                        OptyDetails[0].StageName == 'Booking confirmed' || OptyDetails[0].StageName == 'Closed Lost')
                    {
                           errormsgreserved = 'This Opportunity is already Booked / Sold / Closed / Cancelled  . Please select a New Opportunity.'; 
                    }
                    else if(OptyDetails[0].Project_Unit__c != Null)
                    {
                        errormsgreserved = OptyDetails[0].Name+ ' :- A unit has been already Reserved for this opportunity. Please select a New Opportunity.';
                    }
                    else{
                        OptyDetails = [SELECT Name,StageName,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blockingobj.Opportunity__c];        
                        AcntDetails = [SELECT Id,Name,Company_Name__c,PersonEmail,PersonMobilePhone FROM Account where id = :OptyDetails[0].AccountID ];
                        system.debug('AcntDetails =' +AcntDetails);
                        blockingobj.Account_Name__c = AcntDetails[0].id;
                        blockingobj.Company__c = AcntDetails[0].Company_Name__c;
                        blockingobj.Person_Email__c = AcntDetails[0].PersonEmail;
                        blockingobj.PersonMobilePhone__c = AcntDetails[0].PersonMobilePhone;     
                    }       
                  } 
           }  // Closed if(act == 'Blocked') 
           
           // Get current logged in User's Email and Profile Details : 
           userName = UserInfo.getUserName();
           profileId = Userinfo.getProfileId();
           userProfile = [SELECT Id,Name FROM Profile WHERE Id=:profileId].Name;
           system.debug('User Name : ' + userName);
           system.debug('User Profile : ' + userProfile);
           
           
           activeUser = [Select Email From User where Username = : userName limit 1];
           system.debug('activeUser : ' + activeUser);
           userEmail = activeUser.Email;
           system.debug('userEmail : ' + userEmail);
           List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
           String MyProflieName = PROFILE[0].Name;
               
    }//Constructor Closed
    
    public PageReference setAccDtls()
    {
        if(blockingobj.Opportunity__c != null )
        {
            OptyDetails = [SELECT Name,StageName,Project_Unit__c,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blockingobj.Opportunity__c];
            if (OptyDetails[0].StageName == 'Booked' || OptyDetails[0].StageName == 'Sold' || OptyDetails[0].StageName == 'Closed Lost' || OptyDetails[0].StageName == 'Cancelled' ||
                OptyDetails[0].StageName == 'Booking confirmed' || OptyDetails[0].StageName == 'Closed Lost')
                {
                   errormsgreserved = 'This Opportunity is already Booked / Sold / Closed / Cancelled  . Please select a New Opportunity.';  
                }
            else if(optyDetails[0].Project_Unit__c != Null)
                {
                    errormsgreserved = OptyDetails[0].Name+ ' :- A unit has been already Reserved for this opportunity. Please select a New Opportunity.';
                }    
            else{
                
                OptyDetails = [SELECT Name,StageName,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blockingobj.Opportunity__c];        
                
                
                errormsgreserved = '';
                errormsgchanged = 'changed';
                AcntDetails = [SELECT Id,Name,Company_Name__c,PersonEmail,PersonMobilePhone FROM Account where id = :OptyDetails[0].AccountID ];
                system.debug('AcntDetails =' +AcntDetails);
                blockingobj.Account_Name__c = AcntDetails[0].id;
                blockingobj.Company__c = AcntDetails[0].Company_Name__c;
                blockingobj.Person_Email__c = AcntDetails[0].PersonEmail;
                blockingobj.PersonMobilePhone__c = AcntDetails[0].PersonMobilePhone;
                //Added By Netra : 30/03/2016
                if(OptyDetails[0].Sales_Manager__c!= null )
                {
                    blockingobj.Sales_Manager__c = OptyDetails[0].Sales_Manager__c;
                }    
                
             }   
           }     
           return null;
         
    }    
   
    public PageReference save()
    {
        System.debug('save method called');
        Boolean isError = false;
        errorMsg = '';
        if(blockingobj.Status__c == 'Blocked' && act=='Blocked') //if(blockingobj.Status__c == 'Reserved' && act=='Reserved') 
        {    
             if(blockingobj.Blocked_with_Token__c && blockingobj.Cheque_Number__c == null){
                 isError = true;
                 ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,'Please enter Cheque Number.');
                 ApexPages.addMessage(myMsg1);
                 errorMsg = 'Please enter Cheque Number.';
                 return null;
             }   
             else if(!isError){
                 System.debug('Blocked Code');
                 //system.debug('blockingobj.Opportunity__c : netra : ' + blockingobj.Opportunity__r.Sales_Manager__c);
                 Blocking_Detail__c blockingRecord = new Blocking_Detail__c();
                 blockingRecord.Cheque_Number__c = blockingobj.Cheque_Number__c;
                 blockingRecord.Comments__c = blockingobj.Comments__c;
                 blockingRecord.Opportunity__c = blockingobj.Opportunity__c;
                 blockingRecord.Status__c = blockingobj.Status__c;
                 blockingRecord.Unit__c = blockingobj.Unit__c;
                 system.debug('blockingobj.Unit__c'+blockingobj.Unit__c);
                 
                 blockingRecord.Account_Name__c = blockingobj.Account_Name__c;
                 blockingRecord.Company__c = blockingobj.Company__c;
                 blockingRecord.Person_Email__c = blockingobj.Person_Email__c;
                 blockingRecord.PersonMobilePhone__c = blockingobj.PersonMobilePhone__c;
                 blockingRecord.Blocked_with_Token__c = blockingobj.Blocked_with_Token__c;
                 blockingRecord.Blocked_without_Token__c = blockingobj.Blocked_without_Token__c; 
                 blockingRecord.Token_Amount__c = blockingobj.Token_Amount__c;
                 blockingRecord.Instrument_Date__c = blockingobj.Instrument_Date__c;   
                               
                 // New added By Netra : 30/03/2016
                 
                 /*Show Opportunity */
                   
                 UnitDetails = [SELECT ID,Customers__c,Unit_Status__c  FROM Project_Unit__c WHERE id =:blockingRecord.Unit__c];//,Blocking_Date__c
                 
                 system.debug('UnitDetails' + UnitDetails);
                 for(Project_Unit__c unt:UnitDetails)
                 {
                     
                     unt.Unit_Status__c = 'Reserved';
                     unt.Customers__c = blockingRecord.Opportunity__c; 
                     unt.ID = blockingRecord.Unit__c;
                    
                     system.debug('unt.Opportunity_Name__c'+ unt.Customers__c);
                 }       
                 
                 
                 OptyDetails = [SELECT Name,Project_Unit__c ,StageName,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blockingRecord.Opportunity__c];//,Blocking_Date__c
                 
                 system.debug('OptyDetails2...' + OptyDetails );
                 for(Opportunity opty:OptyDetails )
                 {
                     
                     opty.Project_Unit__c = blockingRecord.Unit__c;
                                         
                     system.debug('opty.Project_Unit__c'+ opty.Project_Unit__c);
                 }       
                 
                  
                 try 
                 {
                     insert blockingRecord;
                     update UnitDetails;
                     update OptyDetails ;
                 } 
                 catch(DmlException ex) 
                 {
                     ApexPages.addMessages(ex);
                     errorMsg = ex.getMessage();
                     return null;
                 }   
              }    
              else{
              
              }     
           }// if closed
         
         // Check current logged in user Email id == Sales Manager's Email ID or Profile = Sales coordinator or Profile = System Administrator
         // If above any condition is true then only user can open / release the Unit. o/w show error Message.       
              if(blockingobj.Status__c == 'Released' && act=='Released') //if(blockingobj.Status__c == 'Unreserved' && act=='Unreserved')
              {    
                     
                     System.debug('UnBlocked Code');            
                     List<Blocking_Detail__c> blckDtls = [SELECT Id,Release_Comments__c,Token_Amount__c,Instrument_Date__c,Opportunity__c,Unit_Number__c,Unit__c,Status__c,Company__c,Person_Email__c,PersonMobilePhone__c,Account_Name__c,Sales_Manager__c,Sales_Manager_Email__c FROM Blocking_Detail__c WHERE Unit__c = :blockingobj.Unit__c AND Status__c = 'Blocked' ORDER BY CreatedDate DESC];           
                     system.debug('Blocked Dtls: ' + blckDtls);
                     Blocking_Detail__c UnblockingRecord = new Blocking_Detail__c();
                   if(blckDtls.size() > 0)
                   {  
                         if(userProfile == 'System Administrator' )  // 
                         { 
                             system.debug('userEmail :' + userEmail);
                             system.debug('blckDtls[0].Sales_Manager_Email__c : ' + blckDtls[0].Sales_Manager_Email__c);
                             system.debug('userProfile : ' + userProfile);
                             errorMsg = '';
                             system.debug('errorMsg xxx : ' + errorMsg);
                             UnblockingRecord.Status__c = 'Released';             //UnblokingRecord.Status__c = 'Unreserved'; 
                             UnblockingRecord.Id = blckDtls[0].Id; 
                             UnblockingRecord.Release_Comments__c = blockingobj.Release_Comments__c;
                             UnblockingRecord.Account_Name__c = blckDtls[0].Account_Name__c;
                             UnblockingRecord.Company__c = blckDtls[0].Company__c;
                             UnblockingRecord.Person_Email__c = blckDtls[0].Person_Email__c;
                             UnblockingRecord.PersonMobilePhone__c = blckDtls[0].PersonMobilePhone__c;
                             UnblockingRecord.Sales_Manager__c = blckDtls[0].Sales_Manager__c;
                             UnblockingRecord.Sales_Manager_Email__c = blckDtls[0].Sales_Manager_Email__c;
                             //UnblockingRecord.Unit__c = blckDtls[0].Unit__c ;
                             
                             UnitDetails = [SELECT ID,Customers__c,Unit_Status__c  FROM Project_Unit__c WHERE id =:blckDtls[0].Unit__c];//,Blocking_Date__c
                 
                             system.debug('UnitDetails' + UnitDetails);
                             for(Project_Unit__c unt:UnitDetails)
                             {
                                 system.debug('unt.Opportunity_Name__c'+ unt.Customers__c);
                                 
                                 unt.Unit_Status__c = 'Vacant';
                                 unt.Customers__c = null; 
                                                                                                 
                                 system.debug('unt.Opportunity_Name__c'+ unt.Customers__c);
                             }       
                             
                             
                             OptyDetails = [SELECT Name,Project_Unit__c ,StageName,AccountID,Sales_Manager__c FROM Opportunity WHERE Id = :blckDtls[0].Opportunity__c];//,Blocking_Date__c
                             
                             system.debug('OptyDetails2...' + OptyDetails );
                             for(Opportunity opty:OptyDetails )
                             {
                                 system.debug('opty.Project_Unit__c'+ opty.Project_Unit__c);
                                 opty.Project_Unit__c = null;
                                                     
                                 system.debug('opty.Project_Unit__c'+ opty.Project_Unit__c);
                             }       
                             
                             try {
                             
                             update UnblockingRecord;
                             update UnitDetails;
                             update OptyDetails ;
                             
                             } catch (DmlException e) {
                                apexpages.addmessages(e);
                                errorMsg = e.getMessage();
                                return null;
                             }
                         } // If Closed for UserEmail checking.
                         else
                         {
                             ApexPages.Message myMsg1 = new ApexPages.Message(ApexPages.Severity.Error,'You do not have the authorization to Unblock this unit. Please contact your Administrator.');
                             ApexPages.addMessage(myMsg1);
                             errorMsg = 'You do not have the authorization to Unblock this unit. Please contact your Administrator.';
                             system.debug('errorMsg inside Else part : '+ errorMsg);
                         }
                     }  // if closed of blckDtls.size() > 0   
                } // If Closed status== Released
            if(string.isBlank(errorMsg))
            {
                   
                 //PageReference newpage = new Pagereference('/' + blockingobj.Unit__c);     
                 PageReference newpage = new Pagereference('/apex/S_InventoryMatrixview');
                 newpage.setRedirect(true);
                 return newpage;
             }
       
         
       return null; 
    }// Save Method Closed... 
    
    public void dummyMethod(){
    
    }   
}