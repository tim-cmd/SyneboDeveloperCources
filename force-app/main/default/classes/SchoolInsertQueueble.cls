public class SchoolInsertQueueble implements Queueable{
    
    private String schoolName;
    private School__c parentSchool;
    
    public SchoolInsertQueueble(String name) {
        this.schoolName = name;
    }
    
    public void execute(QueueableContext context) {
        parentSchool = new School__c(Name = schoolName);
    	insert parentSchool;
        System.debug(JSON.serialize(parentSchool));
        
        System.enqueueJob(new StudentsInsertQueueable(parentSchool.Id, 4));
    }
     
}