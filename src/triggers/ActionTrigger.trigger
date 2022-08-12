/**
 * Created by mzulubiev on 21.07.2022.
 */

trigger ActionTrigger on Action__c (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {
        ActionTriggerHandler.handleAfterUpdate(Trigger.oldMap, Trigger.new);
    }

}