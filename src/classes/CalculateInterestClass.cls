public class CalculateInterestClass{

    public static void CalculateInterest(List<Standard_Customer_Pay_Plan_Detail__c> SCPPDList)
    {
        system.debug('Anuja Method SCPPDList' +SCPPDList);
        List < ID > ListCPPHid = new List < ID > ();
        List < ID > ListOptyid = new List < ID > ();
        List < ID > ListidCPPHid = new List < ID > ();
        List <Customer_Pay_Plan_Header__c > CPPHListtoUpdate = new List <Customer_Pay_Plan_Header__c>();
        List <Standard_Customer_Pay_Plan_Detail__c > SCCPDListtoUpdate = new List <Standard_Customer_Pay_Plan_Detail__c>();
        for(Standard_Customer_Pay_Plan_Detail__c s :SCPPDList){
            if(s.Customer_Pay_Plan_Header__c != null && s.Customer_Pay_Plan_Header__r.Customer__c != null)
            {
                ListCPPHid.add(s.Customer_Pay_Plan_Header__c);
                ListOptyid.add(s.Customer_Pay_Plan_Header__r.Customer__c);
            }
        }
        ///////////////////////////////////////////////////////////////////////////////
        List<Standard_Customer_Pay_Plan_Detail__c> ListSCPPDToUpdate  = new List <Standard_Customer_Pay_Plan_Detail__c>();
        for(Standard_Customer_Pay_Plan_Detail__c s3 :SCPPDList){   
            if(((s3.Charge_Amount_Due__c != null && s3.Charge_Amount_Due__c > 0) || (s3.Service_Tax_Amount_Due__c!= null && s3.Service_Tax_Amount_Due__c > 0)) && s3.Customer_Pay_Plan_Header__r.Project__r.RDS_Interest_Rate__c != null)
            {
            	if(s3.Total_Interest_Amount__c != null)
               		s3.Total_Interest_Amount__c += (s3.Charge_Amount_Due__c + s3.Service_Tax_Amount_Due__c)* s3.Customer_Pay_Plan_Header__r.Project__r.RDS_Interest_Rate__c/36500;
               	else
               		s3.Total_Interest_Amount__c = (s3.Charge_Amount_Due__c + s3.Service_Tax_Amount_Due__c)* s3.Customer_Pay_Plan_Header__r.Project__r.RDS_Interest_Rate__c/36500;
               ListSCPPDToUpdate.add(s3);
            }
        }
        
        system.debug('List with Total Interest To update..' +ListSCPPDToUpdate);
            if(ListSCPPDToUpdate.size() >0 ){
            update  ListSCPPDToUpdate;
            }
        List<Id> CPPHList= new List<Id>();        
        Set<Id> mySet = new Set<Id>();
        mySet.addAll(ListCPPHid);
        System.Debug('Set'+mySet); 
        Map<Id,List<Standard_Customer_Pay_Plan_Detail__c>> MapListSCppd= new Map<Id,List<Standard_Customer_Pay_Plan_Detail__c>>();
        Map<Id,Standard_Customer_Pay_Plan_Detail__c> MapSCppd= new Map<Id,Standard_Customer_Pay_Plan_Detail__c>([SELECT Id,Customer_Pay_Plan_Header__r.Id,Total_Interest_Amount__c,Customer_Pay_Plan_Header__c  FROM Standard_Customer_Pay_Plan_Detail__c WHERE Customer_Pay_Plan_Header__c in :mySet]);     
        List <Customer_Pay_Plan_Header__c> CCPHList = new List<Customer_Pay_Plan_Header__c>();
        for(Standard_Customer_Pay_Plan_Detail__c s : MapSCppd.values())
        {
            if(MapListSCppd.containsKey(s.Customer_Pay_Plan_Header__r.Id)) {
                MapListSCppd.get(s.Customer_Pay_Plan_Header__r.Id).add(s);
            } else {
                List<Standard_Customer_Pay_Plan_Detail__c> tempSList = new List<Standard_Customer_Pay_Plan_Detail__c>();
                tempSList.add(s);
                MapListSCppd.put(s.Customer_Pay_Plan_Header__r.Id, tempSList);
            }
        }
        System.debug('MapListSCppd :' +MapListSCppd);
        
        for(List<Standard_Customer_Pay_Plan_Detail__c> p : MapListSCppd.values()) 
        {
           Decimal Total = 0;
           Customer_Pay_Plan_Header__c CCPHObj = new Customer_Pay_Plan_Header__c();
           for(Standard_Customer_Pay_Plan_Detail__c q : p)
           {
               if(q.Total_Interest_Amount__c !=null)
               {
                    Total +=q.Total_Interest_Amount__c ;  
               }
               if(q.Customer_Pay_Plan_Header__r.id != null)
               {
                   CCPHObj.id = q.Customer_Pay_Plan_Header__r.id; 
                   System.debug('CCPHObj id' +CCPHObj.id);                  
               }
           }
           CCPHObj.Total_Interest_Amount__c = Total;
           CCPHList.add(CCPHObj);
           System.debug('CCPHList' +CCPHList);
        }
        if(CCPHList.size() >0) {
            update CCPHList;
        }
        List<Id> OptyList= new List<Id>();        
        Set<Id> myOptyIdSet = new Set<Id>();
        myOptyIdSet.addAll(ListOptyid);
        System.Debug('myOptyIdSet : '+myOptyIdSet); 
        Map<Id,List<Customer_Pay_Plan_Header__c>> MapListCPPH = new Map<Id,List<Customer_Pay_Plan_Header__c>>();
        Map<Id,Customer_Pay_Plan_Header__c> MapCPPH = new Map<Id,Customer_Pay_Plan_Header__c>([SELECT Id,Name,Total_Interest_Amount__c,Customer__r.Id  FROM Customer_Pay_Plan_Header__c WHERE Customer__r.Id in :myOptyIdSet]);     
        List <Opportunity> OPtyListNew = new List<Opportunity>();
       
        for(Customer_Pay_Plan_Header__c c : MapCPPH.values()) {
            if(MapListCPPH.containsKey(c.Customer__r.Id)) {
                MapListCPPH.get(c.Customer__r.Id).add(c);
            } else {
                List<Customer_Pay_Plan_Header__c> tempCList = new List<Customer_Pay_Plan_Header__c>();
                tempCList.add(c);
                MapListCPPH.put(c.Customer__r.Id, tempCList);
            }
        }
       System.debug('MapListCPPH' +MapListCPPH);
        for(List<Customer_Pay_Plan_Header__c> cp : MapListCPPH.values()){
        Decimal totInterest = 0;
        Opportunity OptyObj = new Opportunity();
            for(Customer_Pay_Plan_Header__c cpp : cp)
            {
                if(cpp.Total_Interest_Amount__c != null)
                   {
                        totInterest +=cpp.Total_Interest_Amount__c ;  
                   }
                if(cpp.Customer__r.Id != null)
                {
                    OptyObj.id = cpp.Customer__r.Id;
                }
            }
             OptyObj.Total_Interest__c = totInterest;
             OPtyListNew.add(OptyObj);
                    
        }
        if(OPtyListNew.size() > 0){
            update OPtyListNew ;
        }
    }
}