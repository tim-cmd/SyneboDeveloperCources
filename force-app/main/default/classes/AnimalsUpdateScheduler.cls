global class AnimalsUpdateScheduler implements Schedulable{
    global void execute(SchedulableContext ctx){
        AnimalSyncBatch animalUpd = new AnimalSyncBatch();
		Database.executeBatch(animalUpd);
    }
}