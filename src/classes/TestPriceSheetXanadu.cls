@isTest
private class TestPriceSheetXanadu 
{    
        @isTest
        private static void PriceSheetXanaduTest() 
        {
        //create Account
         Account acc = TestDataFactory.createPATemplate('TestPA1' , 'testleada@radiustest.com', '9876544441', false);
         
              //Create Project
              Client__c cl = TestDataFactory.createClients('Client1');
                
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
            
            // create Global Charges
            Global_Charges__c gc1 = TestDataFactory.creategobalCharges('100');
        
            //Create Customer Payment Schedule
            Customer_Pay_Plan_Header__c CPPH = TestDataFactory.createCPPH2(q[0].Id,gc1);
    
            // Create Standard Pay plan Details
           List< Standard_Customer_Pay_Plan_Detail__c> scppd = TestDataFactory.createscppd(CPPH,1);
            
            
            
            Test.startTest();
            
            ApexPages.StandardController sc = new ApexPages.StandardController(q[0]);
            PriceSheetXanadu qtnxanadu= new PriceSheetXanadu(sc);
            Id qid = ApexPages.currentPage().getParameters().get('q[0].Id');
            
            qtnxanadu.proj = p[0];
            qtnxanadu.qId =  q[0].Id; 
            if(qtnxanadu.qId != null) 
            {
                List<Quotation__c> qList = [SELECT id,Name,Saleable__c,Project_Unit__r.Chargeable_Area__c,Project__c,Project__r.Name,Prepared_Date__c,Zone__c,Wing__c,Appartment_Configuration__c,FloorNo__c,Project_Unit__c,
                            Project_Unit__r.Name,Base_Rate_PSF__c,Base_Rate_L__c,Premium_Charges_Description_1__c,Premium_Charges_Description_2__c,Premium_Charges_Description_3__c,
                            Premium_Charges_Description_4__c,Premium_Charges_Amount_1__c,Premium_Charges_Amount_2__c,Premium_Charges_Amount_3__c,Premium_Charges_Amount_4__c,
                            Floor_Rise_PSF__c,Floor_Rise_L__c,Carpet_Area_Sq_Ft__c,Infrastructure_charges__c,Development_Charges_PSF__c,Development_Charges_L__c,
                            Stamp_Duty__c,Stamp_Duty_D__c,Registration_Charges__c,MVAT__c,MVAT_ST__c,MVAT_D__c,MVAT_ST_D__c,Service_Taxes_Total__c,Service_Taxes_Total_D__c,
                            Project_Specific_Charges_Amount_1__c,Project_Specific_Charges_Amount_2__c,Project_Specific_Charges_Amount_3__c,Project_Specific_Charges_Description_1__c,
                            Project_Specific_Charges_Description_2__c,Project_Specific_Charges_Description_3__c,Legal_Charges__c,Legal_Charges_ST__c,Club_Membership_Charges__c,Club_Membership_ST__c,
                            Other_Charges_Amount_1__c,Other_Charges_Amount_2__c,Other_Charges_Amount_3__c,Other_Charges_Category_1__c,Other_Charges_Category_2__c,Other_Charges_Category_3__c,
                            Other_Charges_Desc_1__c,Other_Charges_Desc_2__c,Other_Charges_Desc_3__c,Other_Charges_Desc_4__c,
                            Other_Charges_Desc_5__c,Other_Charges_Desc_6__c,Other_Charges_Desc_7__c,Other_Charges_Desc_8__c,Other_Charges_Desc_9__c,Other_Charges_Desc_10__c,
                            Other_Charges_Desc_11__c,Other_Charges_Desc_12__c,Other_Charges_Desc_13__c,Other_Charges_Desc_14__c,Other_Charges_Amount_4__c,Other_Charges_Amount_5__c,Other_Charges_Amount_6__c,
                            Other_Charges_Amount_7__c,Other_Charges_Amount_8__c,Other_Charges_Amount_9__c,Other_Charges_Amount_10__c,Other_Charges_Amount_11__c,Other_Charges_Amount_12__c,
                            Other_Charges_Amount_13__c,Other_Charges_Amount_14__c,Proj_Maint_Charges_Desc_1__c,Proj_Maint_Charges_Desc_2__c,Proj_Maint_Charges_Desc_3__c,Project_Maintenance_Charges_Amount_1__c,
                            Project_Maintenance_Charges_Amount_2__c,Project_Maintenance_Charges_Amount_3__c,Service_Tax_Total__c,Discount_1_Type__c,Discount_2_Type__c,Discount_1_PSF__c,Discount_2_PSF__c 
                                
                 FROM Quotation__c Where Id=:qtnxanadu.qId ]  ;         
                system.debug('abc : ' + qList ); //q[0].id;
                List<Customer_Pay_Plan_Header__c> cpphList = [SELECT Id,Name, Quotation__c,Global_Charges__c,Global_Charges__r.Name FROM Customer_Pay_Plan_Header__c WHERE (Quotation__r.Id =:q[0].Id AND Global_Charges__r.Name = 'Basic')];
                system.debug('cpphList :' + cpphList );
            
                List <Standard_Customer_Pay_Plan_Detail__c>scppList = [SELECT Id,Customer_Pay_Plan_Header__c,Is_to_be__c,Days_Months_Value__c ,Installment__c,Amount_Value__c,Is_to_be_Paid__c FROM Standard_Customer_Pay_Plan_Detail__c WHERE (Customer_Pay_Plan_Header__c = :cpphList[0].Id AND Is_to_be_Paid__c = 'From Dt. of Booking')];
                system.debug('scppList xxx : '+ scppList );
                
                
                
            }
            Decimal totalRate = 0;
            system.debug('totalRate : ' + totalRate);
            system.debug('q[0]xxxxxxxxx : ' + q[0].Id);
            
            Test.stopTest();
        } 
}