({
    onClickHandler : function(component, event, helper) {
        console.log("clicked")
        const open = component.get("v.open");
        if(!open) {
            component.set("v.open", true);

            const label = component.get("v.label");

            let compEvent = component.getEvent("onclick");
            compEvent.setParams({value: label});
            compEvent.fire();
        }
    }
})
