/**
 * Created by mzulubiev on 07.07.2022.
 */

@IsTest
private class RestrictContactByNameTest {

    @IsTest
    private static void TestBeforeInsertNameINVALIDNAME(){

        Contact contact = new Contact(LastName='INVALIDNAME');

        Test.startTest();
        try {
            upsert contact;
        }catch (DmlException ex){
            System.AssertEquals(ex.getMessage(), 'The Last Name INVALIDNAME is not allowed for DML');
        }
        Test.stopTest();
    }
}