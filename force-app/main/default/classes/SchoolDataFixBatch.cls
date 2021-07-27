public class SchoolDataFixBatch implements Database.Batchable<sObject> {    
	public Database.QueryLocator start(Database.BatchableContext bc) {		         
         return Database.getQueryLocator('SELECT Id, Last_Child_Date__c, (SELECT Id, CreatedDate FROM Students__r ORDER BY CreatedDate DESC LIMIT 1) FROM School__c');
    }
    
    public void execute(Database.BatchableContext bc, List<School__c> records){
        
        List<School__c> schools = new List<School__c>();
        
        for (School__c sc : records){
            for (Student__c st: sc.Students__r){
                sc.Last_Child_Date__c = st.CreatedDate;
            }            
        schools.add(sc);
        }        
        update schools;
    }
    
    public void finish(Database.BatchableContext bc){
        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(JSON.serialize(job));
    }
}