public class SchoolWithStudentsQueueable implements Queueable {
    
    private List<Student__c> students = new List<Student__c>();
    private School__c parentSchool;
    private Student__c student;
    private ID parentId;
    private String schoolName;
    private Integer studentQuantity;
        
    
    public SchoolWithStudentsQueueable(String parentName, Integer childQuantity) {
        this.schoolName = parentName;
        this.studentQuantity = childQuantity;     
    }    
    
    private void insertParent(){
        
        parentSchool = new School__c(Name = schoolName);
    	insert parentSchool;
        System.debug('School created: ' + JSON.serialize(parentSchool));
        
        this.parentId = parentSchool.Id;
    }
    
    private void insertChilds(){
            
        for (Integer i=0; i<studentQuantity; i++){
            student = new Student__c (Name = 'Test Queueable. Student ' + String.valueOf(i),
                                     School__c = parentId);
            students.add(student);
        }
        insert students;
        System.debug('Students created: ' + JSON.serialize(students));
    }
    
    public void execute(QueueableContext context) {
        insertParent();
        insertChilds();
    }
     
}