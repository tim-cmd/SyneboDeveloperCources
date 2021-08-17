public class SearchAnimalVFController {

    private Id animalId;
	
    public AnimalServiceWrapper animalWrap;
    public AnimalServiceWrapper.Animal animal = new AnimalServiceWrapper.Animal();
        
    public SearchAnimalVFController(ApexPages.StandardController stdController){
        this.animalId = stdController.getId();  
    }    
    
    public AnimalServiceWrapper.Animal getAnim(){
        animalWrap = AnimalServiceWrapper.parse(this.getSearch());
        animal = animalWrap.animal;
        return animal;
    }
    
    public String getSearch () {
			        
        String recordExternalId = [SELECT External_Id__c FROM Animal__c WHERE Id = :animalId LIMIT 1].External_Id__c;
        
        String response = AnimalsCallouts.makeGetDataCallout(recordExternalId);
        
        //animalWrap = AnimalServiceWrapper.parse(response);
        //animal = animalWrap.animal;
        
        System.debug('Animal: ' + JSON.serialize(animalWrap));
        System.debug('Animal: ' + JSON.serialize(animal));
        
        return response;
    }
    	
    public String getEats (){
        String eats = animalWrap.animal.eats;
        System.debug('getEats(): ' + eats);
        return eats;
    }
    public String getSays (){
        return animalWrap.animal.says;
    }
    public String getName (){
        return animalWrap.animal.name;
    }
    public String getExternalId (){
        return animalWrap.animal.id;
    }
    
    /*
    public Animal getAnimList (){
        List<Animal> animList = new List<Animal>();
        Animal animal = new Animal(AnimalsCallouts.makeGetDataCallout(this.getSearch()));
        
        animList.add(animal);
        return animList;
    }
    */
   
}