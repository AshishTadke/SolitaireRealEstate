public with sharing class S_InventoryMatrix {
    public Project_Unit__c unit {
        get;
        private set;
    }
    public String selectedTower {
        get;
        set;
    }
    public String selectedVal {
        get;
        set;
    }
    public String selectedstatus {
        get;
        set;
    }
    public String SelectedClusterId {
        get;
        set;
    }
    public String SelectedProjectId {
        get;
        set;
    }
    public String selectedConf {
        get;
        set;
    }
    public Boolean sold {
        get;
        set;
    }
    public Boolean open {
        get;
        set;
    }
    public Boolean booked {
        get;
        set;
    }
    public Boolean blocked {
        get;
        set;
    }
    public Boolean reserved {
        get;
        set;
    }
    public Boolean onebhk {
        get;
        set;
    }
    public Boolean twobhk {
        get;
        set;
    }
    public Boolean threebhk {
        get;
        set;
    }
    public Boolean fourbhk {
        get;
        set;
    }
    public Boolean fivebhk {
        get;
        set;
    }
    public List < Decimal > floorAscSeqList {
        get;
        set;
    }
    public Map < Decimal, List < Project_Unit__c >> JMap {
        get;
        set;
    }
    String projectsent = ApexPages.currentPage().getParameters().get('projectsent');
    String statussent = ApexPages.currentPage().getParameters().get('statussent');
    String towersent = ApexPages.currentPage().getParameters().get('towersent');
    List < String > s = new List < String > ();

  /*  public List < SelectOption > getClients {
        get {
            List < SelectOption > clientoptns = new List < Selectoption > ();
            List < Client__c > clientqury = new List < Client__c > ();
            clientqury = new List < Client__c > ([Select Id, Name from Client__c]);
            clientoptns.add(new SelectOption('', 'Select a Client'));
            for (Client__c obj: clientqury) {
                clientoptns.add(new SelectOption(obj.Id, obj.Name));
            }
            return clientoptns;
        }
        set;
    }
    */

    public List < SelectOption > getProjects {
        get {
            List < SelectOption > optns = new List < Selectoption > ();
            List < Project__c > queryResult = new List < Project__c > ();
          
            queryResult = [Select Id, Name from Project__c];
            optns.add(new SelectOption('', 'Select a Project'));
            for (Project__c obj: queryResult) {
                optns.add(new SelectOption(obj.Id, obj.Name));
            }
            return optns;
        }
        set;
    }
    public List < SelectOption > getClusterNames {

        get {

            set < string > clusterSet = new set < string > ();
            List < SelectOption > ClusterOptions = new List < SelectOption > ();
            ClusterOptions.add(new SelectOption('0', 'Select a Phase'));
            if (selectedVal != null) {
                for (Cluster__c c: [select Id, name, Project__c from Cluster__c Where Project__c = : selectedVal]) {
                    if (!clusterSet.contains(c.name.tolowercase())) {
                        ClusterOptions.add(new SelectOption(c.Id, c.name));
                    }
                    clusterSet.add(c.name.tolowercase());
                }
            }
            return ClusterOptions;
        }
        set;

    }
   

    public List < SelectOption > getTowers {

        get {
            List < SelectOption > options = new List < Selectoption > ();
            options.add(new SelectOption('', 'Select a Tower'));
            if (SelectedClusterId != null) {
                List < Tower__c > qResult = new List < Tower__c > ([Select Id, Name from Tower__c where Zone_Name__r.id = : SelectedClusterId order by Name asc]);
                for (Tower__c obj1: qResult) {
                    options.add(new SelectOption(obj1.Id, obj1.Name));
                }
            }
            return options;
        }
        set;
    }

    public List < SelectOption > getProjectunittype {
        get {
            List < SelectOption > unitopt = new List < Selectoption > ();
            unitopt.add(new SelectOption('', 'Select Configuration'));

            if (selectedVal != null && selectedTower != null) {

                List < Project_Unit_Type__c > conf = new List < Project_Unit_Type__c > ([Select Id, Name from Project_Unit_Type__c Where RDS_Project__c = : selectedVal]);
                system.debug(' project unit query>>>>>' + conf);

                for (Project_Unit_Type__c unit: conf) {
                    unitopt.add(new SelectOption(unit.Id, unit.Name));
                }
            }
            system.debug('unitopt >>>>' + unitopt);
            return unitopt;

        }
        set;
    }



    public List < Decimal > floorDescSeqList {
        get {
            towersent = selectedTower;
            projectsent = selectedVal;
            JMap = new Map < Decimal, List < Project_Unit__c >> ();
            floorAscSeqList = new List < Decimal > ();
            floorDescSeqList = new List < Decimal > ();
            system.debug('towersent ..' + towersent);
            system.debug('projectsent ..' + projectsent);

            if (towersent != null && projectsent != null) {
                List < Project_Unit__c > unitlist = ([SELECT Id, Name, Floor__c, Floor1__c, Unit_Status__c, Project_Unit_Type__r.Name, RDS_Project_Unit_Type__r.Name,Booking__c,Booking__r.Opportunity__c,Customers__c, 
                                                       Customers__r.Name from Project_Unit__c where TowerName__c = : towersent order by Floor__c DESC, Name ASC]);
                System.debug('UNIT LIST:' + unitList);

                for (Project_Unit__c thisUnit: unitList) {
                    if (JMap.containsKey((thisUnit.Floor__c))) {
                        JMap.get((thisUnit.Floor__c)).add(thisUnit);
                    } else {
                        List < Project_Unit__c > unitList1 = new List < Project_Unit__c > ();
                        unitList1.add(thisUnit);
                        JMap.put((thisUnit.Floor__c), unitList1);
                    }
                }

                floorAscSeqList.addAll(JMap.keySet());
                floorAscSeqList.sort();

                for (Integer i = floorAscSeqList.size() - 1; i >= 0; i--) {
                    floorDescSeqList.add(floorAscSeqList.get(i));
                }
                System.debug('FLOOR SEQ:' + floorDescSeqList.size());
                System.debug('J Map:' + JMap);


            }
            return floorDescSeqList;
        }
        set;

    }
}