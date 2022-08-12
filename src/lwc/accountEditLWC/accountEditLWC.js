/**
 * Created by mzulubiev on 12.07.2022.
 */

import {LightningElement, api, wire} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class AccountEditLwc extends LightningElement {
    @api recordId;

}