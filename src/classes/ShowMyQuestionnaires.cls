/**
 * Created by mzulubiev on 13.07.2022.
 */

public with sharing class ShowMyQuestionnaires {

    @AuraEnabled (Cacheable = true)
    public static List<Questionnaire__c> selectQuestionnairesByUserId(Id userId, Integer queryLimit) {
        if (queryLimit == null) {
            queryLimit = 5;
        }

        return [
                SELECT Name, CreatedById
                FROM Questionnaire__c
                WHERE CreatedById =:userId
                LIMIT :queryLimit
        ];
    }

}