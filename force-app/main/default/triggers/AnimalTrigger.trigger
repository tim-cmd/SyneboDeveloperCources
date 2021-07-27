trigger AnimalTrigger on Animal__c (after insert) {
    
    List<String> animals = new List<String>();    
    
    if(Trigger.isAfter &&  Trigger.isInsert){
        for (Animal__c animal : Trigger.new){
            animals.add(animal.External_Id__c);
        }
        AnimalTriggerHandler.getAnimalData(animals);        
    }

}