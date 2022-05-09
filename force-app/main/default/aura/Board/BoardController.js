({
    doInit : function(component, event, helper) {
        const gameMode = component.get("v.mode");
        const columns = gameMode && gameMode === "hard" ? 6 : gameMode === "medium" ? 4 : 3;
        component.set("v.blockWidth", 12 / columns);
        const words = helper.getWords(columns * columns);
        component.set("v.words", words);
        component.set("v.winWord", helper.getWinWord(words));
    },
    doRender : function(component, event, helper) {
        console.log("Render");
    },

    blockClickHandler : function(component, event, helper) {
        let clickCount = component.get("v.clickCount") + 1;
        const value = event.getParam("value");
        if (value === component.get("v.winWord")) {
            component.set("v.result", "You Win!");
            console.log("you win")
            helper.disableBoard(component);
        } else if (clickCount === 3) {
            component.set("v.result", "You Lose");
            console.log("you Lose")
            helper.disableBoard(component);
        }
        component.set("v.clickCount", clickCount);
    }
})
