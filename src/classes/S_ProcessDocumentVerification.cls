public class S_ProcessDocumentVerification {
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

    public S_ProcessDocumentVerification() {
        Id profileId = userinfo.getProfileId();
        ProfileName = [Select Id, Name from Profile where Id = : profileId].Name;
        UserName = userinfo.getname();
        GetListOfBooking();
    }

    public Pagereference Process() {
        return (new PageReference('/apex/NewDocumentChecklistPage?Id=' + lstBooking[integer.valueof(ProcessRowNo)].id));
    }

    public Pagereference Release() {

        Booking__c objBooking = New Booking__c();
        objBooking.id = lstBooking[integer.valueof(ReleaseRowNo)].id;
        objBooking.Call_Centre_Rep__c = null;
        update objBooking;

        GetListOfBooking();
        return null;
    }

    public Pagereference Assign() {

        Opportunity objOpp = new Opportunity();
        objOpp.id = lstBooking[integer.valueof(AssignRowNo)].Opportunity__c;
        objOpp.Physical_document_received__c = true;
        update objOpp;

        GetListOfBooking();
        return null;
    }

    public void GetListOfBooking() {
        lstBooking = New list < booking__c > ([select id, Owner.Name, Verification_status__c, View_Rejected_Documents__c, Opportunity__c, Opportunity__r.Physical_document_received__c, Name, Last_Call_Date__c, Welcome_Call_Done_By__c, Call_Disposition__c, Call_Back_Date__c, Call_Centre_Rep__c, Customer__c, Unit_No__c, Project__r.name, Unit_No__r.Unit_Status__c, Booking_Date__c from booking__c
            where(Unit_No__r.Unit_Status__c = 'BIP - RM Verification'
                OR Unit_No__r.Unit_Status__c = 'BIP - Sales') and Opportunity__c != null ORDER BY Booking_Date__c limit 999
        ]);
    }
}