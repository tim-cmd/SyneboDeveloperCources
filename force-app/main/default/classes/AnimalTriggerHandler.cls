public class AnimalTriggerHandler {
    
    @future(callout=true)
    public static void getAnimalData(List<String> ids){
        List<String> externalIds = new List<String>();
        List<Animal__c> animalList = new List<Animal__c>();
        System.debug('ids: '+ ids);
        
        for(String id : ids){            
        	AnimalServiceWrapper animalWrap = AnimalServiceWrapper.parse(AnimalsCallouts.makeGetDataCallout(id));            
            System.debug(animalWrap.animal.name);
            
            Animal__c anim = new Animal__c (External_Id__c = animalWrap.animal.id,
                                           Name = animalWrap.animal.name,
                                           Eats__c = animalWrap.animal.eats,
                                           Says__c = animalWrap.animal.says);
            animalList.add(anim);
        }
       	System.debug('animalList: '+ animalList);
        
        upsert animalList External_Id__c;
    }
        
}