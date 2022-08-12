/**
 * Created by mzulubiev on 21.07.2022.
 */

public class ActionTriggerHandler {

    public static void handleAfterUpdate(List<Action__c> newList) {
        EmployeeAction__c employeeAction = [SELECT Id FROM EmployeeAction__c WHERE Id='a067Q000002AmTFQA0'];
        employeeAction.Status__c = 'Failed';
        update employeeAction;
//        Set<Id> parentIds = new Set<Id>();
//        for (Action__c action : newList){
//            parentIds.add(action.Id);
//        }
//
//        Map<Id, List<EmployeeAction__c>> mapOfChildObject = new Map<Id, List<EmployeeAction__c>>();
//        for (EmployeeAction__c employeeAction : [SELECT Id, Status__c, Reference_to_Action__c FROM EmployeeAction__c WHERE Reference_to_Action__c=:parentIds AND Status__c != 'Completed']){
//            if(!mapOfChildObject.containsKey(employeeAction.Reference_to_Action__c)){
//                mapOfChildObject.put(employeeAction.Reference_to_Action__c, new List<EmployeeAction__c>{employeeAction});
//            }else{
//                mapOfChildObject.get(employeeAction.Reference_to_Action__c).add(employeeAction);
//            }
//        }
//
//        List<EmployeeAction__c> listEmployeeActions = new List<EmployeeAction__c>();
//        for (Action__c action : newList){
//            if (action.Status__c == 'Finished') {
//                for (EmployeeAction__c employeeAction : mapOfChildObject.get(action.Id)){
//                    employeeAction.Status__c = 'Failed';
//                    listEmployeeActions.add(employeeAction);
//                }
//            }
//        }
//
//        if (listEmployeeActions.size() > 0) {
//            update listEmployeeActions;
//        }

    }

}