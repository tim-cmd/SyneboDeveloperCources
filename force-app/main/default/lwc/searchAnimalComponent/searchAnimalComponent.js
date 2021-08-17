import { LightningElement,track} from 'lwc';
// import server side apex class method 
import getAnimalList from '@salesforce/apex/SearchAnimalLWC.getAnimalList';
// import standard toast event 
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
 
export default class customSearch extends LightningElement {
    
    @track animalRecords;
    searchValue = '';
    error;
    results;
 
    // update searchValue var when input field value change
    searchKeyword(event) {
        this.searchValue = event.target.value;
        console.log('onchange searchValue: ' + this.searchValue)
    }
 
    // call apex method on button click 
    handleSearchKeyword() {
        
        if (this.searchValue != '') {
            console.log('onclick searchValue: ' + this.searchValue)
            getAnimalList({
                    'searchKey' : this.searchValue
                })
                console.log('getAnimalList called')
                .then((result) => {
                    console.log("result: " + result);
                    // set @track contacts variable with return contact list from server  
                    this.animalRecords = result;
                    console.log('result assigned: ' + this.animalRecords);
                })
                .catch((error) => {
                    this.error = error.body.message;
                    console.log('error catched: ' + this.error);
                    //const event = new ShowToastEvent({
                    //    variant: 'error',
                    //    message: error.body.message,
                    });
                    //this.dispatchEvent(event);
                    // reset contacts var with null
                    //console.log('reset contacts var with null')   
                    //this.animalsRecord = null;
                //});
        } else {
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
        }
    }
}