@isTest
public class SchoolWithStudentsQueueableTest {
	
    @isTest
    static void testQueueable(){
        
        Test.startTest(); 
        SchoolWithStudentsQueueable queueable = new SchoolWithStudentsQueueable('Queuebles Unit test', 5);
        System.enqueueJob(queueable);
        Test.stopTest(); 
       
        School__c[] parent = [SELECT Id FROM School__c WHERE Name = 'Queuebles Unit test'];
        System.assertEquals(1, parent.size());
        System.assertEquals(5, [SELECT COUNT() FROM Student__c WHERE School__c = :parent[0].id]);
    }
}