/**
 * Created by mzulubiev on 06.07.2022.
 */

trigger WebinarTrigger on Webinar__c (after insert, before update) {

    if (Trigger.isAfter && Trigger.isInsert) {
        WebinarTriggerHandler.handleAfterInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        WebinarTriggerHandler.handleBeforeUpdate(Trigger.newMap, Trigger.oldMap);
    }
}