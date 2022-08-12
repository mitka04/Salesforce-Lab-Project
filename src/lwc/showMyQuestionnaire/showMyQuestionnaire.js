/**
 * Created by mzulubiev on 13.07.2022.
 */

import {LightningElement, api, wire} from 'lwc';
import selectQuestionnairesByUserId from '@salesforce/apex/ShowMyQuestionnaires.selectQuestionnairesByUserId';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Created By', fieldName: 'CreatedById' }
];

export default class ShowMyQuestionnaire extends LightningElement {

    @api getUserIdFromParent;
    checkForDisplayOrNot;

    @wire(selectQuestionnairesByUserId, {userId: '$getUserIdFromParent'})
    questionnaires;


    columns = columns;

    showMyQuestionnaires(){
        this.checkForDisplayOrNot = true;
    }

    hideMyQuestionnaires(){
        this.checkForDisplayOrNot = false;
    }

}