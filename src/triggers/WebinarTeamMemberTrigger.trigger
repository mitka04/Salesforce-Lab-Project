/**
 * Created by mzulubiev on 06.07.2022.
 */

trigger WebinarTeamMemberTrigger on Webinar_Team_Member__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        WebinarTeamMemberTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isUpdate) {
        WebinarTeamMemberTriggerHandler.handleBeforeUpdate(Trigger.newMap, Trigger.oldMap);
    }
}