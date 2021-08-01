global class AnimalSyncBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    List<String> externalIds = new List<String>(); 
    List<Animal__c> animalListToUpsert = new List<Animal__c>();

    global Database.QueryLocator start(Database.BatchableContext bc) {
            
         return Database.getQueryLocator('SELECT id, External_Id__c FROM Animal__c WHERE External_Id__c!=NULL');
    }
    
    global void execute(Database.BatchableContext bc, List<Animal__c> scope){        

        for (Animal__c a : scope){
            externalIds.add(a.External_Id__c);
        }
                       
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