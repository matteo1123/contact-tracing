({
    startGame: function (component, event, helper) {
        const combobox = component.find("modeCombobox");
        const currentSelectedMode = component.get("v.selectedMode");
        component.set("v.selectedMode", combobox.get("v.value"));
        if (currentSelectedMode) {
            const boardComp = component.find("board");
            boardComp && boardComp.startGame();
        }
    },
    reshuffleBoard : function(component, event, helper) {
        console.log('shuffle')
    }
})
