/**
 * Created by mzulubiev on 13.07.2022.
 */

public with sharing class InsertWebinar {

    @AuraEnabled
    public static Id insetWebinarWithValues(String name, String type, Integer cost, Integer pricePerParticipant){
        Webinar__c webinar = new Webinar__c(Name=name, Type__c=type, Cost__c=cost, Price_per_participant__c=pricePerParticipant);
        insert webinar;
        return webinar.Id;
    }
}