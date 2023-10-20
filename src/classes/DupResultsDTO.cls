public class DupResultsDTO {
    public Lead originalLead;
    public Id dupEnquiryTaskId;
    public Id duplicateMaster;
    public string errmsg;
    public Map<String,Set<Id>> duplicatesMap = new Map<String,Set<Id>>();
    public Map<String,List<string>> duplicatesMapNew = new Map<String,List<string>>();
    
    public DupResultsDTO() {
        this.originalLead = null;
        this.dupEnquiryTaskId = null;
        this.duplicateMaster = null;
        this.errmsg = '';
        this.duplicatesMap = new Map<String,Set<Id>>();
        this.duplicatesMapNew = new Map<string,List<string>>(); 
    } 
    public DupResultsDTO(Lead l, Id duplicateMaster, Id taskId, Map<String,Set<Id>> duplicatesMap) {
        this.originalLead = l;
        this.dupEnquiryTaskId = taskId;
        this.duplicateMaster = duplicateMaster;
        this.duplicatesMap = duplicatesMap;
    } 
}