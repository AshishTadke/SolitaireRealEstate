global with sharing class TaskRelatedListclass {
    
    public Map<String,List<task>> taskMap {get; set;}
    public Map<String,String> commandButtonMap{get; set;}
    private final Opportunity opp;
    private final Lead lead;
    private String objName;
   
   
    public TaskRelatedListclass(ApexPages.StandardController stdController) {
     
        objName = stdController.getRecord().getSObjectType().getDescribe().getName();
        if(objName == 'Opportunity') {
            this.opp = (Opportunity)stdController.getRecord();
        } else if(objName == 'Lead') {
            this.lead = (lead)stdController.getRecord();
        } else {
            
        }
        getButtonMap();
       
       
    }
    
    
    public Map<String,String> getButtonMap() {

        //Instantiate variables
        commandButtonMap = new Map<String,String>();

        Integer counter = 0;
        
        for(string t : taskType) {
            if(objName == 'Lead') {
                if(t == 'Site Visit') {
                    
                } else {
                    commandButtonMap.put(t,'New ' +t);
                }
            } else if(objName == 'Opportunity'){
                commandButtonMap.put(t,'New ' +t);
            }  else {
                
            }
        }
        system.debug('commandButtonMap====== '+commandButtonMap);
        return commandButtonMap;
    }
    
    @RemoteAction
    global static List<Task>  getTasksByType(String taskType, Id parentId) {
        //Instantiate variables
        List<Task> taskList = new List<Task>();
        if(parentId.getSObjectType().getDescribe().getName() == 'Opportunity' ){
            taskList = TaskManagementServices.getTaskByType(taskType, 'ALL' , 'createdDate' , 'DESC', parentId);
            System.debug('Task list for home loan testing:' + taskList);
        }
        else if (parentId.getSObjectType().getDescribe().getName() == 'Lead' ){
            taskList = TaskManagementServices.getTaskByTypeLead(taskType, 'ALL' , 'createdDate' , 'DESC', parentId);
        }
        else {
            
        }
        system.debug('taskList'+taskList);
        return taskList;
    }
    
    // this controls the list of tabs we see on related list    
    public List<String> taskType
    {
        get {
          List<String> taskTypeValues = new List<String>();
                
           Schema.DescribeFieldResult fieldResult = Task.Task_Type__c.getDescribe();
           List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
           
           for( Schema.PicklistEntry f : ple)
           {
                if(objName == 'Lead') {
                    if(f.getValue() == 'Site Visit') {
                        
                    } else {
                        taskTypeValues.add(f.getValue());
                    }
                } else {
                    taskTypeValues.add(f.getValue());
    
                }                
           }
           System.debug('tasktypes:===== ' + taskTypeValues);
        // System.debug('taskType:===== ' + taskType);      
           return taskTypeValues;
        }
       private set;
    }
    
 @RemoteAction
    global static boolean getButtonAccess(String buttonName){
        system.debug('buttonName'+buttonName);
        return(ProfileFeatureAccessServices.hasAccess(UserInfo.getUserId(),buttonName));    
    }
    
    @RemoteAction
    global static boolean isRevisit(String parentId){
        return (TaskManagementServices.isRevisit(parentId));
    }
    
    /////---------------- added by vikas for Edit options on customer interaction ----------------------/////////
    @RemoteAction
    global static Integer isSystemAdmin(){
       string id;
      
       id = UserInfo.getProfileId();
       id = id.subString(0,15);
      
       if(id == '00e36000000z4fh') ///// for system admin
       return 1;
       else if(id == '00e36000001C7uD') //// for sales strategy operation profile
       return 2;
       else 
       return 0;
    }
}