/**
 * Created by mzulubiev on 14.07.2022.
 */

public with sharing class WebinarTeamMemberBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator([SELECT Id, Start_Date__c, (SELECT Related_Contact__c FROM Webinar_Team_Members__r) FROM Webinar__c WHERE Start_Date__c=TOMORROW]);
    }

    public void execute(Database.BatchableContext param1, List<Webinar__c> webinars) {

        Set<Webinar_Team_Member__c> ids = new Set<Webinar_Team_Member__c>();
        for (Webinar__c webinar : webinars){
            if (webinar.Webinar_Team_Members__r != null) {
                ids.add(webinar.Webinar_Team_Members__r);
            }
        }

        Map<Id, Webinar_Team_Member__c> webinarTeamMemberMap = new Map<Id, Webinar_Team_Member__c>([SELECT Related_webinar__c, Related_Contact__c
                                                                            FROM Webinar_Team_Member__c
                                                                            WHERE Id IN :ids]);

        List<Messaging.SingleEmailMessage> lstEmail = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail1=new Messaging.SingleEmailMessage();

        for (Webinar_Team_Member__c webinarTeamMember : webinarTeamMemberMap.values()){
            if (webinarTeamMember.Related_Contact__c != null) {
                String[] toAddress = new String[]{ webinarTeamMember.Related_Contact__c };
                mail1.setToAddresses(toAddress);
                mail1.setSubject('Email notification before 1 day for webinar: ' + webinarTeamMember.Related_webinar__c);
                mail1.setPlainTextBody('Email notification before 1 day');
                lstEmail.add(mail1);
            }
        }

        Messaging.sendEmail(lstEmail);

    }

    public void finish(Database.BatchableContext param1) {
    }
}