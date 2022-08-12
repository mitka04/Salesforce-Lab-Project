/**
 * Created by mzulubiev on 08.07.2022.
 */

({
    doSave: function (component, event, helper) {
        var fields = event.getParam('fields');
        console.log(JSON.stringify(fields));
        var webinar = component.find('form').submit(fields);



        var appEvent = $A.get("e.c:passWebinar");
        appEvent.setParams({"webinar" : webinar});
        appEvent.fire();
    }
});