({
	getAnimals : function(searchVal, component) {
        
        component.set("v.columnsToDisplay", [
            { label : "External ID", fieldName: "External_Id__c", type: "text" },
            { label : "Animal Name", fieldName: "Name", type: "text" },
            { label : "Eats", fieldName: "Eats__c", type: "text" },
            { label : "Says", fieldName: "Says__c", type: "text" }
        ]);
        
		var action = component.get("c.getAnimalData");
        action.setParams({
            inputId : searchVal
        });
        
        action.setCallback(this, function(response){
			var state = response.getState();
        	if (state === "SUCCESS"){
            	console.log(response.getReturnValue());
             	component.set("v.animalsList", response.getReturnValue());
            } else {
                alert("error while trying to get data");
            }
		});
        
        $A.enqueueAction(action);
	}

})