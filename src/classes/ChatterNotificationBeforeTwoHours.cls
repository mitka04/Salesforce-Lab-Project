/**
 * Created by mzulubiev on 14.07.2022.
 */

public with sharing class ChatterNotificationBeforeTwoHours implements Schedulable{

    public void execute(SchedulableContext param1) {

        WebinarUserBatch webinarUserBatch = new WebinarUserBatch();
        Database.executeBatch(webinarUserBatch);

    }
}