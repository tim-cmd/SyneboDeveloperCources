@isTest
public class AnimalRestResourceTest {
    
    private static final String NAME = 'rat';
    private static final String EXTERNAl_ID = '99';
    private static final String EATS = 'cheese';
    private static final String SAYS = 'piy piy';
	
    private static Animal__c prepareData(){
        Animal__c testRecord = TestDataFactory.createAnimal(null, null);
        
        testRecord.External_Id__c = EXTERNAl_ID;
        testRecord.Name = NAME;
        testRecord.Eats__c = EATS;
        testRecord.Says__c = SAYS;
        
        update testRecord;
        return testRecord;
    }
    
    @isTest
    static void testGetAnimalByExternalId(){
        
      	Animal__c expected = prepareData();
        
        RestRequest request = new RestRequest();
		// Set request properties
		request.requestUri = 'https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/'+EXTERNAl_ID;
		request.httpMethod = 'GET';
		RestContext.request = request;
		
        List<Animal__c> actual = AnimalRestResource.getAnimals();
        
		System.assertEquals(expected.Id, actual.get(0).id);
    }
    
    @isTest
    static void testGetAnimalById(){
        
      	Animal__c expected = prepareData();
        
        RestRequest request = new RestRequest();
		// Set request properties
		request.requestUri = 'https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/'+expected.Id;
		request.httpMethod = 'GET';
		RestContext.request = request;
		
        List<Animal__c> actual = AnimalRestResource.getAnimals();
        
		System.assertEquals(expected.Id, actual.get(0).id);
    }
    
    @isTest
    static void testGetAnimals(){
        
      	Animal__c expected = prepareData();
        
        RestRequest request = new RestRequest();
		// Set request properties
		request.requestUri = 'https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/';
		request.httpMethod = 'GET';
		RestContext.request = request;
		
        List<Animal__c> actual = AnimalRestResource.getAnimals();
        
		System.assertEquals(1, actual.size());
    }
    
    @isTest
    static void testPostInternalAnimal(){
        
        Animal__c expected = TestDataFactory.createAnimal(null, null);
        expected.External_Id__c = EXTERNAl_ID;
        update expected;
                
        RestRequest request = new RestRequest();
		// Set request properties
		request.requestUri = 'https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/';
		request.httpMethod = 'POST';
        request.params.put('externalId', EXTERNAl_ID);
		RestContext.request = request;
		
        Animal__c actual = AnimalRestResource.createAnimal(NAME, EATS, SAYS);
        
		System.assertEquals(actual.Name, NAME);
        System.assertEquals(actual.Eats__c, EATS);
        System.assertEquals(actual.Says__c, SAYS);              
    }
    
    @isTest
    static void testPostExternalAnimal(){
        
    	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Create your test data
        Test.startTest();
        RestRequest request = new RestRequest();
		// Set request properties
		request.requestUri = 'https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/';
		request.httpMethod = 'POST';
        request.params.put('externalId', EXTERNAl_ID);
		RestContext.request = request; 
        
        Animal__c actualRun = AnimalRestResource.createAnimal(null, null, null);
        Test.stopTest();
        
        Animal__c actual = [SELECT Name, Eats__c, Says__c FROM Animal__c WHERE Id = :actualRun.Id];
        
		System.assertEquals(NAME, actual.Name);
        System.assertEquals(EATS, actual.Eats__c);
        System.assertEquals(SAYS, actual.Says__c);
         
        }
}