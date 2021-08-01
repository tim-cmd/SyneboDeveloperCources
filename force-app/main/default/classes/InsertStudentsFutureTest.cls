@isTest
public class InsertStudentsFutureTest {
	
    @isTest
    private static void testFutureCreation(){
    	Test.startTest();        
    	InsertStudentsFuture.createStudent('FUTURE TEST');
    	Test.stopTest();
        
        Student__c[] students = [SELECT Id from Student__c WHERE Name='FUTURE TEST'];
        System.assertEquals(1, students.size());
	}
}