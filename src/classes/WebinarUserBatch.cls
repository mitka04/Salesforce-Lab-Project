/**
 * Created by mzulubiev on 14.07.2022.
 */

public with sharing class WebinarUserBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext param1) {
        Datetime currentTime = System.now();
        Datetime twoHoursAfter = System.now().addHours(2);
        return Database.getQueryLocator([SELECT Id, Start_Date__c, (SELECT Related_User__c FROM Webinar_Team_Members__r) FROM Webinar__c WHERE Start_Date__c>:currentTime AND Start_Date__c<:twoHoursAfter]);
    }

    public void execute(Database.BatchableContext param1, List<Webinar__c> webinars) {
        Set<Webinar_Team_Member__c> ids = new Set<Webinar_Team_Member__c>();
        for (Webinar__c webinar : webinars){
            if (webinar.Webinar_Team_Members__r != null) {
                ids.add(webinar.Webinar_Team_Members__r);
            }
        }

        Map<Id, Webinar_Team_Member__c> webinarTeamMemberMap = new Map<Id, Webinar_Team_Member__c>([SELECT Related_webinar__c, Related_User__c
                                                                                                    FROM Webinar_Team_Member__c
                                                                                                    WHERE Id IN :ids]);

        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle('Chatter');
        notification.setNotificationTypeId([SELECT Id FROM CustomNotificationType LIMIT 1].Id);

        Set<String> usersToSendNotification = new Set<String>();
        for (Webinar_Team_Member__c webinarTeamMember : webinarTeamMemberMap.values()){
            if (webinarTeamMember.Related_User__c != null) {
                notification.setBody('Chatter' + webinarTeamMember.Related_webinar__c);
                usersToSendNotification.add(webinarTeamMember.Related_User__c);
            }
        }
        notification.setTargetId(UserInfo.getUserId());
        notification.send(usersToSendNotification);

    }

    public void finish(Database.BatchableContext param1) {
    }
}