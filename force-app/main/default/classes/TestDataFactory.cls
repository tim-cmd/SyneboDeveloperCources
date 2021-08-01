@isTest
public class TestDataFactory {
    
    public static List<ID> createStudentWithSchool (Integer numSchools, Integer numStudents){
        
        List<Student__c> students = new List<Student__c>();
	    List<School__c> schools = new List<School__c>();
        
        for(Integer i=0;i<numSchools;i++) {
            School__c sc = new School__c(Name = 'Test School ' + String.valueOf(i));
            schools.add(sc);
        }
        insert schools;
        
        
        for (School__c sch : schools) {            
            for (Integer k=0;k<numStudents;k++) {
                students.add(new Student__c(Name = 'Test Student',
                                School__c = sch.id,
                                School_Assigned_Timestamp__c=null ));
            }
        }
        insert students;

        
        List<Id> stIds = new List<Id>();
        for (Student__c s : students){
            stIds.add(s.Id);
        }
        
        return stIds;
    }
    
    public static ID updateParentSchool(){
        
        List<String> studentIds = TestDataFactory.createStudentWithSchool(2,1);       
                            
        Student__c firstStudent = [SELECT Id, School__c FROM Student__c WHERE Id = :studentIds.get(0)];
        Student__c secondStudent = [SELECT Id, School__c FROM Student__c WHERE Id = :studentIds.get(1)];

        update firstStudent = new Student__c (Id = firstStudent.Id,
            									School__c = secondStudent.School__c);
            
        return firstStudent.Id;
    }
    
    public static ID eraseParentSchool(){
        List<String> studentIds = TestDataFactory.createStudentWithSchool(1,1);
        
        Student__c firstStudent = [SELECT Id, School__c FROM Student__c WHERE Id = :studentIds.get(0)];
        
        update firstStudent = new Student__c (Id = firstStudent.Id,
            									School__c = null);
        
        return firstStudent.Id;

    }

}