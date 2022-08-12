public with sharing class SEL_Contacts {

    @AuraEnabled (Cacheable = true)
    public static List<Contact> selectContactsWithoutCasesByAccountId(Id accountId, Integer recordsLimit) {
        if (recordsLimit == null) {
            recordsLimit = 5;
        }
        return [
            SELECT Name, Email
            FROM Contact
            WHERE AccountId = :accountId
                AND Id NOT IN (SELECT ContactId FROM Case)
            ORDER BY Name
            LIMIT :recordsLimit
        ];
    }

}