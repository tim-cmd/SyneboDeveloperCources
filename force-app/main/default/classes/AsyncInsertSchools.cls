public class AsyncInsertSchools implements Queueable {
    
    private String schoolName;
    private School__c parentSchool;
    
    public AsyncInsertSchools(String name) {
        this.schoolName = name;
    }
    
    public void execute(QueueableContext context) {
        parentSchool = new School__c(Name = schoolName);
    	insert parentSchool;
        System.debug(JSON.serialize(parentSchool));
        
        System.enqueueJob(new AsyncInsertStudentClass(parentSchool.Id, 4));
    }
     
}