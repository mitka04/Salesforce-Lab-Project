/**
 * Created by mzulubiev on 06.07.2022.
 */

public class WebinarTeamMemberTriggerHandler {
    public static void handleBeforeInsert(List<Webinar_Team_Member__c> newList) {
        webinarType(newList);
    }

    public static void handleBeforeUpdate(Map<Id, Webinar_Team_Member__c> newMap, Map<Id, Webinar_Team_Member__c> oldMap) {
        nonDuplicate(newMap.values());
    }

    private static void webinarType(List<Webinar_Team_Member__c> newList){
        Set<Id> ids = new Set<Id>();
        for (Webinar_Team_Member__c webinarTeamMember : newList){
            ids.add(webinarTeamMember.Related_webinar__c);
        }

        Map<Id, Webinar__c> webinarMap = new Map<Id, Webinar__c>([SELECT Id, Type__c FROM Webinar__c WHERE Id IN :ids]);
        System.debug(webinarMap);
        System.debug(newList);
        for (Webinar_Team_Member__c webinarTeamMember : newList){
            if (webinarMap.get(webinarTeamMember.Related_webinar__c).Type__c != 'External' && webinarTeamMember.Related_Contact__c != null) {
                webinarTeamMember.Related_webinar__c.addError('Webinar type should be external');
            }
        }
    }

    private static void nonDuplicate(List<Webinar_Team_Member__c> newList){
        Set<Id> newUserIds = new Set<Id>(); //1
        Set<Id> newContactIds = new Set<Id>(); //1
        Set<Id> newWebinarIds = new Set<Id>(); //1
        Set<Id> dbUserIds = new Set<Id>();
        Set<Id> dbContactIds = new Set<Id>();
        Set<Id> dbWebinarIds = new Set<Id>();

        for (Webinar_Team_Member__c newWebinar : newList){
            newUserIds.add(newWebinar.Related_User__c);
            newContactIds.add(newWebinar.Related_Contact__c);
            newWebinarIds.add(newWebinar.Related_webinar__c);
        }

        for (Webinar_Team_Member__c dbWebinarTeamMember : [SELECT Related_User__c, Related_Contact__c, Related_webinar__c FROM Webinar_Team_Member__c WHERE Related_User__c IN :newUserIds AND Related_Contact__c IN :newContactIds AND Related_webinar__c IN :newWebinarIds]){
            dbUserIds.add(dbWebinarTeamMember.Related_User__c);
            System.debug(dbUserIds);
            dbContactIds.add(dbWebinarTeamMember.Related_Contact__c);
            System.debug(dbContactIds);
            dbWebinarIds.add(dbWebinarTeamMember.Related_webinar__c);
            System.debug(dbWebinarIds);
        }

        for (Webinar_Team_Member__c newWebinarTeamMember : newList){
            if (dbUserIds.contains(newWebinarTeamMember.Related_User__c) &&
            dbContactIds.contains(newWebinarTeamMember.Related_Contact__c) &&
            dbWebinarIds.contains(newWebinarTeamMember.Related_webinar__c)) {
                newWebinarTeamMember.addError('You are inserting duplicate Webinar Team Member');
            }
        }
    }
}



//private static void contactRestriction(List<Webinar_Team_Member__c> newList){
//    Set<Id> webinarIdForNewMembers = new Set<Id>();
//    for(Webinar_Team_Member__c w: newList){
//        webinarIdForNewMembers.add(w.Related_Webinar__c);
//    }
//
//    List<Webinar__c> externalWebinars = [SELECT Id FROM Webinar__c WHERE Id IN :webinarIdForNewMembers AND Type__c='External'];
//    Set<Id> setExternalWebinars = new Set<Id>();
//    for(Webinar__c w : externalWebinars){
//        setExternalWebinars.add(w.Id);
//    }
//
//    for (Webinar_Team_Member__c m : newList){
////            System.debug('XXX ' + m.Related_Webinar__r);
//        if (!setExternalWebinars.contains(m.Related_Webinar__c) && m.Related_Contact__c != null){
//            m.Related_Contact__c.addError('Webinar is not external');
//        }
//    }
//}
