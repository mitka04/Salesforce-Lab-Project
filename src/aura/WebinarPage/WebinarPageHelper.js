/**
 * Created by mzulubiev on 11.07.2022.
 */

({
    init : function(component, event) {
        // Apex function usage
        var getWebinars = component.get('c.getWebinars');
        getWebinars.setParams({
            queryLimit: 10
        });
        getWebinars.setCallback(this, function(response) {
            if (response.getState() === 'SUCCESS') {
                component.set("v.webinars", response.getReturnValue());
            }
            else {
                console.log('Error');
            }
        });
        $A.enqueueAction(getWebinars);

    }
});