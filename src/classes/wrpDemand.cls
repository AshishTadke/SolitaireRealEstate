global class wrpDemand {
        public Decimal CurrentDemandAmount {
            get;
            set;
        }
        public Decimal tdsAmount {
            get;
            set;
        }
        public decimal CurrentServiceTax {
            get;
            set;
        }
        public string ProjectUnit {
            get;
            set;
        }
        public string ProjectId {
            get;
            set;
        }
        public string opportunityId {
            get;
            set;
        }
        public Date InvoiceDate {
            get;
            set;
        }
        public Date InvoiceDueDate {
            get;
            set;
        }
        public String mileStoneName {
            get;
            set;
        }
        public String chargeName {
            get;
            set;
        }
        // sample Basic:1, MSEB:2 . just the names are used for iteration
        public Map<String,Integer> chargeNameMap  {
            get;
            set;
        }
        // sample Basic:Current Demand Amount in Rs, MSEB:Current demand amount in Rs
        public Map<String,String> chargeAmountMap  {
            get;
            set;
        }
        
        // sample Basic SGST TAX AMT: Rs 100, Basic CGST TAX AMT: Rs 100, Basic TOTAL TAX AMT: Rs 200, Basic SGST TAXABLE AMT: 300, 
        // Basic CGST TAXABLE AMT: 300, Basic CGST TAX PERCENTAGE: 9%. Similarly for other charges as well.
        public Map<String,String> chargeTaxMap  {
            get;
            set;
        }
        // sample Basic : in Rs  demand + total tax , MSEB : in Rs  demand + total tax
        public Map<String,String> ChargeOverallTotal  {
            get;
            set;
        }
        // sample Basic:Current Demand Amount in Number, MSEB:Current Demand Amount in Number
        public Map<String,Decimal> chargeAmountMapD  {
            get;
            set;
        }
        // same as chargeTaxMap except that all values are in decimals and not string
        public Map<String,Decimal> chargeTaxMapD  {
            get;
            set;
        }
        // same as chargeoverall total except that all values are in decimals
        public Map<String,Decimal> ChargeOverallTotalD  {
            get;
            set;
        }
        // this is same as chargeoverall except that its all in words
        public Map<String,String> ChargeOverallTotalWords  {
            get;
            set;
        }
        // list of all the taxnames that are applicable across all charges present in this demand. For ex: Basic May have SGST, CGST, MSEB may have SGST, CGST, CESS etc.,
        public Set<String> taxNames  {
            get;
            set;
        }
        // name of the taxes and their percentages in decimals
        public Map<String,Decimal> taxRateMapD  {
            get;
            set;
        }
        // name of the taxes and their percentages in string [9%]
        public Map<String,String> taxRateMap  {
            get;
            set;
        }
        // map of which scppd record belong to which charge
        public Map<String,List<Standard_Customer_Pay_Plan_Detail__c>> scppdChargeMap  {
            get;
            set;
        }
        
        public Map<String, String> grandTotalNumberMap {
            get;
            set;
        }
        public Map<String, String> grandTotalWordsMap {
            get;
            set;
        }
         public Map<String, Decimal> totalCurrentCharges {
            get;
            set;
        }
        
        public wrpDemand() {
            CurrentDemandAmount = 0;
            CurrentServiceTax = 0;
            ProjectUnit = '';
            ProjectId = '';
            OpportunityId = '';
            InvoiceDate = null;
            InvoiceDueDate = null;
            mileStoneName = null;
            chargeName = null;
            tdsAmount = 0;
            chargeNameMap = new Map<String,Integer>();
            chargeAmountMap = new Map<String, String>();
            chargeTaxMap = new Map<String, String>();
            ChargeOverallTotal = new Map<String, String>();
            ChargeOverallTotalWords = new Map<String, String>();
            grandTotalNumberMap = new Map<String, String>();
            grandTotalWordsMap = new Map<String, String>();
            totalCurrentCharges = new Map<String,Decimal>();
            taxNames = new Set<String>();
            taxRateMap = new Map<String, String>();
            
            chargeAmountMapD = new Map<String, Decimal>();
            chargeTaxMapD = new Map<String, Decimal>();
            ChargeOverallTotalD = new Map<String, Decimal>();
            taxRateMapD = new Map<String, Decimal>();
            scppdChargeMap = new Map<String, List<Standard_Customer_Pay_Plan_Detail__c>>();
            
            
        }
    }