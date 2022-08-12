

public with sharing class ChatterBatch implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext param1) {
//        return Database.getQueryLocator([SELECT Name, Start_Date__c, OwnerId, (SELECT Id, Contact__c FROM Webinar_Team_Members__r) FROM Webinar__c WHERE Start_Date__c=:System.today().addDays(1)]);
        return Database.getQueryLocator([SELECT Id, User__c FROM Webinar_Team_Member__c WHERE Webinar__r.Start_Date__c =:System.now().addHours(2)]);
//
    }
    public void execute(Database.BatchableContext param1, List<Webinar_Team_Member__c> participants) {

        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setBody('This is body of the custom notification!');
        notification.setTitle('Hi this is first notification sent using apex!');
        notification.setNotificationTypeId([SELECT Id FROM CustomNotificationType LIMIT 1].Id);
        notification.setTargetPageRef();

        Set<String> userids = new Set<String>();
        for(Webinar_Team_Member__c participant : participants)
        {
            System.debug(participant.User__c);

            userids.add(participant.User__c);
        }
        notification.send(userids);
    }
    public void finish(Database.BatchableContext param1) {
    }
}