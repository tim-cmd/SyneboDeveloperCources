@isTest
public class AnimalsCalloutsTest {

    @isTest
    static void testGetCallout() {
        
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test
        String result = AnimalsCallouts.makeGetDataCallout('99');
        
        // Verify mock response is not null
        System.assertNotEquals(null,result);              
    }
    
    @isTest
    static void testFailGetCallout() {
        
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test
        String result = AnimalsCallouts.makeGetDataCallout('99');
        
        // Verify mock response is not null
        System.assertEquals('not 200 response code',result);              
    }
    
}