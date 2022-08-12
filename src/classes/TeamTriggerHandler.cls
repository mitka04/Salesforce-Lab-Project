/**
 * Created by mzulubiev on 21.07.2022.
 */

public class TeamTriggerHandler {

    public static void handleBeforeInsert(List<Team__c> newList){

    }

    public static void handleBeforeUpdate(List<Team__c> newList){
        Set<Id> parentIds = new Set<Id>();
        for (Team__c team : newList){
            parentIds.add(team.Id);
        }

        Map<Id, List<Employee__c>> mapOfChildObjectEmployee = new Map<Id, List<Employee__c>>();
        for (Employee__c employee : [SELECT Id, Total_points__c, Reference_to_Team__c FROM Employee__c WHERE Reference_to_Team__c=:parentIds]){
            if(!mapOfChildObjectEmployee.containsKey(employee.Reference_to_Team__c)){
                mapOfChildObjectEmployee.put(employee.Reference_to_Team__c, new List<Employee__c>{employee});
            }else{
                mapOfChildObjectEmployee.get(employee.Reference_to_Team__c).add(employee);
            }
        }

//        Map<Id, List<Team__c>> mapOfChildObjectTeam = new Map<Id, List<Team__c>>();
//        for (Team__c team : [SELECT Id, Total_Points__c, Parent_Team__c, Type__c FROM Team__c WHERE Parent_Team__c IN:parentIds AND Type__c = 'Team']){
//            if(!mapOfChildObjectTeam.containsKey(team.Parent_Team__c)){
//                mapOfChildObjectTeam.put(team.Parent_Team__c, new List<Team__c>{team});
//            }else{
//                mapOfChildObjectTeam.get(team.Parent_Team__c).add(team);
//            }
//        }
//
//        Map<Id, List<Team__c>> mapOfChildObjectCountry = new Map<Id, List<Team__c>>();
//        for (Team__c team : [SELECT Id, Total_Points__c, Parent_Team__c, Type__c FROM Team__c WHERE Parent_Team__c IN:parentIds AND Type__c = 'Office']){
//            if(!mapOfChildObjectCountry.containsKey(team.Parent_Team__c)){
//                mapOfChildObjectCountry.put(team.Parent_Team__c, new List<Team__c>{team});
//            }else{
//                mapOfChildObjectCountry.get(team.Parent_Team__c).add(team);
//            }
//        }

        for (Team__c team : newList){
            if (team.Type__c == 'Team' && !mapOfChildObjectEmployee.isEmpty()) {
                for (Employee__c employee : mapOfChildObjectEmployee.get(team.Id)) {
                    team.Total_Points__c += employee.Total_points__c;
                }
            }
//            if (team.Type__c == 'Office' && !mapOfChildObjectTeam.isEmpty()) {
//                for (Team__c teamChild: mapOfChildObjectTeam.get(team.Id)) {
//                    team.Total_Points__c += teamChild.Total_Points__c;
//                }
//            }
//            if (team.Type__c == 'Country' && !mapOfChildObjectCountry.isEmpty()) {
//                for (Team__c teamChildTypeCountry: mapOfChildObjectCountry.get(team.Id)) {
//                    team.Total_Points__c += teamChildTypeCountry.Total_Points__c;
//                }
//            }
        }
    }
}