/**
 * Created by mzulubiev on 13.07.2022.
 */

import {LightningElement, track} from 'lwc';

export default class DoByMyself extends LightningElement {

    @track x = new Date();

    initDate(){
        this.x = new Date();
    }

    updateDate(){
        const cloned = new Date(this.x.getTime());
        cloned.setHours(7);
        this.x = cloned;
    }
}