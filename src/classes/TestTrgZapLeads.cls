@isTest
private Class TestTrgZapLeads {
@isTest
Static void Test1(){
        Project__c p =new Project__c();
        p.Name = 'Project';
        p.Project_Code__c = 'Project123';
        Insert p;
    
        Zapier_Lead__c  z = new Zapier_Lead__c();
        z.email__c = 'click2call@email.com';
        z.Name = 'click2call';
        z.MobileNo__c = '9080706050';
        z.Lead_Source__c = 'DIGITAL';
        z.Lead_Sub_Source__c = 'Facebook';
        z.Campaign_Code__c = '2001';
        z.Project__c = p.Id;
        z.ownerid ='0050K000008X1PV';
    insert z;
    }
}