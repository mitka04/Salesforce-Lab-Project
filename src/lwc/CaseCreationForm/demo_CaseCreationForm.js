import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord }  from 'lightning/uiRecordApi';
import CONTACT_NAME_FIELD from '@salesforce/schema/Contact.Name';

const FIELDS = [
    CONTACT_NAME_FIELD
];

export default class DemoCaseCreationForm extends LightningElement {

    @api accountId;
    @api contactId;
    isLoading = false;

    // Wired contact using Lightning Data Service.
    // Use LDS always when possible because it uses cached values without querying to Database
    @wire(getRecord, {recordId : '$contactId', fields: FIELDS})
    contact;

    saveRecord(event) {
        this.isLoading = true;
    }

    // Value getter. It will recalculate every time tracked (api/track) properties inside will be changed
    get title() {
        let title = 'Create new Case';
        if (this.contact.data) {
            title += ' for ' + this.contact.data.fields.Name.value;
        }
        return title;
    }

    // Success handler. You can also use 'event' to check for record Id and navigate to it
    handleSuccess(event) {
        // Firing CustomEvent. No need for creating another file/registering anything just to use an event.
        this.dispatchEvent(new CustomEvent('casecreated'));
        // Showing Toast message
        this.dispatchEvent(new ShowToastEvent({
            title: 'Case Created',
            variant: 'success'
        }));
        this.isLoading = false;
    }

}