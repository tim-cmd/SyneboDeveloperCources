public class AsyncInsertStudentClass implements Queueable{

    private List<Student__c> students = new List<Student__c>();
    private Integer studentQuantity;
    private ID parent;
    private Student__c student;
       
    public AsyncInsertStudentClass(ID id, Integer quantity) {
        this.studentQuantity = quantity;
        this.parent = id;
    }
    
    public void execute(QueueableContext context) {
        for (Integer i=0; i<studentQuantity; i++){
            student = new Student__c (Name = 'Test Queueable. Student ' + String.valueOf(i),
                                     School__c = parent);
            students.add(student);
        }
        insert students;
        System.debug(JSON.serialize(students));
    }
}