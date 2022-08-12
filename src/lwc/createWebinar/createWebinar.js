/**
 * Created by mzulubiev on 13.07.2022.
 */

import {LightningElement, api, wire} from 'lwc';
import {CloseActionScreenEvent} from "lightning/actions";
import insertWebinar from '@salesforce/apex/InsertWebinar.insetWebinarWithValues';
import {NavigationMixin} from "lightning/navigation";
import {ShowToastEvent} from "lightning/platformShowToastEvent";


export default class CreateWebinar extends NavigationMixin(LightningElement) {

    @api objectApiName;
    @api name;
    @api type;
    @api cost;
    @api pricePerParticipant;
    error='Webinar name should not be empty!';


    closeWindow(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    getName(event){
        this.name = event.target.value;
    }

    getType(event){
        this.type = event.target.value;
    }

    getCost(event){
        this.cost = event.target.value;
    }

    getPricePerParticipant(event){
        this.pricePerParticipant = event.target.value;
    }

    handleSubmit(){
        if (this.name) {
            insertWebinar({
                name: this.name,
                type: this.type,
                cost: this.cost,
                pricePerParticipant: this.pricePerParticipant
            }).then(r => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Webinar was created',
                    variant: 'success'
                }));

                this[NavigationMixin.Navigate]({
                    type: "standard__recordPage",
                    attributes: {
                        recordId: r,
                        actionName: "view"
                    }
                });
            });
        }else{
        }
    }
}