public class trgReceiptHandler {
	public String ReceiptId {
		get;
		set;
	}
	public string IsProcessToErp {
		get;
		set;
	}
	public string GblchrgBasicServiceTaxId {
		get;
		set;
	}
	public string GblchrgPLCandOthersServiceTaxId {
		get;
		set;
	}
	public String ProjectUnitId {
		get;
		set;
	}
	public String CustomerStatus {
		get;
		set;
	}

	public boolean IsProcessed {
		get;
		set;
	}
	public boolean candishonour {
		get;
		set;
	}
	public boolean status {
		get;
		set;
	}
	public boolean checkFirstReceipt {
		get;
		set;
	}
	public boolean CheckIsServiceTaxCalculate {
		get;
		set;
	}
	public boolean IsErrorinReceipt {
		get;
		set;
	}
	public boolean IsLedgerCreated {
		get;
		set;
	}

	public Receipt__c Receipt {
		get;
		set;
	}

	public List < Receipt__c > lstReceiptCheckProjUnit {
		get;
		set;
	}
	public List < Global_Charges__c > lstGblchrgBasicServiceTax {
		get;
		set;
	}
	public List < Global_Charges__c > lstGblchrgPLCandOthersServiceTax {
		get;
		set;
	}
	public List < Project_Charges__c > lstProjchrgBasicServiceTax {
		get;
		set;
	}
	public List < Project_Charges__c > lstProjchrgPLCandOthersServiceTax {
		get;
		set;
	}

	public trgReceiptHandler() {
		IsProcessed = false;
		checkFirstReceipt = false;

		Receipt = new Receipt__c();
		lstGblchrgBasicServiceTax = new List < Global_Charges__c > ();
		lstGblchrgPLCandOthersServiceTax = new List < Global_Charges__c > ();
		lstProjchrgBasicServiceTax = new List < Project_Charges__c > ();
		lstProjchrgPLCandOthersServiceTax = new List < Project_Charges__c > ();


		status = false;
	}

	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// When cheque is rejected after banking, the ledger enteries are reversed and dishonor penalty is applied.
	public void dishonour(Id ReceiptId)
    {
        try
        {
            string Receiptname = '';
            List<Ledger__C> lstledger2 = [select id from Ledger__c where Reciepts__c =: ReceiptId];
            List<Ledger__C> lstledger3 = new List<Ledger__c>();
            List<Receipt__c> LstRec = [select id,Opportunity__c,Opportunity__r.Project_Unit__C, 
            										Receipt_Date__c, Project__r.Cheque_Dishonour__c,
            									Project_Unit__c,name,Reason_for_rejection_new__c, 
            									Receipt_Status__c, Banking__c, Receipt_Number__c 
            									from Receipt__c where id =: ReceiptId];
           	receipt = lstRec[0];             

            if(lstledger2.size() > 0)
            {
                for(Ledger__C ledger : lstledger2)
                {
                    ledger.Remarks__c = 'Receipt No : ' + lstRec[0].Receipt_Number__c + ': Dishonored on ' + system.now().format('dd/MM/yyyy') + ' due to ' + Receipt.Banking__c + ' From Sales System';
                    lstledger3.add(ledger);
                }    
                update lstledger3;
            }
            
            List<Receipt_Details__c> lstreceiptdetail = [select id,Charges__r.Charge_Code__c, Charges__r.Charge_Code__r.Id,
            							Amount__c,Standard_Customer_Pay_Plan_Detail__c,
            							Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c,Is_Cheque_Dishonour__c,
            							Is_Interest_Settlement__c,Is_Advanced_Demand__c,
            							Project__r.Cheque_Dishonour__c,Demand_Invoice__c,
            							Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c,
            							Receipts__r.Booking__c, Is_Interest_Settlement_ST__c
            							from Receipt_Details__c where Receipts__c =: ReceiptId];
           	List<Ledger__c> reversalList = [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, Global_Charges__c,Global_Charges__r.Name,
											Standard_Customer_Pay_Plan_Detail__c,Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Paid__c,Receipt_Details__c,
											Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c, Customer_Pay_Plan_Header__c, 
											receipt_details__r.Is_advanced_demand__c, Opportunity__r.Id, Demand_Invoice__C
											from Ledger__c where Reciepts__c =: ReceiptId and Debit_Credit__c = 'Credit'];
           	
            Map<Id,List<Ledger__c>> scppdLedgerMap = new Map<Id,List<Ledger__c>>();
            Map<Id,List<Ledger__c>> cpphLedgerMap = new Map<Id,List<Ledger__c>>();
            Map<Id, Ledger__c> receiptDetailLedgerMap = new Map<Id, Ledger__c>();
            
            if(reversalList.size() > 0) {
            	for(Ledger__c l : reversalList) {
            		if(scppdLedgerMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Id)) {
            			scppdLedgerMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Id).add(l);
            		}else {
            			List<Ledger__C> temp = new List<Ledger__c>();
            			temp.add(l);
            			scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id,temp);
            		}
            		if(cpphLedgerMap.containsKey(l.Customer_Pay_Plan_Header__r.Id)) {
            			cpphLedgerMap.get(l.Customer_Pay_Plan_Header__r.Id).add(l);
            		}else {
            			List<Ledger__C> temp = new List<Ledger__c>();
            			temp.add(l);
            			cpphLedgerMap.put(l.Customer_Pay_Plan_Header__r.Id,temp);
            		}
            		/** if(l.Global_Charges__r.Name.equals('Interest')) {
            			List<Opportunity> oList = [Select Id, Total_Interest__c, Total_Interest_Settled__c, Total_Waiver__c, Total_Interest_Waiver__c 
            										from Opportunity where id = :l.Opportunity__r.Id];
            			if(oList.size() == 1) {
            				if(oList[0].Total_Interest_Settled__c != null) {
            					oList[0].Total_Interest_Settled__c -= l.Amount__c;
            				} 
            				update oList;
            			}
            		} **/
            		if(l.Receipt_Details__c != null)
            			receiptDetailLedgerMap.put(l.Receipt_Details__c, l);
            	}
            	System.debug('SCPPDMAP:' + scppdLedgerMap);
				System.debug('CPPHMAP:' + cpphLedgerMap);
				Decimal amtPaid = 0;
				Decimal amtSTPaid = 0;
				Decimal amtAdvPaid = 0;
				Decimal amtSTAdvPaid = 0;
				Decimal amtIntPaid = 0;
				Decimal amtIntSTPaid = 0;
				List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id, Name , Charge_Amount_Paid__c,Service_Tax_Amount_Paid__c,
																			Customer_Pay_Plan_Header__r.Amount_Recd_Till_Date__c,
																			Customer_Pay_Plan_Header__r.Service_Tax_Recd_Till_Date__c,
																			Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
																			Charge_Amount_Billed__c, Service_Tax_Amount_Billed__c,
																			Int_Flatcost_Paid__c, Int_Flatcost_Pending__c, Int_Flatcost_Waived__c, 
    																		Int_ServiceTax_Paid__c, Int_ServiceTax_Pending__c, Int_ServiceTax_Waived__c
																			from 
																			Standard_Customer_Pay_Plan_Detail__c
																			where Id in :scppdLedgerMap.keyset()];
																			
				List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
																			Service_Tax_Recd_Till_Date__c,
																			Amount_Demanded_Till_Date__c,
																			Service_Tax_Demanded_Till_Date__c,
																			Int_flatcost_Paid_Till_Date__c, Int_flatcost_Waived_Till_Date__c,
                                                                    		Int_servicetax_waived_till_date__c, Int_servicetax_paid_till_date__c
                                                                    		from 
																			Customer_Pay_Plan_Header__C where Id in :cpphLedgerMap.keyset()];	
				// milestone record payments data reversal													
				for(Standard_Customer_Pay_Plan_Detail__c s : scppdList){
					for(Ledger__c l : scppdLedgerMap.get(s.Id)) {
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
							amtSTPaid += l.Amount__c;
						else if(!(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) &&  !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Cheque Dishonor')) )
							amtPaid += l.Amount__c;
							
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtSTAdvPaid += l.Amount__c;	
						else if(!l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtAdvPaid += l.Amount__c;
							
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment'))
							amtIntPaid += l.Amount__c;
						else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax'))
							amtIntSTPaid += l.Amount__c;
					}
						s.Charge_Amount_Paid__c = s.Charge_Amount_Paid__c - amtPaid;
						s.Service_Tax_Amount_Paid__c = s.Service_Tax_Amount_Paid__c - amtSTPaid;
						s.Service_Tax_Amount_Advance_Recd__c = s.Service_Tax_Amount_Advance_Recd__c - amtSTAdvpaid;
						s.Charge_Amount_Advance_Recd__c = s.Charge_Amount_Advance_Recd__c -amtAdvPaid;
						s.Int_Flatcost_Paid__c = s.Int_Flatcost_Paid__c - amtIntPaid;
						s.Int_ServiceTax_Paid__c = s.Int_ServiceTax_Paid__c - amtIntSTPaid;
						
						amtPaid = 0;
						amtSTPaid =0;
						amtAdvPaid = 0;
						amtSTAdvPaid =0;
						amtIntPaid = 0;
						amtIntSTPaid = 0;
				}	
				if(scppdList.size() > 0)
					update scppdList;
				// milestone header record payments data reversal. it contains the roll up of the payments demanded and made		
				for(Customer_Pay_Plan_Header__c c : cpphList){
						
					for(Ledger__c l : cpphLedgerMap.get(c.Id)) {
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
							amtSTPaid += l.Amount__c;
						else if(!(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) &&  !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Cheque Dishonor')) )
							amtPaid += l.Amount__c;
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtSTAdvPaid += l.Amount__c;	
						else if(!l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtAdvPaid += l.Amount__c;
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment'))
							amtIntPaid += l.Amount__c;
						else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax'))
							amtIntSTPaid += l.Amount__c;
					}
					if(c.Amount_Recd_Till_Date__c != null)
						c.Amount_Recd_Till_Date__c = c.Amount_Recd_Till_Date__c- amtPaid;
					if(c.Service_Tax_Recd_Till_Date__c != null)
						c.Service_Tax_Recd_Till_Date__c =c.Service_Tax_Recd_Till_Date__c-  amtSTPaid;
					if(c.Int_flatcost_Paid_Till_Date__c != null)
						c.Int_flatcost_Paid_Till_Date__c = c.Int_flatcost_Paid_Till_Date__c -amtIntPaid;
					if(c.Int_servicetax_paid_till_date__c != null)
						c.Int_servicetax_paid_till_date__c = c.Int_servicetax_paid_till_date__c - amtIntSTPaid;
					
					amtPaid = 0;
					amtSTPaid =0;
					amtAdvPaid = 0;
					amtSTAdvPaid =0;
					amtIntPaid = 0;
					amtIntSTPaid = 0;

				}	
				if(cpphList.size() > 0)
				update cpphList;
            }
            
            Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Cheque Dishonor'];
            Global_Charges__c i = [Select Id from Global_Charges__c where Name = 'Interest Installment'];
        	Global_Charges__c iST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax'];
        	
            List<Ledger__c> lstledger = new List<Ledger__c>();
            if(lstreceiptdetail.size()>0)
            {   
                for(Receipt_Details__c receiptdetails : lstreceiptdetail)
                {
                    Ledger__c newledger = new Ledger__c();
                    newledger.Opportunity__c = Receipt.Opportunity__c;
                    if(receiptDetails.is_cheque_dishonour__c){
                    	if(g != null)
                    		newledger.Global_Charges__c = g.Id;
                    } else if(receiptDetails.Is_Interest_Settlement__c){
                    	if( i != null)
                    		newledger.Global_Charges__c = i.Id;
                    } else if(receiptDetails.Is_Interest_Settlement_ST__c){
                    	if( iST != null)
                    		newledger.Global_Charges__c = iST.Id;
                    }
                    else {
                    	System.debug('In else part of global charges:' + receiptdetails.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c);
                    	// newledger.Global_Charges__c =  receiptdetails.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c;   
                    	newledger.Global_Charges__c =  receiptDetailLedgerMap.get(receiptdetails.Id).Global_Charges__c;
                    }
                    newledger.Project_Unit__c = Receipt.Project_Unit__c;
                    newledger.Reciepts__c = Receipt.id;
                    newledger.Receipt_Details__c = receiptdetails.id;
                    newledger.Amount__c = receiptdetails.Amount__c;
                    newledger.Standard_Customer_Pay_Plan_Detail__c = receiptdetails.Standard_Customer_Pay_Plan_Detail__c;
                    newledger.Customer_Pay_Plan_Header__c = receiptDetails.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                    newledger.Debit_Credit__c = 'Debit';
                    newledger.Ledger_Type__c = 'Credit Reversal'; // using this to categorize a debit ledger created due to check bounce
                    newledger.Remarks__c = 'Receipt No : ' + lstRec[0].Receipt_Number__c + ': Dishonored on ' + system.now().format('dd/MM/yyyy') + ' due to ' + lstRec[0].Banking__c + ' From Sales System';
                    newledger.Transaction_Date__c = Receipt.Receipt_Date__c;
                    if(receiptdetails.Receipts__r.Booking__c != null)
                    	newledger.Booking__c = receiptdetails.Receipts__r.Booking__c;
                    if(Receipt.Opportunity__r.Project_Unit__c != null)
                    {
                        newledger.Project_Unit__c = Receipt.Opportunity__r.Project_Unit__c;
                    }
                    if(receiptdetails.Demand_Invoice__c != null)
                    	newLedger.Demand_Invoice__c = receiptdetails.Demand_Invoice__c;
                    lstledger.add(newledger);   
                }				
            }
            // cheque dishonour penalty debit ledger creation
               	Ledger__c newledger = new Ledger__c();
                newledger.Opportunity__c = Receipt.Opportunity__c;                           
                newledger.Reciepts__c = Receipt.id;                            
                newledger.Debit_Credit__c = 'Debit';
                newledger.Remarks__c = 'Amount Charged On Receipt No : ' + receipt.Receipt_Number__c + ' for cheque dishonour penalty';
                if(g != NULL)
                	newledger.Global_Charges__c = g.Id;
                newledger.Amount__c = Receipt.Project__r.Cheque_Dishonour__c;
                newledger.Transaction_Date__c = Receipt.Receipt_Date__c;
                if(Receipt.Opportunity__r.Project_Unit__c != null)
                {
                	newledger.Project_Unit__c = Receipt.Opportunity__r.Project_Unit__c;
                }
                lstledger.add(newledger);
                if(lstLedger.size() > 0)
                insert lstledger;
                
                InterestManagementServices.reverseInterestDetails(ReceiptId);
        }
        catch(Exception ex)
        {
            System.Debug('Error in Receipt Process,dishonour Method'+ ex);
        } 
    }
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// When physical verification is rejected, the ledger enteries are revered. no dishonor penalty is applied.
	public void verificationRejection(Id ReceiptId)
    {
        try
        {
            string Receiptname = '';
            List<Ledger__C> lstledger2 = [select id from Ledger__C where Reciepts__c =: ReceiptId];
            List<Ledger__C> lstledger3 = new List<Ledger__c>();
            List<Receipt__c> LstRec = [select id,Opportunity__c,Opportunity__r.Project_Unit__C, Receipt_Date__c, Project_Unit__c,
													            name,Reason_for_rejection_new__c, Receipt_Status__c, Banking__c,Receipt_Number__c,
													            Project__r.Cheque_Dishonour__c
													            from Receipt__c where id =: ReceiptId];
           	receipt = lstRec[0];             

            if(lstledger2.size() > 0)
            {
                for(Ledger__C ledger : lstledger2)
                {
                    ledger.Remarks__c = 'Receipt No : ' + lstRec[0].Receipt_Number__c + ' physical verification rejected on ' + system.now().format('dd/MM/yyyy') + 'due to ' + lstRec[0].Reason_for_rejection_new__c + ' From Sales System';
                    lstledger3.add(ledger);
                }    
                update lstledger3;
            }
            
            List<Receipt_Details__c> lstreceiptdetail = [select id,Charges__r.Charge_Code__c,Charges__r.Charge_Code__r.Id,
            													Amount__c,Standard_Customer_Pay_Plan_Detail__c,Is_Cheque_Dishonour__c,
						            							Project__r.Cheque_Dishonour__c,Is_Interest_Settlement__c,Is_Advanced_Demand__c,
						            							Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c, Demand_Invoice__c,
						            							Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c,
						            							Receipts__r.Booking__c 
						            							from Receipt_Details__c where Receipts__c =: ReceiptId];
           	List<Ledger__c> reversalList = [Select Id, Debit_Credit__c, Amount__c, Customer_Pay_Plan_Header__r.Id, Global_Charges__c,Global_Charges__r.Name,Receipt_Details__c,
											Standard_Customer_Pay_Plan_Detail__c,Standard_Customer_Pay_Plan_Detail__r.Charge_Amount_Paid__c,Opportunity__r.Id,Demand_Invoice__c,
											Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c, Customer_Pay_Plan_Header__c, receipt_details__r.Is_advanced_demand__C 
											from Ledger__c where Reciepts__c =: ReceiptId];
           	
            Map<Id,List<Ledger__c>> scppdLedgerMap = new Map<Id,List<Ledger__c>>();
            Map<Id,List<Ledger__c>> cpphLedgerMap = new Map<Id,List<Ledger__c>>();
            Map<Id, Ledger__c> receiptDetailLedgerMap = new Map<Id, Ledger__c>();
            if(reversalList.size() > 0) {
            	for(Ledger__c l : reversalList) {
            		if(scppdLedgerMap.containsKey(l.Standard_Customer_Pay_Plan_Detail__r.Id)) {
            			scppdLedgerMap.get(l.Standard_Customer_Pay_Plan_Detail__r.Id).add(l);
            		}else {
            			List<Ledger__C> temp = new List<Ledger__c>();
            			temp.add(l);
            			scppdLedgerMap.put(l.Standard_Customer_Pay_Plan_Detail__r.Id,temp);
            		}
            		if(cpphLedgerMap.containsKey(l.Customer_Pay_Plan_Header__r.Id)) {
            			cpphLedgerMap.get(l.Customer_Pay_Plan_Header__r.Id).add(l);
            		}else {
            			List<Ledger__C> temp = new List<Ledger__c>();
            			temp.add(l);
            			cpphLedgerMap.put(l.Customer_Pay_Plan_Header__r.Id,temp);
            		}
            		/** if(l.Global_Charges__r.Name.equals('Interest')) {
            			List<Opportunity> oList = [Select Id, Total_Interest__c, Total_Interest_Settled__c, Total_Waiver__c, Total_Interest_Waiver__c 
            										from Opportunity where id = :l.Opportunity__r.Id];
            			if(oList.size() == 1) {
            				if(oList[0].Total_Interest_Settled__c != null) {
            					oList[0].Total_Interest_Settled__c -= l.Amount__c;
            				} 
            				update oList;
            			}
            		}**/
            		if(l.Receipt_Details__c != null)
            			receiptDetailLedgerMap.put(l.Receipt_Details__c, l);
            	}
            	System.debug('SCPPDMAP:' + scppdLedgerMap);
				System.debug('CPPHMAP:' + cpphLedgerMap);
				Decimal amtPaid = 0;
				Decimal amtSTPaid = 0;
				Decimal amtAdvPaid = 0;
				Decimal amtSTAdvPaid = 0;
				Decimal amtIntPaid = 0;
				Decimal amtIntSTPaid = 0;
				List<Standard_Customer_Pay_Plan_Detail__c> scppdList = [Select Id, Name , Charge_Amount_Paid__c,Service_Tax_Amount_Paid__c,
																			Customer_Pay_Plan_Header__r.Amount_Recd_Till_Date__c,
																			Customer_Pay_Plan_Header__r.Service_Tax_Recd_Till_Date__c,
																			Charge_Amount_Advance_Recd__c,Service_Tax_Amount_Advance_Recd__c,
																			Service_Tax_Amount_Billed__c, Charge_Amount_Billed__c,
																			Int_Flatcost_Paid__c, Int_Flatcost_Pending__c, Int_Flatcost_Waived__c, 
    																		Int_ServiceTax_Paid__c, Int_ServiceTax_Pending__c, Int_ServiceTax_Waived__c
																			from Standard_Customer_Pay_Plan_Detail__c
																			 where Id in :scppdLedgerMap.keyset()];
																			
				List<Customer_Pay_Plan_Header__C> cpphList = [Select Id, Name , Amount_Recd_Till_Date__c,
																			Service_Tax_Recd_Till_Date__c,
																			Amount_Demanded_Till_Date__c,
																			Service_Tax_Demanded_Till_Date__c,
																			Int_flatcost_Paid_Till_Date__c, Int_flatcost_Waived_Till_Date__c,
                                                                    		Int_servicetax_waived_till_date__c, Int_servicetax_paid_till_date__c
																			 from 
																			Customer_Pay_Plan_Header__C where Id in :cpphLedgerMap.keyset()];														
				for(Standard_Customer_Pay_Plan_Detail__c s : scppdList){
				
					for(Ledger__c l : scppdLedgerMap.get(s.Id)) {
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
							amtSTPaid += l.Amount__c;
						else if(!(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) &&  !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Cheque Dishonor')) )
							amtPaid += l.Amount__c;
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtSTAdvPaid += l.Amount__c;	
						else if(!l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
							amtAdvPaid += l.Amount__c;
						if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment'))
							amtIntPaid += l.Amount__c;
						else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax'))
							amtIntSTPaid += l.Amount__c;
					}
						s.Charge_Amount_Paid__c = s.Charge_Amount_Paid__c - amtPaid;
						s.Service_Tax_Amount_Paid__c = s.Service_Tax_Amount_Paid__c - amtSTPaid;
						s.Service_Tax_Amount_Advance_Recd__c = s.Service_Tax_Amount_Advance_Recd__c - amtSTAdvpaid;
						s.Charge_Amount_Advance_Recd__c = s.Charge_Amount_Advance_Recd__c -amtAdvPaid;
						s.Int_Flatcost_Paid__c = s.Int_Flatcost_Paid__c - amtIntPaid;
						s.Int_ServiceTax_Paid__c = s.Int_ServiceTax_Paid__c - amtIntSTPaid;
						
						amtPaid = 0;
						amtSTPaid =0;
						amtAdvPaid = 0;
						amtSTAdvPaid =0;
						amtIntPaid = 0;
						amtIntSTPaid = 0;
					}	
					if(scppdList.size() > 0)
						update scppdList;
						
					for(Customer_Pay_Plan_Header__c c : cpphList){
						
						for(Ledger__c l : cpphLedgerMap.get(c.Id)) {
							if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax'))
								amtSTPaid += l.Amount__c;
							else if(!(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment')) &&  !(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax')) && !(l.Global_Charges__r.Name.equalsIgnoreCase('Cheque Dishonor')) )
								amtPaid += l.Amount__c;
							if(l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
								amtSTAdvPaid += l.Amount__c;	
							else if(!l.Global_Charges__r.Name.equalsIgnoreCase('Service Tax') && l.receipt_details__R.is_Advanced_Demand__c)
								amtAdvPaid += l.Amount__c;
							if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Installment'))
								amtIntPaid += l.Amount__c;
							else if(l.Global_Charges__r.Name.equalsIgnoreCase('Interest Servicetax'))
								amtIntSTPaid += l.Amount__c;
						}
					if(c.Amount_Recd_Till_Date__c != null)
						c.Amount_Recd_Till_Date__c = c.Amount_Recd_Till_Date__c- amtPaid;
					if(c.Service_Tax_Recd_Till_Date__c != null)
						c.Service_Tax_Recd_Till_Date__c =c.Service_Tax_Recd_Till_Date__c-  amtSTPaid;
					if(c.Int_flatcost_Paid_Till_Date__c != null)
						c.Int_flatcost_Paid_Till_Date__c = c.Int_flatcost_Paid_Till_Date__c -amtIntPaid;
					if(c.Int_servicetax_paid_till_date__c != null)
						c.Int_servicetax_paid_till_date__c = c.Int_servicetax_paid_till_date__c - amtIntSTPaid;
					
					
					amtPaid = 0;
					amtSTPaid =0;
					amtAdvPaid = 0;
					amtSTAdvPaid =0;
					amtIntPaid = 0;
					amtIntSTPaid = 0;
				}	
									
				if(cpphList.size() > 0)
				update cpphList;
		            	
            }
            
            Global_Charges__c g = [Select Id from Global_Charges__c where Name = 'Cheque Dishonor'];
            Global_Charges__c i = [Select Id from Global_Charges__c where Name = 'Interest Installment'];
        	Global_Charges__c iST = [Select Id from Global_Charges__c where Name = 'Interest Servicetax'];
        	List<Ledger__c> lstledger = new List<Ledger__c>();
            if(lstreceiptdetail.size()>0)
            {   
                for(Receipt_Details__c receiptdetails : lstreceiptdetail)
                {
                    Ledger__c newledger = new Ledger__c();
                    newledger.Opportunity__c = Receipt.Opportunity__c;
					if(receiptDetails.is_cheque_dishonour__c){
                    	if(g != null)
                    		newledger.Global_Charges__c = g.Id;
                    } else if(receiptDetails.Is_Interest_Settlement__c){
                    	if( i != null)
                    		newledger.Global_Charges__c = i.Id;
                    } else if(receiptDetails.Is_Interest_Settlement_ST__c){
                    	if( iST != null)
                    		newledger.Global_Charges__c = iST.Id;
                    }
                    else {
                    	System.debug('In else part of global charges:' + receiptdetails.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__r.Global_Charges__c);
                    	newledger.Global_Charges__c =  receiptDetailLedgerMap.get(receiptdetails.Id).Global_Charges__c;
                    }           
                    newledger.Project_Unit__c = Receipt.Project_Unit__c;
                    newledger.Reciepts__c = Receipt.id;
                    newledger.Receipt_Details__c = receiptdetails.id;
                    newledger.Amount__c = receiptdetails.Amount__c;
                    newledger.Standard_Customer_Pay_Plan_Detail__c = receiptdetails.Standard_Customer_Pay_Plan_Detail__c;
                    newledger.Customer_Pay_Plan_Header__c = receiptDetails.Standard_Customer_Pay_Plan_Detail__r.Customer_Pay_Plan_Header__c;
                    newledger.Debit_Credit__c = 'Debit';
                    newledger.Ledger_Type__c = 'Credit Reversal'; // using this to categorize a debit ledger created due to check bounce
                    newledger.Remarks__c = 'Receipt No : ' + lstRec[0].Receipt_Number__c + ' physical verification rejected on  ' + system.now().format('dd/MM/yyyy') + 'due to ' + lstRec[0].Reason_for_rejection_new__c + ' From Sales System';
                    newledger.Transaction_Date__c = Receipt.Receipt_Date__c;
                    if(receiptdetails.Receipts__r.Booking__c != null)
                    	newledger.Booking__c = receiptdetails.Receipts__r.Booking__c;
                    if(Receipt.Opportunity__r.Project_Unit__c != null)
                    {
                        newledger.Project_Unit__c = Receipt.Opportunity__r.Project_Unit__c;
                    }
                    if(receiptdetails.Demand_Invoice__c != null)
                    	newLedger.Demand_Invoice__c = receiptdetails.Demand_Invoice__c;                   
                    lstledger.add(newledger); 
                	}
                }
                if(lstLedger.size() > 0)
                	insert lstledger;              
            	else {
            		System.debug('No ledgers created, no one is dishonoured ;-');	
            	}
            	
            	InterestManagementServices.reverseInterestDetails(ReceiptId);
        }
        catch(Exception ex)
        {
            System.Debug('Error in Receipt Process,verification rejection Method'+ ex);
        } 
    }
 
}