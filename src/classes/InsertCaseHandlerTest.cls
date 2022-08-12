/**
 * Created by mzulubiev on 07.07.2022.
 */

@IsTest
private class InsertCaseHandlerTest {

    @IsTest static void TestShouldUpdatePriorityToLow(){
        Case testCase = new Case(Status='Open', Origin='Phone', AccountId='asd');
        insert testCase;

        Test.startTest();
        InsertCaseHandler.updateCase(testCase);
        Test.stopTest();

        System.assertEquals(testCase.Priority, 'Low');
    }

    @IsTest static void TestShouldUpdatePriorityToMedium(){
        Case testCase = new Case(Status='Escalated', Origin='Phone');
        insert testCase;

        Test.startTest();
        InsertCaseHandler.updateCase(testCase);
        Test.stopTest();

        System.assertEquals(testCase.Priority, 'Medium');
    }
}