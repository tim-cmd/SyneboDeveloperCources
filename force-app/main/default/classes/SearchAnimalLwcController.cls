public with sharing class SearchAnimalLwcController {
	@AuraEnabled(cacheable=true)
    public static List<Animal__c> getContactList(string searchKey) {
        //string searchKeyword = '%' + searchKey + '%';
		
       // create contact list to store search result 
        List<Animal__c> animalList = new List<Animal__c>();
     
	   // query contact records
        for (Animal__c animal_i : [Select id,Name,Says__c,Eats__C,External_Id__c
                            From Animal__c
                            WHERE External_Id__c = :searchKey]){
           animalList.add(animal_i);
        }
        
         if(animalList.size() == 0){
            throw new AuraHandledException('No Record Found..'); 
         }
         
        return animalList;
    }
}