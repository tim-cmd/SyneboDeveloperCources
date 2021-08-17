import { LightningElement, track } from 'lwc';
import getAnimalList from '@salesforce/apex/SearchAnimalLWC.getAnimalList';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class SearchAnimalComponent extends LightningElement {
    @track animals;
    @track error;
    searchValue = '';

    searchKeyword(event) {
        this.searchValue = event.target.value;
        console.log('onchange searchValue: ' + this.searchValue)
    }

    handleSearchKeyword() {
        console.log('onclick searchValue: ' + this.searchValue);
        getAnimalList({searchKey : this.searchValue})
            .then(result => {
                console.log('result: ' + JSON.stringify(result));
                this.animals = result;
            })
            .catch(error => {
                console.log('error: ' + error.body.message);
                this.error = error.body.message;

                const event = new ShowToastEvent({
                        variant: 'error',
                        message: error.body.message,
                });
                this.dispatchEvent(event);
                // reset contacts var with null
                console.log('reset contacts var with null')   
                this.animalsRecord = null;

            });
    }
}