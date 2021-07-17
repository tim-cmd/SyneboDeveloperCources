public class StudentTriggerHandler {
    public void lastJoinedUpdNew (List<String> schoolsNew){
        List<School__c> schoolsToUpdate = [SELECT Id FROM School__c WHERE Id IN :schoolsNew];
        
        if (schoolsToUpdate.size()>0){
            for (School__c sc : schoolsToUpdate){
                sc.Last_Student_joined__c = datetime.now();
            }
			update schoolsToUpdate;             
        }
    }

    public void lastJoinedUpdPrev (List<String> schoolsOld){
        List<School__c> schoolsList = [SELECT Id FROM School__c WHERE Id IN :schoolsOld];
        Map<Id,Datetime> oldSchoolsToUpdate = new Map<Id,Datetime>();
        AggregateResult[] results = [SELECT School__c, MAX(School_Assigned_Timestamp__c)time 
                                     FROM Student__c 
                                     WHERE School__c IN :schoolsOld 
                                     GROUP BY School__c];
        
        for (AggregateResult ar : results){
            oldSchoolsToUpdate.put((Id) ar.get('School__c'), (Datetime) ar.get('time'));
        }
        
        for (School__c sc : schoolsList){
            
                sc.Last_Student_joined__c = oldSchoolsToUpdate.get(sc.Id);
            }
			update schoolsList;             
        }    

}