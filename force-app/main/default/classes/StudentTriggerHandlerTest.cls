@isTest
public class StudentTriggerHandlerTest {
	
    @isTest
    static void insertStudentTest(){
        
        Test.startTest();
        List<String> studentIds = new List<String>();
            studentIds = TestDataFactory.createStudentWithSchool(2,2);
        System.debug('studentsData ' + studentIds);
        Test.stopTest();
 
        List<Student__c> studentsData = [SELECT School_Assigned_Timestamp__c FROM Student__c WHERE Id IN :studentIds];
        
        for(Student__c s : studentsData){
            DateTime expected = s.School_Assigned_Timestamp__c;
            System.debug('expected ' + expected);
            System.assertEquals(System.now(), expected);
        }
        
        
    }
    
    @isTest
    static void updateStudentsSchool(){
        
        Test.startTest();
        ID studentId = TestDataFactory.updateParentSchool();
        Test.stopTest();
        
        Student__c actual = [SELECT School_Assigned_Timestamp__c FROM Student__c WHERE Id=:studentId];
        
        System.assertEquals(System.now(), actual.School_Assigned_Timestamp__c);
        
    }
    
    @isTest
    static void eraseStudentsSchool(){
        
        Test.startTest();
        ID studentId = TestDataFactory.eraseParentSchool();
        Test.stopTest();
        
        Student__c actual = [SELECT School_Assigned_Timestamp__c FROM Student__c WHERE Id=:studentId];
        
        System.assertEquals(null, actual.School_Assigned_Timestamp__c);
    }
}