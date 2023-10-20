@isTest
public class ProcessBookingTracker 
{
    private static Legal_Entity__c objlglentity;
    private static Broker__c objBroK;
    private static Project__c objpr;
    private static Unit_Number_Structure__c objUn;
    private static Global_Charges__c ObjGloChrg;
    private static Project_Charges__c PCharge;
    private static Project_Unit_Type__c objPUT;
    private static Project_Unit__c objPU;
    private static Standard_Pay_Plan_Header__c objSPP;
    private static Standard_Customer_Pay_Plan_Detail__c objSPPD;
    private static Standard_Customer_Pay_Plan_Detail__c objSPPD1;
    private static Standard_Customer_Pay_Plan_Detail__c objSPPD2;
    private static Account objac;
    private static Receipt__c objRec;
    private static Receipt_Details__c objRecDtl ;
    private static Ledger__c objLed;
    private static Receipt__c objRec3;
    private static Receipt_Details__c objRecDtl2 ;
    private static Ledger__c objLed2;
    private static Booking__c objBoo;
    private static Booking_Details__c objBookDet;
    private static Booking__c objBoo1  ; 
    private static Booking_Details__c objBookDet1 ;
    private static opportunity objOpp;
    private static Unit_Charges__c objUC;
    private static Customer_Pay_Plan_Header__c objCPPH;
    private static Quotation__c q;
        static testMethod void myUnitTest() 
        {
            LoadData();
            
            objBoo = new Booking__c();
            objBoo.Project__c= objpr.Id;
            objBoo.Customer__c =objopp.id;
            objBoo.Receipts__c = objRec.id;
            objBoo.Unit_No__c = objPU.id;
            objBoo.Area__c ='1500';
            objBoo.Effective_From__c=System.today();
            objBoo.Status__c='UnProcessed';
            objBoo.UnitChange__c=false;
            objBoo.isSave__c = true;
            objBoo.quotation__c = q.id;
            objBoo.primary_applicant_email__c = 'test@test.com';
            insert objBoo;
            
            
            objBookDet = new Booking_Details__c();
            objBookDet.Booking__c = objBoo.id;
            objBookDet.Standard_Pay_Plan_Header__c = objSPP.id;
            objBookDet.nRate__c=5;
            objBookDet.Customer__c=objopp.id;
            objBookDet.PlanCode__c=objSPP.Plan_Code__c;
            objBookDet.Amount_Type__c='Rate';
            objBookDet.Amount__c=10;
            objBookDet.Charge__c = ObjGloChrg.Id;
            objBookDet.Project_Unit__c=objPU.id;
            insert objBookDet;
            
            objCPPH = new Customer_Pay_Plan_Header__c();
            //objCPPH.Project_Unit__c = objPU.id;
            //objCPPH.Effect_From_Date__c  =date.today().adddays(2); 
            objCPPH.booking__c = objBoo.id;
            insert objCPPH;
            
            Test.startTest();      
            
            ApexPages.currentPage().getParameters().put('id', objBoo.id);
            ProcessBooking objProBooking = new ProcessBooking();  
            
            objProBooking.outputmessage = '';
            objProBooking.TowerName = '';
            objProBooking.status = true;
            objProBooking.Process();
            
            objPU.Unit_Status__c ='CRM Returned To Sales';
            objPU.Reason_For_CRM_returns_to_sales__c = 'Physical Document Rejected';
            update objPU;
            system.debug('objPU.Unit_Status__c::: '+objPU.Unit_Status__c);
            system.debug('objPU.Reason_For_CRM_returns_to_sales__c:::: '+objPU.Reason_For_CRM_returns_to_sales__c);
            objProBooking.Process();
              
            objProBooking.incrementCounter();  
            //objProBooking = null; 
            S_PaymentReceiptComponentController sp = new S_PaymentReceiptComponentController();
            sp.letterhead = '';
            sp.bookingId = null;
            sp.ownerName = '';
            sp.ownerPhone = '';
            sp.ownerEmail = '';
            sp.ownerSalutation = '';
            sp.legalAddress = '';
            sp.legalCity = '';
            sp.legalPinCode = '';
            
            sp.strReceiptId = objRec.id;
            S_PaymentReceiptComponentController.wrapperclass wrp = new S_PaymentReceiptComponentController.wrapperclass(objRecDtl,null,false);
            sp.getReceiptDetails();
            
            
            Test.StopTest();   
        }
  
  
        
        static void LoadData()
        {
            objlglentity = new Legal_Entity__c();
            objlglentity.Name ='RS';
            objlglentity.RDS_Company_Code__c='rs';
            objlglentity.RDS_Service_Tax_No__c= '012345678912444';
            objlglentity.RDS_Company_Name__c='111';
            objlglentity.RDS_Address1__c='123';
            objlglentity.RDS_Address2__c='234';
            objlglentity.RDS_City__c='delhi';
            objlglentity.RDS_Pin_Code__c='201301';
            objlglentity.RDS_Phone__c='9953528045';
            insert objlglentity;
            
            objBroK = new Broker__c();
            objBroK.Broker_Code__c = '12346';
            objBroK.Broker_Name__c = 'Brokname';
            objBroK.Status__c = 'Actives';
            insert objBroK;
            
            objpr = new Project__c();
            objpr.Project_Code__c = 'T31';
            objpr.Name = 'TestProject';
            objpr.RDS_Short_Name__c = 'Tp';
            objpr.Start_Date__c = System.today().addDays(-5);
            objpr.RDS_Company_Code__c = objlglentity.Id;
            objpr.RDS_Interest_Rate__c = 12;
            insert objpr;
            
            objUn = new Unit_Number_Structure__c();
            objUn.Name = 'testUN';
            objUn.Description__c = 'Desc';
            objUn.Sequence_No__c = 2;
            // objUn.Sorting_No__c = 2;
            objUn.Project__c = objpr.Id;
            objUn.Maximum_Length__c = 2;
            objUn.Delimiter__c = '/';
            insert objUn;     
            
            
            ObjGloChrg = new Global_Charges__c();
            ObjGloChrg.Name = 'TestGlobal';
            ObjGloChrg.Code__c = '673';
            ObjGloChrg.Description__c = 'SERVICE TAX';
            ObjGloChrg.Sequence_No__c = 999;
            ObjGloChrg.Charge_Type__c = 'Tax';
            insert ObjGloChrg;
            
            PCharge = new Project_Charges__c();
            PCharge.Charge_Code__c = ObjGloChrg.Id;
            PCharge.Project__c = objpr.Id;
            PCharge.Charge_Id__c = 1;
            PCharge.Name = 'TestProjectCharge';
            PCharge.Active__c = true;
            PCharge.Applied_This_Charge_To_FA__c = true;
            insert PCharge;
            
            objPUT = new Project_Unit_Type__c();
            objPUT.RDS_Code__c = '101';
            objPUT.RDS_Project__c = objpr.id;
            insert objPUT;
            
            objPU = new Project_Unit__c();  
            objPU.Project_Unit_Type__c = objPUT.id;  
            objPU.Name = 'TestUnit';      
            objPU.Project__c = objpr.Id;
            objPU.Param1__c = '5';
            objPU.Param2__c = '6';
            objPU.UnitNo__c ='9';
            objPU.Unit_Status__c ='Vacant';
            insert objPU;
            
            
            
            objSPP = new Standard_Pay_Plan_Header__c();
            objSPP.Project__c = objpr.Id;
            objSPP.Charge_Code__c= PCharge.Id;
            objSPP.Name='fdr';
            objSPP.Plan_Code__c= '89';
            objSPP.Effective_from__c = System.today();
            insert objSPP;
            
            objSPPD = new Standard_Customer_Pay_Plan_Detail__c();
            objSPPD.Standard_Pay_Plan_Header__c=objSPP.id;
            objSPPD.Project__c=objpr.id;
            objSPPD.Is_to_be_Paid__c='From Dt. of Booking';
            objSPPD.Days_Months__c='Day(s)';
            objSPPD.Days_Months_Value__c=5;
            objSPPD.Amount__c='Percentage';
            objSPPD.Amount_Value__c=30;
            objSPPD.Installment__c = 30;
            insert objSPPD;  
            
            
            objac = new Account();
            objac.FirstName = 'Pawan';
            objac.LastName = 'Srivastava';
            objac.Project__c = objpr.Id;
            objac.Correspondence_Address__c = 'Delhi';
            objac.Category__c = 'General';
            insert objac;
            
             //----------------------added----------------------------------
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
            
            user objuser = new user();
            objuser.IsActive=true;
            objuser.Alias = 'standt';
            objuser.Email='standarduser@testorg.com'; 
            objuser.EmailEncodingKey='UTF-8';
            objuser.LastName='Testing';
            objuser.LanguageLocaleKey='en_US'; 
            objuser.LocaleSidKey='en_US'; 
            objuser.ProfileId = p.Id; 
            objuser.TimeZoneSidKey='America/Los_Angeles';
            objuser.UserName='standardusr@testorg.com';
            insert objuser;            
            system.debug('objuser-------------------------------------'+objuser);
            user objuser2 = new user();
            objuser2.IsActive=true;
            objuser2.Alias = 'standtt';
            objuser2.Email='standarduser2@testorg.com'; 
            objuser2.EmailEncodingKey='UTF-8';
            objuser2.LastName='RCD';
            objuser2.LanguageLocaleKey='en_US'; 
            objuser2.LocaleSidKey='en_US'; 
            objuser2.ProfileId = p.Id; 
            objuser2.TimeZoneSidKey='America/Los_Angeles';
            objuser2.UserName='standardusr2@testorg.com';
            insert objuser2;  
            
            objopp = new opportunity();
            objopp.name = 'Test';
            objopp.AccountId = objac.id;
            objopp.closeDate = date.today().adddays(2);
            objopp.stageName = 'Proposal';
            objopp.project__c = objpr.Id;
            objopp.Project_unit__c = objPU.Id;
            objOpp.Relationship_Manager__c = objuser.id;
            objOpp.Status__c = 'Active';
            insert objopp;
            
            q = new Quotation__c();
          q.Name = 'Q010101';
          q.Quote_Status__c = 'Valid';
          q.Prepared_Date__c = System.today();
          q.Project__c = objpr.Id;
          q.Project_Unit__c = objPU.Id;
          q.FloorNo__c = 11;
          q.Opportunity__c = objopp.Id;
          q.Appartment_Configuration__c = '1 BHK';
          q.Carpet_Area_Sq_Ft__c = 1200;
          q.Token_Amount__c =110000;
          q.ST_Token_Amount__c = 1000;
          q.Agreement_Value__c = 60422880;
          q.Agreement_Value_ST__c = 2537761;
          insert q;
     
            
             objPU.Unit_Status__c ='Sold';
             update objPU;
             objPU.Unit_Status__c ='Block';
             update objPU;
             objPU.Unit_Status__c ='CRM Returned To Sales';
             update objPU;
             objPU.Unit_Status__c ='Welcome Call Pending';
             update objPU;
             objPU.Unit_Status__c ='BIP - Sales';
             update objPU;
             objPU.Unit_Status__c ='BIP - RM Verification';
             update objPU;  
             
          
            objRec = new Receipt__c();
            objRec.Project__c = objpr.Id;
            objRec.Opportunity__c = objopp.Id;
            objRec.Pay_Plan__c = objSPP.Id;
            objRec.Project_Unit__c = objPU.Id;
            objRec.Broker__c = objBroK.Id;
            objRec.Receipt_No_Manual__c = '12';
            objRec.Receipt_Status__c = 'Processed';
            objRec.Additional_Info__c = 'Testing';
            objRec.Cheque_DD_Amount_Rs__c = 100;
            objRec.Direct__c = true;
            objRec.Mode__c = 'Local Cheque';
            objRec.Branch__c = 'Noida';
            objRec.RTGS__c = '123';
            objRec.Cheque_DD__c = '12';
            objRec.Remarks__c = true;
            objRec.Total_Amount__c = 100;
            objRec.Manual_Receipt_Date__c = System.today();
            objRec.Receipt_Date__c = System.today().addDays(-1);
            objRec.Cheque_DD_Date__c = System.today();
            objRec.Discount_Value__c = 1;
            objRec.Project_Unit__c = objPU.Id;
            objRec.Discount_to_begiven_on_Timely_payment__c    = 'As Amount';
            objRec.Token_Amount_Receipt__c = true;
            objRec.On_Account_Money__c = 0;
            objRec.Currency__c = 'Indian Rupee';
            objRec.Opportunity_Email_id__c = 'test@test.com';
            insert objRec; 
            
            objRecDtl = new Receipt_Details__c();
            objRecDtl.Project__c=objpr.Id;
            objRecDtl.Amount__c=100;
            objRecDtl.Charges__c=PCharge.id;
            objRecDtl.Receipts__c=objRec.id;
            insert objRecDtl;
            
            
            objLed = new Ledger__c();
            objLed.Project_Unit__c=objPU.Id;
            objLed.Reciepts__c=objRec.id;
            objLed.Amount__c=objRecDtl.Amount__c;
            objLed.Debit_Credit__c='Credit';
            objLed.Global_Charges__c=ObjGloChrg.id;
            objLed.Opportunity__c=objopp.id;
            insert objLed;
       
            
           
            team__c objteam = new team__c();
            objteam.Team_Type__c= 'CRM Team';
            objteam.Tower__c = objPU.Param2__c;
            objteam.Project__c = objpr.id;
            insert objteam;
            
            Team_Members__c objteamM = new Team_Members__c();
            objteamM.Counter__c=22;
            objteamM.User__c=userinfo.getuserid();
            objteamM.Team__c=objteam.id;
            objteamM.User_Active__c = true;
            insert objteamM;
            
            system.debug('objteam.Team_Type__c----------->'+objteam.Team_Type__c+'objteamM.User_Active__c---->'+objteamM.User_Active__c+'objteam.Tower__c------------->'+objteam.Tower__c+'objteamM.IsActive__c----->'+objteamM.IsActive__c+'objteam.Project__c-------->'+objteam.Project__c);
            
            
            objUC = new Unit_Charges__c();
            objUC.Project_Unit__c = objPU.id; 
            insert objUC;
            
            objCPPH = new Customer_Pay_Plan_Header__c();
            objCPPH.Project_Unit__c = objPU.id;
            objCPPH.Effect_From_Date__c  =date.today().adddays(2); 
            //objCPPH.booking__c = objBoo.id;
            insert objCPPH;
            
        }
        
  
  
}