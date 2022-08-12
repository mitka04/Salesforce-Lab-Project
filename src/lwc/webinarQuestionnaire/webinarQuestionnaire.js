/**
 * Created by mzulubiev on 12.07.2022.
 */

import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import UserNameFld from '@salesforce/schema/User.Name';

export default class WebinarQuestionnaire extends NavigationMixin(LightningElement) {

    @api recordId;
    @api notification;
    @api queryLimit;
    userId;
    title;
    whyNotRecommend;
    error;

    @wire(getRecord, {recordId: Id, fields: [UserNameFld]})
    userDetails({error, data}) {
        if (data){
            this.title = 'Hi ' + data.fields.Name.value + '!' + ' Share your feedback with us!';
            this.userId = Id;
        } else if (error) {
            this.error = error;
        }
    }

    checkValueOfPicklist(event){
        const value = event.target.value;

        this.whyNotRecommend = (value === 'No');
    }

    // Success handler. You can also use 'event' to check for record Id and navigate to it
    handleSuccess(event) {
        // Showing Toast message
        this.dispatchEvent(new ShowToastEvent({
            title: this.notification,
            variant: 'success'
        }));

        const currentId = event.detail.id;//get record id

        //
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: currentId,
                actionName: "view"
            }
        });
    }

}