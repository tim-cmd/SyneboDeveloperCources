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

Practice 3: Async Apex
    
    0. InsertStudentsFuture  - @future method to creating a single Student__c record.

            anon call: InsertStudentsFuture.insertStudentFuture('future st');

    1.1  SchoolInsertQueueble  - Queueable to creating a single School__c record (Parent);
        StudentsInsertQueueable  - Queueable to creating multiple Student__c records (Childs), call from SchoolInsertQueueble.execute().

        anon call: 
        //constructor parameter: Parent Name
            SchoolInsertQueueble queueable = new AsyncInsertSchools('Some School Name');
            System.enqueueJob(queueable);

    1.2 SchoolWithStudentsQueueable  - combined logic (Parent wit Childs in one Class).

        anon call: 
        //constructor parameters: Parent Name, Number of Childs to insert 
            SchoolWithStudentsQueueable queueable = new SchoolWithStudentsQueueable('Queuebles joined test 2', 5);
            System.enqueueJob(queueable);

    2. SchoolDataFixBatch - Batch to populate School__c.Last_Child_Date__c = MAX(CreatedDate) from child Student__c records.
        
        Generate data Anon.apex - scripts for generating test data
        
        Erase School's value to test: 
            List<School__c> schools = [SELECT Id, Last_Child_Date__c FROM School__c];
                for (School__c sc : schools){
                sc.Last_Child_Date__c =NULL;
                }
                update schools;

        Run Batch job:
            SchoolDataFixBatch schoolFix = new SchoolDataFixBatch();
            Database.executeBatch(schoolFix);

Practice 4:

    1. Trigger to update an Animal__c record by ExternalId (get data from Web Service)
        AnimalTrigger
        AnimalTriggerHandler
        AnimalsCallouts
        AnimalServiceWrapper

    2. Scheduler + Batch to update existing records by ExternalId
        AnimalSyncBatch
        AnimalsUpdateScheduler

        anon to start scheduler: 
        AnimalsUpdateScheduler scheduler = new AnimalsUpdateScheduler();
        scheduler.execute(null);

Practice 5:
    Postman collection: https://www.getpostman.com/collections/aa2729d9a95c22071384
    
    AnimalRestResource - main class
        WebService URL:  https://animals-rest-resource-developer-edition.eu40.force.com/services/apexrest/Animals/

        GET : specify SF Id or External Id at the end of URL  to get a specific Animal__c record OR left it blank to get all Animals
        POST : specify externalId as a parameter and JSON body parameters name, eats, says to upsert a record in SF
                {
                "name":"turtle",
                "eats":"weed",
                "says":"hhhhr"
                }

Practice 6: Unit testing
    
    Pr2: StudentTriggerHandlerTest, TestDataFactory
    Pr3: InsertStudentsFutureTest,  SchoolWithStudentsQueueableTest, SchoolDataFixBatchTest
    Pr4: 
