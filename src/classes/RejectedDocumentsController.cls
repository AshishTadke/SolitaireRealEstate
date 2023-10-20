public with sharing class RejectedDocumentsController
{
       
    public Applicant_Details__c applicant {get; set;}
    public Applicant_Details__c applicant2 {get; set;}
    public Applicant_Details__c applicant3 {get; set;}
    public Applicant_Details__c applicant4 {get; set;}
    public Applicant_Details__c applicant5 {get; set;}
    public Booking__c boookingObj {get; set;}
    public Quotation__c quotationObj {get; set;}
    public List<Booking__c> lstBookingmk {get;set;}
    public Document_Checklist_Header__c  checklistHeader {get;set;}     
    List<Document_Checklist__c> lstDocumentChecklist = new List<Document_Checklist__c>();  
    public Document_Checklist__c DocRow1 {get;set;}
    public Document_Checklist__c DocRow2 {get;set;}
    public Document_Checklist__c DocRow3 {get;set;}
    public Document_Checklist__c DocRow4 {get;set;}    
    public Document_Checklist__c DocRow5 {get;set;}        
    public Document_Checklist__c DocRow6 {get;set;}            
    public Document_Checklist__c DocRow7 {get;set;}            
    public Document_Checklist__c DocRow8 {get;set;}                
    public Document_Checklist__c DocRow9 {get;set;}                    
    public Document_Checklist__c DocRow10 {get;set;}                        
    public Document_Checklist__c DocRow11 {get;set;} 
    public Document_Checklist__c DocRow12 {get;set;}
    public Document_Checklist__c DocRow13 {get;set;}    
    public Document_Checklist__c DocRow14 {get;set;}                                   
    public Document_Checklist__c DocRow15 {get;set;}                                       
    public Document_Checklist__c DocRow16 {get;set;}    
                                        
    public List<Document_Checklist__c> rejectedDocsList {get;set;}
    //Get the booking id from the page URL
    String DocumentHeaderId {get;set;} 
    
    //This list stores the list of applicants for this booking
    List<Applicant_Details__c> applicantList = new List<Applicant_Details__c>();
    public Integer i{get;set;}
    public Integer j{get;set;}
    public string err{get;set;}
    public RejectedDocumentsController()
    {
         applicant = new Applicant_Details__c();
         applicant2 = new Applicant_Details__c();
         applicant3 = new Applicant_Details__c();
         applicant4 = new Applicant_Details__c();
         applicant5 = new Applicant_Details__c();
         boookingObj = new Booking__c();
         quotationObj = new Quotation__c();
         lstDocumentChecklist = new List<Document_Checklist__c>();
         checklistHeader = new Document_Checklist_Header__c ();         
         DocRow1 = new Document_Checklist__c();
         DocRow2 = new Document_Checklist__c();
         DocRow3 = new Document_Checklist__c();
         DocRow4 = new Document_Checklist__c();
         DocRow5 = new Document_Checklist__c();
         DocRow6 = new Document_Checklist__c();
         DocRow7 = new Document_Checklist__c();
         DocRow8 = new Document_Checklist__c();
         DocRow9 = new Document_Checklist__c();
         DocRow10 = new Document_Checklist__c();
         DocRow11 = new Document_Checklist__c();
         DocRow12 = new Document_Checklist__c();
         DocRow13 = new Document_Checklist__c();
         DocRow14 = new Document_Checklist__c();
         DocRow15 = new Document_Checklist__c();
         DocRow16 = new Document_Checklist__c();         
         DocRow1.Description__c = 'Residence and Office address is legible';
         DocRow2.Description__c = 'Mobile, Landline number and email id is';
         DocRow3.Description__c = 'Correct Booking date and consideration value';
         DocRow4.Description__c = 'Flat number and Configuration';
         DocRow5.Description__c = 'Booking amount, cheque details and Bank Name';
         DocRow6.Description__c = 'Date of application';
         DocRow7.Description__c = 'Cost sheet attached and signed by applicant';
         DocRow8.Description__c = 'Correct Booking Source mentioned';
         DocRow9.Description__c = 'Approvals for deviations (if any) are at';
         DocRow10.Description__c ='CAM charges, society and other charges';
         DocRow11.Description__c = 'Overwriting/Cancellation/White ink-sign';
         DocRow12.Description__c = 'Rechecked Applicant / Co-applicant names';
         DocRow13.Description__c = 'Rates offered same as attached cost sheet';
         DocRow14.Description__c = 'Sign at all places (Same as photo id)';
         DocRow15.Description__c = 'Sales manager Signatures';
         DocRow16.Description__c = 'Site visit form copy attached';
         
         
         //Get the document header id from URL
         if(ApexPages.currentPage().getParameters().get('DocumentHeaderId') != null && ApexPages.currentPage().getParameters().get('DocumentHeaderId') != '')
         DocumentHeaderId = ApexPages.currentPage().getParameters().get('DocumentHeaderId');
         if(DocumentHeaderId != null && DocumentHeaderId != '')
         {
             //Fetch the list of rejected documents which have the same document header id as in the URL
             rejectedDocsList = [Select Name, Description__c, Rejection_Remarks__c, Details__c FROM Document_Checklist__c where Verified__c= false and Document_Checklist_Header__c=:DocumentHeaderId];     
         }                           
    }
    
    public PageReference Save(){ 
    return null;
    }
    public PageReference Accept(){
    return null;
    }
    public PageReference btnReject(){ 
    return null;
    }

}