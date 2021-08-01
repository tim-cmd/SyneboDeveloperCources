@isTest
private class AnimalsUpdateSchedulerTest {
    
	private static final String NAME = 'rat';
    private static final String EXTERNAl_ID = '99';
    private static final String EATS = 'cheese';
    private static final String SAYS = 'piy piy';
	    
    @isTest
    static void schedulerTest() {
//        String CRON_EXP = '0 0 0 15 3 ? *';
        
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Create your test data
        List<Animal__c> testData = new List<Animal__c>();
        for (Integer i = 0; i<1; i++){
        	Animal__c anim = new Animal__c (Name = 'mouse');
        	testData.add(anim);
        }
        insert testData;
        
        for (Animal__c an : testData){
            an.External_Id__c = EXTERNAl_ID;
        }
        update testData;
        
        Test.startTest();

//            String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new AnimalsUpdateScheduler());
//            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
//            System.assertEquals(CRON_EXP, ct.CronExpression);
//            System.assertEquals(0, ct.TimesTriggered);
		
        AnimalsUpdateScheduler scheduler = new AnimalsUpdateScheduler();
        scheduler.execute(null);            

        Test.stopTest();
        // Add assert here to validate result        

		List<Animal__c> dataProcessed = [SELECT Name, Eats__c, Says__c FROM Animal__c 
                                        WHERE External_Id__c = :EXTERNAl_ID LIMIT 1];
        System.assertEquals(1, dataProcessed.size());
        
        for (Animal__c actual : dataProcessed){
        	System.assertEquals(NAME, actual.Name);
            System.assertEquals(EATS, actual.Eats__c);
            System.assertEquals(SAYS, actual.Says__c);
        }
    }
}