SF org Credentials:
Username: artemlysechko@wise-koala-616r8y.com
Password: odessa2021

json for extention:
[{"Name":"DevCourses.SM21.Artem","SfName":"artemlysechko@wise-koala-616r8y.com","Password":"odessa2021","GroupId":"Require","Description":"","orgId":"","Type":{"Id":"Production","Domain":"https://login.salesforce.com/","LP":"HOME","landingPageOtherUrl":""}}]

Practice 1: 
    Creating Objects and Fields
     School__c
        Class__c
            Student_Card__c - junction between  Class__c and Student__c
        Student__c

Practice 2: Trigger to update a Parent object on the child(s) change
    Student__c.School_Assigned_Timestamp__c is populated when Student__c.School__c is changed;

    StudentTrigger
    WHEN: Student__c record is created and School__c != NULL
    OR WHEN: Student__c.School__c is changed 
    THEN: populate Student__c.School_Assigned_Timestamp__c
    AND: fill in School__r.Last_Student_joined__c by datetime when a child Student__c record was assigned (insert and update)

    TODO: improve by adding delete and undelete statements to Trigger
