/**
 * Created by mzulubiev on 08.07.2022.
 */


({
    doInit : function(component, event, helper) {
        helper.getList(component);
    },

    doEventInit : function (component, event, helper) {
        var webinar = event.getParam("webinar");
        component.set("v.WebinarList", webinar);
    },

    doApprove : function(component, event, helper) {
        helper.approve(component, event);

    },

    getDescription : function (component, event, helper) {
        helper.description(component, event);
    },

    doSaveDetails : function (component, event, helper) {
        helper.saveDetails(component, event);
    },

    showModel: function(component, event, helper) {
        component.set("v.showModal", true);
    },

    hideModel: function(component, event, helper) {
        component.set("v.showModal", false);
    }
})