/**
 * Created by mzulubiev on 08.07.2022.
 */

({
    getList: function(component) {
        var action = component.get('c.getWebinarsAbove100');
// Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {
                component.set('v.WebinarList', actionResult.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    approve: function (component, event){
        var webinar = event.target.closest("[data-id]").dataset.id;
        var action = component.get("c.approveWebinar");

        action.setParams({"recordId" : webinar});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS'){
                $A.get('e.force:refreshView').fire();
            }else{
                console.log(response);
            }
        })

        $A.enqueueAction(action);
    },

    reject : function (component, event) {
        var webinar = event.target.closest("[data-id]").dataset.id;
        var action = component.get("c.rejectWebinar");

        action.setParams({"recordId" : webinar});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS'){
                $A.get('e.force:refreshView').fire();
            }else{
                console.log(response);
            }
        })

        $A.enqueueAction(action);
    },

    description : function (component, event) {
        var description = event.detail.value;

        component.set("v.description", description);
    },

    saveDetails: function(component, event, helper) {
        var webinar = event.target.closest("[data-id]").dataset.id;
        var description = component.get("v.description");
        var action = component.get("c.rejectWebinar");

        action.setParams({"recordId" : webinar, "description" : description});

        action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === 'SUCCESS'){
                    component.set("v.showModal", false);
                    $A.get('e.force:refreshView').fire();
                }else{
                    console.log(response);
                }
            }
        )

        $A.enqueueAction(action);
    }
})