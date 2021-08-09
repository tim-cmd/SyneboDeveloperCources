public class GetAnimalCMPController {
    
    @AuraEnabled
    public static List<Animal__c> getAnimalData(String inputId){
        
        List<Animal__c> animal = new List<Animal__c>();
        
         if (inputId == null || String.isBlank(inputId))
            animal = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c LIMIT 15];
         else if (inputId instanceOf ID)
            animal = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c WHERE Id = :inputId];
         else 
            animal = [SELECT External_Id__c, Name, Eats__c, Says__c FROM Animal__c WHERE External_Id__c = :inputId];
    		
        return animal;
	}
}