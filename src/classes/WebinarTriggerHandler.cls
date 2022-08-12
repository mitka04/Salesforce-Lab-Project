/**
 * Created by mzulubiev on 06.07.2022.
 */

public class WebinarTriggerHandler {
    public static void handleAfterInsert(List<Webinar__c> newList) {
        for (Webinar__c webinar : newList){
            WebinarEvent__e webinarEvent = new WebinarEvent__e(salesforce_id__c=webinar.Id);
            EventBus.publish(webinarEvent);
        }
    }

    public static void handleBeforeUpdate(Map<Id, Webinar__c> newMap, Map<Id, Webinar__c> oldMap) {
        rejectIfStatusCanceled(newMap.values());
    }


    private static void approveIfCostBelow100(List<Webinar__c> newList){
        for (Webinar__c webinar : newList){
            if (webinar.Cost__c < 100) {
                webinar.Approval__c = 'Approved';
            }
        }
    }

    private static void rejectIfStatusCanceled(List<Webinar__c> newList){
        for (Webinar__c webinar : newList){
            if (webinar.Approval__c == 'Rejected') {
                webinar.Status__c = 'Canceled';
            }
        }
    }
}