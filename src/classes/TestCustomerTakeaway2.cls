@isTest
private  Class TestCustomerTakeaway2
{
    @isTest
    private static void CustomerTakeaway2Test() 
    {
        //create Account
        Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@radiustest.com', '9876544441', false);
        
        //Create Client
        Client__c cl = TestDataFactory.createClients('Client1');
        
        //Create Project
        List<Project__c> p = TestDataFactory.createProjectWithClient(1,'888',cl.Id);
        
        //create Clusters
        List<Cluster__c> cList = TestDataFactory.createClusters(2, p[0].Id);
        
        //create Towers
        List<Tower__c> tList = TestDataFactory.createTowers(2, p[0].Id);
        
        //create Units
        List<Project_Unit__c> uList = TestDataFactory.createUnits(tList[0].Id, p[0].Id);
        
        //Payment_Master__c PM = TestDataFactory.createPaymentMaster(p.Id);
        
        //create Opportunity
        List<Opportunity>  oList = TestDataFactory.createOpptyForAccount(acc.Id, p[0].Id, 1);

        //create Quote
        List<Quotation__c> q = TestDataFactory.createQuote(p[0], uList[0], oList[0].Id,2);
        
        //create Booking
        List<Booking__c> b = TestDataFactory.createBookingNew(oList[0],q[0].Id,p[0].Id,uList[0].Id,1); 

        // create Global Charges
        Global_Charges__c gc1 = TestDataFactory.creategobalCharges('100');
        
        // Create Applicant
        //List<Applicant_Details__c> app1 = TestDataFactory.createApplicant(b[0].id,1);
        
        //Create Customer Payment Schedule
        Customer_Pay_Plan_Header__c CPPH = TestDataFactory.createCPPH(b[0].Id,gc1);

        // Create Standard Pay plan header
       //List< Standard_Pay_Plan_Header__c> stdPPH = TestDataFactory.createstdPPH(p[0].Id,1);
        
       // Create Receipt
       Receipt__c rec = TestDataFactory.createReceipt(b[0].Id,q[0].Id,uList[0].Id);


        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(b[0]);
        CustomerTakeaway2Class takeaway2 = new CustomerTakeaway2Class(sc);
        Id bkid = ApexPages.currentPage().getParameters().get('b[0].Id');//  = ApexPages.currentPage().getParameters().get('bId');
        system.debug('bkid :' + bkid);
        takeaway2.srNo =  1; 
        takeaway2.wordNumber = S_NumberToWord.convertNumbertoWords(b[0].Allotment_Premium__c);
        takeaway2.installment=45321;
        system.debug('b[0].Id : ' + b[0].Id);
        if(bkid != null || b[0].Id != null)
        {
           List<Booking__c> bList = [SELECT Id,Name,Booking_Date__c,Application_No__c,Opportunity__c,Opportunity__r.Account.salutation,Opportunity__r.Account.Name,No_of_Parking__c,
                    Opportunity__r.Account.BillingAddress,Allotment_Premium__c,Source_of_Booking__c,Booking_Source_Details__c,Sub_Source__c,Date_for_offer_of_Possession__c,
                    Opportunity__r.Account.BillingStreet,Opportunity__r.Account.BillingCity,Opportunity__r.Account.BillingState,Opportunity__r.Account.BillingPostalCode,
                    Opportunity__r.Account.BillingCountry,Opportunity__r.Account.Mobile__c,Opportunity__r.Account.Alternate_number_1__c,Opportunity__r.Mailing_Address__c,
                    Opportunity__r.Account.PersonEmail,Opportunity__r.Account.Pan__c,Opportunity__r.Account.Resident_Status__c,Opportunity__r.Other_Applicants_Name__c,
                    Project__c,Project__r.Name,Unit_No__r.Name,Unit_No__r.Carpet_Area__c,Unit_No__r.Configuration__c,Future_Correspondence_Contact_Name__c
                FROM Booking__c WHERE Id =: b[0].Id];
                system.debug('Blist xxx : '+bList);
                
                Receipt__c recList = [SELECT Id, Cheque_DD__c,Total_Amount__c,Mode__c,DraweeBank__c,Receipt_Date__c,Token_Amount_ST__c,Token_Amount_Receipt__c  FROM Receipt__c WHERE Booking__r.Id =:bkid AND (Token_Amount_Receipt__c = True OR Token_Amount_ST__c = True)];
                system.debug('recList :' + recList);
                
            List< Applicant_Details__c > applicantList  = [SELECT Id, Name,Mobile_Number__c,Email_Address__c,Landline_Number__c,Applicant_Number__c,Booking__c,Pincode__c,Country__c,City__c,State__c,Permanent_Address__c,PancardNo__c 
                                   FROM Applicant_Details__c WHERE Booking__r.Id =: bkid  AND Applicant_Number__c = 'Primary Applicant' ];
            
            system.debug('applicantList xxx : ' + applicantList  );
            
            List<Customer_Pay_Plan_Header__c> cpphList = [SELECT Id,Name, Booking__c,Global_Charges__c,Global_Charges__r.Name FROM Customer_Pay_Plan_Header__c WHERE Booking__r.Id =:b[0].Id AND Global_Charges__r.Name = 'Basic' ];
            system.debug('cpphList :' + cpphList );
            
            List <Standard_Customer_Pay_Plan_Detail__c> scppList = [SELECT Id,Customer_Pay_Plan_Header__c,Is_to_be__c,Installment__c,Amount_Value__c,Due_Date__c,Service_Tax_Amount_Q__c,Installment_Number__c FROM Standard_Customer_Pay_Plan_Detail__c WHERE Customer_Pay_Plan_Header__r.Id = :cpphList[0].Id ORDER BY Installment_Number__c ASC ];
            system.debug('scppList xxx : '+ scppList );
        }
        
        Test.stopTest();
        
    }
}