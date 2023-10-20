public with sharing class InventoryCostServices {
    public static decimal baseRateVal;
    /** get all the charges, interest %, cancellation % and any other parameters defined at the project level for an unit **/
    /** also including the parameters like PLC values, saleable area, floor rise from the unit level **/
    public static Map<String,Decimal> getProjectLevelCharges(Id UnitId) {
        Map<String,Decimal> chargeRateMap = new Map<String,Decimal>();
        List<Project_Unit__c> unit = [Select Id, Project__c,Project__r.Id, S_View1__c, S_View_2__c, S_View_3__c,
                                                            PLC_Total__c,Legal_Entity__c,Chargeable_Area__c,
                                                            Property_Type__c,Floor__c,TowerName__c,Unit_Status__c,
                                                            Carpet_Area__c,Actual_Area_value__c
                                                            from Project_Unit__c where Id = :unitId];
      //  System.debug('Unit details: ' + unit);
        if(unit.size() == 1) {
            List<Project__c> projList = [Select Id, Forefeiting__c,Brokerage__c, S_Floor_Rise_Rate__c, S_Applicable_From_Floor__c, 
                                                                        RDS_Interest_Rate__c,Token_Amount__c,S_Ready_Reckoner_Rate__c
                                                                        from Project__c where Id =: unit[0].Project__r.Id ];
          //  System.debug('Unit details: ' + projList);
            if(projList.size() == 1) {
                if(projList[0].Brokerage__c != NULL)
                    chargeRateMap.put('BROKERAGE',projList[0].Brokerage__c);
                else 
                    chargeRateMap.put('BROKERAGE',0.0);
                
                if(projList[0].Forefeiting__c != NULL)  
                    chargeRateMap.put('CANCELLATION%',projList[0].Forefeiting__c);
                else
                    chargeRateMap.put('CANCELLATION%',0.0);
                
                if(projList[0].RDS_Interest_Rate__c != NULL)
                    chargeRateMap.put('INTEREST%',projList[0].RDS_Interest_Rate__c);
                else
                    chargeRateMap.put('INTEREST%',0.0);
                
                if(projList[0].S_Ready_Reckoner_Rate__c != NULL)
                    chargeRateMap.put('READYRECKONER',projList[0].S_Ready_Reckoner_Rate__c);
                else
                    chargeRateMap.put('READYRECKONER',0.0);
                   
                if(unit[0].Floor__c != NULL)
                    chargeRateMap.put('FLOORNO',unit[0].Floor__c); //this should be included while calculating basic
                else
                    chargeRateMap.put('FLOORNO',0);
    
                if(unit[0].Actual_Area_value__c != NULL) {
                    chargeRateMap.put('AREA',unit[0].Actual_Area_value__c);
                } else {
                    chargeRateMap.put('AREA',0.0);
                }
                        
            } else {
                //TODO throw custom exception
            }
        } else {
            //TODO throw custom exception
        }
      //  System.debug('Unit details: ' + chargeRateMap);
        return chargeRateMap;

    }

    public static List<Project_Charges__c> getProjectChargesDefined(String ProjectName) {
        List<Project_Charges__c> projCharges = [Select Id, Name, 
                                                            Active__c,
                                                            Charge_Code__r.Name,
                                                            S_Charge_Calculated_As__c,
                                                            S_Payable_At__c,
                                                            S_Charge_Bucket__c,
                                                            S_Charge_Percentage__c,
                                                            S_Lumpsum_Charge_Amount__c,
                                                            Service_Tax_Percentage__c,
                                                            Interest_Applicable_on_this_charge__c,
                                                            Service_Tax_Applicable_on_this_charge__c,Finished__c,Subvention_Charge__c,
                                                            Payment_Plan_Applicable__c,
                                                            Remarks__c, 
                                                            Description__c from 
                                                            Project_Charges__c where Project__r.Name = :projectName];
         System.debug('Project charges list::'+projCharges );
        return projCharges;
    }
    
    public static Map<String,Project_Charges__c> getProjectChargesMap(Id pId) {
        List<Project_Charges__c> projCharges = [Select Id, Name, 
                                                            Active__c,
                                                            Charge_Code__r.Name,
                                                            S_Charge_Calculated_As__c,
                                                            S_Payable_At__c,
                                                            S_Charge_Bucket__c,
                                                            S_Charge_Percentage__c,
                                                            S_Lumpsum_Charge_Amount__c,
                                                            Service_Tax_Percentage__c,
                                                            Interest_Applicable_on_this_charge__c,
                                                            Service_Tax_Applicable_on_this_charge__c,Finished__c,Subvention_Charge__c,
                                                            Remarks__c,
                                                            Payment_Plan_Applicable__c from 
                                                            Project_Charges__c where Project__r.Id = :pId];
        Map<String,Project_Charges__c> chargesMap = new Map<String,Project_Charges__c>();
        for(Project_Charges__c p : projCharges) {
            chargesMap.put(p.Name,p);
        }
        return chargesMap;
    }
    
    // get the taxRate for a single project and its charges.
    public static Map<String,Decimal> getTaxRateForCharges(Id pId) {
        List<Project_Charges__c> projChargesList = [Select Id, Name, 
                                                                Active__c,
                                                                Charge_Code__r.Name,
                                                                S_Charge_Calculated_As__c,
                                                                S_Payable_At__c,
                                                                S_Charge_Bucket__c,
                                                                S_Charge_Percentage__c,
                                                                S_Lumpsum_Charge_Amount__c,
                                                                Service_Tax_Percentage__c,
                                                                Interest_Applicable_on_this_charge__c,
                                                                Service_Tax_Applicable_on_this_charge__c,Finished__c,Subvention_Charge__c,
                                                                Payment_Plan_Applicable__c from 
                                                                Project_Charges__c where Project__r.Id = :pId
                                                                and Service_Tax_Applicable_on_this_charge__c = true
                                                                and Service_Tax_Percentage__c != NULL];
        Map<String,Decimal> taxSlabMap = getTaxSlabs();
        Map<String,Decimal> taxRateMap = new Map<String,Decimal>();
    
        for (Project_Charges__c pc: projChargesList) {
            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                taxRateMap.put(pc.Name,taxSlabMap.get(pc.Service_Tax_Percentage__c));
            }
        }
        return taxRateMap;
    }
    
    // get the taxRate for a list of projects and their charges.
    public static Map<Id,Map<String,Decimal>> getTaxRateForCharges(Set<Id> pIdSet) {
        List<Project_Charges__c> projChargesList = [Select Id, Name, 
                                                                Active__c,
                                                                Charge_Code__r.Name,
                                                                S_Charge_Calculated_As__c,
                                                                S_Payable_At__c,
                                                                S_Charge_Bucket__c,
                                                                S_Charge_Percentage__c,
                                                                S_Lumpsum_Charge_Amount__c,
                                                                Service_Tax_Percentage__c,
                                                                Interest_Applicable_on_this_charge__c,
                                                                Service_Tax_Applicable_on_this_charge__c,Finished__c,Subvention_Charge__c,
                                                                Project__r.Id,
                                                                Payment_Plan_Applicable__c from 
                                                                Project_Charges__c 
                                                                where Project__r.Id in :pIdSet
                                                                and Service_Tax_Applicable_on_this_charge__c = true
                                                                and Service_Tax_Percentage__c != NULL
                                                                ];
        Map<String,Decimal> taxSlabMap = getTaxSlabs();
        Map<String,Decimal> taxRateMap = new Map<String,Decimal>();
        Map<Id,Map<String,Decimal>> projTaxRateMap = new Map<Id,Map<String,Decimal>>();
        for (Project_Charges__c pc: projChargesList) {
            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                if(projTaxRateMap.containsKey(pc.Project__r.Id)) {
                    projTaxRateMap.get(pc.Project__r.Id).put(pc.Name,taxSlabMap.get(pc.Service_Tax_Percentage__c));
                } else {
                Map<String,Decimal> tMap = new Map<string,Decimal>();
                tMap.put(pc.Name,taxSlabMap.get(pc.Service_Tax_Percentage__c));
                projTaxRateMap.put(pc.Project__r.Id,tMap);
                }
            }
        }
        return projTaxRateMap;
    }
    
    // get the taxRate for a single project and its charges.
    // updated for GST to get the child records rather than the parent record.
    // we are going to sum all the child tax values and arrive at the  final amount for each project charge
    public static Map<String,List<Tax_Breakup__c>> getChildTaxRateForCharges(Id pId) {
        List<Project_Charges__c> projChargesList = [Select Id, Name, 
                                                                Active__c,
                                                                Charge_Code__r.Name,
                                                                S_Charge_Calculated_As__c,
                                                                S_Payable_At__c,
                                                                S_Charge_Bucket__c,
                                                                S_Charge_Percentage__c,
                                                                S_Lumpsum_Charge_Amount__c,
                                                                Service_Tax_Percentage__c,
                                                                Interest_Applicable_on_this_charge__c,
                                                                Service_Tax_Applicable_on_this_charge__c,Finished__c,Subvention_Charge__c,
                                                                Payment_Plan_Applicable__c from 
                                                                Project_Charges__c where Project__r.Id = :pId
                                                                and Service_Tax_Applicable_on_this_charge__c = true
                                                                and Service_Tax_Percentage__c != NULL];
        Map<String,List<Tax_Breakup__c>> taxSlabMap = getChildTaxSlabs();
        Map<String,List<Tax_Breakup__c>> taxRateMap = new Map<String,List<Tax_Breakup__c>>();
    
        for (Project_Charges__c pc: projChargesList) {
            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                taxRateMap.put(pc.Name,taxSlabMap.get(pc.Service_Tax_Percentage__c));
            }
        }
        return taxRateMap;
    }
    // take slabs data from the global configuration
    public static Map<String, list<Tax_Breakup__c>> getChildTaxSlabs() {
        Map<String, List<Tax_Breakup__c>> taxslabsMap = new Map<String, List<Tax_Breakup__c>>();
        list<Tax_Breakup__c>   lstTaxSlab = [select Name,Tax_Percentage__c, Tax_Name__c, Tax_Code__c,   Taxable_Percentage__c, Tax_Percentage_On_100__c,Tax_Slab__c, Tax_Slab__r.Name, Tax_Split_Type__c from Tax_breakup__c where Tax_Slab__r.From_Date__c <= TODAY and (Tax_Slab__r.To_Date__c >= TODAY OR Tax_Slab__r.To_Date__c = null)];
       // system.debug('lstTaxSlab --- '+lstTaxSlab);
        for(Tax_Breakup__c objTS : lstTaxSlab){
            if(taxslabsMap.containsKey(objTS.Tax_Slab__r.Name))
                taxslabsMap.get(objTS.Tax_Slab__r.Name).add(objTS);
            else {
                List<tax_breakup__c> tbList = new List<tax_breakup__c>();
                tbList.add(objTS);
                taxslabsMap.put(objTS.Tax_Slab__r.Name, tbList);
            }
                
        }   
        return taxslabsMap;
    }
    public static Decimal calculateAllotmentCharges(Id unitId) {
        Decimal allotmentCharges = 0;
        List<Project_Unit__c> u = new List<Project_Unit__c>();
        u = [Select Id, Single_car_park_Earmarked__c,Single_Open_Earmarked__c, Stack__c, Tandem_car_park_Earmarked__c, Tandem_Open_Earmarked__c,
                                        TowerName__r.ProjectName__r.Allotment_Charges_1__c, TowerName__r.ProjectName__r.Allotment_Charges_2__c,
                                        TowerName__r.ProjectName__r.Allotment_Charges_3__c, TowerName__r.ProjectName__r.Allotment_Charges_4__c,
                                        TowerName__r.ProjectName__r.Allotment_Charges_5__c,TowerName__r.ProjectName__r.Allotment_Charges_6__c,
                                        TowerName__r.ProjectName__r.Allotment_Charges_7__c
                                        from Project_Unit__C 
                                        where Id = :unitId];
        if(u.size() == 1) {
            allotmentCharges = (u[0].Single_car_park_Earmarked__c * u[0].TowerName__r.ProjectName__r.Allotment_Charges_1__c) +
                                (u[0].Tandem_car_park_Earmarked__c *  u[0].TowerName__r.ProjectName__r.Allotment_Charges_2__c) +
                                (u[0].Single_Open_Earmarked__c * u[0].TowerName__r.ProjectName__r.Allotment_Charges_3__c) +
                                (u[0].Tandem_Open_Earmarked__c * u[0].TowerName__r.ProjectName__r.Allotment_Charges_4__c) +
                                (u[0].Stack__c * u[0].TowerName__r.ProjectName__r.Allotment_Charges_5__c);
        }
        return allotmentCharges;
    }
        
    public static Legal_Entity__c getLegalEntityDetails(Id unitId, Id pId) {
        Legal_Entity__c le = new Legal_Entity__c();
        Id leId = null;
        List<Project_Unit__c> pu = [Select Id, Name, Legal_Entity__r.Id from Project_Unit__c where Id = : unitId];
        if(pu != null && pu.size() > 0) {
            leId =pu[0].Legal_Entity__r.Id; 
        }
        
        if(leId == null) {
            List<Project__c> p = [Select Id, Name, RDS_Company_Code__r.Id from Project__c where Id = : pId];
            if(p != null && p.size() > 0)
                leId = p[0].RDS_Company_Code__r.Id;
        }
     //   System.debug('ledId:' + leId);
        if(leId != null) {
            le = [Select Name,Account_Name_Flat_Cost__c,  Bank_Name_Flat_Cost__c,Account_Number_Flat_Cost__c,Account_Number_Service_tax__c, 
                                        IFSC_Code_Flat_Cost__c, MICR_Code_Flat_Cost__c,RDS_PAN_No__c,RDS_Company_Name__c,
                                        Account_Name_Service_Tax__c,Bank_Name_Service_tax__c, 
                                        IFSC_Code_Service_Tax__c, MICR_Code_Service_Tax__c, RDS_Service_Tax_No__c,
                                        RDS_Address1__c,RDS_Address2__c, RDS_City__c, RDS_Pin_Code__c, CIN__c, GSTIN__c,
                                        Branch_Flat_Cost__c,Branch_GST__c,Branch_TDS__c,Account_Type_Flat_Cost__c,Account_Type_GST__c,
                                        Account_Type_TDS__c,Account_Name_TDS__c,Account_Number_TDS__c,IFSC_Code_TDS__c,Bank_Name_TDS__c,  Service_Code__c,
                                        RDS_Phone__c, Account_Name_SRL__c,Account_Number_SRL__c,IFSC_Code_SRL__c,Bank_Name_SRL__c,MICR_CodeSRL__c
                                        FROM Legal_Entity__c where Id = : leId];
        }
        return le;
    }

    /** from the rate list table query the latest rate list for each type of charge that is applicable for this unit
    ** the rate list contains one record per charge for each unit. rate lists are created only for charges for which payment plan is applicable
    ** rate list are not tied to the payment plan, if any deviation needs to be specified on these charges, it will be done as per sq.ft 
    ** lumpsum while creating the quote.
    **/
    
    public static Map<String,Decimal> getRateList(Id unitId, Decimal subvention_Base_Rate) {
        Map<String,Decimal> chargeRateMap = new Map<String,Decimal>();
        List<Rate_List__c> rateList = [Select Id, Rate__c, ChargeCost__c,Global_Charges__r.Name, Amount__c, Charged_Based_On__c,Project_Unit__r.Name, Project__r.Name, Project_Charges__r.Name,Project_Unit__r.Actual_Area_value__c 
                                            from Rate_List__c
                                            where Project_Unit__c = :unitId 
                                            and (Effective_Till__c = null or Effective_Till__c >= TODAY)];
                                
        if(rateList.size() > 0 ) {
            for(Rate_List__c r : rateList)  {
                // System.debug('Rate r:' + r);
                   if(String.isNotBlank(r.Global_Charges__r.Name)) {
                        if(r.Global_Charges__r.Name != 'Basic'){
                              chargeRateMap.put(r.Project_Charges__r.Name + 'PSF', r.Rate__c.setscale(0,RoundingMode.HALF_UP));//
                              chargeRateMap.put(r.Project_Charges__r.Name, r.Amount__c.setscale(0,RoundingMode.HALF_UP));
                        }
                        else{
                              if(baseRateVal == null){
                      decimal amt;
                      if(subvention_Base_Rate > 0){
                                    amt = subvention_Base_Rate * r.Project_Unit__r.Actual_Area_value__c;
                    chargeRateMap.put(r.Project_Charges__r.Name + 'PSF', subvention_Base_Rate);
                  }
                      else{
                    amt = r.Rate__c * r.Project_Unit__r.Actual_Area_value__c;       
                                    chargeRateMap.put(r.Project_Charges__r.Name + 'PSF', r.Rate__c);
                  }
                                  chargeRateMap.put(r.Project_Charges__r.Name, amt.setscale(0,RoundingMode.HALF_UP));  
                              
                              }
                              else{
                                    decimal amt = baseRateVal * r.Project_Unit__r.Actual_Area_value__c;
                                    chargeRateMap.put(r.Project_Charges__r.Name + 'PSF', baseRateVal);//
                                    chargeRateMap.put(r.Project_Charges__r.Name, amt.setscale(0,RoundingMode.HALF_UP));
                              }
                        }
                   }                 
            }                       
            
        }
        return chargeRateMap;
    }

    /** returns all the charges based on the rateList, the
    ** tax slab for each slab and computed value after adding the tax slabs
    **/
    public static Map<String,Decimal> getAllCharges(Id unitId, Decimal allotmentCharges1, Decimal discountLumpsum, Id subPlanId, String Finished, String SubCharge){
               System.debug('getAllCharges Finished:' + Finished);
        List<Project_Unit__c> unit = [Select Id, Project__r.Name, Project__r.ClientLookup__r.Id, 
                                            Project__r.ClientLookup__r.Name, Floor__c,
                                            Project__r.Id from Project_Unit__c where Id = :unitId];
        
                if(unit.size() ==1 ) {
                Map<String, Decimal> allChargesMap = new Map<String,Decimal>();
                List<Payment_Plan__c> selectedSubventionPlan = new List<Payment_Plan__c>();
                Map<String,Decimal> rateListMap = new Map<String,Decimal>();
                if(subPlanId != null)
                selectedSubventionPlan = [Select Subvention_Base_Rate__c  from Payment_Plan__c where Id =: subPlanId];
                List<Project_Charges__c> projChargesList = getProjectChargesDefined(unit[0].Project__r.Name);
                 System.debug('projChargesList before:' + projChargesList );
                 
                 //Ashish
                 
                if(!selectedSubventionPlan.isEmpty())
                    rateListMap = getRateList(unitId,selectedSubventionPlan[0].Subvention_Base_Rate__c);
                else
                    rateListMap = getRateList(unitId,0);
                Map<String,Decimal> projectLevelCharges = getProjectLevelCharges(unitId);
                
                Map<String,Decimal> flatCostMap = new Map<String,Decimal>();
               // system.debug('projChargesList:::: '+projChargesList);
                //system.debug('rateListMap :: '+rateListMap);
                system.debug('projectLevelCharges ::: '+projectLevelCharges);
                //Query the plan to get the subvention base rate
                //Pass the plan id from the page
               
                
                
                
                // System.debug('RATE MAP:' + rateListMap);
                // Basic should always be a rate list. just in case it is defined as lumpsum.. that is fine too
                // but it can't be any other type
                // with the basic we find the flat cost
                Decimal premium = 0.0;
                for(Project_Charges__C pc : projChargesList) {
                    if(pc.Active__c && pc.Charge_Code__r.Name.equals('Basic')) {
                        // calculate the charge value.
                        if(pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level')) {
                            flatCostMap.put('BASERATE', rateListMap.get(pc.Charge_Code__r.Name + 'PSF'));
                        } 
                    }
                    if(pc.Active__c && pc.Charge_Code__r.Name.equals('Floor Rise')) {
                        // calculate the charge value.
                        if(pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level')) {
                            flatCostMap.put('FLOORRISEPERSQFT', (rateListMap.get(pc.Charge_Code__r.Name + 'PSF') ) );
                        } 
                    }
                    // adding up all the PSF premiums
                    if(pc.Active__c && pc.Charge_Code__r.Name.contains('Premium')) {
                        // calculate the charge value.
                        if(pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level')) {
                            premium += rateListMap.get(pc.Charge_Code__r.Name + 'PSF');
                        } 
                        // adding the individual premium values to the flatcost map.
                        flatCostMap.put(pc.Charge_Code__r.Name, rateListMap.get(pc.Charge_Code__r.Name + 'PSF'));
                    }
                }
                flatCostMap.put('TOTALPLC',premium);
                
                if(projectLevelCharges.containsKey('AREA')) {
                    flatCostMap.put('AREA',projectLevelCharges.get('AREA'));
                }
                
              
                Decimal flatCost = calculateFlatCost(flatCostMap);
                allChargesMap.put('FLATCOST',flatCost.setscale(0,RoundingMode.HALF_UP));
                allChargesMap.put('TOTALPLC', flatCostMap.get('TOTALPLC'));
                allChargesMap.put('BASERATE',flatCostMap.get('BASERATE'));
                allChargesMap.put('FLOORRISEPERSQFT', flatCostMap.get('FLOORRISEPERSQFT'));
                allChargesMap.put('FLOORNO', unit[0].Floor__c);
                allChargesMap.put('AREA', flatCostMap.get('AREA'));
                if(flatCostMap.containsKey('Premium 1'))
                    allChargesMap.put('Premium 1', flatCostMap.get('Premium 1'));
                if(flatCostMap.containsKey('Premium 2'))
                    allChargesMap.put('Premium 2', flatCostMap.get('Premium 2'));
                if(flatCostMap.containsKey('Premium 3'))
                    allChargesMap.put('Premium 3', flatCostMap.get('Premium 3'));
                if(flatCostMap.containsKey('Premium 4'))
                    allChargesMap.put('Premium 4', flatCostMap.get('Premium 4'));
                
                
                // Sum up all the charges that are part of agreement value and add it with the flat cost
                // to arrive at the agreement value
                // agrement val charges can't be defined as a % of itself , 
                // so higher of ready reckoner or agreement value is not applicable
                // calculate the charge value.
                // initially set it up as flat cost and then add the development charges etc.,
                Decimal agreementVal = allChargesMap.get('FLATCOST');
                agreementVal = 0;
                for(Project_Charges__C pc : projChargesList) {
                     
                        Decimal percentageFactor = 0.0;
                        Decimal rrVal = 0.0;
                        Decimal flatCostVal = 0.0;
                        // add all the values categorized under agreement value bucket to arrive at the
                        // agreement value except the basic since it already included in the flat cost calculation
                        if(pc.Active__c && pc.S_Charge_Bucket__c.equals('Agreement Value') /* && !(pc.Charge_Code__r.Name.equals('Basic') || pc.Charge_Code__r.Name.contains('Premium')  || pc.Charge_Code__r.Name.equals('Floor Rise')) */ ) {
                        if(pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level')) {
                            if(pc.Finished__c == True && Finished == 'Finished'){
                                agreementVal += rateListMap.get(pc.Charge_Code__r.Name);
                            }
                            else if(pc.Finished__c == True && Finished == 'Unfinished'){
                                agreementVal += 0;
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
                                agreementVal += rateListMap.get(pc.Charge_Code__r.Name);
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
                                agreementVal += 0;
                            }                           
                            else
                            agreementVal += rateListMap.get(pc.Charge_Code__r.Name);
                        } else if(pc.S_Charge_Calculated_As__c.equals('Lumpsum at Project Level')) {
                            if(pc.Finished__c == True && Finished == 'Finished'){
                               agreementVal += pc.S_Lumpsum_Charge_Amount__c;
                            }
                            else if(pc.Finished__c == True && Finished == 'Unfinished'){
                                agreementVal += 0; 
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
                                agreementVal += pc.S_Lumpsum_Charge_Amount__c;
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
                                agreementVal += 0;
                            }           
                else{
                agreementVal += pc.S_Lumpsum_Charge_Amount__c;
                    }

                               
                        } else {
                            // TODO throw exception
                        }
                    }

                }
                
                if(allotmentCharges1 != 0.0) {
                    agreementVal = (agreementVal + allotmentCharges1).setscale(0,RoundingMode.HALF_UP);
                    if(allChargesMap.containsKey('Allotment Charges')) {
                        allChargesMap.put('Allotment Charges' ,allChargesMap.get('Allotment Charges') + allotmentCharges1 );
                    }
                }
                if(discountLumpsum != 0.0) {
                    agreementVal = (agreementVal - discountLumpsum).setscale(0,RoundingMode.HALF_UP);
                    if(allChargesMap.containsKey('BASERATE')) {
                        System.debug('BASE RATE BEFORE DISCOUNT:' + allChargesMap.get('BASERATE'));
                        allChargesMap.put('BASERATE' ,(allChargesMap.get('BASERATE') - discountLumpsum/allChargesMap.get('AREA')).setscale(0,RoundingMode.HALF_UP) );
                        System.debug('BASE RATE AFTER DISCOUNT:' + allChargesMap.get('BASERATE'));
                    }
                }
                allChargesMap.put('AGREEMENTVALUE',agreementVal.setscale(0,RoundingMode.HALF_UP));
                // rest of the charges
                //system.debug('Inventoryclass projcharge::: '+projChargesList);
                for(Project_Charges__C pc : projChargesList) {
                    if(pc.Active__c) {
                        system.debug('pc.Charge_Code__r.Name::: '+pc.Charge_Code__r.Name);
                       // system.debug('pc.S_Lumpsum_Charge_Amount__c::: '+pc.S_Lumpsum_Charge_Amount__c);
                        Decimal chargeVal = 0.0;
                        Decimal rrVal = 0.0;
                        Decimal avVal = 0.0;
                        Decimal flatCostVal = 0.0;    
                        System.debug('Charge Details:' + pc);  
                        system.debug('pc.S_Charge_Calculated_As__c.equals :: '+pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level'));
                        system.debug('pc.Charge_Code__r.Name :: '+pc.Charge_Code__r.Name);
                        
if(pc.S_Charge_Calculated_As__c.equals('Rate List at Unit Level')) {
    if(pc.Finished__c == True && Finished == 'Finished'){
        chargeVal = rateListMap.get(pc.Charge_Code__r.Name);
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
        system.debug('allChargesMap:: '+allChargesMap);
       }
    else if(pc.Finished__c == True && Finished == 'Unfinished'){
        }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
        chargeVal = rateListMap.get(pc.Charge_Code__r.Name);
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
        system.debug('allChargesMap:: '+allChargesMap);
       }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
        }
    else{
        chargeVal = rateListMap.get(pc.Charge_Code__r.Name);
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
        system.debug('allChargesMap:: '+allChargesMap);
    }    
    } 
else if(pc.S_Charge_Calculated_As__c.equals('Lumpsum at Project Level')) {
    
    if(pc.Finished__c == True && Finished == 'Finished'){
        chargeVal = pc.S_Lumpsum_Charge_Amount__c;
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
        }
    else if(pc.Finished__c == True && Finished == 'Unfinished'){
        }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
        chargeVal = pc.S_Lumpsum_Charge_Amount__c;
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
        }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
        }
    else{
        chargeVal = pc.S_Lumpsum_Charge_Amount__c;
        allChargesMap.put(pc.Charge_Code__r.Name, chargeVal);
    }
        
    } 
else if(pc.S_Charge_Calculated_As__c.equals('Percentage of Agreement Value')) {
           //Added by shailesh for rounding up stamp duty to next 500//
    if(pc.Finished__c == True && Finished == 'Finished'){
            if(pc.Charge_Code__r.Name == 'Stamp Duty') {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                avVal = avVal.round(System.RoundingMode.UP);
                Decimal StampDutyRemainder = math.mod((Integer)avVal,1000);//
                If(StampDutyRemainder < 500 && StampDutyRemainder != 0) { 
                        avVal = avVal /500;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal*500;
                }
                else If(StampDutyRemainder > 500) {
                        avVal = avVal /1000;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal *1000;
                }
                else if(StampDutyRemainder == 0 || StampDutyRemainder == 500) {
                        avVal = avVal;
                }
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
            }
            else {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
        }
        }
    else if(pc.Finished__c == True && Finished == 'Unfinished'){
        }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
            if(pc.Charge_Code__r.Name == 'Stamp Duty') {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                avVal = avVal.round(System.RoundingMode.UP);
                Decimal StampDutyRemainder = math.mod((Integer)avVal,1000);//
                If(StampDutyRemainder < 500 && StampDutyRemainder != 0) { 
                        avVal = avVal /500;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal*500;
                }
                else If(StampDutyRemainder > 500) {
                        avVal = avVal /1000;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal *1000;
                }
                else if(StampDutyRemainder == 0 || StampDutyRemainder == 500) {
                        avVal = avVal;
                }
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
            }
            else {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
        }
        }
    else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
        }
     else{
             if(pc.Charge_Code__r.Name == 'Stamp Duty') {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                avVal = avVal.round(System.RoundingMode.UP);
                Decimal StampDutyRemainder = math.mod((Integer)avVal,1000);//
                If(StampDutyRemainder < 500 && StampDutyRemainder != 0) { 
                        avVal = avVal /500;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal*500;
                }
                else If(StampDutyRemainder > 500) {
                        avVal = avVal /1000;
                        avVal = avVal.round(System.RoundingMode.UP);
                        avVal = avVal *1000;
                }
                else if(StampDutyRemainder == 0 || StampDutyRemainder == 500) {
                        avVal = avVal;
                }
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
            }
            else {
                avVal = (pc.S_Charge_Percentage__c *  allChargesMap.get('AGREEMENTVALUE'))/100;
                allChargesMap.put(pc.Charge_Code__r.Name, avVal.setscale(0,RoundingMode.HALF_UP));
        }
     }
        
    }
                                  

                    }
                }
                system.debug('allChargesMap:: '+allChargesMap);
                Decimal charge2Sum = 0;
                Decimal charge3Sum = 0;
                // doing these summing of charges buckets here as MVAT charges is a percentage of consideration value + other charges and maintenance charges   
                for(Project_Charges__c pc : projChargesList) {
                    if(pc.S_Charge_Bucket__c.equals('Maintenance Charges') && pc.Active__c){
                        charge2Sum = charge2Sum + allChargesMap.get(pc.Charge_Code__r.Name);
                    }
                    if(pc.S_Charge_Bucket__c.equals('Other Charges') && pc.Active__c){
                        
                        charge3Sum = charge3Sum + allChargesMap.get(pc.Charge_Code__r.Name);
                        
                    
                    }
                    allChargesMap.put('Maintenance Charges', charge2Sum);
                    allChargesMap.put('Other Charges', charge3Sum);
                }
                
                for(Project_Charges__c pc : projChargesList) {
                    if(pc.Active__c && (pc.Charge_Code__r.Name.equalsIgnoreCase('MVAT') || pc.Charge_Code__r.Name.equalsIgnoreCase('Registration Charges'))) {
                        if(pc.Charge_Code__r.Name.equalsIgnoreCase('MVAT') && pc.S_Charge_Calculated_As__c.equals('Fixed at Code Level')) {
                            Decimal MVAT = calculateMVAT(unit[0].Project__r.Id, pc.S_Charge_Percentage__c, allChargesMap);
                            allChargesMap.put(pc.Charge_Code__r.Name, MVAT.setscale(0,RoundingMode.HALF_UP));
                        }
                        if(pc.Charge_Code__r.Name.equalsIgnoreCase('Registration Charges') && pc.S_Charge_Calculated_As__c.equals('Fixed at Code Level')) {
                            Decimal Registration = calculateRegistrationCharges(unit[0].Project__r.Id, pc.S_Charge_Percentage__c, allChargesMap.get('AGREEMENTVALUE'));
                            allChargesMap.put(pc.Charge_Code__r.Name, Registration.setscale(0,RoundingMode.HALF_UP));
                        }
                    }
                }
                
                allChargesMap.putAll(rateListMap);
                allChargesMap.putAll(projectLevelCharges);
                system.debug('allChargesMap:: '+allChargesMap);
                
                //calculate service tax for each cost
                Map<String,List<tax_breakup__c>> taxSlabMap = getChildTaxSlabs();
                    
                    for(Project_Charges__c pc: projChargesList) {
                       Decimal totalTax = 0;
                       if (pc.Service_Tax_Applicable_on_this_charge__c && pc.Active__c  && taxSlabMap.get(pc.Service_Tax_Percentage__c) != null && !pc.S_Charge_Bucket__c.equals('Agreement Value')) {
                            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    totalTax += allChargesMap.get(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT');
                                }
                                allChargesMap.put(pc.charge_code__r.Name + ' TOTAL TAX AMT', totalTax);
                            }
                            
                        }
                    }

                    Decimal taxAmt = 0;
                    Decimal taxAmtonAgreement = 0;
                    Decimal allotmentTaxAmt = 0;
                    
                    for(Project_Charges__c pc: projChargesList) {
                        // here we are calculating the tax amounts of agreement value as individual component
                        if(pc.Service_Tax_Applicable_on_this_charge__c && pc.Active__c  && taxSlabMap.get(pc.Service_Tax_Percentage__c) != null && pc.S_Charge_Bucket__c.equals('Agreement Value') ) {
                          
                          if(pc.Finished__c == True && Finished == 'Finished'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmt += allChargesMap.get(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT');
                                }
                            }
                            }
                            else if(pc.Finished__c == True && Finished == 'Unfinished'){
                            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmt += 0;
                                }
                            }
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmt += allChargesMap.get(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT');
                                }
                            }
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
                            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmt += 0;
                                }
                            }
                            }
                            else{
                            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get(pc.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmt += allChargesMap.get(pc.charge_code__r.Name + ' '+  tb.tax_name__c + ' TAX AMT');
                                }
                            }                            
                            }
                          
                           
                        } 
                        // here we are calculating the tax amount of agreement value on complete agreement value component [doesn't have the breakup]
                        if(pc.Service_Tax_Applicable_on_this_charge__c && pc.Active__c  && taxSlabMap.get(pc.Service_Tax_Percentage__c) != null && pc.S_Charge_Bucket__c.equals('Agreement Value') && pc.Charge_Code__r.Name.equals('Basic')) {
                           
                           if(pc.Finished__c == True && Finished == 'Finished'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmtonAgreement += allChargesMap.get('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT');
                                    if(allotmentCharges1 != 0.0)
                                        allotmentTaxAmt += ((tb.Taxable_Percentage__c * allotmentCharges1/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    System.debug('taxAmount:' + taxAmtonAgreement);
                                }
                            }
                            }
                            
                            else if(pc.Finished__c == True && Finished == 'Unfinished'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmtonAgreement += 0;
                                    if(allotmentCharges1 != 0.0)
                                        allotmentTaxAmt += ((tb.Taxable_Percentage__c * allotmentCharges1/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    System.debug('taxAmount:' + taxAmtonAgreement);
                                }
                            }
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'Yes'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmtonAgreement += 0;
                                    if(allotmentCharges1 != 0.0)
                                        allotmentTaxAmt += ((tb.Taxable_Percentage__c * allotmentCharges1/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    System.debug('taxAmount:' + taxAmtonAgreement);
                                }
                            }
                            }
                            else if(pc.Subvention_Charge__c == True && SubCharge == 'No'){
                                if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmtonAgreement += 0;
                                    if(allotmentCharges1 != 0.0)
                                        allotmentTaxAmt += ((tb.Taxable_Percentage__c * allotmentCharges1/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    System.debug('taxAmount:' + taxAmtonAgreement);
                                }
                            }
                            }
                            else{
                            if(taxSlabMap.containsKey(pc.Service_Tax_Percentage__c)) {
                                for(tax_breakup__c tb : taxSlabMap.get(pc.Service_Tax_Percentage__c)) {
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAX RATE' , tb.tax_percentage__c );
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+ tb.tax_name__c +  ' TAXABLE AMOUNT' , (tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100).setscale(0,RoundingMode.HALF_UP));
                                    allChargesMap.put('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT' , ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP) );
                                    taxAmtonAgreement += allChargesMap.get('AGREEMENTVALUE' + ' '+  tb.tax_name__c + ' TAX AMT');
                                    if(allotmentCharges1 != 0.0)
                                        allotmentTaxAmt += ((tb.Taxable_Percentage__c * allotmentCharges1/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                    System.debug('taxAmount:' + taxAmtonAgreement);
                                }
                            }
                            }
                           
                        }
                    }
                    
                    allChargesMap.put('AGREEMENTVALUE TAX AMT' , taxAmtonAgreement.setscale(0,RoundingMode.HALF_UP));
                    
                // adding more charge info to the map to display base rates in the discount section
                // basic total includes the PLC as it cant be separated out
                allchargesMap.put('BASICRATE+PLC',(allChargesMap.get('BASERATE') + allChargesMap.get('TOTALPLC') ).setscale(0,RoundingMode.HALF_UP));
                allChargesMap.put('BASIC+PLCTOTAL',(allChargesMap.get('BASICRATE+PLC') * projectLevelCharges.get('AREA')).setscale(0,RoundingMode.HALF_UP));
                allChargesMap.put('FLOORRISETOTAL',(allChargesMap.get('FLOORRISEPERSQFT') * projectLevelCharges.get('AREA')).setscale(0,RoundingMode.HALF_UP));
                
                // harding coding allotment charges name here. dont have a choice.
                if(allChargesMap.containsKey('Allotment Charges'))
                    allChargesMap.put('Allotment ChargesPerSqFt',(allChargesMap.get('Allotment Charges')/projectLevelCharges.get('AREA')).setscale(0,RoundingMode.HALF_UP));
                
                if(allChargesMap.containsKey('BASIC+PLCTOTAL') && allChargesMap.containsKey('Allotment Charges'))
                    allChargesMap.put('TOTALRATECARDLUMPSUM',(allChargesMap.get('BASIC+PLCTOTAL') + allChargesMap.get('FLOORRISETOTAL') + allChargesMap.get('Allotment Charges')).setscale(0,RoundingMode.HALF_UP));
                else 
                    allChargesMap.put('TOTALRATECARDLUMPSUM',(allChargesMap.get('BASIC+PLCTOTAL') + allChargesMap.get('FLOORRISETOTAL')).setscale(0,RoundingMode.HALF_UP));
                
                if(allChargesMap.containsKey('BASIC+PLCTOTAL') && allChargesMap.containsKey('Allotment Charges'))   
                    allChargesMap.put('TOTALRATECARDPSF', allChargesMap.get('BASICRATE+PLC') + (allChargesMap.get('FLOORRISEPERSQFT') + allChargesMap.get('Allotment ChargesPerSqFt')).setscale(0,RoundingMode.HALF_UP));
                else 
                    allChargesMap.put('TOTALRATECARDPSF', allChargesMap.get('BASICRATE+PLC') + (allChargesMap.get('FLOORRISEPERSQFT')).setscale(0,RoundingMode.HALF_UP)); 
                
                if(allotmentCharges1 != 0.0) {
                    //taxAmt += (allChargesMap.get('BASIC TAX RATE') * allotmentCharges1) /100;
                    allChargesMap.put('Allotment Charges1', allotmentCharges1);
                    allChargesMap.put('Allotment Charges1 TAX AMT' , allotmentTaxAmt);
                }                 
        for(String key : allChargesMap.keySet()) {
                    System.debug(key + ':' + allChargesMap.get(key));
                }
                return allChargesMap;
        } else {
            // throw exception
            return null;
        }
    }
    // take slabs data from the global configuration
    public static Map<String, Decimal> getTaxSlabs() {
        Map<String, Decimal> taxslabsMap = new Map<String, Decimal>();
        list<Tax_Slab__c>   lstTaxSlab = [select Name,From_Date__c, To_Date__c, Percentage__c from Tax_Slab__c where From_Date__c <= TODAY and (To_Date__c >= TODAY OR To_Date__c = null)];
       // system.debug('lstTaxSlab --- '+lstTaxSlab);
        for(Tax_Slab__c objTS : lstTaxSlab){
            taxslabsMap.put(objTS.Name,objTS.Percentage__c);
        }   
        return taxslabsMap;
    }
    
    public static Decimal calculateFlatCost(Map<String,Decimal> rateMap){
        Decimal flatCost = 0.0;
        Decimal ratePerSqFt = 0.0;
        //calculate the total rate per sq feet, by adding base rate + floor rise rate 
        // System.debug('RATE MAP:' + rateMap);
        if(rateMap.containsKey('BASERATE') && rateMap.containsKey('AREA')) {
            ratePerSqFt = rateMap.get('BASERATE') + rateMap.get('FLOORRISEPERSQFT');
            
        } else {
            // throw exception
           // System.debug('In Else');
        }
        
        // add PLC values to the base rate
        if(rateMap.containsKey('TOTALPLC'))
            ratePerSqFt = ratePerSqFt + rateMap.get('TOTALPLC');
            
        //calculate the flat cost by multiplying area and ratePerSqFt
        flatCost = ratePerSqFt * rateMap.get('AREA');
       // System.debug('rate:' + ratePerSqFt + 'sqft:' + rateMap.get('AREA'));
        return flatCost;
    }
    
    public static Decimal calculateMVAT(Id projectId, Decimal Percentage, Map<String,Decimal> allChargesMap) {
        Decimal MVAT =0;
        Decimal subTotal1 = 0;
        Decimal subTotal2 = 0;
        Decimal subTotal3 = 0;
        Decimal subTotal4 = 0;
        Decimal subTotal5 = 0;
        Decimal subTotal6 = 0;
        Decimal subTotal7 = 0;
        Decimal subTotal8 = 0;
        
        If(allChargesMap.containsKey('AGREEMENTVALUE')) {
            subTotal1 = allChargesMap.get('AGREEMENTVALUE');
        }
        If(allChargesMap.containsKey('Maintenance Charges')) {
            subTotal2 = allChargesMap.get('Maintenance Charges');
        }
        If(allChargesMap.containsKey('Other Charges')) {
            subTotal3 = allChargesMap.get('Other Charges');
        }
        If(allChargesMap.containsKey('Land Under Construction (LUC) Reimbursement')) {
            subTotal4 = allChargesMap.get('Land Under Construction (LUC) Reimbursement');
        }
        If(allChargesMap.containsKey('Advance Property Charges')) {
            subTotal5 = allChargesMap.get('Advance Property Charges');
        }
        If(allChargesMap.containsKey('Ultimate Organization formation & related charges')) {
            subTotal6 = allChargesMap.get('Ultimate Organization formation & related charges');
        }
        If(allChargesMap.containsKey('Electricity Deposit Reimbursement')) {
            subTotal7 = allChargesMap.get('Electricity Deposit Reimbursement');
        }
        If(allChargesMap.containsKey('Building Protection Deposit')) {
            subTotal8 = allChargesMap.get('Building Protection Deposit');
        }
       // System.debug('Subtotal 1: AV ' + subTotal1);
       // System.debug('Subtotal 2: Maintenance ' + subTotal2);
        //System.debug('Subtotal 3: Other ' + subTotal3);
       // System.debug('Subtotal 4: LUC ' + subTotal4);
        //System.debug('Subtotal 5: Advance Property ' + subTotal5);
        //System.debug('Subtotal 6: Ultimate Org ' + subTotal6);
       // System.debug('Subtotal 7: Electricity ' + subTotal7);
        //System.debug('Subtotal 8: Building protection ' + subTotal8);
        
        MVAT = (((subTotal1 + subTotal2 + subTotal3 - subTotal4 - subTotal5 -subTotal6 - subTotal7 - subTotal8)*Percentage)/100).setscale(0,RoundingMode.HALF_UP);
        return MVAT;
    }
    
    public static Decimal calculateRegistrationCharges(Id projectId,Decimal Percentage,Decimal agreementValue) {
        Decimal registration = 0;
       // System.debug('Percentage:' + Percentage + 'Agreement value:' + agreementValue);
        registration = (Percentage *  agreementValue)/100;
        if(registration <= 30000) {
            registration = (registration + 3000).setscale(0,RoundingMode.HALF_UP);
        } else {
            registration = 39000;
        }
        return registration;
    }
    
    public static Project_Unit__c  getUnitDetails(Id unitId){
        List<Project_Unit__c> unit = [Select Id, Name,Project__r.Name,Project__r.Id,Project__r.ClientLookup__r.Id, Project__r.ClientLookup__r.Name, TowerName__r.Name, TowerName__r.Zone_Name__r.Name, S_View1__c,S_View_2__c,S_View_3__c,PLC_Total__c,
                                                            Project_Unit_Type__r.Name,Floor__c,Carpet_Area__c, Actual_Area_value__c, 
                                                            Single_car_park_Earmarked__c,Single_Open_Earmarked__c, Stack__c, Tandem_car_park_Earmarked__c, Tandem_Open_Earmarked__c,
                                                            TowerName__r.ProjectName__r.Allotment_Charges_1__c, TowerName__r.ProjectName__r.Allotment_Charges_2__c,
                                                            TowerName__r.ProjectName__r.Allotment_Charges_3__c, TowerName__r.ProjectName__r.Allotment_Charges_4__c,
                                                            TowerName__r.ProjectName__r.Allotment_Charges_5__c, TowerName__r.ProjectName__r.Allotment_Charges_6__c, TowerName__r.ProjectName__r.Allotment_Charges_7__c
                                                                     from Project_Unit__c where Id = :unitId];
        if(unit.size() ==1) {
            return unit[0];
        } else {
            return null;
        }
        
    }
    
    public static Project__c  getProjectDetails(Id unitId){
        List<Project_Unit__c> unit = [Select Id, Name,Project__r.Name,Project__r.Id, TowerName__r.Name, View__c,
                                                            Project_Unit_Type__r.Name,Floor__c,Carpet_Area__c,
                                                            Project__r.ClientLookup__r.Id, Project__r.ClientLookup__r.Name
                                                                     from Project_Unit__c where Id = :unitId];
        if(unit.size() ==1) {                                                            
            List<Project__c> projList = [Select Id, Address__c, Total_Max_Discount_Allowed__c,Edit_Base_Rate__c,Edit_Discount_Lumsum__c, 
                                    Service_Tax_Required_On_Token_Amount__c,NPV__c ,Days_to_Send_Demand__c, Name,Discount_Link_Option__c, 
                                    Quotation_Validity__c, single_car_park_available__c, tandem_car_park_available__c,Two_wheeler_Available__c,
                                    single_open_available__c, tandem_open_available__c, stack_available__c,New_Stack_Available__c,
                                    Allotment_Charges_1__c, Allotment_Charges_2__c, Allotment_Charges_3__c, Allotment_Charges_4__c,
                                    Allotment_Charges_5__c,Allotment_Charges_6__c,Allotment_Charges_7__c, Discount_Threshold_TL__c,Discount_Threshold_SM__c,Discount_Threshold_SH__c
                                    from Project__c where Id =: unit[0].Project__r.Id ];
            if(projList.size() ==1) {
                return projList[0];
            } else {
                return null;
            }
        }else {
            return null;
        }
        
    }
    
    public static List<Payment_Plan__c> getPlanList(Id projId, Id tId, ID subPlanId) {
       // System.debug('PID:' + projId + 'Tower Id:' + tID);
        List<Payment_Plan__c> planList = new List<Payment_Plan__c>();
        if(subPlanId != null){
        planList = [Select Id, Name, Bank_Loan_Self_Funded__c, Plan_Code__c from Payment_Plan__c where project__r.Id = : projId and tower__r.Id = :tId and ID = : subPlanId and Sub_Vention__c = True];
        }
    else{
        planList = [Select Id, Name, Bank_Loan_Self_Funded__c, Plan_Code__c,Sub_Vention__c from Payment_Plan__c where project__r.Id = : projId and tower__r.Id = :tId and Sub_Vention__c = false];
    }
    return planList;
    }
    
    public static Map<String,Project_Construction_Stages__c> getConstructionStagesByName(Id projId) {
        Map<String,Project_Construction_Stages__c> pstageMap = new Map<string,Project_Construction_Stages__c>();
        List<Project_Construction_Stages__c> psList = [Select Id, Name, Planned_date_of_completion__c,Actual_date_of_completion__c from Project_Construction_Stages__c where Project__r.Id = : projId];
        for(Project_Construction_Stages__c p : psList) {
            pstageMap.put(p.Name, p);
        }
        return pstageMap;
    }
    
    public static Map<Id,Project_Construction_Stages__c> getConstructionStagesById(Id projId, Id towerId) {
       // System.debug('Pstage Map Method:' + projId + '::' + towerId);
        Map<Id,Project_Construction_Stages__c> pstageMap = new Map<Id,Project_Construction_Stages__c>([Select Id, Name, Planned_date_of_completion__c,Actual_date_of_completion__c 
                                                                                                        from Project_Construction_Stages__c 
                                                                                                        where Project__r.Id = : projId 
                                                                                                        and tower__r.Id = : towerId]);
       // System.debug('pStageMap:' + pStageMap);
        return pstageMap;
    }
    
    /** get the payment plan and use the percentage values defined to get the actual value at each milestone based on Agreement Value **/
    public static List<PlanDetailWrapper> getPlanDetails(Id ppId, Map<String,Decimal> allChargesMap) {
        system.debug('inside getPlandetails meyhod');
        system.debug('av value:: '+allChargesMap.get('AGREEMENTVALUE'));
        Decimal av = allChargesMap.get('AGREEMENTVALUE').setscale(0,RoundingMode.HALF_UP);
        Decimal overallServiceTaxAmount = allChargesMap.get('AGREEMENTVALUE TAX AMT').setscale(0,RoundingMode.HALF_UP);
        Decimal serviceTaxRate = allChargesMap.get('AGREEMENTVALUE TAX RATE');
        //calculate service tax for each cost
        Map<String,List<tax_breakup__c>> taxSlabMap = getChildTaxSlabs();
        List<Payment_Plan__c> selectedSubventionPlan = [Select Subvention_Base_Rate__c,Sub_Vention__c from Payment_Plan__c where Id =: ppId];
        List<Standard_Customer_Pay_Plan_Detail__c> pdList = [Select Id, Installment_Number__c, Is_to_be_Paid__c, Is_to_be__c,Days_Months__c,Days_Months_Value__c,
                                                            Project_Construction_Stages__r.Name,Project_Construction_Stages__c,Is_Milestone_Achieved__c,
                                                            Project__r.Id,  Project__c, Project__r.Days_from_Dt_of_Booking_for_NPV__c, Tower__c, Installment__c, Due_Date__c,Value__c,Amount__c,Amount_Value__c, 
                                                            Calculate_Installment_Amount_as__c,Total_Charge_Value_Minus__c,Contribution_From__c,OC_Milestone__c,Project__r.No_GST_on_Token__c,Add_Token_GST__c,
                                                            Standard_Pay_Plan_Header__r.Name, Standard_Pay_Plan_Header__r.Payment_Plan__r.Name,Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c, 
                                                            Standard_Pay_Plan_Header__r.Charge_Code__r.Name,Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c, Deduct_Token__c,Remarks__c,Registration_Linked__c from  
                                                            Standard_Customer_Pay_Plan_Detail__c where 
                                                            Standard_Pay_Plan_Header__r.Payment_Plan__c = :ppId 
                                                            and Customer_Pay_Plan_Header__c = Null 
                                                            and Standard_Pay_Plan_Header__r.Charge_Code__r.Name = 'Basic'
                                                            ORDER BY createdDate, Integer_Installment_No__c];
        // in a round about way I am getting the project Id here. Didn't need the project id in this method earlier but now 
        // need for getting the construction stages due date for that project
        Map<Id,Project_Construction_Stages__c> pstageMap = getConstructionStagesById(pdList[0].project__c, pdList[0].tower__c);         
        
        List<PlanDetailWrapper> planDetailsWList = new List<PlanDetailWrapper>();                                               
        Decimal Amount = 0;
        Decimal ServiceTax = 0;
        Decimal total = 0;
        Decimal staxTotal = 0;
        Integer count = 0;
        Decimal mileStonePercentage = 0;
        Decimal tempSTforToken = 0;
       // System.debug('Agreement Value:: start of calculation::' + av);
                    
        for(Standard_Customer_Pay_Plan_Detail__c pd : pdList) {
                    System.debug('PD:' + pd);
                    if(pd.Amount__c.equals('Amount') && count==0) {
                        Amount = (pd.Amount_Value__c).setscale(0,RoundingMode.HALF_UP);
                        pd.Amount_Value__c = (Amount/av*100).setscale(2,RoundingMode.HALF_UP);
                        pd.Amount__c = 'Percentage';                        
                        total += Amount;                        
                        pd.Value__c = string.valueOf( pd.Amount_Value__c ) + ' %';
                        pd.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                        pd.Is_to_Be__c = 'Token Amount';
                        allChargesMap.put('TOKENAMOUNT', Amount);
                        allChargesMap.put('TOKEN TAX AMT',serviceTax);
                        
                    }else if(pd.Amount__c.equals('Percentage')) {
                        Amount = ((pd.Amount_Value__c * av)/100).setscale(0,RoundingMode.HALF_UP);                        
                        total += Amount;                        
                        pd.Value__c = string.valueOf( pd.Amount_Value__c ) + ' %';
                        pd.Milestone_Percentage__c = pd.Amount_Value__c.setscale(5,RoundingMode.HALF_UP);
                    } 
                    else if(pd.Amount__c.equals('Amount') && !pd.deduct_Token__c) {
                        Amount = (pd.Amount_Value__c).setscale(0,RoundingMode.HALF_UP);
                        pd.Amount_Value__c = (Amount/av*100).setscale(2,RoundingMode.HALF_UP);
                        pd.Amount__c = 'Percentage';                        
                        total += Amount;                        
                        pd.Value__c = string.valueOf( pd.Amount_Value__c ) + ' %';
                        pd.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    } else if(pd.Amount__c.equals('Amount') && pd.deduct_Token__c) {
                        Amount = ((pd.Calculate_Installment_Amount_as__c * av)/100 - pd.Total_Charge_Value_Minus__c).setscale(0,RoundingMode.HALF_UP);
                        pd.Amount_Value__c = (pd.Calculate_Installment_Amount_as__c - (pd.Total_Charge_Value_Minus__c)/av*100).setscale(2,RoundingMode.HALF_UP);
                        pd.Amount__c = 'Percentage';                        
                        total += Amount;                      
                        pd.Value__c = string.valueOf( pd.Amount_Value__c ) + ' %';
                        pd.Milestone_Percentage__c = (pd.Calculate_Installment_Amount_as__c - (pd.Total_Charge_Value_Minus__c)/av*100).setscale(5,RoundingMode.HALF_UP);
                    }
            // service tax calculations for GST
                    Map<String,Decimal> taxMap = new Map<String,Decimal>();
                    
                    Decimal st = 0;
                    serviceTax = 0;
                    for(Tax_Breakup__c tb: taxSlabMap.get(pd.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                         if(pd.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c) {
                              if(count == 0) {
                                  st = 0;
                                  tempSTforToken = ((tb.Taxable_Percentage__c * Amount /100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                              else if(pd.Add_Token_GST__c) { // 
                                  st = (((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100) + tempSTforToken).setscale(0,RoundingMode.HALF_UP);
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                              else {
                                  st = ((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                         }
                         else if(!pd.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c) {
                             st = ((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                             taxMap.put(tb.Tax_Name__c, st);
                             serviceTax += st;
                             staxTotal += st;
                         }
                           
                    }
                    if(pd.Is_to_be_Paid__c.equals('From Dt. of Booking')) {
                        if(pd.Days_Months__c.equals('Month(s)')) {
                          if(Integer.valueOf(pd.Days_Months_Value__c) != 0){
                             //// pd.due_date__c = System.today().addMonths(Integer.valueOf(pd.Days_Months_Value__c));  ///// Commented by vikas
                             pd.due_date__c = System.today().addMonths(Integer.valueOf(pd.Days_Months_Value__c));  ////// Including booking date
                             pd.due_date__c = pd.due_date__c.addDays(-1);
                          }
                          else{
                             pd.due_date__c = System.today().addMonths(Integer.valueOf(pd.Days_Months_Value__c));
                          }
                        } else if (pd.Days_Months__c.equals('Day(s)')) {
                           if(Integer.valueOf(pd.Days_Months_Value__c) != 0){
                              //// pd.due_date__c = System.today().addDays(Integer.valueOf(pd.Days_Months_Value__c));
                              pd.due_date__c = System.today().addDays(Integer.valueOf(pd.Days_Months_Value__c - 1));
                           }
                           else{
                              pd.due_date__c = System.today().addMonths(Integer.valueOf(pd.Days_Months_Value__c));
                           }
                        }
                    } else if(pd.Is_to_be_Paid__c.equals('From Dt. of Registration')) {
                        if(pd.Days_Months__c.equals('Month(s)')) {
                            pd.due_date__c = System.today().addMonths(Integer.valueOf(pd.Days_Months_Value__c)).addDays(Integer.valueOf(pd.Project__r.Days_from_Dt_of_Booking_for_NPV__c));
                        } else if (pd.Days_Months__c.equals('Day(s)')) {
                            pd.due_date__c = System.today().addDays(Integer.valueOf(pd.Days_Months_Value__c) + Integer.valueOf(pd.Project__r.Days_from_Dt_of_Booking_for_NPV__c));
                        }
                    } 
                    else if(pd.Is_to_be_Paid__c.equals('Construction Stage')) {
                        Date completionDate = null;
                        Boolean IsMilestoneAchieved = false;
                        Project_Construction_Stages__c pStage = pstageMap.get(pd.Project_Construction_Stages__c);
                       // System.debug('pStage:' + pStage);
                        if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c > System.today())
                            completionDate = pStage.Actual_date_of_completion__c;
                        else if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c <= System.today()) {
                            completionDate = system.today();
                            IsMilestoneAchieved = True;
                        }
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c > System.today())
                            completionDate = pStage.Planned_date_of_completion__c;
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c <= System.today())
                            completionDate = system.today();
                        // this may not right, but ideally the code shouldnt come in here if the data is set correctly. 
                        if (completionDate == null)
                            completionDate = system.today().addDays(365);
                        if(pd.Days_Months__c.equals('Month(s)')) {
                            pd.due_date__c = completionDate.addMonths(Integer.valueOf(pd.Days_Months_Value__c));
                        } else if (pd.Days_Months__c.equals('Day(s)')) {
                            pd.due_date__c = completionDate.addDays(Integer.valueOf(pd.Days_Months_Value__c));
                        }
                        pd.Is_To_be__c = pd.Days_Months__c + ' ' +  pd.Days_Months_Value__c + ' after Stage: ' + pStage.Name;
                        ///Added by shailesh on 27.1.17///
                        if(IsMilestoneAchieved)
                            pd.Is_Milestone_Achieved__c = True;
                        else
                            pd.Is_Milestone_Achieved__c = False;
                    }
                if(selectedSubventionPlan[0].Sub_Vention__c){
                            if(pd.OC_Milestone__c){
                                  pd.Contribution_From__c = 'Customer';
                            }
                            else{
                                  pd.Contribution_From__c = 'Financial Institution';
                            }
            }
            
                        pd.value__c = pd.value__c.replace('of Total Charge Value','');
                        // this will continue to hold the original installment number, used in logic for payment plan editing.
                        pd.Installment_Number__c = string.valueOf(count + 1);
                        pd.Inst_No__c = pd.Installment_Number__c; 
                        planDetailsWList.add(new PlanDetailWrapper(Amount.setscale(0,RoundingMode.HALF_UP),serviceTax.setscale(0,RoundingMode.HALF_UP), Amount+ServiceTax, pd,taxMap));
                        count++;
        }
        
        // gist of what is being achieved below
        // when the agreement value is being broken up in individual milestones based on % of each milestone and 
        // rounding is carried out on each milestone value, 
        // the overall total of the individual milestones will not added to the original agreement value [may be a difference of few Rs]
        // the below code, finds out the difference, forces the final sum total to match the agreement value.
        // same logic is applied for the service tax as well.
        
        if(planDetailsWList.size() > 1) {
            planDetailWrapper pw = planDetailsWList[planDetailsWList.size() -1];
            
           // System.debug('PW:Last' + pw);
            //System.debug('original total:'+ total.setscale(0,RoundingMode.HALF_UP) + 'AV:' + av);
           // System.debug('original ST:' + sTaxTotal.setscale(0,RoundingMode.HALF_UP) + 'ST:' + overallServiceTaxAmount);
            
            if(total.setscale(0,RoundingMode.HALF_UP) > av) {
               // System.debug('original total:' + total + ' original ms amt:' +  pw.amount);
                pw.amount = pw.amount - (total.setscale(0,RoundingMode.HALF_UP) - av);
                pw.PayPlanRecord.Amount_Value__c = (pw.amount /av   *100).setscale(2,RoundingMode.HALF_UP);
                pw.PayPlanRecord.Milestone_Percentage__c = (pw.amount /av   *100).setscale(5,RoundingMode.HALF_UP);
                pw.PayPlanRecord.Value__c = string.valueOf( pw.PayPlanRecord.Amount_Value__c ) + ' %';
                
                //System.debug('updated total:' + total + 'pw.amount: ' + pw.amount + 'difference:' +  (total.setscale(0,RoundingMode.HALF_UP) - av) );
                total = av;
            } else if (total.setscale(0,RoundingMode.HALF_UP)< av) {
                //System.debug('If AV greater than original total scenarion: original total:' + total + ' original ms amt:' +  pw.amount);
                pw.amount = pw.amount + (av - total.setscale(0,RoundingMode.HALF_UP));
                pw.PayPlanRecord.Amount_Value__c = (pw.amount /av   *100).setscale(2,RoundingMode.HALF_UP);
                pw.PayPlanRecord.Value__c = string.valueOf( pw.PayPlanRecord.Amount_Value__c ) + ' % ';
                pw.PayPlanRecord.Milestone_Percentage__c = (pw.amount /av   *100).setscale(5,RoundingMode.HALF_UP);
               // System.debug('updated total:' + total + 'pw.amount: ' + pw.amount + 'difference:' +  (total.setscale(0,RoundingMode.HALF_UP) - av) );
                total = av;
            } 
            
            
                    // service tax calculations for GST
            Map<String,Decimal> taxMap = new Map<String,Decimal>();
            // if the amount of the last row has changed as part of conciling the totals,then recalculate the service taxes on that new amount.
            Decimal st = 0;
            for(Tax_Breakup__c tb: taxSlabMap.get(pw.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                 st = ((tb.Taxable_Percentage__c * pw.amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                 taxMap.put(tb.Tax_Name__c, st);
                 st += st;
            }
            pw.serviceTax = st;
            pw.taxMap = taxMap;
            
            
           // System.debug('PW Adjusted Last:' + pw);
            planDetailsWList.remove(planDetailsWList.size() -1);
            planDetailsWList.add(pw);
            Map<string,decimal> taxMap1 = new Map<String,Decimal>();
            Decimal servicetax1 = 0;
            Decimal stTotal = 0;
            for(String taxName: taxMap.keySet()) {
                servicetax1 = allChargesMap.get('AGREEMENTVALUE ' + taxName + ' TAX AMT').setscale(0,RoundingMode.HALF_UP);
                taxMap1.put(taxName, servicetax1);
                stTotal += serviceTax1;
                
            }
            
            planDetailsWList.add(new PlanDetailWrapper(total.setscale(0,RoundingMode.HALF_UP),stTotal.setscale(0,RoundingMode.HALF_UP),total+stTotal,null,taxMap1));
        }
        
        return  planDetailsWList;           
    }
    
    /** get the payment plan based on the edited schedule, which is stored in a wrapper class **/
    public static List<PlanDetailWrapper> calculateUpdatedPaymentSchedule(List<PlanDetailWrapper> pdList, Map<String,Decimal> allChargesMap, List<PlanDetailWrapper> po) {
        
        Decimal av = allChargesMap.get('AGREEMENTVALUE').setscale(0,RoundingMode.HALF_UP);
        Decimal overallServiceTaxAmount = allChargesMap.get('AGREEMENTVALUE TAX AMT').setscale(0,RoundingMode.HALF_UP);
        Decimal serviceTaxRate = allChargesMap.get('AGREEMENTVALUE TAX RATE');
        
        List<PlanDetailWrapper> planDetailsWList = new List<PlanDetailWrapper>();                                               
        Decimal Amount = 0;
        Decimal ServiceTax = 0;
        Decimal total = 0;
        Decimal staxTotal = 0;
        Integer count = 0; 
        Integer originalInstallment = 0;
        Integer arrayIndex = 0;
    Decimal tempSTforToken = 0;
        Map<Id,Project_Construction_Stages__c> pstageMap = getConstructionStagesById(pdList[0].payPlanRecord.project__c, pdList[0].payPlanRecord.Tower__c);         
    //calculate service tax for each cost
        Map<String,List<tax_breakup__c>> taxSlabMap = getChildTaxSlabs();
        for(PlanDetailWrapper pd : pdList) {
                  //  System.debug('pdList:' + pd);
                    originalInstallment = Integer.valueOf(pd.payPlanRecord.Inst_No__c);
                    arrayIndex = originalInstallment - 1;
                    pd.payPlanRecord.Installment_Number__c = string.valueOf(count);
                    if(pd.PayPlanRecord.Remarks__c != null &&  pd.PayPlanRecord.Remarks__c.equals('New Row') && pd.payPlanRecord.Amount__c.equals('Percentage') ) {
                        Amount = ((pd.payPlanRecord.Amount_Value__c * av)/100).setscale(0,RoundingMode.HALF_UP);                  
                        total += Amount;                        
                        pd.payPlanRecord.Value__c = String.valueOf(pd.payPlanRecord.Amount_Value__c) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (pd.payPlanRecord.Amount_Value__c).setscale(5,RoundingMode.HALF_UP);
                    } else if (pd.PayPlanRecord.Remarks__c != null  && pd.PayPlanRecord.Remarks__c.equals('New Row') && pd.payPlanRecord.Amount__c.equals('Amount') ) {
                        Amount = (pd.payPlanRecord.Amount_Value__c).setscale(0,RoundingMode.HALF_UP);
                        pd.payPlanRecord.Amount_Value__c = (Amount/av*100).setscale(2,RoundingMode.HALF_UP);
                        pd.payPlanRecord.Amount__c = 'Percentage';                       
                        total += Amount;                       
                        pd.payPlanRecord.Value__c = string.valueOf( pd.payPlanRecord.Amount_Value__c ) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    } 
                    else if(pd.payPlanRecord.Amount__c.equals('Percentage') && (po[arrayIndex].payPlanRecord.Amount__c != pd.payPlanRecord.Amount__c || po[arrayIndex].payPlanRecord.Amount_Value__c != pd.payPlanRecord.Amount_Value__c)) {
                        Amount = ((pd.payPlanRecord.Amount_Value__c * av)/100).setscale(0,RoundingMode.HALF_UP);                  
                        total += Amount;                   
                        pd.payPlanRecord.Value__c = String.valueOf(pd.payPlanRecord.Amount_Value__c) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    } else if(pd.payPlanRecord.Amount__c.equals('Percentage') && po[arrayIndex].payPlanRecord.Amount__c == pd.payPlanRecord.Amount__c) {
                        Amount = (po[arrayIndex].Amount).setscale(0,RoundingMode.HALF_UP);     
                        total += Amount;
                        pd.payPlanRecord.Value__c = String.valueOf(po[arrayIndex].payPlanRecord.Amount_Value__c) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    } 
                    else if(pd.payPlanRecord.Amount__c.equals('Amount') && (po[arrayIndex].payPlanRecord.Amount__c != pd.payPlanRecord.Amount__c || po[arrayIndex].payPlanRecord.Amount_Value__c != pd.payPlanRecord.Amount_Value__c) ) {
                        Amount = (pd.payPlanRecord.Amount_Value__c).setscale(0,RoundingMode.HALF_UP);
                        pd.payPlanRecord.Amount_Value__c = (Amount/av*100).setscale(2,RoundingMode.HALF_UP);
                        pd.payPlanRecord.Amount__c = 'Percentage';
                        total += Amount;
                        pd.payPlanRecord.Value__c = string.valueOf( pd.payPlanRecord.Amount_Value__c ) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    } else {
                        Amount = (po[arrayIndex].Amount).setscale(0,RoundingMode.HALF_UP);  
                        total += Amount;
                        pd.payPlanRecord.Value__c = string.valueOf( po[arrayIndex].payPlanRecord.Amount_Value__c ) + '%';
                        pd.payPlanRecord.Milestone_Percentage__c = (Amount/av*100).setscale(5,RoundingMode.HALF_UP);
                    }
            // service tax calculations for GST
                    Map<String,Decimal> taxMap = new Map<String,Decimal>();
                    
                    Decimal st = 0;
                    servicetax = 0;
                    for(Tax_Breakup__c tb: taxSlabMap.get(pd.payplanrecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                          if(pd.payplanrecord.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c) { 
                              if(count == 0) {
                                  st = 0;
                                  tempSTforToken = ((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                              else if(pd.payplanrecord.Add_Token_GST__c) {
                                  st = (((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100) + tempSTforToken).setscale(0,RoundingMode.HALF_UP) ;
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                              else {
                                  st = ((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                                  taxMap.put(tb.Tax_Name__c, st);
                                  serviceTax += st;
                                  staxTotal += st;
                              }
                         }
                         else if(!pd.payplanrecord.Standard_Pay_Plan_Header__r.Payment_Plan__r.No_GST_on_Token__c) {
                             st = ((tb.Taxable_Percentage__c * Amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                             taxMap.put(tb.Tax_Name__c, st);
                             serviceTax += st;
                             staxTotal += st;                        
                         }
                    }
                    if(pd.payPlanRecord.Is_to_be_Paid__c.equals('From Dt. of Booking')) {
                        if(pd.payPlanRecord.Days_Months__c.equals('Month(s)')) {
                          if(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c) != 0){
                             //// pd.payPlanRecord.due_date__c = System.today().addMonths(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));  ///// Commented by vikas
                             pd.payPlanRecord.due_date__c = System.today().addMonths(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));  ////// Including booking date
                             pd.payPlanRecord.due_date__c = pd.payPlanRecord.due_date__c.addDays(-1);
                          }
                          else{
                             pd.payPlanRecord.due_date__c = System.today().addMonths(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));
                          }
                        } else if (pd.payPlanRecord.Days_Months__c.equals('Day(s)')) {
                            if(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c) != 0){ 
                              //// pd.payPlanRecord.due_date__c = System.today().addDays(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));
                              pd.payPlanRecord.due_date__c = System.today().addDays(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c - 1));
                            }
                            else{
                              pd.payPlanRecord.due_date__c = System.today().addDays(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));
                            }
                        }
                        pd.payPlanRecord.Is_To_be__c = pd.payPlanRecord.Days_Months__c + ' ' +  pd.payPlanRecord.Days_Months_Value__c + ' ' + pd.payPlanRecord.Is_to_be_Paid__c;                        
                    } else if(pd.payPlanRecord.Is_to_be_Paid__c.equals('From Dt. of Registration')) {
                        if(pd.payPlanRecord.Days_Months__c.equals('Month(s)')) {
                            pd.payPlanRecord.due_date__c = System.today().addMonths(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c)).addDays(Integer.valueOf(pd.payPlanRecord.Project__r.Days_from_Dt_of_Booking_for_NPV__c));
                        } else if (pd.payPlanRecord.Days_Months__c.equals('Day(s)')) {
                            pd.payPlanRecord.due_date__c = System.today().addDays(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c) + Integer.valueOf(pd.payPlanRecord.Project__r.Days_from_Dt_of_Booking_for_NPV__c));
                        }
                        pd.payPlanRecord.Is_To_be__c = pd.payPlanRecord.Days_Months__c + ' ' +  pd.payPlanRecord.Days_Months_Value__c + ' ' + pd.payPlanRecord.Is_to_be_Paid__c;                        
                    } 
                    else if(pd.payPlanRecord.Is_to_be_Paid__c.equals('Construction Stage')) {
                        Date completionDate = null;
                        Boolean IsMilestoneAchieved = False;
                        Project_Construction_Stages__c pStage = pstageMap.get(pd.payplanRecord.Project_Construction_Stages__c);
                        if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c > System.today())
                            completionDate = pStage.Actual_date_of_completion__c;
                        else if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c <= System.today()) {
                            completionDate = system.today();
                            IsMilestoneAchieved = True;
                        }    
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c > System.today())
                            completionDate = pStage.Planned_date_of_completion__c;
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c <= System.today())
                            completionDate = system.today();
                        // this may not right, but ideally the code shouldnt come in here if the data is set correctly. 
                        if (completionDate == null)
                            completionDate = system.today().addDays(365);
                        if(pd.payPlanRecord.Days_Months__c.equals('Month(s)')) {
                            pd.payPlanRecord.due_date__c = completionDate.addMonths(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));
                        } else if (pd.payPlanRecord.Days_Months__c.equals('Day(s)')) {
                            pd.payPlanRecord.due_date__c = completionDate.addDays(Integer.valueOf(pd.payPlanRecord.Days_Months_Value__c));
                        }
                        pd.payPlanRecord.Is_To_be__c = pd.payPlanRecord.Days_Months__c + ' ' +  pd.payPlanRecord.Days_Months_Value__c + ' after Stage: ' + pStage.Name;
                        ///Added by shailesh 27.1.17///
                        if(IsMilestoneAchieved)
                            pd.payPlanRecord.Is_Milestone_Achieved__c = True;
                        else
                            pd.payPlanRecord.Is_Milestone_Achieved__c = False;
                    }
                        
                    if(count==0) {
                        pd.payPlanRecord.is_To_be__c = 'Token Amount';
                        allChargesMap.put('TOKENAMOUNT', Amount);
                        allChargesMap.put('TOKEN TAX AMT',serviceTax);
                    }
                    count++;
                   // System.debug('pdList: Updated' + pd);
                    planDetailsWList.add(new PlanDetailWrapper(Amount.setscale(0,RoundingMode.HALF_UP),serviceTax.setscale(0,RoundingMode.HALF_UP), Amount+serviceTax, pd.payPlanRecord,taxMap));
        }
        // gist of what is being achieved below
        // when the agreement value is being broken up in individual milestones based on % of each milestone and 
        // rounding is carried out on each milestone value, 
        // the overall total of the individual milestones will not added to the original agreement value [may be a difference of few Rs]
        // the below code, finds out the difference, forces the final sum total to match the agreement value.
        // same logic is applied for the service tax as well.
        
       if(planDetailsWList.size() > 1) {
            if(math.abs(total.setscale(0,RoundingMode.HALF_UP) -av) <= 100) {
                planDetailWrapper pw = planDetailsWList[planDetailsWList.size() -1];
                if(total.setscale(0,RoundingMode.HALF_UP) > av) {
                   // System.debug('original total:' + total + 'original ms amt:' +  pw.amount);
                    Decimal orginalAmount = pw.amount;
                    pw.amount = pw.amount - (total.setscale(0,RoundingMode.HALF_UP) - av);
                    pw.PayPlanRecord.Amount_Value__c = (pw.amount  /av  *100).setscale(2,RoundingMode.HALF_UP);
                    pw.PayPlanRecord.Value__c = string.valueOf( pw.PayPlanRecord.Amount_Value__c ) + ' %';
                    pw.payPlanRecord.Milestone_Percentage__c = (pw.amount  /av  *100).setscale(5,RoundingMode.HALF_UP);
                    total = av;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Last milestone has been decreased to match the consideration value '));
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'  Original Value:' + orginalAmount +' Adjusted Amount:' + pw.amount));
                    //System.debug('updated total:' + total + 'pw.amount: ' + pw.amount + 'difference:' +  (total.setscale(0,RoundingMode.HALF_UP) - av) );
                } else if (total.setscale(0,RoundingMode.HALF_UP) < av) {
                    Decimal orginalAmount = pw.amount;
                    pw.amount = pw.amount + av - (total.setscale(0,RoundingMode.HALF_UP));
                    total = av;
                    pw.PayPlanRecord.Amount_Value__c = (pw.amount  /av  *100).setscale(2,RoundingMode.HALF_UP);
                    pw.PayPlanRecord.Value__c = string.valueOf( pw.PayPlanRecord.Amount_Value__c ) + ' %';
                    pw.payPlanRecord.Milestone_Percentage__c = (pw.amount  /av  *100).setscale(5,RoundingMode.HALF_UP);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Last milestone has been increased to match the consideration value '));
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'  Original Value:' + orginalAmount +' Adjusted Amount:' + pw.amount));
                } 
                
                
        // service tax calculations for GST
                Map<String,Decimal> taxMap = new Map<String,Decimal>();
                // if the amount of the last row has changed as part of conciling the totals,then recalculate the service taxes on that new amount.
                Decimal st = 0;
                for(Tax_Breakup__c tb: taxSlabMap.get(pw.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                     st = ((tb.Taxable_Percentage__c * pw.amount/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                     taxMap.put(tb.Tax_Name__c, st);
                     st += st;
                }
                pw.taxMap = taxMap;
                pw.servicetax = st;
            
                
                planDetailsWList.remove(planDetailsWList.size() -1);
                planDetailsWList.add(pw);
                Map<String,Decimal> taxMap1  = new Map<String,Decimal>();
                Decimal serviceTax1 = 0;
                Decimal stTotal = 0;
                for(String taxName: taxMap.keySet()) {
                    serviceTax1 = allChargesMap.get('AGREEMENTVALUE ' + taxName + ' TAX AMT').setscale(0,RoundingMode.HALF_UP);
                    taxMap1.put(taxName, serviceTax1);
                    stTotal += serviceTax1;
                }
                planDetailsWList.add(new PlanDetailWrapper(total.setscale(0,RoundingMode.HALF_UP),stTotal.setscale(0,RoundingMode.HALF_UP),total+stTotal, null, taxMap1));
            } else {
                if(total.setscale(0,RoundingMode.HALF_UP) > av) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There is an excess of Rs ' + (total.setscale(0,RoundingMode.HALF_UP) - av)));
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,' Excess amount in percentage ' + ((total.setscale(0,RoundingMode.HALF_UP) - av)/av*100).setscale(2,RoundingMode.HALF_UP) + ' %'));
                } else if (total.setscale(0,RoundingMode.HALF_UP) < av) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'There is an shortfall of Rs ' + (av - total.setscale(0,RoundingMode.HALF_UP) ) ) );
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Short amount in percentage ' + (((av - total.setscale(0,RoundingMode.HALF_UP))/av*100).setscale(2,RoundingMode.HALF_UP) + ' %') ) );
                } 
                planDetailsWList[planDetailsWList.size() -1].totalError = true;
                planDetailsWList.add(new PlanDetailWrapper(total.setscale(0,RoundingMode.HALF_UP),sTaxTotal.setscale(0,RoundingMode.HALF_UP), total+sTaxTotal, null, new Map<String,Decimal>()));
            }
        } 
        
        return  planDetailsWList;           
    }
    
    public static void insertCustomerPaymentPlan(List<PlanDetailWrapper> pwdList, Id planId, Project__c p, Project_Unit__c u, Opportunity o, quotation__c q, Map<String, Decimal> allChargesMap, String SubCharge){
        List<Payment_Plan__c> selectedSubventionPlan = [Select Subvention_Base_Rate__c,Sub_Vention__c from Payment_Plan__c where Id =: planId];
        List<Standard_Pay_Plan_Header__c> spphList = [Select Id, Name,Charge_Code__c,Charge_Code__r.Name , Charge_Code__r.Service_Tax_Percentage__c,Charge_Code__r.Subvention_Charge__c
                                                        from Standard_Pay_Plan_Header__c where Payment_Plan__c = :planId 
                                                        and Charge_Code__r.Name != 'Basic'];
        List<Global_Charges__c> globalChargesList =[select id,Name from Global_Charges__c];
        Map<String, Id> globalChargesMap = new Map<String,Id>();
        List<Customer_Pay_Plan_Header__c> cpphList = new List<Customer_Pay_Plan_Header__c>();
        List<Id> spphIdList = new List<Id>();
        
        //calculate service tax for each cost
        Map<String,List<Tax_Breakup__c>> taxSlabMap = getChildTaxSlabs();
                
        for(Global_Charges__c g : globalChargesList) {
            globalChargesMap.put(g.Name,g.Id);
        }
     //   System.debug('Opportunity o:' + o);
        for(Standard_Pay_Plan_Header__c spph : spphList) {
            
                Customer_Pay_Plan_Header__c  cpph = new Customer_Pay_Plan_Header__c();
                cpph.Standard_Pay_Plan_Header__c = spph.id;
                cpph.Global_Charges__c =  globalChargesMap.get(spph.Charge_Code__r.Name);
                cpph.Project__c = p.Id;
                cpph.Tower__c = u.TowerName__c;
                cpph.Project_Unit__c = u.Id;
                cpph.Effect_From_Date__c = system.today();
                cpph.PlanDt__c = system.today();
                cpph.Amount__c = allChargesMap.get(spph.Charge_Code__r.Name);
                if( allChargesMap.containsKey(spph.Charge_Code__r.Name + ' TOTAL TAX AMT'))
                    cpph.Service_Tax_Amount_Q__c = allChargesMap.get(spph.Charge_Code__r.Name + ' TOTAL TAX AMT');
                Decimal st = 0;
                Integer count = 1;
                if(String.isNotBlank(spph.Charge_Code__r.Service_Tax_Percentage__c) && taxSlabMap.containsKey(spph.Charge_Code__r.Service_Tax_Percentage__c)) {
                    for(Tax_Breakup__c tb: taxSlabMap.get(spph.Charge_Code__r.Service_Tax_Percentage__c)) {                  
                    st = ((tb.Taxable_Percentage__c * allChargesMap.get(spph.Charge_Code__r.Name)/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                         String fieldTaxName = 'Tax_Name_' + count + '__c';
                         String fieldTaxAmount = 'Tax_Amount_' + count + '__c';
                         String fieldTaxPercent = 'Tax_Percentage_' + count  + '__c';
                         cpph.put(fieldTaxName, tb.Tax_Name__c);
                         cpph.put(fieldTaxAmount, st);
                         cpph.put(fieldTaxPercent, tb.Tax_Percentage__c);
                         count++;
                    }
                    
            }
                cpph.Quotation__c = q.Id;
                cpphList.add(cpph);
                spphIdList.add(spph.Id);
            
        }
        List<Standard_Pay_Plan_Header__c> spphBasicList = [Select Id, Name,Charge_Code__c,Charge_Code__r.Name,Charge_Code__r.Service_Tax_Percentage__c 
                                                            from Standard_Pay_Plan_Header__c 
                                                            where Payment_Plan__c = :planId and Charge_Code__r.Name = 'Basic' LIMIT 1];
        Customer_Pay_Plan_Header__c  cpphBasic = new Customer_Pay_Plan_Header__c();
        cpphBasic.Standard_Pay_Plan_Header__c = spphBasicList[0].id;
        cpphBasic.Global_Charges__c =  globalChargesMap.get(spphBasicList[0].Charge_Code__r.Name);
        cpphBasic.Project__c = p.Id;
        cpphBasic.Tower__c = u.TowerName__c;
        cpphBasic.Project_Unit__c = u.Id;
        cpphBasic.Effect_From_Date__c = system.today();
        cpphBasic.PlanDt__c = system.today();
        cpphBasic.Amount__c = allChargesMap.get('AGREEMENTVALUE');
        if( allChargesMap.containsKey('AGREEMENTVALUE TAX AMT'))
                cpphBasic.Service_Tax_Amount_Q__c = allChargesMap.get('AGREEMENTVALUE TAX AMT');
        cpphBasic.Quotation__c = q.Id;
        cpphList.add(cpphBasic);
    Decimal st1 = 0;
        Integer count = 1;
        if(String.isNotBlank(spphBasicList[0].Charge_Code__r.Service_Tax_Percentage__c) && taxSlabMap.containsKey(spphBasicList[0].Charge_Code__r.Service_Tax_Percentage__c)) {
            for(Tax_Breakup__c tb: taxSlabMap.get(spphBasicList[0].Charge_Code__r.Service_Tax_Percentage__c)) {
                 st1 = ((tb.Taxable_Percentage__c * allChargesMap.get('AGREEMENTVALUE')/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                 String fieldTaxName = 'Tax_Name_' + count + '__c';
                 String fieldTaxAmount = 'Tax_Amount_' + count + '__c';
                 String fieldTaxPercent = 'Tax_Percentage_' + count  + '__c';
                 cpphBasic.put(fieldTaxName, tb.Tax_Name__c);
                 cpphBasic.put(fieldTaxAmount, st1);
                 cpphBasic.put(fieldTaxPercent, tb.Tax_Percentage__c);
                 count++;
            }
            
        }
        Database.SaveResult[] srList = Database.insert(cpphList);
        
        List<Id> cpphIdList = new List<Id>();
        for(Database.saveResult sr : srList) {
            if(sr.isSuccess()) {
                cpphIdList.add(sr.getId());
            }
        }
        
        List<Customer_Pay_Plan_Header__c> cpphInsertedList = new List<Customer_Pay_Plan_Header__c>();
        List<Customer_Pay_Plan_Header__c> cpphInsertedListBasic = new List<Customer_Pay_Plan_Header__c>();
        
        if(cpphIdList.size() >0 )  {
            cpphInsertedList = [SELECT Id, Amount__c, Global_Charges__r.Name, Global_Charges__c, quotation__r.Id, Standard_Pay_Plan_Header__r.Id 
                                                                                                        FROM Customer_Pay_PLan_Header__c
                                                                                                        WHERE Id in :cpphIdList and 
                                                                                                        Global_Charges__r.Name != 'Basic'];
                                                                                                        
            cpphInsertedListBasic = [SELECT Id, Amount__c, Global_Charges__r.Name, Global_Charges__c, quotation__r.Id, Standard_Pay_Plan_Header__r.Id 
                                                                                                        FROM Customer_Pay_PLan_Header__c
                                                                                                        WHERE Id in :cpphIdList and 
                                                                                                        Global_Charges__r.Name = 'Basic'];      
        }       
                                                                                        
        Map<Id,Customer_Pay_Plan_Header__c> scpphCPPHMap = new Map<Id,Customer_Pay_PLan_Header__c>();                                                                                           
        for(Customer_Pay_PLan_Header__c cpph : cpphInsertedList) {
            scpphCPPHMap.put(cpph.Standard_Pay_Plan_Header__r.Id, cpph);    
        }
        
        List<Standard_Customer_Pay_Plan_Detail__c> scppdList = new List<Standard_Customer_Pay_Plan_Detail__c>();
      //  System.debug('scppheader records:' + spphIdList);
        scppdList = [Select Name, Calculate_Installment_Amount_as__c, Amount__c, Amount_Value__c, Total_Charge_Value_Minus__c, On_date__c,OC_Milestone__c,
                            Project__c, Project__r.Id, Project_Construction_Stages__c, Value__c, Integer_Installment_No__c, Actual_Revise_Due_Date__c,
                            Standard_Pay_Plan_Header__c, Customer_Pay_Plan_Header__c, PayPlanIID__c, Days_Months_Value__c, Days_Months__c,Contribution_From__c,
                            Is_to_be__c, Inst_No__c, Installment_Number__c, Is_to_be_Paid__c, Deduct_Token__c, Installment__c, Due_Date__c, Registration_Linked__c,Is_Milestone_Achieved__c,
                            Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c,Add_Token_GST__c
                            FROM Standard_Customer_Pay_Plan_Detail__c
                            WHERE Standard_Pay_Plan_Header__c in :spphIdList
                            AND Customer_Pay_Plan_Header__c = null];

        
        Map<Id,List<Standard_Customer_Pay_Plan_Detail__c>> headerDetailMap = new Map<Id,List<Standard_Customer_Pay_Plan_Detail__c>>();
        for (Standard_Customer_Pay_Plan_Detail__c scppd : scppdList) {
            if(headerDetailMap.containsKey(scppd.Standard_Pay_Plan_Header__c)) {
                headerDetailMap.get(scppd.Standard_Pay_Plan_Header__c).add(scppd);
            }
            else {
                List<Standard_Customer_Pay_Plan_Detail__c> detailRecList = new List<Standard_Customer_Pay_Plan_Detail__c>();
                detailRecList.add(scppd);
                headerDetailMap.put(scppd.Standard_Pay_Plan_Header__c, detailRecList);
            }
        }
       
        Map<Id,Project_Construction_Stages__c> pstageMap = getConstructionStagesById(p.ID,u.TowerName__r.Id);   
        List<Standard_Customer_Pay_Plan_Detail__c> scppdNewList = new List<Standard_Customer_Pay_Plan_Detail__c>();
        
        // this inserts the pay plan detail record [child of customer pay plan header record.
        // the pay plan detail record templates are already there in the payment plan
        // we want to clone them again and put it under customer pay plan header
        // the actual installment amount will be put in the pay plan
        Decimal Amount = 0;
        String chargeCode;
        for(Id sId : headerDetailMap.keySet()) {
            for(Standard_Customer_Pay_Plan_Detail__c sc : headerDetailMap.get(sId)) {
           //   System.debug('Standaard Pay PLan Detail Template:' + sc);
                Standard_Customer_Pay_Plan_Detail__c scNew = new Standard_Customer_Pay_Plan_Detail__c();
                    scNew.Amount__c = sc.Amount__c;
                    scNew.Calculate_Installment_Amount_as__c = sc.Calculate_Installment_Amount_as__c;
                    scNew.Amount_Value__c = sc.Amount_Value__c;
                    scNew.Total_Charge_Value_Minus__c = sc.Total_Charge_Value_Minus__c;
                    scNew.On_date__c = sc.On_date__c;
                    scNew.Project__c = sc.Project__r.Id;
                    scNew.Project_Construction_Stages__c = sc.Project_Construction_Stages__c;
                    scNew.Is_to_be__c = sc.Is_to_be__c;
                    scNew.Is_to_be_Paid__c = sc.Is_to_be_Paid__c;
                    scNew.Customer_Pay_Plan_Header__c = scpphCPPHMap.get(sc.Standard_Pay_Plan_Header__c).Id;
                    scNew.Standard_Pay_Plan_Header__c = sc.Standard_Pay_Plan_Header__c;
                    scNew.Days_Months_Value__c = sc.Days_Months_Value__c;
                    scNew.Days_Months__c = sc.Days_Months__c;
                    scNew.Inst_No__c = sc.Inst_No__c;
                    scNew.Installment_Number__c = sc.Installment_Number__c;
                    scNew.Tower__C = u.TowerName__c;
                    scNew.Registration_Linked__c = sc.Registration_Linked__c;
                    scNew.Is_Milestone_Achieved__c = sc.Is_Milestone_Achieved__c;
                    scNew.Add_Token_GST__c = sc.Add_Token_GST__c;
                    if(sc.Amount__c.equals('Percentage') && sc.Total_Charge_Value_Minus__c == null ) {
                        Amount = ((sc.Amount_Value__c * scpphCPPHMap.get(sc.Standard_Pay_Plan_Header__c).Amount__c)/100).setscale(0,RoundingMode.HALF_UP);
                        scNew.Value__c = String.valueOf(sc.Amount_Value__c);
                        scNew.Installment__c = Amount;
                    } else if(sc.Amount__c.equals('Percentage') && sc.Total_Charge_Value_Minus__c != null) {
                        Amount = ((sc.Amount_Value__c * scpphCPPHMap.get(sc.Standard_Pay_Plan_Header__c).Amount__c)/100 - sc.Total_Charge_Value_Minus__c).setscale(0,RoundingMode.HALF_UP);
                        scNew.Amount_Value__c = scNew.Calculate_Installment_Amount_as__c;
                        scNew.Value__c = String.valueOf(sc.Amount_Value__c) + ' - ' + String.valueOf(sc.Total_Charge_Value_Minus__c);
                        scNew.Installment__c = Amount;
                    } 
                    else if(sc.Amount__c.equals('Amount') && sc.Total_Charge_Value_Minus__c == null) {
                        Amount = (sc.Amount_Value__c).setscale(0,RoundingMode.HALF_UP);
                        scNew.Value__c =  String.valueOf(sc.Amount_Value__c);
                        scNew.Installment__c = Amount;
                    } else if(sc.Amount__c.equals('Amount') && sc.Total_Charge_Value_Minus__c != null) {
                        Amount = ((sc.Calculate_Installment_Amount_as__c * scpphCPPHMap.get(sc.Standard_Pay_Plan_Header__c).Amount__c)/100 - sc.Total_Charge_Value_Minus__c).setscale(0,RoundingMode.HALF_UP);
                        scNew.Value__c = String.valueOf(scNew.Amount_Value__c) + '- ' + String.valueOf(scNew.Total_Charge_Value_Minus__c);
                        scNew.Installment__c = Amount;
                    }
                    if(sc.Is_to_be_Paid__c.equals('From Dt. of Booking')) {
                        if(sc.Days_Months__c.equals('Month(s)')) {
                          if(Integer.valueOf(sc.Days_Months_Value__c) != 0){
                             //// scNew.due_date__c = System.today().addMonths(Integer.valueOf(sc.Days_Months_Value__c));  ///// Commented by vikas
                             scNew.due_date__c = System.today().addMonths(Integer.valueOf(sc.Days_Months_Value__c));  ////// Including booking date
                             scNew.due_date__c = sc.due_date__c.addDays(-1);
                          }
                          else{
                             scNew.due_date__c = System.today().addMonths(Integer.valueOf(sc.Days_Months_Value__c));
                          }
                        } else if (sc.Days_Months__c.equals('Day(s)')) {
                           if(Integer.valueOf(sc.Days_Months_Value__c) != 0){
                              //// scNew.due_date__c = System.today().addDays(Integer.valueOf(sc.Days_Months_Value__c));
                              scNew.due_date__c = System.today().addDays(Integer.valueOf(sc.Days_Months_Value__c - 1));
                           }
                           else{
                              scNew.due_date__c = System.today().addDays(Integer.valueOf(sc.Days_Months_Value__c));
                           }
                        }
                    } else if(sc.Is_to_be_Paid__c.equals('Construction Stage')) {
                        Date completionDate = null;
                        Project_Construction_Stages__c pStage = pstageMap.get(sc.Project_Construction_Stages__c);
                            
                        if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c > System.today())
                            completionDate = pStage.Actual_date_of_completion__c;
                        else if(pStage.Actual_date_of_completion__c != null && pStage.Actual_date_of_completion__c <= System.today())
                            completionDate = system.today();
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c > System.today())
                            completionDate = pStage.Planned_date_of_completion__c;
                        else if(pStage.Planned_date_of_completion__c != null && pStage.Planned_date_of_completion__c <= System.today())
                            completionDate = system.today();
                            
                        if(completionDate != null) {
                            if(sc.Days_Months__c.equals('Month(s)')) {
                                scNew.due_date__c = completionDate.addMonths(Integer.valueOf(sc.Days_Months_Value__c));
                            } else if (sc.Days_Months__c.equals('Day(s)')) {
                                scNew.due_date__c = completionDate.addDays(Integer.valueOf(sc.Days_Months_Value__c));
                            }
                        }
                    }
                    scNew.Due_Date_on_Quote__c = scNew.Due_Date__c;
                    chargeCode  = scpphCPPHMap.get(sc.Standard_Pay_Plan_Header__c).Global_Charges__r.Name;
                                       // service tax calculations for GST
                    
                    Decimal st = 0;
                    Integer count1 = 1;
                    if(String.isNotBlank(sc.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c) && taxSlabMap.containsKey(sc.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                        for(Tax_Breakup__c tb: taxSlabMap.get(sc.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                             st = ((tb.Taxable_Percentage__c * scNew.Installment__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                             String fieldTaxName = 'Tax_Name_' + count1 + '__c';
                             String fieldTaxAmount = 'Tax_Amount_' + count1 + '__c';
                             scNew.put(fieldTaxName, tb.Tax_Name__c);
                             scNew.put(fieldTaxAmount, st);
                             count1++;
                             st +=st;
                        }
                        
                        scNew.Service_Tax_Amount_Q__c = st;
             }  
                    //System.debug('Other charges list:' + scNew);
                scppdNewList.add(scNew);
            }
            Amount = 0;
        }
        // for inserting the basic [flat cost] payment plan records, 
        // we need to go over the wrapper records, which has been edited by the user and 
        // insert the edited values as payment milestones in the database 
        Decimal t =0;
        for(PlanDetailWrapper pd : pwdList) {
            Standard_Customer_Pay_Plan_Detail__c scNewB = new Standard_Customer_Pay_Plan_Detail__c();

            scNewB.Amount__c = pd.PayPlanRecord.Amount__c;
            scNewB.Amount_Value__c = pd.PayPlanRecord.Amount_Value__c;
            scNewB.Calculate_Installment_Amount_as__c = null;
            scNewB.Installment__c = pd.amount;
            scNewB.Service_Tax_Amount_Q__c = pd.serviceTax;
            scNewB.On_date__c = pd.PayPlanRecord.On_date__c;
            scNewB.Project__c = pd.PayPlanRecord.Project__c;
            scNewB.Project_Construction_Stages__c = pd.PayPlanRecord.Project_Construction_Stages__c;
            scNewB.Is_to_be__c = pd.PayPlanRecord.Is_to_be__c;
            scNewB.Is_to_be_Paid__c = pd.PayPlanRecord.Is_to_be_Paid__c;
            scNewB.Customer_Pay_Plan_Header__c = cpphInsertedListBasic[0].Id;
            scNewB.Standard_Pay_Plan_Header__c = cpphInsertedListBasic[0].Standard_Pay_Plan_Header__r.Id;
            scNewB.Days_Months_Value__c = pd.PayPlanRecord.Days_Months_Value__c;
            scNewB.Days_Months__c = pd.PayPlanRecord.Days_Months__c;
            //scNewB.Inst_No__c = pd.PayPlanRecord.Installment_Number__c;
            scNewB.Inst_No__c = string.valueOf(count);
            scNewB.Installment_Number__c = pd.PayPlanRecord.Installment_Number__c;
            scNewB.Due_Date__c = pd.PayPlanRecord.Due_Date__c;
            scNewB.Due_Date_on_Quote__c = scNewB.Due_Date__c;
            scNewB.Tower__C = u.TowerName__c;
            scNewB.Deduct_Token__c = false;
            scNewB.Registration_Linked__c = pd.PayplanRecord.Registration_Linked__c;
            scNewB.Milestone_Percentage__c = pd.PayplanRecord.Milestone_Percentage__c;
            scNewB.Is_Milestone_Achieved__c = pd.PayplanRecord.Is_Milestone_Achieved__c;
            scNewB.Add_Token_GST__c = pd.PayplanRecord.Add_Token_GST__c;
        if(selectedSubventionPlan[0].Sub_Vention__c){
                 scNewB.OC_Milestone__c = pd.PayplanRecord.OC_Milestone__c;
                 scNewB.Contribution_From__c = pd.PayplanRecord.Contribution_From__c;
        }    
            Decimal st = 0;
            System.debug('taxSlabMap:' + taxSlabMap);
            System.debug('pd taxname:' + pd.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c);
            Integer count2 = 1;
            if(String.isNotBlank(pd.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c) && taxSlabMap.containsKey(pd.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                for(Tax_Breakup__c tb: taxSlabMap.get(pd.payPlanRecord.Standard_Pay_Plan_Header__r.Charge_Code__r.Service_Tax_Percentage__c)) {
                     st = ((tb.Taxable_Percentage__c * scNewB.Installment__c/100) * tb.Tax_Percentage__c/100).setscale(0,RoundingMode.HALF_UP);
                     String fieldTaxName = 'Tax_Name_' + count2 + '__c';
                     String fieldTaxAmount = 'Tax_Amount_' + count2 + '__c';
                     scNewB.put(fieldTaxName, tb.Tax_Name__c);
                     scNewB.put(fieldTaxAmount, st);
                     count2++;
                     st +=st;
                }
            }
        if(taxSlabMap.containsKey('TDS')){
                  //system.debug('cv amount::: '+allChargesMap.get('AGREEMENTVALUE'));
                  if(allChargesMap.get('AGREEMENTVALUE') > 5000000)
                    scNewB.TDS__c = ((taxSlabMap.get('TDS')[0].Tax_Percentage__c * pd.amount)/100).setscale(0,RoundingMode.HALF_UP);
                  else
                    scNewB.TDS__c = 0;
            }
          
            scppdNewList.add(scNewB);
        }
        //save all the pay plan detail records into the database.
        
       Database.SaveResult[] srList1 = Database.insert(scppdNewList);
    }
    
    // calculate NPV of the money based on the payment plan
    public static Decimal calculateNPV(List<planDetailWrapper> pwList , Id projId){
            Decimal NPV = 0.0;
            Decimal NPVDayRate = 0;
            Integer daysBetween =0; 
            Decimal NPVofMoney = 0.0;
            Decimal TotalNPV = 0.0;
            List<Project__c> p = [Select Id, Address__c, Total_Max_Discount_Allowed__c, NPV__c , Name from Project__c where Id =: projId ];         
            if(p.size() == 1) {
                NPV = p[0].NPV__c;
                NPVDayRate = (NPV/365/100).setscale(18, RoundingMode.HALF_UP) + 1;
            }
           // System.debug('NPV:' + NPV + NPVDayRate);
            if(NPV != 0) {
                for(PlanDetailWrapper pw : pwList) {
                    NPVOfMoney =  0.0;
                 //   System.debug('plan wrapper list:' + pw);
                    if(pw.payPlanRecord.Due_Date__c != null) {
                        daysBetween = system.today().DaysBetween(pw.payPlanRecord.Due_Date__c);
                        /// System.debug('Days between:' + daysBetween);
                        NPVofMoney = pw.amount/NPVDayRate.pow(daysBetween);
                      //  System.debug('NPV of money:' + NPVOfMoney);
                        TotalNPV = TotalNPV + NPVofMoney;
                    }
                }
              //  System.debug('Total NPV:' + TotalNPV);
            
            }
            return (TotalNPV.setscale(0,RoundingMode.HALF_UP));
    }
    // query the discounts defined at project level and put in a wrapper 
    public static List<DiscountWrapper> getProjectLevelDiscounts(Id pId, Id uId) {
      /*  List<Project_Unit__c> pd = [Select Id, Actual_Area_value__c,
                                       Discount1_Type__c,Discount2_Type__c,Discount3_Type__c,Discount4_Type__c, 
                                       Discount5_Type__c,Discount6_Type__c,Discount7_Type__c,Discount8_Type__c, Discount9_Type__c,
                                       Discount1_Per_Sq_Ft__c, Discount2_Per_Sq_Ft__c,Discount3_Per_Sq_Ft__c,Discount4_Per_Sq_Ft__c,
                                       Discount5_Per_Sq_Ft__c, Discount6_Per_Sq_Ft__c,Discount7_Per_Sq_Ft__c,Discount8_Per_Sq_Ft__c,Discount9_Per_Sq_Ft__c,
                                       Discount8_Description__c, Discount9_Description__c  
                                           from Project_Unit__c where Id = :uId]; */
                                           
          List<Project__c> pd = [Select Id, 
                                       Discount1_Type__c,Discount2_Type__c,Discount3_Type__c,Discount4_Type__c, 
                                       Discount5_Type__c,Discount6_Type__c,Discount7_Type__c,Discount8_Type__c, Discount9_Type__c,
                                       Discount1_Per_Sq_Ft__c, Discount2_Per_Sq_Ft__c,Discount3_Per_Sq_Ft__c,Discount4_Per_Sq_Ft__c,
                                       Discount5_Per_Sq_Ft__c, Discount6_Per_Sq_Ft__c,Discount7_Per_Sq_Ft__c,Discount8_Per_Sq_Ft__c,Discount9_Per_Sq_Ft__c,
                                       Discount8_Description__c, Discount9_Description__c  
                                           from Project__c where Id = :pId];                                
        Project_unit__c u = getUnitDetails(uId);
        List<DiscountWrapper> dwList = new List<DiscountWrapper>();
        if(pd.size() == 1) {
            if(pd[0].Discount1_Per_Sq_Ft__c != 0 && pd[0].Discount1_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount1_Per_Sq_Ft__c;
               // Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw1 = new DiscountWrapper(pd[0].Discount1_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw1);
            } 
            
            if(pd[0].Discount2_Per_Sq_Ft__c != 0 && pd[0].Discount2_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount2_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw2 = new DiscountWrapper(pd[0].Discount2_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw2);
            } 
            
            if(pd[0].Discount3_Per_Sq_Ft__c != 0 && pd[0].Discount3_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount3_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw3 = new DiscountWrapper(pd[0].Discount3_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw3);
            } 
            
            if(pd[0].Discount4_Per_Sq_Ft__c != 0 && pd[0].Discount4_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount4_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw4 = new DiscountWrapper(pd[0].Discount4_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw4);
            } 
            
            if(pd[0].Discount1_Per_Sq_Ft__c != 0 && pd[0].Discount5_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount5_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw5 = new DiscountWrapper(pd[0].Discount5_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw5);
            } 
            
            if(pd[0].Discount6_Per_Sq_Ft__c != 0 && pd[0].Discount6_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount6_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw6 = new DiscountWrapper(pd[0].Discount6_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw6);
            } 
            
            if(pd[0].Discount7_Per_Sq_Ft__c != 0 && pd[0].Discount7_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount7_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw7 = new DiscountWrapper(pd[0].Discount7_Type__c,  psfVal, lumpsumVal, false, false, false, 'Customer Type');
                dwList.add(dw7);
            } 
            
            if(pd[0].Discount8_Per_Sq_Ft__c != 0 && pd[0].Discount8_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount8_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw8 = new DiscountWrapper( pd[0].Discount8_Description__c ,psfVal, lumpsumVal, true, false, false, pd[0].Discount8_Type__c);
                dwList.add(dw8);
            } 
            
            if(pd[0].Discount9_Per_Sq_Ft__c != 0 && pd[0].Discount9_Per_Sq_Ft__c != null) {
                Decimal psfVal = pd[0].Discount9_Per_Sq_Ft__c;
                //Decimal lumpsumVal = (psfVal * pd[0].Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                Decimal lumpsumVal = (psfVal * u.Actual_Area_value__c).setscale(0,RoundingMode.HALF_UP);
                DiscountWrapper dw9 = new DiscountWrapper( pd[0].Discount9_Description__c ,psfVal, lumpsumVal, true, false, false, pd[0].Discount9_Type__c);
                dwList.add(dw9);
            } 
            dwList.add(new DiscountWrapper('SCUD',0.0, 0.0,true,false,false,'SCUD') );
            dwList.add(new DiscountWrapper('Total Discount',0.0, 0.0,false,false,true,'Total') );
         //   System.debug('Discount List:' + dwList);
            
        } else {
            return null;
        }
        
        return dwList;
    }
  
    public class PlanDetailWrapper {
        public Decimal amount  {get; set;}
        public Decimal serviceTax  {get; set;}
        public Decimal totalPay  {get; set;}
        public Standard_Customer_Pay_Plan_Detail__c payPlanRecord {get; set;}
        public boolean totalError  {get; set;}
        public Map<String,Decimal> taxMap {get; set;}
        public PlanDetailWrapper(Decimal amount,  Decimal serviceTax, Standard_Customer_Pay_Plan_Detail__c payPlanRecord) {
            this.amount = amount.setscale(0,RoundingMode.HALF_UP);
            this.serviceTax  = serviceTax.setscale(0,RoundingMode.HALF_UP);
            this.PayPlanRecord = payPlanRecord;
            if(totalPay != null)
                this.totalPay = totalPay.setscale(0,RoundingMode.HALF_UP);
            this.totalError = false;
        }
        public PlanDetailWrapper(Decimal amount,  Decimal serviceTax, Decimal totalPay,Standard_Customer_Pay_Plan_Detail__c payPlanRecord, Map<String,Decimal> taxMap) {
            this.amount = amount.setscale(0,RoundingMode.HALF_UP);
            this.serviceTax  = serviceTax.setscale(0,RoundingMode.HALF_UP);
            this.PayPlanRecord = payPlanRecord;
            if(totalPay != null)
                this.totalPay = totalPay.setscale(0,RoundingMode.HALF_UP);
            this.totalError = false;
            this.taxMap = new Map<String,Decimal>();
            this.taxMap = taxMap;
        }
        
        public PlanDetailWrapper(Decimal amount,  Decimal serviceTax, Decimal totalPay, Standard_Customer_Pay_Plan_Detail__c payPlanRecord, Boolean totalError) {
            this.amount = amount.setscale(0,RoundingMode.HALF_UP);
            this.serviceTax  = serviceTax.setscale(0,RoundingMode.HALF_UP);
            if(totalPay != null)
                this.totalPay = totalPay.setscale(0,RoundingMode.HALF_UP);
            this.PayPlanRecord = payPlanRecord;
            this.totalError = totalError;
        }
        
    }
    public class DiscountWrapper {
        public String type {get;set;}
        public Decimal perSqFtVal {get;set;}
        public Decimal lumpsumVal {get;set;}
        public String  SperSqFtVal {get;set;}
        public String  SlumpsumVal {get;set;}
        public Boolean psf {get;set;}
        public Boolean lumpsum {get;set;}
        public Boolean applied {get;set;}
        public String discountType {get;set;}
        public Boolean selected {get;set;}
        public Decimal perSqFtMax {get;set;}
        
        public DiscountWrapper(String type, Decimal perSqFtVal, Decimal lumpsumVal, Boolean psf, Boolean lumpsum, Boolean Applied, String discountType) {
            this.type = type;
            this.perSqFtVal = perSqFtVal.setscale(0,RoundingMode.HALF_UP);
            this.lumpsumVal = lumpsumVal.setscale(0,RoundingMode.HALF_UP);
           // this.SperSqFtVal = QuotationManagementServices.INFormat(perSqFtVal);
            //this.SlumpsumVal = QuotationManagementServices.INFormat(lumpsumVal);
            this.psf = psf;
            this.lumpsum = lumpsum;
            this.applied = applied;
            this.discountType = discountType;
            this.selected = false;
            this.PerSqftMax = perSqFtVal;
        }
    }
}