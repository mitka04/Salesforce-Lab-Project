/**
 * Created by mzulubiev on 07.07.2022.
 */

@IsTest
private class WebinarTeamMemberTriggerHandlerTest {


    @IsTest
    static void testBeforeInsertWebinarType() {

        List<Webinar_Team_Member__c> webinarTeamMembers = new List<Webinar_Team_Member__c>();

        Contact contact = new Contact(LastName='Test');
        insert contact;
        Webinar__c webinar = new Webinar__c(Name='Test', Type__c='Internal');
        insert webinar;
        Webinar_Team_Member__c webinarTeamMember = new Webinar_Team_Member__c(Name='Test', Related_Contact__c=contact.Id, Related_webinar__c=webinar.Id);
        webinarTeamMembers.add(webinarTeamMember);

        Test.startTest();
        try {
            insert webinarTeamMembers;
        }catch (DmlException ex){
            System.assertEquals('Webinar type should be external', webinarTeamMember.getErrors()[0].getMessage());
        }
        Test.stopTest();

    }

    @IsTest
    static void testBeforeUpdateNonDuplicate(){
        List<Webinar_Team_Member__c> webinarTeamMembers = new List<Webinar_Team_Member__c>();

        Contact contact = new Contact(LastName='Test');
        insert contact;
        User user = new User(Alias = 'standt', Email='standarduser@testorg.com',
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', ProfileId = [SELECT Id FROM Profile WHERE Name='Marketing User'].Id,
                TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        insert user;
        System.debug(user);
        Webinar__c webinar = new Webinar__c(Name='Test', Type__c='Internal');
        insert webinar;
        Webinar_Team_Member__c webinarTeamMember = new Webinar_Team_Member__c(Name='Test', Related_Contact__c=contact.Id, Related_webinar__c=webinar.Id, Related_User__c=user.Id);
        webinarTeamMembers.add(webinarTeamMember);
        insert webinarTeamMembers;

        Test.startTest();
        try {
            insert webinarTeamMembers;
        }catch (DmlException ex){
            System.assertEquals('You are inserting duplicate Webinar Team Member', ex.getMessage());
        }
        Test.stopTest();
    }

}