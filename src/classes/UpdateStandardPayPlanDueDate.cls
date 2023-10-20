public class UpdateStandardPayPlanDueDate 
{
  public static void UpdateDueDate(string BookingId)
  {
   system.debug('inside update method xxxx ');
    if (BookingId != null && BookingId != '')
    {
      list<Booking__c> lstBooking = [select id, Unit_No__r.param2__c, Project__c, Customer__c, Unit_No__c, MG_Effect_Date__c
                      from Booking__c
                      where Id =: BookingId
                      and Unit_No__r.param2__c != null];
      system.debug('lstBooking vvvv '+lstBooking.size());
      if (lstBooking != null && lstBooking.size() > 0)
      {
        Booking__c ObjBooking = lstBooking[0];

        list<Construction_Stage__c> lstConsStage = [select id, Due_Date__c, Project_Construction_Stages__c
                                                            from Construction_Stage__c
                                                            where Project_Construction_Stages__r.Project__c =: ObjBooking.Project__c
                              and Tower_Name__c =: ObjBooking.Unit_No__r.param2__c
                              and Due_Date__c <=: ObjBooking.MG_Effect_Date__c];
        system.debug('lstConsStage vvvv '+lstConsStage.size());
        if (lstConsStage != null && lstConsStage.size() > 0)
        {
          Set<id> setConstStageId = new Set<id>();
          for (Construction_Stage__c objConsStage : lstConsStage)
            setConstStageId.add(objConsStage.Project_Construction_Stages__c);

          List<Standard_Customer_Pay_Plan_Detail__c> lstSCPPD = [select id, Due_Date__c
                                      from Standard_Customer_Pay_Plan_Detail__c
                                      where Is_to_be_Paid__c = 'Construction Stage'
                                      and Customer_Pay_Plan_Header__r.Project__c  =: ObjBooking.Project__c
                                      and Customer_Pay_Plan_Header__r.Customer__c =: ObjBooking.Customer__c
                                      and Customer_Pay_Plan_Header__r.Project_Unit__c =: ObjBooking.Unit_No__c
                                      and Project_Construction_Stages__c in : setConstStageId
                                      and Due_Date__c = null ];
          system.debug('lstSCPPD vvvv '+lstSCPPD.size());
          if (lstSCPPD != null && lstSCPPD.size() > 0)
          {
            for (Standard_Customer_Pay_Plan_Detail__c objSCPPD : lstSCPPD)
              objSCPPD.Due_Date__c = ObjBooking.MG_Effect_Date__c;

            update lstSCPPD;
          }
        }
      }
    }
  }
}