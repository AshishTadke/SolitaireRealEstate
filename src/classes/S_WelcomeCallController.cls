public class S_WelcomeCallController {
    public list < booking__c > lstBooking {
        get;
        set;
    }
    public string ProcessRowNo {
        get;
        set;
    }
    public string ReleaseRowNo {
        get;
        set;
    }
    public string AssignRowNo {
        get;
        set;
    }
    public string ProfileName {
        get;
        set;
    }
    public string UserName {
        get;
        set;
    }

    public S_WelcomeCallController() {
        Id profileId = userinfo.getProfileId();
        ProfileName = [Select Id, Name from Profile where Id = : profileId].Name;
        UserName = userinfo.getname();
        GetListOfBooking();
    }

    public Pagereference Process() {
        return (new PageReference('/apex/S_WelcomeCallPage?id=' + lstBooking[integer.valueof(ProcessRowNo)].id));
    }

    public void GetListOfBooking() {
        lstBooking = New list < booking__c > ([select id, Opportunity__c, Name, OwnerId, Last_Call_Date__c, Welcome_Call_Done_By__c, Call_Disposition__c, Call_Back_Date__c, Call_Centre_Rep__c, Customer__c, Unit_No__c, Project__r.name, Unit_No__r.Unit_Status__c, Unit_No__r.Reason_For_CRM_returns_to_sales__c, Booking_Date__c from booking__c where(Unit_No__r.Unit_Status__c = 'Welcome Call Pending'
            OR(Unit_No__r.Unit_Status__c = 'CRM Returned To Sales'
                And Unit_No__r.Reason_For_CRM_returns_to_sales__c = 'Welcome Call Rejected')) and Opportunity__c != null ORDER BY Booking_Date__c limit 999]);
    }
}