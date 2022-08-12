/**
 * Created by mzulubiev on 21.07.2022.
 */

trigger TeamTrigger on Team__c (before insert, before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        TeamTriggerHandler.handleBeforeUpdate(Trigger.new);
    }
}