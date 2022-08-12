/**
 * Created by mzulubiev on 07.07.2022.
 */

public class AccountTriggerHandler {
    public static Integer numberOfAccounts = 0;

    public static void handleAfterInsert(List<Account> newList) {

        numberOfAccounts = newList.size();

        for (Account account : newList){
            createContact(account.Id);
        }
    }


    @Future(Callout=true)
    public static void createContact(Id accountId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://randomuser.me/api/?nat=gb?results='+numberOfAccounts);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            JSON2Apex json2Apex = (JSON2Apex) JSON.deserialize(response.getBody(), JSON2Apex.class);
            Contact contact = new Contact(FirstName=json2Apex.results.get(0).name.first, LastName=json2Apex.results.get(0).name.last, AccountId=accountId);
            insert contact;
        }

    }

}