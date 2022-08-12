/**
 * Created by mzulubiev on 11.07.2022.
 */

({
    onRecordSuccess : function (component, event, helper) {
        $A.get('e.force:refreshView').fire();
    },

    doInit : function(component, event, helper) {
        const actions = [
            {label: 'Approve', name: 'accept'},
            {'label' : 'Reject', 'name' : 'reject'}
        ];
        component.set("v.columns", [
            {'label' : 'Name', 'fieldName': 'Name', 'type' : 'text'},
            {'label' : 'Type', fieldName: 'Type__c', type: 'text'},
            {'label' : 'Cost', fieldName: 'Cost__c', type: 'number'},
            {'label' : 'Price_per_participant', fieldName: 'Price_per_participant__c', type: 'number'},
            {type: 'action', typeAttributes: {rowActions: actions}}
        ]);
        // helper function called

        helper.init(component, event);
    }
});