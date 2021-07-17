trigger StudentTrigger on Student__c (before insert, after insert, before update, after update) {
    StudentTriggerHandler updateParent = new StudentTriggerHandler();
    List<String> newParentIds = new List<String>();
    List<String> oldParentIds = new List<String>();
    
    if (Trigger.isBefore && Trigger.isInsert){
        for(Student__c stud : Trigger.New){
            if (stud.School__c!=null)
            	stud.School_Assigned_Timestamp__c = datetime.now();
        }
        return;
    }
    
    if (Trigger.isBefore && Trigger.isUpdate){
        for(Student__c stud : Trigger.New){
        	if (stud.School__c != trigger.oldMap.get(stud.Id).School__c){
            	if (stud.School__c!=null)
            		stud.School_Assigned_Timestamp__c = datetime.now();
                else
                    stud.School_Assigned_Timestamp__c = null;
        	}
        }
        return;
    }
    
    if (Trigger.isAfter && Trigger.isInsert){
        
        for(Student__c stud : Trigger.New){
            if (stud.School__c != null){
                newParentIds.add(stud.School__c);
            }
        }
        updateParent.lastJoinedUpdNew(newParentIds);
        return;
    }
    
    if (Trigger.isAfter && Trigger.isUpdate){
        
        for(Student__c stud : Trigger.New){
            if (stud.School__c != trigger.oldMap.get(stud.Id).School__c){            
            newParentIds.add(stud.School__c);
            }
        } 
        for(Student__c stud : Trigger.Old){
            if (trigger.oldMap.get(stud.Id).School__c != null){
            oldParentIds.add(stud.School__c);
            }
        }
        
        updateParent.lastJoinedUpdNew(newParentIds);
        updateParent.lastJoinedUpdPrev(oldParentIds);
        return;
    }
}