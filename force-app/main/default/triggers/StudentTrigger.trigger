trigger StudentTrigger on Student__c (before insert, after insert, before update, after update) {
    StudentTriggerHandler updateParent = new StudentTriggerHandler();
    List<String> newParentIds = new List<String>();
    List<String> oldParentIds = new List<String>();
    
    if (Trigger.isBefore && Trigger.isInsert){
        for(Student__c student : Trigger.New){
            if (student.School__c!=null)
            	student.School_Assigned_Timestamp__c = datetime.now();
        }
        return;
    }
    
    if (Trigger.isBefore && Trigger.isUpdate){
        for(Student__c student : Trigger.New){
        	if (student.School__c != trigger.oldMap.get(student.Id).School__c){
            	if (student.School__c!=null)
            		student.School_Assigned_Timestamp__c = datetime.now();
                else
                    student.School_Assigned_Timestamp__c = null;
        	}
        }
        return;
    }
    
    if (Trigger.isAfter && Trigger.isInsert){
        
        for(Student__c student : Trigger.New){
            if (student.School__c != null){
                newParentIds.add(student.School__c);
            }
        }
        updateParent.lastJoinedUpdNew(newParentIds);
        return;
    }
    
    if (Trigger.isAfter && Trigger.isUpdate){
        
        for(Student__c student : Trigger.New){
            if (student.School__c != trigger.oldMap.get(student.Id).School__c){            
            newParentIds.add(student.School__c);
            }
        } 
        for(Student__c student : Trigger.Old){
            if (trigger.oldMap.get(student.Id).School__c != null){
            oldParentIds.add(student.School__c);
            }
        }
        
        updateParent.lastJoinedUpdNew(newParentIds);
        updateParent.lastJoinedUpdPrev(oldParentIds);
        return;
    }
}