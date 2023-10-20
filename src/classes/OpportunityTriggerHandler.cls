public class OpportunityTriggerHandler {
    //====================================================================================================================
    // This function check the Project Unit status Vacant or not if not than throw error.
    //====================================================================================================================  
    public void insertBefore(List < Opportunity > lstOpp) {
        Set < Id > setIdofProjUnit = new Set < Id > ();

        if (lstOpp.size() > 0) {
            for (Opportunity eachOpp: lstOpp) {
                if (eachOpp.Project_Unit__c != null)
                    setIdofProjUnit.add(eachOpp.Project_Unit__c);
                if (eachOpp.Page_Running__c == true)
                    return;
            }
        }

        if (setIdofProjUnit.size() > 0) {
            List < Project_Unit__c > lstProjUnit = [Select Id, Customers__c, Unit_Status__c from Project_Unit__c Where Id IN: setIdofProjUnit];
            if (lstProjUnit.size() > 0) {
                for (Opportunity eachOpp: lstOpp) {
                    for (Project_Unit__c eachProjUnit: lstProjUnit) {
                        if (eachOpp.Project_Unit__c == eachProjUnit.Id && eachProjUnit.Unit_Status__c != null) {
                            if (eachOpp.Project_Unit__c == eachProjUnit.Id && eachProjUnit.Unit_Status__c != 'Vacant' && !Test.isRunningTest()) {
                                eachOpp.Project_Unit__c.addError('This Project Unit is not Vacant, please choose other one. Before Insert.');
                            }
                        }
                    }
                }
            }
        }
    }

    //====================================================================================================================
    // This function change the status of Project Unit and create new record in Unit Event History object.
    //====================================================================================================================
    public void insertAfter(List < Opportunity > lstOpp) {
        Set < Id > setIdofProjUnit = new Set < Id > ();
        Set < Id > setofOppId = new Set < Id > ();
        if (lstOpp.size() > 0) {
            for (Opportunity eachOpp: lstOpp) {
                if (eachOpp.Project_Unit__c != null) {
                    setIdofProjUnit.add(eachOpp.Project_Unit__c);
                    setofOppId.add(eachOpp.Id);
                    if (eachOpp.Page_Running__c == true)
                        return;
                }
            }
        }

        if (setofOppId.size() > 0) {
            List < Project_Unit__c > lstProjUnittoUpdate = [Select Id, Unit_Status__c, Customers__c from Project_Unit__c Where ID IN: setIdofProjUnit AND(Unit_Status__c = NULL OR Unit_Status__c = 'Vacant')];

            List < Opportunity > lstOpptoUpdate = new List < Opportunity > ();
            List < Unit_Event_History__c > lstUnitEventHistoryNew = new List < Unit_Event_History__c > ();

            if (lstOpp.size() > 0) {
                for (Opportunity eachOpp: lstOpp) {
                    if (eachOpp.Duplicate_Project_Unit_Request__c != false)
                        eachOpp.Duplicate_Project_Unit_Request__c = false;

                    if (lstProjUnittoUpdate.size() > 0) {
                        for (Project_Unit__c eachProjUnit: lstProjUnittoUpdate) {
                            if (eachOpp.Project_Unit__c == eachProjUnit.Id) {
                                eachProjUnit.Customers__c = eachOpp.Id;
                                eachProjUnit.Unit_Status__c = 'Hold';
                                if (eachProjUnit.Unit_Status__c == 'Hold') {
                                    Unit_Event_History__c objUnitEventHis = new Unit_Event_History__c();
                                    objUnitEventHis.Customer__c = eachOpp.Id;
                                    objUnitEventHis.Project_Unit__c = eachOpp.Project_Unit__c;
                                    objUnitEventHis.Event__c = eachProjUnit.Unit_Status__c;
                                    objUnitEventHis.Effective_Date__c = Date.today();
                                    objUnitEventHis.Created_Date__c = Date.today();
                                    objUnitEventHis.Remarks__c = 'Project Unit has been blocked';
                                    //objUnitEventHis.Booking__c = '';             //Not Create the value in Booking.

                                    lstUnitEventHistoryNew.add(objUnitEventHis);
                                }
                            }
                        }
                    }
                }

                if (lstProjUnittoUpdate.size() > 0) {
                    update lstProjUnittoUpdate;
                    if (lstUnitEventHistoryNew.size() > 0) {
                        insert lstUnitEventHistoryNew;
                    }
                }
            }
        }
    }

    //====================================================================================================================
    // This function check the Project Unit Status and throw error if not vacant. 
    // It create Unit Event History record.
    // It maintain the functionality of Approval as same for Old Project Unit request.
    //====================================================================================================================
    public void beforeUpdate(List < Opportunity > lstOpp, Map < Id, Opportunity > mapOldOppId) {
        Set < Id > setIdofProjUnit = new Set < Id > ();
        Set < Id > setofOppId = new Set < Id > ();
        if (lstOpp.size() > 0) {
            for (Opportunity eachOpp: lstOpp) {
                if (eachOpp.Project_Unit__c != null && eachOpp.Physical_document_received__c == true && mapOldOppId.get(eachOpp.Id).Physical_document_received__c == false) {
                    eachOpp.Date_Of_Form_Receipt_From_Sales_Team__c = system.today();
                } else {
                    setIdofProjUnit.add(eachOpp.Project_Unit__c);
                    setofOppId.add(eachOpp.Id);
                    if (eachOpp.Page_Running__c == true)
                        return;
                }
            }
        }

        if (setofOppId.size() > 0) {
            List < Project_Unit__c > lstProjUnittoUpdate = new List < Project_Unit__c > ();
            List < Project_Unit__c > lstProjUnit = [Select Id, Customers__r.Duplicate_Project_Unit_Request__c, Customers__r.Reassign_Approval__c, Unit_Status__c, Customers__c from Project_Unit__c Where Id IN: setIdofProjUnit OR Customers__c IN: setofOppId];
            List < Unit_Event_History__c > lstUnitEventHistoryNew = new List < Unit_Event_History__c > ();
            if (lstOpp.size() > 0) {
                for (Opportunity eachOpp: lstOpp) {
                    if (lstProjUnit.size() > 0) {
                        for (Project_Unit__c eachProjUnit: lstProjUnit) {
                            if (eachOpp.Project_Unit__c != mapOldOppId.get(eachOpp.Id).Project_Unit__c && eachProjUnit.Customers__c != eachOpp.Id && (eachProjUnit.Unit_Status__c == 'Hold' || eachProjUnit.Unit_Status__c == 'Booked' || eachProjUnit.Unit_Status__c == 'Cancelled' || eachProjUnit.Unit_Status__c == 'Sold') && eachOpp.Release_Unit__c != true) {
                                eachOpp.Project_Unit__c.addError('This Project Unit is not Vacant, please choose other one. Before Update.');
                            } else if (eachProjUnit.Id != mapOldOppId.get(eachOpp.Id).Project_Unit__c && eachOpp.Duplicate_Project_Unit_Request__c != true && (eachProjUnit.Unit_Status__c == null || eachProjUnit.Unit_Status__c == 'Vacant') && eachOpp.Release_Unit__c != true) {
                                eachProjUnit.Unit_Status__c = 'Hold';
                                eachProjUnit.Customers__c = eachOpp.Id;

                                //Updating the Unit Status and Customer of Project Unit and inserting the new Evnet History
                                if (eachProjUnit.Unit_Status__c == 'Hold') {
                                    Unit_Event_History__c objUnitEventHis = new Unit_Event_History__c();
                                    objUnitEventHis.Project_Unit__c = eachProjUnit.Id;
                                    objUnitEventHis.Event__c = eachProjUnit.Unit_Status__c;
                                    objUnitEventHis.Effective_Date__c = Date.today();
                                    objUnitEventHis.Customer__c = eachOpp.Id;

                                    objUnitEventHis.Created_Date__c = Date.today();
                                    objUnitEventHis.Remarks__c = 'Project Unit has been blocked';
                                    //objUnitEventHis.Booking__c = '';                // Not create the value of booking

                                    lstUnitEventHistoryNew.add(objUnitEventHis);
                                }
                            }
                        }
                    }
                }
            }
            if (lstUnitEventHistoryNew.size() > 0) {
                insert lstUnitEventHistoryNew;
            }
            if (lstProjUnit.size() > 0) {
                update lstProjUnit;
            }
        }
    }

    public void AfterUpdate(List < Opportunity > lstOpp, Map < Id, Opportunity > mapOldOppId) {
        Set < Id > setIdofProjUnit1 = new Set < Id > ();
        if (lstOpp.size() > 0) {
            for (Opportunity eachOpp: lstOpp) {
                if (eachOpp.Project_Unit__c != null && eachOpp.Physical_document_received__c == true && mapOldOppId.get(eachOpp.Id).Physical_document_received__c == false)
                    setIdofProjUnit1.add(eachOpp.Project_Unit__c);
            }

            list < Project_Unit__c > lstPU = [select id, Unit_Status__c from Project_Unit__c where id in : setIdofProjUnit1];

            if (lstPU != null && lstPU.size() > 0) {
                for (Opportunity eachOpp: lstOpp) {
                    if (lstPU[0].Unit_Status__c != 'BIP - Sales' && eachOpp.Physical_document_received__c == true && mapOldOppId.get(eachOpp.Id).Physical_document_received__c == false) {
                        eachOpp.Physical_document_received__c.addError('Project Unit status must be "BIP - Sales" to select this checkbox');
                    } else if (eachOpp.Physical_document_received__c == true && mapOldOppId.get(eachOpp.Id).Physical_document_received__c == false) {
                        lstPU[0].Unit_Status__c = 'BIP - RM Verification';
                    }

                }
                update lstPU;
            }
        }
    }
} // End of Class