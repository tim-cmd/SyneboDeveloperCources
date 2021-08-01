@isTest
private class AnimalTriggerHandlerTest {

    private static final String NAME = 'rat';
    private static final String EXTERNAl_ID = '99';
    private static final String EATS = 'cheese';
    private static final String SAYS = 'piy piy';
    
    
    @isTest
    static void testUpdateFromResource() {
        
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        
        // Call method to test
       	Test.startTest();
        Animal__c anim = TestDataFactory.createAnimal('99', null);
        Test.stopTest();
        
        Animal__c result = [SELECT ID, External_Id__c, Name, Eats__c, Says__c FROM Animal__c WHERE External_Id__c = '99' LIMIT 1];
        
        System.assertEquals(NAME, result.Name);
        System.assertEquals(EXTERNAl_ID, result.External_Id__c);
        System.assertEquals(EATS, result.Eats__c);
        System.assertEquals(SAYS, result.Says__c);
    }
    
}