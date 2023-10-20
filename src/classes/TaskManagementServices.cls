public class TaskManagementServices {
    public static String className = TaskManagementServices.class.getName();
    public static Map < Id, Task > createTaskforEnquiries(Map < Id, Lead > enquiriesMap) {
        List < task > taskList = new List < Task > ();
        List < task > retTaskList = new List < Task > ();
        List < Id > taskIds = new List < Id > ();
        Map < Id, Task > taskWhoIdMap = new Map < Id, Task > ();
        List < Id > aSet = new List < Id > ();
        List < Id > lSet = new List < Id > ();
        Map < Id, Account > accDetails = new Map < Id, Account > ();
        Map < Id, Lead > leadDetails = new Map < Id, Lead > ();

        System.debug('Enquiries Map:' + enquiriesMap);

        if (!enquiriesMap.isEmpty()) {
            for (Id wid: enquiriesMap.keyset()) {
                if (wId.getSObjectType().getDescribe().getName() == 'Account') {
                    aSet.add(wid);
                } else if (wId.getSObjectType().getDescribe().getName() == 'Lead') {
                    lSet.add(wid);
                } else {

                }
            }

            // if the task is to be associated with an person account, then the personcontactId has to be mapped in whoId

            if (!aSet.isEmpty()) {
                accDetails = new Map < Id, Account > ([Select Id, PersonContactId, OwnerId from Account where id in : aSet]);
            }

            if (!lset.isEmpty()) {
                leadDetails = new Map < Id, Lead > ([Select Id, OwnerId from Lead where id in : lSet]);
            }

            System.debug('LEAD DETAILS:' + leadDetails);
            System.debug('ACCOUNT DETAILS:' + accDetails);


            for (Id wId: enquiriesMap.keyset()) {
                task t = new task();
                t.status = 'Completed';
                t.task_type__c = 'Enquiry Received';
                t.Subject = 'New Enquiry Received From:' + enquiriesMap.get(wId).LeadSource;
                if (String.isNotBlank(enquiriesMap.get(wId).lastName))
                    t.FullName__c = (enquiriesMap.get(wId).lastName);
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Email__c))
                    t.emailAddress__c = (enquiriesMap.get(wId).RDS_Email__c);
              
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Country__c))
                    t.country__c = (enquiriesMap.get(wId).RDS_Country__c);
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Country_Code__c))
                    t.dialingCode__c = (enquiriesMap.get(wId).RDS_Country_Code__c);
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Mobile__c))
                    t.Mobile_Number_Webform__c = (enquiriesMap.get(wId).RDS_Mobile__c);

              
                    
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Budget__c))
                    t.Budget_WebForm__c = (enquiriesMap.get(wId).RDS_Budget__c);
                if (String.isNotBlank(enquiriesMap.get(wId).RDS_Project__c))
                    t.ProjectInterestedWeb__c = (enquiriesMap.get(wId).RDS_Project__c);
                
                if (String.isNotBlank(enquiriesMap.get(wId).Source_Remarks__c))
                    t.description = 'Customer Enquired through ' + (enquiriesMap.get(wId).Source_Remarks__c);
                //fields added for SEO information
                if (String.isNotBlank(enquiriesMap.get(wId).web_banner_source__c))
                    t.web_banner_source__c = (enquiriesMap.get(wId).web_banner_source__c);
                if (String.isNotBlank(enquiriesMap.get(wId).web_banner_size__c))
                    t.web_banner_size__c = (enquiriesMap.get(wId).web_banner_size__c);
                if (String.isNotBlank(enquiriesMap.get(wId).IP_address_web2lead__c))
                    t.IP_address_web2lead__c = (enquiriesMap.get(wId).IP_address_web2lead__c);

                ///////////////////////////////////////////----------------------- vikas added below some field on dated 23-08-16 for web lead enquiry received -------------------///////////////////////// 

                if (String.isNotBlank(enquiriesMap.get(wId).UTM_Campaign__c))
                    t.UTM_Campaign__c = (enquiriesMap.get(wId).UTM_Campaign__c);
                if (String.isNotBlank(enquiriesMap.get(wId).UTM_Display__c))
                    t.UTM_Display__c = (enquiriesMap.get(wId).UTM_Display__c);
                if (String.isNotBlank(enquiriesMap.get(wId).UTM_Medium__c))
                    t.UTM_Medium__c = (enquiriesMap.get(wId).UTM_Medium__c);
                if (String.isNotBlank(enquiriesMap.get(wId).UTM_Source__c))
                    t.UTM_Source__c = (enquiriesMap.get(wId).UTM_Source__c);
                if (String.isNotBlank(enquiriesMap.get(wId).UTM_Term__c))
                    t.UTM_Term__c = (enquiriesMap.get(wId).UTM_Term__c);

                ////////////////////////////////////////////////////------------------- vikas added field end here -----------------------------///////////////////////////////  

                if (wId.getSObjectType().getDescribe().getName() == 'Lead') {
                    t.whoId = wId;
                    t.OwnerId = leadDetails.get(wid).OwnerId;
                } else if (wId.getSObjectType().getDescribe().getName() == 'Account') {
                    t.whoId = accDetails.get(wId).PersonContactId;
                    t.ownerId = accDetails.get(wid).OwnerId;
                    t.whatId = wId;
                } else {
                    t.whoId = '';
                    t.ownerId = '';
                }
                if (t.ActivityDate == null) {
                    t.activityDate = System.today();
                    t.Call_Time__c = System.Now().format('h:mm a');
                }
                taskList.add(t);
            }

            try {
                Database.SaveResult[] srList = Database.insert(taskList, true);
                // Iterate through each returned result

                for (Database.SaveResult sr: srList) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully inserted account. Task ID: ' + sr.getId());
                        taskIds.add(sr.getId());
                    } else {
                        // Operation failed, so get all errors  
                        List < String > customMsgList = new List < String > ();
                        for (Database.Error err: sr.getErrors()) {
                            String msg = 'Task Insert Failed :' + err.getMessage();
                            customMsgList.add(msg);
                        }
                        throw new GlobalException(customMsgList, '', className);
                    }
                }

                if (!taskIds.isEmpty()) {
                    retTaskList = [SELECT Id, Subject, WhoId, WhatId, OwnerId from Task where Id in : taskIds];
                }

                for (task t: retTaskList) {
                    taskWhoIdMap.put(t.whoId, t);
                }

            } catch (System.DmlException ex) {
                List < String > customMsgList = new List < String > ();
                for (Integer i = 0; i < ex.getNumDml(); i++) {
                    String msg = 'Task Insert Failed :' + ex.getMessage();
                    customMsgList.add(msg);
                }
                throw new GlobalException(customMsgList, '', className);
            }
        }
        return taskWhoIdMap;
    }
    
     

    public static List < Task > getTaskByType(String taskType, String taskStatus, String sortField, String sortOrder, Id whatId) {

        String baseQuery = 'SELECT Id, Subject, Task_Type__c, ActivityDate, Call_Time__c, Status, What.Name, Who.Name, Priority,Registraion_Status__c, Owner.Name, Ageing__c,Description,Call_Attempt_Status__c,Previous_Call_Attempt_Status__c,Attempted_By1__c,Function__c,RM__c,Next_Action_Date__c,Case_Status__c from Task ';
        String buildQuery = baseQuery;
        List < String > customMsgList = new List < String > ();

        if (String.isBlank(taskType) || String.isblank(taskStatus) || String.isBlank(sortOrder) || String.isBlank(sortField) || String.isBlank(whatId)) {
            String msg = 'Required Parameters Missing';
            customMsgList.add(msg);
            throw new GlobalException(customMsgList, '', 'TaskManagementServices.getTaskByType');
        }

        if (!sortOrder.equals('ASC') && !sortOrder.equals('DESC')) {
            String msg = 'Incorrect sort order, sort order can only be ASC or DESC';
            customMsgList.add(msg);
            throw new GlobalException(customMsgList, '', 'TaskManagementServices.getTaskByType');

        }
        List < String > taskStatusList = new List < String > ();
        if (taskStatus.equals('ALL')) {
            taskStatusList.add('\'Completed\'');
            taskStatusList.add('\'Open\'');
            taskStatusList.add('\'Scheduled\'');
        } else {
            taskStatusList.add('\'' + taskStatus + '\'');
        }

        buildQuery = buildQuery + 'where task_type__c =' + '\'' + taskType + '\'' + ' and status IN ' + taskStatusList + ' and whatId =' + '\'' + whatId + '\'' + ' order by Status, ' + sortField + ' ' + sortOrder;
        System.debug('QUERY:' + buildQuery);
        List < Task > taskList = (List < Task > ) Database.query(buildQuery);
        return taskList;
    }

    public static List < Task > getTaskByTypeLead(String taskType, String taskStatus, String sortField, String sortOrder, Id whoId) {
        // New - Netra 18/03/2016
        String baseQuery = 'SELECT Id, Subject, Task_Type__c, ActivityDate,Call_Time__c,  Status, What.Name, Who.Name, Priority, OwnerId, Ageing__c,Description,Call_Attempt_Status__c,Previous_Call_Attempt_Status__c,Attempted_By1__c,Function__c,RM__c,Next_Action_Date__c,Case_Status__c FROM Task ';

        String buildQuery = baseQuery;
        List < String > customMsgList = new List < String > ();

        if (String.isBlank(taskType) || String.isblank(taskStatus) || String.isBlank(sortOrder) || String.isBlank(sortField) || String.isBlank(whoId)) {
            String msg = 'Required Parameters Missing';
            customMsgList.add(msg);
            throw new GlobalException(customMsgList, '', 'TaskManagementServices.getTaskByType');
        }

        if (!sortOrder.equals('ASC') && !sortOrder.equals('DESC')) {
            String msg = 'Incorrect sort order, sort order can only be ASC or DESC';
            customMsgList.add(msg);
            throw new GlobalException(customMsgList, '', 'TaskManagementServices.getTaskByType');

        }
        List < String > taskStatusList = new List < String > ();
        if (taskStatus.equals('ALL')) {
            taskStatusList.add('\'Completed\'');
            taskStatusList.add('\'Open\'');
        } else {
            taskStatusList.add('\'' + taskStatus + '\'');
        }

        buildQuery = buildQuery + 'where task_type__c =' + '\'' + taskType + '\'' + ' and status IN ' + taskStatusList + ' and whoId =' + '\'' + whoId + '\'' + ' order by Status, ' + sortField + ' ' + sortOrder;
        System.debug('QUERY:' + buildQuery);
        List < Task > taskList = (List < Task > ) Database.query(buildQuery);
        return taskList;
    }


    public static boolean isRevisit(String parentId) {
        List < Task > taskList = new List < Task > ();
        taskList = TaskManagementServices.getTaskByType('Site Visit', 'ALL', 'createdDate', 'DESC', parentId);
        if (taskList.size() > 0)
            return true;
        else
            return false;
    }

    public static boolean isFirstVisit(String parentId) {
        List < Task > taskList = new List < Task > ();
        taskList = TaskManagementServices.getTaskByType('Site Visit', 'ALL', 'createdDate', 'DESC', parentId);
        if (taskList.size() == 1)
            return true;
        else
            return false;
    }

    public static void latestTaskRollupToOpp(List < Task > taskList) {
        Map < Id, Task > opptyTaskMap = new Map < Id, Task > ();
        for (Task t: TaskList) {
            if (t.WhatId != null && t.WhatId.getSObjectType().getDescribe().getName() == 'Opportunity') {
                if (opptyTaskMap.containsKey(t.whatId)) {
                    // if a task already exist for the oppty, 
                    // replace it with the new task only if the new task is the latest
                    if (opptyTaskMap.get(t.whatId).createdDate < t.createdDate) {
                        opptyTaskMap.put(t.whatId, t);
                    }
                } else {
                    opptyTaskMap.put(t.whatId, t);
                }
            }
        }
        List < Opportunity > oppList = [select Name, Id, call_proposed_date_of_visit__c, Follow_up_date__c,
            Last_call_attempted_by__c, Last_call_attempt_status__c,Last_Call_Attempt_Status_Details__c, Last_call_description__c,
            last_call_attempt_date__c, Last_Call_Rating__c, Presales_Call_counter__c,
            Unique_SVF_Number__c, Walk_in_Source__c, Walk_in_Sub_Source__c, Site_Visit_Channel_Partner__c, Xcelerate_ID__c,
            Walk_in_Channel_Partner_Email__c, Walk_in_Channel_Partner_Name__c,
            Walk_in_Channel_Partner_Phone__c, Walk_in_Channel_Partner__c,
            Walk_in_Source_Remarks__c, Last_VDNB_Attempted_By__c, Last_VDNB_Call_status__c, Last_VDNB_Attempt_Date__c,
            Expected_Re_Visit_Date__c, Next_Action_Date_VDNB__c, Last_VDNB_Call_Description__c,
            Walk_in_Respective_Customer_Account__c, Walk_in_Attended_By__c,
            visit_counter__c, Date_Of_Visit__c, Visit_Rating__c, Visit_Task_Id__c, AccountId,
            Sourcing_Manager__c, Sales_Manager__c, Descriptive_Remarks_Feedback__c,
            Unit_type_configuration__c, S_Budget__c, IsFirstPresalesCall__c, Sourcing_TL__c, Name_of_TL__c
               
            from Opportunity
            where Id in : opptyTaskMap.keySet()
        ];
        Set < Id > accIdSet = new Set < Id > ();
        List < AggregateResult > taskCountAg = [Select count(Id) taskCount, whatId oppId, task_type__c taskType from Task
            where whatId in : opptyTaskMap.keySet() group by whatId, task_type__c
        ];
        Map < String, Map < String, Integer >> oppTaskCountMap = new Map < String, Map < String, Integer >> ();
        for (AggregateResult ar: taskCountAg) {
            if (oppTaskCountMap.containsKey((String) ar.get('oppId'))) {
                oppTaskCountMap.get((String) ar.get('oppId')).put((String) ar.get('taskType'), (Integer) ar.get('taskCount'));
            } else {
                Map < String, Integer > tempMap = new Map < String, Integer > ();
                tempMap.put((String) ar.get('taskType'), (Integer) ar.get('taskCount'));
                oppTaskCountMap.put((String) ar.get('oppId'), tempMap);
            }
        }
        for (Opportunity o: oppList) {
            System.debug('Oppty:' + o);
            if (opptyTaskMap.containsKey(o.Id) && opptyTaskMap.get(o.Id).Task_Type__c == 'Presales Call') {
                
                o.Last_call_description__c = opptyTaskMap.get(o.Id).description;
                o.Last_Presales_Task_Id__c = opptyTaskMap.get(o.Id).Id;
                o.Last_call_attempt_status__c = opptyTaskMap.get(o.Id).Call_Attempt_Status__c;
                o.Last_Call_Attempt_Status_Details__c = OpptyTaskMap.get(o.Id).Reason_For_Lost__c;
                o.Next_Action_Date__c = opptyTaskMap.get(o.Id).Next_Action_Date__c;
                o.call_proposed_date_of_visit__c = opptyTaskMap.get(o.Id).Call_Proposed_Date_Of_Visit__c;
                o.Last_Call_Rating__c = opptyTaskMap.get(o.Id).Call_Rating__c;
                o.Last_call_attempted_by__c = opptyTaskMap.get(o.Id).Attempted_By1__c;
                
                Datetime taskDate = opptyTaskMap.get(o.Id).ActivityDate;

                if (taskDate == null)
                    taskDate = Date.today();

                // stripping the time value 00:00:00 from the t.activity date value
                String taskDate1 = taskDate.Date().format();

                // Here we are concatenating the date and time values to make create a datetime string                       
                taskDate1 = taskDate1 + ' ' + opptyTaskMap.get(o.Id).Call_Time__c;

                System.Debug('Value of datetime parse function' + taskDate1);
                o.last_call_attempt_date__c = DateTime.Parse(taskDate1);
                o.Presales_Call_counter__c = oppTaskCountMap.get(o.Id).get('Presales Call');
                system.debug('o.Presales_Call_counter__c:::: ' + o.Presales_Call_counter__c);
                if (o.Presales_Call_counter__c == 1)
                    o.IsFirstPresalesCall__c = true;
                else
                    o.IsFirstPresalesCall__c = false;
                system.debug('o.IsFirstPresalesCall__c::::: ' + o.IsFirstPresalesCall__c);

            }
            
              

            if (opptyTaskMap.containsKey(o.Id) && opptyTaskMap.get(o.Id).Task_Type__c == 'Site Visit') { /////!(opptyTaskMap.get(o.Id).revisit__c)) commented by vikas
                //o.Unique_SVF_Number__c = opptyTaskMap.get(o.Id).Visit_Form_No__c;
                o.Walk_in_Source__c = opptyTaskMap.get(o.Id).Walk_in_Source__c;
                o.Walk_in_Sub_Source__c = opptyTaskMap.get(o.Id).Walk_in_Sub_Source__c;
                o.Site_Visit_Channel_Partner__c = opptyTaskMap.get(o.Id).Channel_Partner__c;
                o.Unique_SVF_Number__c = opptyTaskMap.get(o.Id).Visit_Form_No__c;
                //o.Site_Visit_Source_Details__c = opptyTaskMap.get(o.Id).Registraion_Status__c;
                o.Walk_in_Channel_Partner_Email__c = opptyTaskMap.get(o.Id).New_Channel_Partner_Email__c;
                o.Walk_in_Channel_Partner_Name__c = opptyTaskMap.get(o.Id).New_Channel_Partner_Name__c;
                o.Walk_in_Channel_Partner_Phone__c = opptyTaskMap.get(o.Id).New_Channel_Partner_Phone__c;
                o.Walk_in_Channel_Partner__c = opptyTaskMap.get(o.Id).Existing_Channel_Partner__c;

                if (string.isNotBlank(o.Descriptive_Remarks_Feedback__c))
                    o.Descriptive_Remarks_Feedback__c += '\n' + system.today().format() + ' : ' + opptyTaskMap.get(o.Id).description;
                else
                    o.Descriptive_Remarks_Feedback__c = system.today().format() + ' : ' + opptyTaskMap.get(o.Id).description;
                o.Walk_in_Respective_Customer_Account__c = opptyTaskMap.get(o.Id).Walk_in_Respective_Customer_Account__c;
                o.Sales_Manager__c = opptyTaskMap.get(o.Id).Sales_Attempted_By__c;
                o.visit_counter__c = oppTaskCountMap.get(o.Id).get('Site Visit');
                o.Date_Of_Visit__c = opptyTaskMap.get(o.Id).S_Activity_Created_Date__c;
                o.Visit_Rating__c = opptyTaskMap.get(o.Id).Call_Rating__c;
                o.Visit_Task_Id__c = opptyTaskMap.get(o.Id).Id;
                o.Sourcing_Manager__c = opptyTaskMap.get(o.Id).Sourcing_Manager__c;
                o.Sales_Manager__c = opptyTaskMap.get(o.Id).Call_Attempted_By_Name__c;
                o.Name_of_TL__c = opptyTaskMap.get(o.Id).Name_of_TL__c;
                o.Sourcing_TL__c = opptyTaskMap.get(o.Id).Sourcing_TL__c;
                o.Purpose__c = opptyTaskMap.get(o.Id).Registraion_Status__c;

                o.Unit_type_configuration__c = opptyTaskMap.get(o.Id).Configuration__c;
                o.S_Budget__c = opptyTaskMap.get(o.Id).Budget__c;
                if (opptyTaskMap.get(o.Id).Budget_Site_Visit_In_Lacs__c != null)
                    o.Budget_Site_Visit_In_Lacs__c = opptyTaskMap.get(o.Id).Budget_Site_Visit_In_Lacs__c;

            }


/////////------------------Adding By Ashish for CRM Interaction Stored to Opportunity-------------------//////////////////////

            if (opptyTaskMap.containsKey(o.Id) && opptyTaskMap.get(o.Id).Task_Type__c == 'CRM Interaction'){
                
                if (opptyTaskMap.get(o.Id).Function__c == 'Account Management') {
                o.Account_Management_Status__c = opptyTaskMap.get(o.Id).Customer_Status__c;
                o.Account_Management_Remarks__c = opptyTaskMap.get(o.Id).Description;
                o.AM_Next_action_Date__c = opptyTaskMap.get(o.Id).Next_Action_Date__c;
                o.Case_Status__c = opptyTaskMap.get(o.Id).Case_Status__c;
                o.RM_Name_AM__c = opptyTaskMap.get(o.Id).RM__c;                
                o.Interaction_Date__c= Date.Today();
                }
                
                if (opptyTaskMap.get(o.Id).Function__c == 'Banking Management') {
                o.Banking_Status__c = opptyTaskMap.get(o.Id).Customer_Status__c;
                o.Banking_Remarks__c = opptyTaskMap.get(o.Id).Description;
                o.BM_Next_action_Date__c = opptyTaskMap.get(o.Id).Next_Action_Date__c;
                o.BM_Case_Status__c = opptyTaskMap.get(o.Id).Case_Status__c;
                o.RM_Name_BM__c = opptyTaskMap.get(o.Id).RM__c;
                o.BM_Interaction_Date__c= Date.Today();
                }
                
                if (opptyTaskMap.get(o.Id).Function__c == 'Recovery Management') {
                o.Recovery_Status__c = opptyTaskMap.get(o.Id).Customer_Status__c;
                o.Recovery_Remarks__c = opptyTaskMap.get(o.Id).Description;
                o.Payment_Expected_Date__c = opptyTaskMap.get(o.Id).PTP_Date1__c;
                o.CRM_Next_action_Date__c = opptyTaskMap.get(o.Id).Next_Action_Date__c;
                o.RM_Case_Status__c = opptyTaskMap.get(o.Id).Case_Status__c;
                o.RM_Name_RM__c = opptyTaskMap.get(o.Id).RM__c;
                o.RM_Interaction_Date__c= Date.Today();                
                }
                


            }
/////////------------------Adding By Ashish for CRM Interaction Stored to Opportunity end-------------------//////////////////////            
            ///////// Adding By vikas for VDNB Call Stored to Opportunity  //////////////////////

            /*if (opptyTaskMap.containsKey(o.Id) && opptyTaskMap.get(o.Id).Task_Type__c == 'VDNB Call') {////////Commented by Ashish For crm interaction On 4/5/19
                o.Last_VDNB_Attempted_By__c = opptyTaskMap.get(o.Id).VDNB_Attempted_By__c;
                o.Last_VDNB_Call_status__c = opptyTaskMap.get(o.Id).VDNB_Status__c;
                o.Last_VDNB_Attempt_Date__c = opptyTaskMap.get(o.Id).Call_Proposed_Date_Of_Visit__c;
                o.Last_VDNB_Call_Description__c = opptyTaskMap.get(o.Id).Description;
                o.Expected_Re_Visit_Date__c = opptyTaskMap.get(o.Id).Expected_Revisit_Date__c;
                o.Next_Action_Date_VDNB__c = opptyTaskMap.get(o.Id).Next_Action_Date__c;
                


            }*/
            
            
            // update opportunities with once SV done at Account level
            System.debug('revisit logic:' + isRevisit(o.Id));
            if (isFirstVisit(o.Id)) {
                accIdSet.add(o.AccountId);
            }
            System.debug('accidSet:' + accIdSet);

        }
        update(oppList);
        List < Account > accList = [Select Id, visit_count__c from Account where Id in : accIdSet];
        System.debug('accList:' + accList);
        for (Account a: accList) {
            if (a.visit_count__c != null) {
                a.visit_count__c++;
            } else {
                a.visit_count__c = 1;
            }
        }
        update accList;
    }

    public static void latestTaskRollupToLead(List < Task > taskList) {
        Map < Id, Task > leadTaskMap = new Map < Id, Task > ();
        for (Task t: TaskList) {
            if (t.whoId != null && t.whoId.getSObjectType().getDescribe().getName() == 'Lead') {
                if (leadTaskMap.containsKey(t.whoId)) {
                    // if a task already exist for the oppty, 
                    // replace it with the new task only if the new task is the latest
                    if (leadTaskMap.get(t.whoId).createdDate < t.createdDate) {
                        leadTaskMap.put(t.whoId, t);
                    }
                } else {
                    leadTaskMap.put(t.whoId, t);
                }
            }
        }
        List < Lead > leadList = [select Name, Id, call_proposed_date_of_visit__c, Follow_up_date__c,
            Last_call_attempted_by__c, Last_call_attempt_status__c,Last_Call_Attempt_Status_Details__c, 
            Last_Call_Rating__c, Presales_Call_counter__c, last_call_attempt_date__c, IsFirstPresalesCall__c from lead
            where Id in : leadTaskMap.keySet()
        ];

        List < AggregateResult > taskCountAg = [Select count(Id) taskCount, whoId leadId, task_type__c taskType from Task
            where whoId in : leadTaskMap.keySet() group by whoId, task_type__c
        ];
        Map < String, Map < String, Integer >> leadTaskCountMap = new Map < String, Map < String, Integer >> ();
        for (AggregateResult ar: taskCountAg) {
            if (leadTaskCountMap.containsKey((String) ar.get('leadId'))) {
                leadTaskCountMap.get((String) ar.get('leadId')).put((String) ar.get('taskType'), (Integer) ar.get('taskCount'));
            } else {
                Map < String, Integer > tempMap = new Map < String, Integer > ();
                tempMap.put((String) ar.get('taskType'), (Integer) ar.get('taskCount'));
                leadTaskCountMap.put((String) ar.get('leadId'), tempMap);
            }
        }
        for (Lead l: leadList) {
            if (leadTaskMap.containsKey(l.Id) && leadTaskMap.get(l.Id).Task_Type__c == 'Presales Call') {
                
                l.Last_call_description__c = leadTaskMap.get(l.Id).description;
                l.Last_Presales_Task_Id__c = leadTaskMap.get(l.Id).Id;
                l.Last_call_attempt_status__c = leadTaskMap.get(l.Id).Call_Attempt_Status__c;
                l.Last_Call_Attempt_Status_Details__c = leadTaskMap.get(l.Id).Reason_For_Lost__c;
                l.Latest_Next_Action_Date__c = leadTaskMap.get(l.Id).Next_Action_Date__c;
                l.call_proposed_date_of_visit__c = leadTaskMap.get(l.Id).Call_Proposed_Date_Of_Visit__c;
                l.Last_Call_Rating__c = leadTaskMap.get(l.Id).Call_Rating__c;
                l.Last_call_attempted_by__c = leadTaskMap.get(l.Id).Attempted_By1__c;
                
                Datetime taskDate = leadTaskMap.get(l.Id).ActivityDate;
                

                if (taskDate == null)
                    taskDate = Date.today();

                // stripping the time value 00:00:00 from the t.activity date value
                String taskDate1 = taskDate.Date().format();

                // Here we are concatenating the date and time values to make create a datetime string                       
                taskDate1 = taskDate1 + ' ' + leadTaskMap.get(l.Id).Call_Time__c;

                System.Debug('Value of datetime parse function' + taskDate1);
                l.last_call_attempt_date__c = DateTime.Parse(taskDate1);
                l.Presales_Call_counter__c = leadTaskCountMap.get(l.Id).get('Presales Call');
                system.debug('l.Presales_Call_counter__c:::: ' + l.Presales_Call_counter__c);
                if (l.Presales_Call_counter__c == 1)
                    l.IsFirstPresalesCall__c = true;
                else
                    l.IsFirstPresalesCall__c = false;
                system.debug('l.IsFirstPresalesCall__c::::: ' + l.IsFirstPresalesCall__c);

            }
        }
        update(leadList);
    }

    public static void updateSCPP(Task[] lstTask) {
        system.debug('Inside Method');
        list < Task > tskDetails = new list < Task > ();
        set < id > taskIds = new set < id > ();
        set < id > SCPPDids = new set < id > ();
        for (task tsk: lstTask) {
            taskIds.add(tsk.id);
        }
        system.debug('ids : ' + taskIds);
        tskDetails = [SELECT id, Address__c, Description, Payment_Instrument__c, Reason_For_Call__c, L2__c, L3__c, Standard_Customer_Pay_Plan_Detail__c, Next_Action_Date__c, PTP_Amount__c, PTP_Date__c FROM Task WHERE Id in : taskIds];
        system.debug('Task List: ' + tskDetails);
        for (task t: tskDetails) {
            SCPPDids.add(t.Standard_Customer_Pay_Plan_Detail__c);
        }
        Map < Id, Standard_Customer_Pay_Plan_Detail__c > scppDetails = new Map < Id, Standard_Customer_Pay_Plan_Detail__c > ([SELECT Id, Call_Comments__c, Pick_up_address__c, L1__c, L2__c, L3__c, PTP_Amount__c, PTP_Date__c, Last_Call_Disposition__c, PTP_Instrument__c FROM Standard_Customer_Pay_Plan_Detail__c WHERE Id in : SCPPDids]);
        list < Standard_Customer_Pay_Plan_Detail__c > SCPPDtoadd = new list < Standard_Customer_Pay_Plan_Detail__c > ();
        for (Standard_Customer_Pay_Plan_Detail__c s: scppDetails.values()) {
            for (task t: tskDetails) {
                if (t.PTP_Amount__c != null) {
                    s.PTP_Amount__c = t.PTP_Amount__c;
                }
                if (t.Next_Action_Date__c != null) {
                    s.PTP_Date__c = t.Next_Action_Date__c;
                }
                s.L1__c = t.Reason_For_Call__c;
                s.L2__c = t.L2__c;
                s.L3__c = t.L3__c;
                s.PTP_Instrument__c = t.Payment_Instrument__c;
                s.Pick_up_address__c = t.Address__c;
                s.Call_Comments__c = t.Description;
                SCPPDtoadd.add(s);
                system.debug('before SCPPDtoadd' + SCPPDtoadd);

            }

        }

        update SCPPDtoadd;
    }

    // returns the time from the datetime field in the user's locale
    // if the input was 17/1/2016 12:30 AM, returns 12:30 AM as a string
    public static String formatTime(DateTime input) {
        String dt = input.format();
        Integer s = dt.indexOf(' ');
        return dt.substring(s + 1);
    }


    ////Clone task to communicaton object//////

    public static void createCommunicationEntries(Task[] TaskList) {
        List < Id > allWhatIdOpty = new List < Id > ();
        List < Id > allWhatIdAccount = new List < Id > ();
        List < Id > allWhoIdLead = new List < Id > ();
        for (Task t: TaskList) {
            //debugging
            if (t.whatId != null) {
                System.debug('WHAT AM I? :' + t.whatId.getSobjectType());
            }
            if (t.whoId != null) {
                System.debug('WHO AM I? :' + t.whoId.getSobjectType());
            }

            if (t.WhatId != null && t.whatId.getSobjectType() == Schema.Opportunity.SObjectType) {
                allWhatIdOpty.add(t.WhatId);
            } else if (t.whatId != null && t.whatId.getSObjectType() == Schema.Account.SObjectType) {
                allWhatIdAccount.add(t.whatId);
            } else {
                System.debug('Ignore the task created against any other object types');
            }

            if (t.WhoId != null && t.whoId.getSObjectType() == Schema.Lead.SObjectType) {
                allWhoIdLead.add(t.WhoId);
            } else {
                System.debug('Ignore the task created against any other object types');
            }
        }

        if (!allWhatIdOpty.isEmpty() || !allWhatIdAccount.IsEmpty() || !allWhoIdLead.isEmpty()) {
            //Create maps
            Map < Id, Opportunity > WhatIdToOptyMap = new Map < Id, Opportunity > ([SELECT Id, Name, Account.FirstName, Account.LastName, Account.PersonEmail, Account.PersonMobilePhone, Project__c, IsFirstPresalesCall__c FROM Opportunity WHERE Id IN: allWhatIdOpty]);
            Map < Id, Lead > WhoIdToLeadMap = new Map < Id, Lead > ([SELECT Id, Name, Email, FirstName, LastName, mobilePhone, IsFirstPresalesCall__c FROM Lead WHERE Id IN: allWhoIdLead]);
            Map < Id, Account > WhatIdToAccountMap = new Map < Id, Account > ([SELECT Id, Name, personEmail, FirstName, LastName, PersonMobilePhone FROM Account WHERE(Id IN: allWhatIdAccount OR PersonContactId In: allWhatIdAccount) and isPersonAccount = true]);

            //Create a list 
            List < Communication__c > cloneList = new List < Communication__c > ();
        //    List < UserDetails__c > UserDetails;
            for (Task t: TaskList) {
                String objectWhatName = '';
                String objectWhoName = '';
                String dt = '';
                //Create an object
                Communication__c cloneRecord = new Communication__c();
                cloneRecord.Name = t.Subject;
                cloneRecord.Status__c = t.Status;
                //This code is added on 22/9/2015 to insert date and time in communication object date and time field
                cloneRecord.ActivityDate__c = t.ActivityDate;
                cloneRecord.ActivityTime__c = t.DueTime__c;
                cloneRecord.Task_Type__c = t.Task_Type__c;
                cloneRecord.Show_Walk_In_Source__c = t.ShowWalkInSource__c;
                cloneRecord.Revisit__c = t.Revisit__c;
                //cloneRecord.Walk_in_Source__c = t.Walk_in_Source__c;
                //cloneRecord.Walk_in_Sub_Source__c = t.Walk_in_Sub_Source__c;


                // All the below fields added for populating various task fields on communication by Vikas
                cloneRecord.Call_Back__c = t.Call_Back__c;
                cloneRecord.Call_Back_Date__c = t.Call_Back_Date__c;
                cloneRecord.Call_Proposed_Date_Of_Visit__c = t.Call_Proposed_Date_Of_Visit__c;
                cloneRecord.Call_Rating__c = t.Call_Rating__c;
                cloneRecord.Call_Source__c = t.Call_Source__c;
                cloneRecord.Call_Status__c = t.Call_Status__c;
                cloneRecord.Campaign_Lookup__c = t.Campaign_Lookup__c;
                cloneRecord.Email_Id__c = t.Email_Id__c;
                cloneRecord.Configuration__c = t.Configuration__c;

                cloneRecord.Previous_Call_Attempt_Status__c = t.Previous_Call_Attempt_Status__c;
                cloneRecord.Project_Interested__c = t.ProjectInterestedWeb__c;
                cloneRecord.Sourcing_Manager__c = t.Sourcing_Manager__c;
                cloneRecord.Subject__c = t.Subject;
                cloneRecord.Team_Attended_By__c = t.Team_Attended_By__c;
                cloneRecord.Visit_Form_Number__c = t.Visit_Form_No__c;
                cloneRecord.Financial_Institute__c = t.Financial_Institute__c;
                cloneRecord.Visit_Status__c = t.Event_Status__c;
                cloneRecord.Visit_Type__c = t.Name_Of_Banks__c;
                cloneRecord.Call_Attempt_Status__c = t.Call_Attempt_Status__c;
                cloneRecord.Communication_Type__c = t.Communication_Type__c;
                if (t.Task_Type__c == 'Enquiry Received') {
                    cloneRecord.Enquiry_Received_Project_Lookup__c = t.ProjectInterestedWeb__c;
                    system.debug(' cloneRecord.Enquiry_Received_Project__c>>>>>  ' + cloneRecord.Enquiry_Received_Project_Lookup__c);
                }
                //The activity date is a Date field which needs to be converted into a datetime field. The time value will be picked-up from
                // t.DueTime__c field and its value will be concatenated with the value of activity date value.
                Datetime OnlyDate = t.ActivityDate;

                if (OnlyDate == null)
                    OnlyDate = Date.today();

                // stripping the time value 00:00:00 from the t.activity date value
                String ODate = OnlyDate.Date().format();

                // Here we are concatenating the date and time values to make create a datetime string       
                if (t.Call_Time__c != null) {
                    dt = ODate + ' ' + t.Call_Time__c;
                } else {
                    dt = System.now().format();

                }
                System.Debug('Value of datetime parse function' + dt);

                System.Debug('HardCoded Value of datetime parse function' + dt);
                cloneRecord.Due_Date__c = DateTime.Parse(dt);

                //Populating the externalId field on communication record with the task Id.
                cloneRecord.TaskId__c = t.id;

                ///Population cp details incase of site visit///
                if (t.Task_Type__c == 'Site Visit') {
                    cloneRecord.Next_Action_Date__c = t.Next_Action_Date__c;
                    //cloneRecord.Sales_Manager_Email__c = t.Sales_Attempted_By__c;
                    if (t.Walk_in_Source__c == 'Channel Partner') {
                        if (t.Walk_in_Sub_Source__c == 'Registered') {
                            cloneRecord.ExistingChannelPartner__c = t.Existing_Channel_Partner__c;
                        } else {
                            cloneRecord.NewChannel_Partner_Name__c = t.New_Channel_Partner_Name__c;
                            cloneRecord.Channel_Partner_Phone__c = t.New_Channel_Partner_Phone__c;
                        }

                    }
                }

                if (t.WhatId != null) {
                    objectWhatName = t.WhatId.getSObjectType().getDescribe().getName();
                }
                if (t.WhoId != null) {
                    objectWhoName = t.WhoId.getSObjectType().getDescribe().getName();
                }
                // If the parent record is an opportunity then query project object and get the sales managers name and email id.    
                if (objectWhatName == 'Opportunity') {
                    // for copying tasks against Oppty

                    if (!WhatIdToOptyMap.isEmpty() && WhatIdToOptyMap.containsKey(t.whatId)) {
                        // mobile phone and email of the customer
                        cloneRecord.Customer_Mobile_Phone__c = WhatIdToOptyMap.get(t.whatId).Account.PersonMobilePhone;
                        cloneRecord.Customer_Preferred_Email__c = WhatIdToOptyMap.get(t.WhatId).Account.personEmail;
                        cloneRecord.IsFirstPresalesCall__c = WhatIdToOptyMap.get(t.WhatId).IsFirstPresalesCall__c;
                        cloneRecord.Project_Interested__c = WhatIdToOptyMap.get(t.WhatId).Project__c; // for populating project interested only for opty
                    }

                    cloneRecord.sobjectName__c = objectWhatName;
                    cloneRecord.OptyName__c = t.WhatId;
                    cloneList.add(cloneRecord);
                } else if (objectWhoName == 'Lead') {
                    //for copying tasks against leads
                    //mobile phone and preferred email of the customer
                    if (!WhoIdToLeadMap.isEmpty() && WhoIdToLeadMap.containsKey(t.WhoId)) {
                        cloneRecord.Customer_Mobile_Phone__c = WhoIdToLeadMap.get(t.WhoId).mobilePhone;
                        cloneRecord.Customer_Preferred_Email__c = WhoIdToLeadMap.get(t.WhoId).Email;
                        system.debug('WhoIdToLeadMap.get(t.WhoId).IsFirstPresalesCall__c::: ' + WhoIdToLeadMap.get(t.WhoId).IsFirstPresalesCall__c);
                        cloneRecord.IsFirstPresalesCall__c = WhoIdToLeadMap.get(t.WhoId).IsFirstPresalesCall__c;
                    }

                    cloneRecord.sobjectName__c = objectWhoName;
                    cloneRecord.LeadName__c = t.WhoId;
                    cloneList.add(cloneRecord);
                } else if (ObjectWhatName == 'Account') {
                    // for copying tasks against person accounts.

                    //mobile phone and preferred email of the customer
                    if (!WhatIdToAccountMap.isEmpty() && WhatIdToAccountMap.containsKey(t.whatId)) {
                        cloneRecord.Customer_Mobile_Phone__c = WhatIdToAccountMap.get(t.WhatId).PersonMobilePhone;
                        cloneRecord.Customer_Preferred_Email__c = WhatIdToAccountMap.get(t.WhatId).personEmail;
                    }

                    cloneRecord.sobjectName__c = objectWhatName;
                    cloneRecord.AccountName__c = t.WhatId;
                    cloneList.add(cloneRecord);
                }
            }
            if (cloneList.size() > 0) {
                system.debug('cloneList111 : ' + cloneList);
                upsert cloneList TaskId__c;
            }
        }
    }

    public static void HomeLoanTaskRollupToOpp(List < Task > taskList) {
        Map < Id, Task > opptyTaskMap = new Map < Id, Task > ();
        for (Task t: TaskList) {
            if (t.WhatId != null && t.WhatId.getSObjectType().getDescribe().getName() == 'Opportunity') {
                if (opptyTaskMap.containsKey(t.whatId) && t.Task_Type__c == 'Home Loan') {
                    System.debug('This opty is already added into the map');
                } else {
                    opptyTaskMap.put(t.whatId, t);
                }
            }
        }
        List < Opportunity > oppList = [select Name, Id, call_proposed_date_of_visit__c, Follow_up_date__c
            from Opportunity where Id in : opptyTaskMap.keySet()
        ];
    }

    public static void RegTaskRollupToOpp(List < Task > taskList) {
        Map < Id, Task > opptyTaskMap = new Map < Id, Task > ();
        for (Task t: TaskList) {
            if (t.WhatId != null && t.WhatId.getSObjectType().getDescribe().getName() == 'Opportunity') {
                if (opptyTaskMap.containsKey(t.whatId) && t.Task_Type__c == 'Registration') {
                    System.debug('This opty is already added into the map');
                } else {
                    opptyTaskMap.put(t.whatId, t);
                }
            }
        }
        List < Opportunity > oppList = [select Name, Id, call_proposed_date_of_visit__c, Follow_up_date__c
            from Opportunity where Id in : opptyTaskMap.keySet()
        ];
        update oppList;
    }

    // created By Vikas On 18/04/2016 for Call Rating

    public static void callStatusMethod(List < Task > taskList) {

        List < Opportunity > optyList = new List < Opportunity > ();
        List < Opportunity > optyList2 = new List < Opportunity > ();
        List < Lead > leadList = new List < Lead > ();
        List < Lead > leadList2 = new List < Lead > ();
        Map < Id, Task > taskMap = new Map < Id, Task > ();
        Map < Id, Task > leadTaskMap = new Map < Id, Task > ();

        for (Task t: taskList) {
            if (t.WhatId != null && t.WhatId.getSObjectType().getDescribe().getName() == 'Opportunity') {
                taskMap.put(t.whatId, t);
            }

            if (t.whoId != null && t.whoId.getSObjectType().getDescribe().getName() == 'Lead') {
                leadTaskMap.put(t.whoId, t);
            }
        }

        /////  Only for Opportunity    ///// 

        if (taskMap.size() > 0) {


            optyList = [SELECT Id, Last_call_attempt_status__c,Last_Call_Attempt_Status_Details__c, Call_Rating__c FROM Opportunity WHERE Id IN: taskMap.keySet()];

            if (optyList.size() > 0) {
                for (Opportunity opp: optyList) {

                    Decimal rating = opp.Call_Rating__c;

                    string prv_call_rating = taskMap.get(opp.id).Previous_Call_Attempt_Status__c;

                    string call_status = taskMap.get(opp.id).Call_Attempt_Status__c;

                    if (rating != null) {
                        if (prv_call_rating == 'Open' && call_status == 'Open')
                            opp.Call_Rating__c = rating - 2.0;
                        if (prv_call_rating == 'Open' && call_status == 'Follow up')
                            opp.Call_Rating__c = rating - 1.0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating + 2.0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating + 3.0;
                        if (prv_call_rating == 'Open' && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;


                        if (prv_call_rating == 'Follow up' && call_status == 'Follow up')
                            opp.Call_Rating__c = rating - 2.0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating - 0.0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating + 2.0;
                        if (prv_call_rating == 'Follow up' && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && call_status == 'Follow up')
                            opp.Call_Rating__c = rating - 3.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating - 1.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating - 0.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && call_status == 'Follow up')
                            opp.Call_Rating__c = rating - 4.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating - 1.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating - 0.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;


                        if (prv_call_rating == 'Lost' && call_status == 'Follow up')
                            opp.Call_Rating__c = rating + 4.0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating + 4.0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating + 5.0;
                        if (prv_call_rating == 'Lost' && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && call_status == 'Follow up')
                            opp.Call_Rating__c = rating + 4.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            opp.Call_Rating__c = rating + 4.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            opp.Call_Rating__c = rating + 5.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && call_status == 'Lost')
                            opp.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            opp.Call_Rating__c = 0;

                        optyList2.add(opp);
                    }
                }
            }

        }

        if (leadTaskMap.size() > 0) {
            leadList = [SELECT Id, Call_Rating__c, Last_call_attempt_status__c,Last_Call_Attempt_Status_Details__c FROM Lead WHERE Id IN: leadTaskMap.keySet()];
            if (leadList.size() > 0) {
                for (Lead leadobj: leadList) {
                    Decimal rating = leadobj.Call_Rating__c;

                    string call_status = leadTaskMap.get(leadobj.id).Call_Attempt_Status__c;
                    system.debug('leadobj.Last_call_attempt_status__c >>>>> ' + leadobj.Last_call_attempt_status__c);
                    system.debug('call_status  >>>>> ' + call_status);
                    string prv_call_rating = leadTaskMap.get(leadobj.id).Previous_Call_Attempt_Status__c;


                    if (rating != null) {
                        if (prv_call_rating == 'Open' && call_status == 'Open')
                            leadobj.Call_Rating__c = rating - 2.0;
                        if (prv_call_rating == 'Open' && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating - 1.0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating + 2.0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating + 3.0;
                        if (prv_call_rating == 'Open' && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if (prv_call_rating == 'Open' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;


                        if (prv_call_rating == 'Follow up' && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating - 2.0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating - 0.0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating + 2.0;
                        if (prv_call_rating == 'Follow up' && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if (prv_call_rating == 'Follow up' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating - 3.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating - 1.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating - 0.0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit proposed' || prv_call_rating == 'Meeting Proposed' || prv_call_rating == 'No Show') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating - 4.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating - 1.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating - 0.0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit confirmed' || prv_call_rating == 'Meeting Fixed' || prv_call_rating == 'Tele Meeting Fixed') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;


                        if (prv_call_rating == 'Lost' && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating + 4.0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating + 4.0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating + 5.0;
                        if (prv_call_rating == 'Lost' && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if (prv_call_rating == 'Lost' && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;


                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && call_status == 'Follow up')
                            leadobj.Call_Rating__c = rating + 4.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit proposed' || call_status == 'Meeting Proposed' || call_status == 'No Show'))
                            leadobj.Call_Rating__c = rating + 4.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit confirmed' || call_status == 'Meeting Fixed' || call_status == 'Tele Meeting Fixed'))
                            leadobj.Call_Rating__c = rating + 5.0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && call_status == 'Lost')
                            leadobj.Call_Rating__c = 0;
                        if ((prv_call_rating == 'Visit done' || prv_call_rating == 'Meeting done' || prv_call_rating == 'Tele Meeting Done' || prv_call_rating == 'TMD + MD' || prv_call_rating == 'Booking Done') && (call_status == 'Visit done' || call_status == 'Meeting done' || call_status == 'Tele Meeting Done' || call_status == 'TMD + MD' || call_status == 'Booking Done'))
                            leadobj.Call_Rating__c = 0;

                        leadList2.add(leadobj);
                    }
                }
            }

        }


        if (optyList2.size() > 0)
            update optyList2;
        system.debug('leadList2 >>> ' + leadList2.size());
        if (leadList2.size() > 0)
            update leadList2;

    }

}