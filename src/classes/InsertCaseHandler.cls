/**
 * Created by mzulubiev on 07.07.2022.
 */

public class InsertCaseHandler {
    public static void updateCase (Case myCase) {
        if (myCase.Status == 'Open'){
            myCase.Priority = 'Low';
        }
        else {
            myCase.Priority = 'Medium';
        }
        update myCase;
    }
}