public without sharing class SearchAnimalLWC {
	@AuraEnabled(cacheable=true)
    public static List<Animal__c> getAnimalList(string searchKey) {
        //string searchKeyword = '%' + searchKey + '%';
		System.debug('SearchAnimalLWC ==> searchKey: ' + searchKey);
       // create contact list to store search result 
        List<Animal__c> animalList = new List<Animal__c>();
     
	   // query contact records
        for (Animal__c animal_i : [SELECT Name, Eats__c, Says__c, External_Id__c
                            FROM Animal__c
                            WHERE External_Id__c = :searchKey]){
           animalList.add(animal_i);
        }
        
         if(animalList.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
         System.debug('SearchAnimalLWC ==> return: ' + animalList);
        return animalList;
    }
}