@RestResource(urlMapping='/Animals/*')
global without sharing class AnimalRestResource {
    
    @HttpGet
    global static List<Animal__c> getAnimals(){
        List<Animal__c> result = new List<Animal__c>();
        RestRequest request = RestContext.request;
        
        // grab the animalId from the end of the URL
        String animalId = request.requestURI.substring(
        request.requestURI.lastIndexOf('/')+1);
        
        if (String.isBlank(animalId)){
            result = [SELECT External_Id__c,Name,Eats__c,Says__c FROM Animal__c];
        	return result;
            
        } else if (animalId instanceOf Id){
            result =  [SELECT Id, External_Id__c,Name,Eats__c,Says__c
                       FROM Animal__c
                       WHERE Id = :animalId];
            return result;
            
        } else {
            result = [SELECT Id, External_Id__c,Name,Eats__c,Says__c
                      FROM Animal__c
                      WHERE External_Id__c = :animalId];
            return result;
        }
    }
    
    @HttpPost
    global static Animal__c createAnimal(String name, String eats, String says) {
            
        RestRequest animalRequest = RestContext.request;
        
        String externalId = animalRequest.params.get('externalId');      

//        String animalRequestURI = animalRequest.requestURI;
//        String externalId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);

        List<Animal__c> animalsInternal = [SELECT External_Id__c FROM Animal__c WHERE External_Id__c = :externalId];
        String responceExternalId;

            if (animalsInternal.size() == 0){
                AnimalServiceWrapper animalWrap = AnimalServiceWrapper.parse(AnimalsCallouts.makeGetDataCallout(externalId));            
                System.debug('received animal name: ' + animalWrap.animal.name);
                responceExternalId = animalWrap.animal.id;
            }
            if(!(responceExternalId.equalsIgnoreCase('0'))){
                Animal__c thisAnimal = new Animal__c (External_Id__c = externalId);             
                insert  thisAnimal;
                return thisAnimal;
            } else {
                    Animal__c thisAnimal = new Animal__c(
                        Name = name,
                        External_Id__c = externalId,
                        Eats__c = eats,
                        Says__c = says);
                    upsert thisAnimal External_Id__c;
                    return thisAnimal;
                }
    }
    
}