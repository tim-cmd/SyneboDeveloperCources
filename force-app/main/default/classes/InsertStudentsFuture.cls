global class InsertStudentsFuture {
    
    @future
    public static void createStudent(String name) {
    	Student__c student = new Student__c(Name = name);
        insert student;
                
        System.debug('created Student: ' + student.Id + ', ' + student.Name);
        
//        throw new DmlException('cannot create the Student');
  }

}