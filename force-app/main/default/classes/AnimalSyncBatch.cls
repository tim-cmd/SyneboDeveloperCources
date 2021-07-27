global class AnimalSyncBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
		
    List<Animal__c> animalListToUpsert = new List<Animal__c>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        List<String> externalIds = new List<String>();
        List<Animal__c> animalList = [SELECT Id, External_Id__c FROM Animal__c WHERE External_Id__c!=NULL];
        
        
        for (Animal__c animal : animalList){
            if (Integer.valueOf(animal.External_Id__c) >= 0 && Integer.valueOf(animal.External_Id__c) <= 3)
            externalIds.add(animal.External_Id__c);
        }
        System.debug('ext Ids: '+ externalIds);
        
        for(String id : externalIds){            
        	AnimalServiceWrapper animalWrap = AnimalServiceWrapper.parse(AnimalsCallouts.makeGetDataCallout(id));            
            System.debug(animalWrap.animal.name);
            
            if(!(animalWrap.animal.id.equalsIgnoreCase('0'))){
            Animal__c anim = new Animal__c (External_Id__c = animalWrap.animal.id,
                                           Name = animalWrap.animal.name,
                                           Eats__c = animalWrap.animal.eats,
                                           Says__c = animalWrap.animal.says);
            animalListToUpsert.add(anim);
            } else System.debug('no data for id: ' + id);
        }
       	System.debug('animalListToUpsert: '+ animalListToUpsert);
        
        
            
         return Database.getQueryLocator('SELECT Id, External_Id__c FROM Animal__c WHERE External_Id__c!=NULL');
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope){
        
        upsert animalListToUpsert External_Id__c;
    }
    
    global void finish(Database.BatchableContext bc){
        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        System.debug(JSON.serialize(job));
    }
}