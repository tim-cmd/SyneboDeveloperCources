public class AnimalTriggerHandler {
    
    @future(callout=true)
    public static void getAnimalData(List<String> externalIds){

        List<Animal__c> animalListToUpsert = new List<Animal__c>();

        // List<String> externalIds = new List<String>();
        // List<Animal__c> animalList = [SELECT Id, External_Id__c FROM Animal__c WHERE Id IN :ids];       
        
        // for (Animal__c animal : animalList){
        //     if (Integer.valueOf(animal.External_Id__c) >= 0 && Integer.valueOf(animal.External_Id__c) <= 3)
        //     externalIds.add(animal.External_Id__c);
        // }
        // System.debug('ext Ids: '+ externalIds);
        
        for(String id : externalIds){            
        	AnimalServiceWrapper animalWrap = AnimalServiceWrapper.parse(AnimalsCallouts.makeGetDataCallout(id));            
            System.debug('received animal name: ' + animalWrap.animal.name);
            
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
        
}