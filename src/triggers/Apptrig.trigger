trigger Apptrig on Applicant_Details__c (After insert, After update) 
{
    list<Applicant_Details__c> lstApp = new list<Applicant_Details__c>(trigger.new);
    system.debug('lstTask ' +lstApp);
    CopyApptoOpty.updateOPTY(lstApp);
    CopyAppttoBooking.updateBooking(lstApp);
}