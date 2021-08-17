public without sharing class SearchAnimalLWC {
	@AuraEnabled(cacheable=true)
    public static List<Animal__c> getAnimalList(string searchKey) {
	    System.debug('SearchAnimalLWC ==> searchKey: ' + searchKey);
        // create contact list to store search result 
        List<Animal__c> animalList = new List<Animal__c>();
        
        if (searchKey == null || String.isBlank(searchKey)) {
           animalList = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c LIMIT 15];
        } else if (searchKey instanceOf ID){
           animalList = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c WHERE Id = :searchKey];
        } else {
           animalList = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c WHERE External_Id__c = :searchKey];
        } 

        if(animalList.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
        }
        System.debug('SearchAnimalLWC ==> return: ' + animalList);
        return animalList;
    }
}