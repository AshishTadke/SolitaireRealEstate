public with sharing class UpdateConsStageNew {
	public Id projectId {
		get;
		set;
	}
	public Project__c p {
		get;
		set;
	}
	public Id towerId {
		get;
		set;
	}
	public Id stageId {
		get;
		set;
	}
	public Date dueDate {
		get;
		set;
	}
	public Date plannedDate {
		get;
		set;
	} public String updateType {
		get;
		set;
	}
	
	public attachment objattachment {
		get {
			if (objattachment == null) objattachment = new attachment();
			return objattachment;
		}
		set;
	}
	// constructor to intialize the project id based on the URL parameter
	public UpdateConsStageNew() {
		ProjectID = Apexpages.currentPage().getParameters().get('Pid');
		towerId = null;
		stageId = null;
		dueDate = null;
		plannedDate = null;
		updateType = ''; 
		if (ProjectID != null) {
			List < Project__c > lstProj = [select id, Name, Days_To_Send_Demand__c from Project__c where id = : ProjectID];
			if (lstProj.size() > 0) {
				p = lstProj[0];
			}
		}
	}
	// list of towers in this project
	public List < SelectOption > getTowerSelectList() {
		List < SelectOption > options = new List < Selectoption > ();
		List < Tower__c > qResult = new List < Tower__c > ([Select Id, Name from Tower__c where ProjectName__c = : projectID order by Name]);
		options.add(new SelectOption('', 'Select a Tower'));
		for (Tower__c t: qResult) {
			options.add(new SelectOption(t.Id, t.Name));
		}
		return options;
	}

	// getting the list of construction stage related to the chosen tower
	public List < SelectOption > getConstructionSelectList() {
		List < Project_Construction_Stages__c > lstPConStg = [Select p.Id, p.Name from Project_Construction_Stages__c p
		where p.Project__c = : ProjectID and tower__c = : towerId and tower__c != null];
		List < SelectOption > options = new List < SelectOption > ();
		if (lstPConStg.size() > 0) {
			options.add(new SelectOption('', 'Select a Stage'));
			for (Project_Construction_Stages__c PConStg: lstPConStg) {
				options.add(new SelectOption(PConStg.id, PConStg.Name));
			}
		}
		return options;
	}

	public list<SelectOption> updateOptions
    {
        get
        {
        	list<SelectOption> searchOptions = new list<SelectOption>();
           	searchOptions.add(new SelectOption('plannedDate', 'Planned Date'));
           	searchOptions.add(new SelectOption('completionDate', 'Completion Date'));
            return searchOptions;
        }
        set;
    }
	// save method: updates the due date the project construction stage record, upload the arch certificate
	// as an attachment, updates the customer pay plan records associated with this construction stage mile stone.
	public pageReference save() {
		System.debug('Due Date:' + dueDate);
		System.debug('Planned Date:' + plannedDate);
		System.debug('update type:' + updateType);
		// planned Date logic
		if(String.isBlank(updateType)) {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL, 'Please select a date to update'));
			return null;
		}
		if(updateType.equals('plannedDate') &&  plannedDate == null) {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL, 'Please select a planned date'));
			return null;
		} else if(updateType.equals('plannedDate') &&  plannedDate != null){ // update the planned completionDate	
			try {
				Project_Construction_Stages__c pcons = new Project_Construction_Stages__c(id = stageId, Planned_date_of_completion__c = plannedDate);
				upsert pcons;
				System.debug('Due Date before calling update:' + DueDate);
				UpdCustPayPlanDueDatesforSoldUnits(plannedDate);
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Planned Date Updated'));
			} catch (Exception e) {
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'error updating stage:' + e.getMessage()));
			} finally {
				stageId = null;
				towerId = null;
				dueDate = null;
				plannedDate = null;
				updateType = '';
				objattachment = null;
				return null;
			}
		} else if (updateType.equals('completionDate') && dueDate == null) {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.FATAL, 'Please select an actual completion date'));
			return null;
		} else if ( dueDate != null && (objattachment.name == null || objattachment.name == '')) {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Architect certificate upload is mandatory for milestone completion'));
			return null;
		} else if(duedate != null){ //update the actual completion date
			try {
				upload();
				Project_Construction_Stages__c pcons = new Project_Construction_Stages__c(id = stageId, Actual_date_of_completion__c = dueDate);
				upsert pcons;
				System.debug('Due Date before calling update:' + DueDate);
				UpdCustPayPlanDueDatesforSoldUnits(dueDate);
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Completion Date Updated'));
			} catch (Exception e) {
				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'error updating stage:' + e.getMessage()));

			} finally {
				stageId = null;
				towerId = null;
				dueDate = null;
				plannedDate = null;
				updateType = '';
				objattachment = null;
				return null;
			}
			
		} else {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error Occurred, due to incorrect data entered'));
		}
		return null;
	}

	// takes the user back to the project detail page
	public PageReference cancel() {
		PageReference pv = new PageReference('/' + p.Id);
		return pv;
	}

	// just a method for action function to call and then rerender the output panels
	// facing some issues with rerender, required input and page specific validations
	public void dummy() {
	}
	
	public PageReference refresh() {
		PageReference pRef = Apexpages.currentPage();
		pRef.setredirect(true);
		return pRef;
	}
	// method for uploading the architect certificate
	public boolean upload() {
		objattachment.OwnerId = UserInfo.getUserId();
		objattachment.IsPrivate = true;
		objattachment.ParentId = stageId;
		if (objattachment.ParentId != null) {
			insert objattachment;
			return true;
		}
		return false;
	}

	// method for updating the existing customer payplan records that
	// are linked to this specific milestone.
	public PageReference UpdCustPayPlanDueDatesforSoldUnits(Date d) {
		System.debug('Date received:' + d);
		List < Project_Unit__c > lstProjectUnit = new List < Project_Unit__c > ();
		List < Standard_Customer_Pay_Plan_Detail__c > lstStdCusPayPlandtl = new List < Standard_Customer_Pay_Plan_Detail__c > ();
		Set<ID> stageIDSet = new Set<ID>();
		string QueryforUnit = null;
		QueryforUnit = 'Select id,Project_Unit_Type__c, Actual_Area_value__c from Project_Unit__c where ';

		QueryforUnit = QueryforUnit + ' createddate != null AND Project__c = \'' + p.Id + '\' AND Unit_Status__c=\'Sold\' AND TowerName__c = \'' + towerID + '\'';

		lstprojectunit = Database.query(QueryforUnit);

		System.debug('Unit List to update:' + lstProjectUnit);
		if (lstprojectunit.size() > 0) {
			lstStdCusPayPlandtl = [SELECT s.Id, s.Days_Months__c, s.Days_Months_Value__c, Due_Date__c , Is_Milestone_Achieved__c, Construction_Stage_Update_Date__c
									FROM Standard_Customer_Pay_Plan_Detail__c s 
									WHERE s.Customer_Pay_Plan_Header__r.Project__c = : p.ID 
									AND s.Customer_Pay_Plan_Header__r.Effect_To_Date__c = : null AND 
									s.Project_Construction_Stages__c = : stageID AND 
									s.Customer_Pay_Plan_Header__r.Project_Unit__c IN: lstprojectunit];
									
			List < Standard_Customer_Pay_Plan_Detail__c > lstSCPPD = new List < Standard_Customer_Pay_Plan_Detail__c > ();
			if (lstStdCusPayPlandtl.size() > 0) {
				for (Standard_Customer_Pay_Plan_Detail__c objSCPPD: lstStdCusPayPlandtl) {

					System.debug('Here is the list to update' + objSCPPD);
					string DayMonth = objSCPPD.Days_Months__c;
					decimal DayMonthValue = objSCPPD.Days_Months_Value__c;

					if (DayMonthValue == null) {
						DayMonthValue = 0;
					}

					if (DayMonth == 'Day(s)') {
						objSCPPD.Construction_Stage_Update_Date__c = d.addDays(DayMonthValue.intvalue());
						objSCPPD.Due_Date__c = d.addDays(DayMonthValue.intvalue());
					} else {
						objSCPPD.Construction_Stage_Update_Date__c = d.addMonths(DayMonthValue.intvalue());
						objSCPPD.Due_Date__c = d.addMonths(DayMonthValue.intvalue());
					}
					if(updateType.equals('completionDate')) {
						objSCPPD.Is_Milestone_Achieved__c = true;
					}
					lstSCPPD.add(objSCPPD);
					
				}
			}
			if (lstSCPPD.size() > 0) {
				update lstSCPPD;
			} 
		}
		return null;
	}
}