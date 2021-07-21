global class InsertStudentsClass {
    @future
    public static void insertStudentFuture(String name) {
    	Student__c student = new Student__c(Name = name);
        insert student;
        System.debug('created student: ' + student.Id + ', ' + student.Name);
        throw new DmlException('cannot create the Student');
  }

}