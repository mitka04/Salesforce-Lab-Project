/**
 * Created by mzulubiev on 14.07.2022.
 */

global class EmailNotificationBeforeOneDay implements Schedulable{

    global void execute(SchedulableContext param1) {

        WebinarTeamMemberBatch webinarTeamMemberBatch = new WebinarTeamMemberBatch();
        Database.executeBatch(webinarTeamMemberBatch);

    }
}