public class ProcessBooking 
{
  public string BookingId{get;set;}
  public string outputmessage{get;set;}
  Public String ProjectId{get;set;}
  public id CustomerId {get;set;}
  Public String TowerName{get;set;}
  public list<Booking__c> lstbooking;
  public boolean status {get ; set ;}
  public Id towerId {get;set;}
  public list <id>  ListOthereUsersId  {get;set;}
  public list <User> OtherUsersBooking {get;set;}
  public Booking__c bookingProc;
  
    public ProcessBooking()
    {      
        list<Booking__c> lstBooking = new list<Booking__c>();
        BookingId = ApexPages.currentPage().getParameters().get('id');   
        ListOthereUsersId = New list <id> ();
        OtherUsersBooking  =  new List <User> ();
        if(BookingId != null)
        {
            //////////////////Ankur : Commenting out this line and added the next one to fetch an extra field on 18.11.2015 19:36 hrs//////////////////////////////////
              lstBooking = [select id,name,Booking_Date__c, status__c,Unit_No__c,Unit_No__r.name,Unit_No__r.Unit_Status__c,UnitChange__c,Project__c,Project__r.name,Unit_No__r.Param2__c,Unit_No__r.towername__r.Id, Customer__c,Customer__r.name,Customer__r.Passport_No__c,Customer__r.POI_Card_No__c,Customer__r.PAN_Card_No__c, Quotation__c, Quotation__r.Quote_Status__c, Ownerid, Opportunity__c,  
                      Project__r.Sales_Site_Head__c,Project__r.Sales_MIS__c,Project__r.Project_CRM_Lead__c,Sales_Manager__c, Unit_No__r.Reason_For_CRM_returns_to_sales__c /**,Customer__r.Account.Salutation **/
                      from Booking__c where id=: BookingId];              
      
        }

        if(lstBooking != null && lstBooking.size() > 0)
        {
            bookingProc = lstBooking[0];
            ProjectId = lstBooking[0].Project__c;
            towerId = lstBooking[0].Unit_No__r.towername__r.Id;         
            CustomerId = lstBooking[0].Customer__c;
        } 
    }
    
    Public PageReference Process()
    {
       //////////////////Ankur : Commenting out this code as on 18.11.2015 19:36 hrs//////////////////////////////////
        if(bookingProc != null && bookingProc.Quotation__r.Quote_Status__c != 'Valid')
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Booking cannot be processed as the Quotation used for this booking is not in "Valid" status. Quotations that need approval become Valid only after they have been approved.'));
            return null;
        }
        
        
        if(bookingProc != null && bookingProc.id != null && bookingProc.status__c != null && (bookingProc.status__c == 'UnProcessed' || (bookingProc.status__c == 'Booking In Process' && bookingProc.Unit_No__r.Unit_Status__c == 'CRM Returned To Sales') ))
        {            
            list<Team_Members__c> lstTeamMembers = [select id,User__c,User_Active__c,Counter__c,Team__c,Last_Assignment__c from Team_Members__c where Team__r.Team_Type__c= 'CRM Team' AND User_Active__c = true AND Team__r.Towerlookup__c =: towerId AND IsActive__c = true AND Team__r.Project__c =: ProjectId];
            list<Team_Members__c> lstTeamMembersToUpdate = new List<Team_Members__c >();
            system.debug('-------lstTeamMembers------'+lstTeamMembers); 
            if(lstTeamMembers != null && lstTeamMembers.size() >= 1)
            {
                datetime lsttime = system.now();
                Id ownerId = bookingProc.ownerId;
                for(Team_Members__c objTM : lstTeamMembers )
                {
                    if(lsttime!= null && objTM.Last_Assignment__c < lsttime)
                    {
                        lsttime = objTM.Last_Assignment__c;
                        ownerId = objTM.user__c;
                    }
                }    
                    
                for(Team_Members__c objTM : lstTeamMembers )
                {
                    if(objTM.user__c == ownerId)
                    {
                            objTM.Last_Assignment__c = system.now();
                            if(objTM.Counter__c != null)
                            objTM.Counter__c = objTM.Counter__c+1;
                            objTM.Ownerid = ownerId;
                            objTM.Last_Assignment__c = system.now();
                            lstTeamMembersToUpdate.add(objTM);
                    }
                }
                
                  if(bookingProc.UnitChange__c != true) 
                  {
                     if(bookingProc.Unit_No__r.Reason_For_CRM_returns_to_sales__c == null)
                     {
                          bookingProc.sales_manager__c = bookingProc.ownerId;
                     }
                     bookingProc.ownerId = ownerId;
                     List<Applicant_Details__c> listApplicants= [Select Id, Name from Applicant_Details__c where booking__c =: bookingProc.Id];
                     if (listApplicants.size() > 0) {
                        for(Applicant_Details__c a : listApplicants) {
                            a.ownerId = ownerId;
                        }
                        update listApplicants;
                     }
                     List<Opportunity> oList = [Select Id, Relationship_Manager__c from Opportunity where Id =: bookingProc.Customer__c];
                     if(oList != null && oList.size() > 0) {
                        for(Opportunity op : oList) {
                            op.Relationship_Manager__c = ownerId;
                        }
                        update oList;
                     }
                     
                     List<Receipt__C> rList = [Select Id from Receipt__c where Opportunity__r.Id = : CustomerId];
                     if(rList != null && rList.size() > 0) {
                        for(Receipt__c r : rList) {
                            r.ownerId = ownerId;
                        }
                        update rList;
                     }
                     List<Customer_Pay_Plan_Header__c> cpphList = [Select Id from customer_pay_plan_header__c where booking__c =: bookingProc.Id ];
                     Set<Id> cpphIdSet = new Set<Id>();
                     if (cpphList != null && cpphList.size() > 0) {
                        for(Customer_Pay_Plan_Header__c c : cpphList) {
                            cpphIdSet.add(c.Id);
                            c.ownerId = ownerId;
                        }
                        update cpphList;
                        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id from Standard_Customer_Pay_Plan_Detail__c where Customer_Pay_Plan_Header__c in : cpphIdSet];
                        if(scppdList != null && scppdList.size() > 0) {
                            for(Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
                                scppd.ownerId = ownerId;
                            }
                            update scppdList;
                        }
                     }
                  }
                  else
                  {}
                  bookingProc.status__c = 'Booking In Process';
                  update bookingProc;
            }
            
            else
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning,'There is no member in selecting Team.'));
            }
            
            if(lstTeamMembersToUpdate != null && lstTeamMembersToUpdate.size() > 0)
                update lstTeamMembersToUpdate;

            
            if(bookingProc != null && bookingProc.Unit_No__c != null)
            {
                list<Project_Unit__c>lstProjunit = [select id,Project__c, Reason_For_CRM_returns_to_sales__c, Unit_Status__c from Project_Unit__c where Id =: bookingProc.Unit_No__c ];
                if(lstProjunit != null && lstProjunit.size()>0)
                {
                    //////Ankur : Adding on 16.02.2016 
                    if(lstProjunit[0].Unit_Status__c =='CRM Returned To Sales')
                    {
                        if(lstProjunit[0].Reason_For_CRM_returns_to_sales__c == 'Physical Document Rejected')
                        {
                            lstProjunit[0].Unit_Status__c = 'BIP - Sales';
                            update lstProjunit;
                            
                            opportunity objCustomer = new opportunity();
                            objCustomer.id = CustomerId;
                            ///////////Ankur Commented this line to stop unit update on opty
                            //objCustomer.Project_Unit__c = lstProjunit[0].Id;        // Added by Mohit Sharma told by Shubham witness Samyak Jain
                            objCustomer.Physical_document_received__c = false;
                            
                            ///Ankur added this line to update the project on opty
                            //objCustomer.Project__c = lstProjunit[0].Project__r.Id;
                            //objCustomer.Relationship_Manager__c = ownerId;
                            update objCustomer ;
                        }
                        if(lstProjunit[0].Reason_For_CRM_returns_to_sales__c == 'Welcome Call Rejected')
                        {
                            lstProjunit[0].Unit_Status__c = 'Welcome Call Pending';
                            update lstProjunit;
                        }
                    }
                    else
                    {
                            lstProjunit[0].Unit_Status__c = 'BIP - Sales';
                            update lstProjunit;
                            
                            opportunity objCustomer = new opportunity();
                            objCustomer.id = CustomerId;        
                            objCustomer.Physical_document_received__c = false;                        
                            update objCustomer ;
                    }
                }    
            }
            
            list<User>LstUsersRm = [select id, name,email, Salutation__c from user where id =:bookingProc.ownerId];
            list<User>LstUsers = [select id, name,email, Salutation__c from user where Name =:'RCD'];
            system.debug('LstUsers xxxxxx '+LstUsers );
            if(LstUsers !=  null && LstUsers.size()>0)
            {
                String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
                //Ankur Commented this line and added the next one to change the checklist page URL
                //string PageLink = '/apex/DocumentChecklist?id='+bookingProc.id;
                //string PageLink = '/apex/DocumentChecklistPage?id='+bookingProc.id;
                string PageLink = '/apex/S_ProcessDocumentVerification';
                
                
                string strBookingHtmlBody =   'Dear '+' '+LstUsers[0].Salutation__c +' '+ LstUsers[0].Name + ',' +
                'Booking Documents for' /*+bookingProc.Customer__r.Account.Salutation */+' '+ bookingProc.Customer__r.name + 
                ', Flat - '+ bookingProc.Unit_No__r.name  + ' in ' +bookingProc.project__r.name + ' has  been dispatched ' + bookingProc.Booking_Date__c + 
                ' please click the following link to accept and process the physical documents verification.' +

                 baseUrl + PageLink  + ' <br></br>' ;
               
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Booking Process Has Been Initiated. A mail has been sent to CRM Team for further processing.'));

                Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
                mail.setHtmlBody(strBookingHtmlBody);
                list<string> lststringtoaddress = new list<string>();
                lststringtoaddress.add(LstUsers[0].Email);
                mail.setToAddresses(lststringtoaddress);
                mail.setSubject('This Booking Has been Assigned to You');
                Messaging.sendEmail(new Messaging.Singleemailmessage[] { mail});
               
           }    
                /////To SM, Sales Site Head, Sales MIS, Project CRM Lead, RM ///
               
                if(bookingProc.Project__r.Sales_Site_Head__c != null)
                {
                    ListOthereUsersId.add(bookingProc.Project__r.Sales_Site_Head__c);  
                }
                if(bookingProc.Project__r.Sales_MIS__c != null)
                {
                    ListOthereUsersId.add(bookingProc.Project__r.Sales_MIS__c);  
                }
                if(bookingProc.Project__r.Project_CRM_Lead__c != null)
                {
                    ListOthereUsersId.add(bookingProc.Project__r.Project_CRM_Lead__c);  
                }
                System.debug('ListOthereUsersId'  +ListOthereUsersId);
                
                if(ListOthereUsersId.size() > 0)
                {
                    OtherUsersBooking = [select id, name,email from user where id In : ListOthereUsersId];
                    
                }
                System.debug('OtherUsersBooking ' +OtherUsersBooking );
            if(bookingProc.Sales_Manager__c != null)
            {
                System.debug('bookingProc.Sales_Manager__c'+bookingProc.Sales_Manager__c);
                list<User>LstUsersBooking = [select id, name,email,Salutation__c from user where id =: bookingProc.Sales_Manager__c];
                
               if( LstUsersBooking.size() > 0)
               {
                    
                        System.debug('inside LstUsersBooking ');
                         String baseUrlNew = System.URL.getSalesforceBaseUrl().toExternalForm();
                         string strBookingHtmlBodyNew =  'Dear ' +' '+  LstUsersBooking[0].Salutation__c +' '+ LstUsersBooking[0].Name + ',<br></br><br></br>'+
        
                        'Booking processed for ' /**+bookingProc.Customer__r.Account.Salutation**/ +' '+ bookingProc.Customer__r.name  + ' , Flat - ' + bookingProc.Unit_No__r.name + '  in ' + bookingProc.project__r.name + '.' +
                        'Please submit physical booking form to RCD Team for further processing.';
        
                        Messaging.Singleemailmessage mailNew = new Messaging.Singleemailmessage();
                        mailNew.setHtmlBody(strBookingHtmlBodyNew);
                        list<string> lststringtoaddressNew = new list<string>();
                        lststringtoaddressNew.add(LstUsersBooking[0].Email);
                        if(OtherUsersBooking.size() > 0 )
                        {
                            System.debug('Inside OtherUsersBooking' +OtherUsersBooking);
                            for(integer  i = 0 ; i < OtherUsersBooking.size() ; i++)
                            {
                                System.debug('lststringtoaddressNew' +lststringtoaddressNew );
                                 lststringtoaddressNew.add(OtherUsersBooking[i].Email);
                            }
                            
                        }
                        if(LstUsersRm.size() > 0 )
                        { 
                            lststringtoaddressNew.add(LstUsersRm[0].Email);
                        }
                        System.debug('lststringtoaddressNew' +lststringtoaddressNew );
                        mailNew.setToAddresses(lststringtoaddressNew);
                        mailNew.setSubject('New Booking');
                        Messaging.sendEmail(new Messaging.Singleemailmessage[] { mailNew});
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Booking  Has Been Processed . A mail has been sent to CRM for further processing.'));
                   
                }  
            } 
        }  
        else if(bookingProc != null && bookingProc.id != null && bookingProc.status__c != null && bookingProc.status__c == 'Booking In Process')
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Booking Process Already Has Been Initiated.'));
        }
        else if(bookingProc != null && bookingProc.id != null && bookingProc.status__c != null && bookingProc.status__c == 'Processed')
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Booking Has Been Already Processed.'));
        }
        else
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning,'Some internal error encountered while processing your request. Please Contact your Administrator.'));
        }
        return null;
    }
        
    public PageReference incrementCounter() 
    {       
        if(BookingId!= '')
        {
            pageReference P = new pageReference('/'+ BookingId);
            return P;
        }
        return null;
    }
}