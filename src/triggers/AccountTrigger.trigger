/**
 * Created by mzulubiev on 07.07.2022.
 */

trigger AccountTrigger on Account (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {
        AccountTriggerHandler.handleAfterInsert(Trigger.new);
    }

}