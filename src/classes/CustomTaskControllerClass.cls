public with sharing class CustomTaskControllerClass {
    public Task t = new Task();
    public boolean create {
        get;
        set;
    }
    public boolean edit {
        get;
        set;
    }
    public boolean error {
        get;
        set;
    }
    public boolean errorForSave {
        get;
        set;
    }
    public boolean check1 {
        get;
        set;
    }
    public String unitName {
        get;
        set;
    }
    private Id whatId = null;
    private Id whoId = null;
    private Id ownerId = null;
    public Id SCPPDid = null;
    private String origin = null;
    private ApexPages.StandardController stdController = null;
    private string cancelURL = null;
    private string retURL = null;
    public string walksource {
        get;
        set;
    }
    public string walksubsource {
        get;
        set;
    }
    public string channelPartner {
        get;
        set;
    }
    public string xcelerateID {
        get;
        set;
    }
    public string CPName {
        get;
        set;
    }
    public string CPPhone {
        get;
        set;
    }
    public string CPEmail {
        get;
        set;
    }
    public string BookedCustomer {
        get;
        set;
    }
    public string EmpName {
        get;
        set;
    }
    public string EmpId {
        get;
        set;
    }
    public string NameO {
        get;
        set;
    }
    public string EmailO {
        get;
        set;
    }
    public string MobO {
        get;
        set;
    }
    public string RelationO {
        get;
        set;
    }
    public string accountName {
        get;
        set;
    }
    public string pickupAdd {
        get;
        set;
    }
    public string ChannelPName {
        get;
        set;
    }
    public string ChannelPCompany {
        get;
        set;
    }
    public string ChannelPCode {
        get;
        set;
    }
    public string ChannelRepresentativeName {
        get;
        set;
    }
    // public List <Standard_Customer_Pay_Plan_Detail__c> LSCCPD {get;set;} 
    public List < Applicant_Details__c > Lapplicant {
        get;
        set;
    }
    private List < Opportunity > opp = new List < Opportunity > ();
    private List < Account > acc = new List < Account > ();
    private List < Lead > lead = new List < Lead > ();
    public Attachment myfile;
    private Map < String, String > qsMap = new Map < String, String > ();
    public List < Attachment > AtchObj {
        get;
        set;
    }
    public List < Attachment > AtchObjLoanClosure {
        get;
        set;
    }
    public String selectedCriteriaR {
        get;
        set;
    }
    public String selectSubject {
        get;
        set;
    }
    public String UnitMortgageStatus {
        get;
        set;
    }
    public String selectDoc {
        get;
        set;
    }

    public String originalStatus {
        get;
        set;
    } //represents the registration status while landing on the page.

    public CustomTaskControllerClass(ApexPages.StandardController controller) {
        this.stdController = controller;
        this.t = (Task) controller.getRecord();
        create = false;
        edit = false;
        error = false;
        errorForSave = false;
        pickupAdd = '';
        selectedCriteriaR = '';
        check1 = false;
        selectSubject = '';
        UnitMortgageStatus = '';
        selectDoc = '';
        system.debug('check1' + check1);
        qsMap = ApexPages.currentPage().getParameters();
        if (qsMap.containsKey('retURL')) {
            retURL = qsMap.get('retURL');
        }
        if (qsMap.containsKey('cancelURL')) {
            cancelURL = qsMap.get('cancelURL');
        }
        System.debug('query string map:' + qsMap);
        System.debug('returnURL:' + retURL);
        System.debug('cancelURL:' + cancelURL);

        if (qsMap.containsKey('origin')) {
            origin = qsMap.get('origin');
        } else {
            origin = 'Default';
        }
        AtchObj = new List < Attachment > ();
        AtchObjLoanClosure = new List < Attachment > ();
        // what and are who are present in oppty page task button
        if (qsMap.containsKey('who_id') && qsMap.containsKey('what_id')) {
            whatId = ApexPages.currentPage().getParameters().get('what_id');
            whoId = ApexPages.currentPage().getParameters().get('who_id');
            ownerId = UserInfo.getUserId();

            create = true;
        } else if (qsMap.containsKey('who_id')) {
            // who is present only on lead page task
            whoId = ApexPages.currentPage().getParameters().get('who_id');
            ownerId = UserInfo.getUserId();
            create = true;
            retURL = '/' + whoId;
            cancelURL = '/' + whoId;
        } else if (qsMap.containsKey('id')) {
            // if task id is present its an task edit
            edit = true;
            System.debug('Task Details in Edit: ' + t);
        } else {
            // if none are there is an error
            error = true;
            ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.severity.FATAL, 'Missing Required Parameters');
            ApexPages.addMessage(errorMsg);
        }

        // if we dont know the origin, we set to default.
        // if its coming from any of the custom button on task page, it would have the button name as the origin
        // if an origin is known, then take the url parameters and set it in the value of the task
        if (create) {
            String customerName = null;
            String objectwhatName = null;
            String objectwhoName = null;
            String mobile = null;
            Boolean revisit = false;

            if (String.isNotEmpty(whatId)) {
                objectWhatName = whatId.getSObjectType().getDescribe().getName();
            }
            if (String.isNotEmpty(whoId)) {
                objectWhoName = whoId.getSObjectType().getDescribe().getName();
            }
            if (objectwhatName == 'Opportunity') {
                opp = [Select Name, Account.Name, Walk_in_Source__c, Walk_in_Sub_Source__c,Site_Visit_Source_Details__c, Walk_in_Respective_Customer_Account__r.Name, Last_call_attempt_status__c, Id, Project__c,
                    Walk_in_Channel_Partner_Name__c, Walk_in_Channel_Partner_Phone__c, Walk_in_Channel_Partner_Email__c, Walk_in_Employee_Name__c, Site_Visit_Channel_Partner__r.Name,
                    Walk_in_Employee_Id__c, Name_O__c, Relation_With_Radius_O__c, Status__c, Project_Unit__r.Unit_Morgage_Status__c, Site_Visit_Channel_Partner__c, Site_Visit_Xcelerate_ID__c,
                    Person_Email__c, Account_Mobile_Number__c, Project_Unit__r.Id, Project_Unit__r.Name, StageName from Opportunity where Id = : whatId];

                revisit = TaskManagementServices.isRevisit(whatId);
            }
            if (opp.size() == 1) {
                //t.Project__c= opp[0].ProjectName__c; // Added By Netra 18/3/2016
                t.Previous_Call_Attempt_Status__c = opp[0].Last_call_attempt_status__c; // Added By Netra 18/3/2016
                t.Visitor_Name__c = opp[0].Account.Name;
                accountName = opp[0].Account.Name;
                customerName = opp[0].Name;
                system.debug('OPP ID : ' + opp[0].Id);
                system.debug('OPP Name: ' + opp[0].Name);
                walksource = opp[0].Walk_in_Source__c;
                walksubsource = opp[0].Walk_in_Sub_Source__c;
                if (opp[0].Site_Visit_Channel_Partner__c != null)
                    channelPartner = opp[0].Site_Visit_Channel_Partner__c;
                if (opp[0].Site_Visit_Xcelerate_ID__c != null)
                    xcelerateID = opp[0].Site_Visit_Xcelerate_ID__c;
                CPName = opp[0].Walk_in_Channel_Partner_Name__c;
                CPPhone = opp[0].Walk_in_Channel_Partner_Phone__c;
                CPEmail = opp[0].Walk_in_Channel_Partner_Email__c;
                BookedCustomer = opp[0].Walk_in_Respective_Customer_Account__r.Name;
                EmpName = opp[0].Walk_in_Employee_Name__c;
                EmpId = opp[0].Walk_in_Employee_Id__c;
                NameO = opp[0].Name_O__c;
                EmailO = opp[0].Person_Email__c;
                MobO = opp[0].Account_Mobile_Number__c;
                RelationO = opp[0].Relation_With_Radius_O__c;
                t.Walk_in_Source__c = walksource;
                t.Walk_in_Sub_Source__c = walksubsource;
                if (channelPartner != null)
                    t.Channel_Partner__c = channelPartner;
                if(opp[0].Site_Visit_Source_Details__c != null)
                    t.Registraion_Status__c = opp[0].Site_Visit_Source_Details__c;
                system.debug('Opp Walk In Source : ' + opp[0].Walk_in_Source__c);
                system.debug('Opp Walk In Subsource : ' + opp[0].Walk_in_Sub_Source__c);
                ////For Home Loan/////////
                UnitMortgageStatus = opp[0].Project_Unit__r.Unit_Morgage_Status__c;
                System.debug('opp[0].Project_Unit__c ' + opp[0].Project_Unit__c);
            }

            if (objectwhoName == 'Account' || objectwhoName == 'Contact') {
                acc = [Select Name, Id, IsPersonAccount, PersonMobilePhone, PersonContactId from Account where Id = : whoId];


            }
            if (acc.size() == 1 && acc[0].IsPersonAccount) {
                whoId = acc[0].PersonContactId;
                if (string.IsEmpty(customerName)) {
                    customerName = acc[0].Name;
                }
                mobile = acc[0].PersonMobilePhone;
            }

            if (objectwhoName == 'Lead') {
                lead = [Select Name, Id, RDS_Mobile__c, RDS_Project__c, Last_call_attempt_status__c FROM Lead WHERE Id = : whoId];
            }
            if (lead.size() == 1) {
                if (string.IsEmpty(customerName)) {
                    customerName = lead[0].Name;
                }
                mobile = lead[0].RDS_Mobile__c;
                t.ProjectInterestedWeb__c = lead[0].RDS_Project__c; // Added By Netra 18/3/2016
                t.Previous_Call_Attempt_Status__c = lead[0].Last_call_attempt_status__c; // Added By Netra 18/3/2016
            }

            if (String.isNotEmpty(whatId))
                t.WhatId = whatId;
            t.OwnerId = ownerId;
            t.whoId = whoId;
            t.activityDate = System.today();
            t.Call_Time__c = System.Now().format('h:mm a');
            t.Mobile_Number_Webform__c = mobile;
            t.revisit__c = revisit;

            // if we dont know the origin, we set to default.
            // if its coming from any of the custom button on task page, it would have the button name as the origin
            // if an origin is known, then take the url parameters and set it in the value of the task
            if (!origin.equals('Default')) {
                t.status = qsMap.get('status');
                t.Subject = qsMap.get('subject');
                system.debug('qsMap.get subject : ' + qsMap.get('subject'));
                t.Task_Type__c = qsMap.get('taskType');
                t.priority = 'Normal';
            }

        }
        //Anuja added this line to add Standad Pay Plan Detail lookup on task from url
        /*     if(ApexPages.currentPage().getParameters().get('scppd') != null || ApexPages.currentPage().getParameters().get('scppd') == '')
        {
            SCPPDid = ApexPages.currentPage().getParameters().get('scppd');
            //t.Standard_Customer_Pay_Plan_Detail__c = SCPPDid ;
            t.Communication_Type__c= 'Outbound Call';
            t.Reason_For_Call__c = 'Collections';
        } 
        if(t.Task_Type__c != null && t.Task_Type__c.equalsIgnoreCase('Registration')) {
            
            regCheck();
        }
        if(t.Task_Type__c != null && t.Task_Type__c.equalsIgnoreCase('Home Loan')) {
            selectSubject = t.Subject;
            HomeLoanCheck();
        }  */
    }




    Public Pagereference Savedoc() {
        system.debug('------selectDoc' + selectDoc);
        String taskId = System.currentPagereference().getParameters().get('id');

        /* insert the attachment */

        error = false;
        return NULL;
    }


    public PageReference save() {
        system.debug('inside save');
        errorForSave = False;
        Pagereference pv = null;
        try {
            if (origin.equals('CompleteTask')) {
                t.status = 'Completed';
            }
            
            
            
            
            t.Subject = t.Task_Type__c;
            //In case of revisit, if the walk-in source is the same as on opty then populating task fields with opty values
            t.ShowWalkInSource__c = check1;
            System.debug('t.Task_Type__c:' + t.Task_Type__c);
            if (t.Revisit__c == true && t.ShowWalkInSource__c == false && t.Task_Type__c == 'Site Visit') {
                System.Debug('Inside this condition');
                t.Walk_in_Source__c = walksource;
                t.Walk_in_Sub_Source__c = walksubsource;
                if (channelPartner != null)
                    t.Channel_Partner__c = channelPartner;
            }


            if (errorForSave != True) {
                System.debug('in task save:');
                pv = stdController.save();
                System.debug('in task save:1');
            }

            // took a day to figure this out. if the standard controller save is called
            // it handles the validation exceptions and returns a null as page reference
            // doesnt throw DML exception as described in the SF documents
            // check for pv = null and return the same to see the exceptions on UI
            if (pv == null) {
                return null;
            }
            if (String.isNotEmpty(retURL)) {
                pv = new PageReference(retURL);
            } else {
                pv = new PageReference('/' + t.whoId);
            }
            return pv;
        } catch (DMLException e) {
            System.debug('DML:' + e.getMessage());
            ApexPages.addMessages(e);
            return null;
        } catch (Exception e) {
            System.debug('Ex:' + e.getMessage());
            ApexPages.addMessages(e);
            return null;
        }
    }

    public PageReference cancel() {
        Pagereference pv = null;
        if (String.isNotEmpty(cancelURL)) {
            pv = new PageReference(cancelURL);
        } else {
            if (String.isNotEmpty(t.whatId)) {
                cancelURL = '/' + t.whatId;
            } else {
                cancelURL = '/' + t.whoId;
            }
            pv = new PageReference(cancelURL);
        }
        return pv;
    }

}