//first
List<School__c> parents = new List<School__c>();
School__c sc;

for (Integer i = 0; i<200; i++){
	sc = new School__c (Name = 'Generate Parent for Batch ' + String.valueOf(i));
    parents.add(sc);
}
insert parents;

// next
List<School__c> parents = [SELECT Id FROM School__c WHERE Name LIKE 'Generate Parent%' ];
List<Student__c> childs = new List<Student__c>();
Student__c st;

for (School__c sc : parents){
	for (Integer i = 0; i<5; i++){
	st = new Student__c (Name = 'Generate Child for Batch ' + String.valueOf(i),
                        School__c = sc.Id);
    childs.add(st);
	}
}
insert childs;