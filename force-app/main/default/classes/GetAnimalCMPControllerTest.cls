@isTest
public class GetAnimalCMPControllerTest {
    
    private static List<Animal__c> prepareAnimals(){
        List<Animal__c>  anim = new List<Animal__c>();
            
        for(Integer i=40; i<44; i++){
            anim.add(new Animal__c (Name = 'test animal ' + String.valueOf(i)));
        }
        return anim;
    }
    
    @isTest
    private static void testBlank(){
        
        List<Animal__c> testData = prepareAnimals();
        insert testData;
        
        Test.startTest();
        List<Animal__c> actual = GetAnimalCMPController.getAnimalData('');
        Test.stopTest();
        
        System.assertEquals(testData, actual);
        
    }
    
    @isTest
    private static void testId(){
        
        Animal__c testData = new Animal__c (Name = 'test animal');
        insert testData;
        
        Test.startTest();
        List<Animal__c> actual = GetAnimalCMPController.getAnimalData(testData.id);
        Test.stopTest();
        
        System.assertEquals(testData.id, actual[0].id);
        
    }
    
    @isTest
    private static void testExternal(){
        
        Animal__c testData = new Animal__c (Name = 'test animal');
        
        insert testData;
        update new Animal__c (Id=testData.Id,
                             External_Id__c = '33');
        
        Test.startTest();
        List<Animal__c> actual = GetAnimalCMPController.getAnimalData('33');
        Test.stopTest();
        
        System.assertEquals(testData.id, actual[0].id);
        
    }

}