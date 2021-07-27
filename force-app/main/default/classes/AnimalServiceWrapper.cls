public class AnimalServiceWrapper {
	public Animal animal;

	public class Animal {
		public String id;
		public String name;
		public String eats;
		public String says;
	}

	
	public static AnimalServiceWrapper parse(String json) {
		return (AnimalServiceWrapper) System.JSON.deserialize(json, AnimalServiceWrapper.class);
	}
}