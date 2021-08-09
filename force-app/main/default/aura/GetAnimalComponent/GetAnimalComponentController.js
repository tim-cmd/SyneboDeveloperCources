({
    
    doInit: function(component, event, helper){
    	helper.getAnimals(null, component);
	},
     
    searchAnimals : function(component, event, helper) {
        var searchValue = component.get("v.inputId");
        console.log("searchValue " + searchValue);
		helper.getAnimals(searchValue, component);
	}
});