/**
 * Created by mzulubiev on 08.07.2022.
 */

public with sharing class GetWebinars {

    @AuraEnabled
    public static List<Webinar__c> getWebinarsAbove100(){
        List<Webinar__c> webinars = [SELECT Id, Name, Approval__c FROM Webinar__c WHERE Cost__c > 100 AND Approval__c='Pending'];
        return webinars;
    }

    @AuraEnabled
    public static void approveWebinar(Id recordId){
        Webinar__c getWebinar = [SELECT Id, Name, Approval__c FROM Webinar__c WHERE Id =:recordId];
        getWebinar.Approval__c = 'Approved';
        update getWebinar;
    }

    @AuraEnabled
    public static void rejectWebinar(Id recordId, String description){
        System.debug(recordId);
        System.debug(description);
        Webinar__c getWebinar = [SELECT Id, Name, Approval__c FROM Webinar__c WHERE Id =:recordId];
        getWebinar.Approval__c = 'Rejected';
        getWebinar.Description__c = description;
        update getWebinar;
    }
}