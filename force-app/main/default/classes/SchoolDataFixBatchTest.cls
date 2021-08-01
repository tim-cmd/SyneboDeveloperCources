@isTest
public class SchoolDataFixBatchTest {
    
    @isTest
    static void testSchoolBatchResult(){
        Test.startTest();
        List<String> dataIds = TestDataFactory.createStudentWithSchool(200, 5);
        
            SchoolDataFixBatch schoolFix = new SchoolDataFixBatch();
            Database.executeBatch(schoolFix);
        Test.stopTest();
        
        System.debug('dataIds list: ' + dataIds);
        List<School__c> scholsCreated = [SELECT Id, Last_Child_Date__c FROM School__c WHERE Id IN :dataIds];
        
        System.debug('scholsCreated object list: ' + scholsCreated);
        for(School__c sc : scholsCreated){
            
        	System.assertNotEquals(null, sc.Last_Child_Date__c);
        }    
    }
}