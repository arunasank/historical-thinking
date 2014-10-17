function create() {
    var basicLine;

    if(historyWindow.timelineCount > 0)
    {
        basicLine = Qt.createComponent("../view/BasicLine.qml").createObject(historyWindow,
                                    {"objectName":"basicLine" + (historyWindow.basiclineNameCount)});
        console.log(basicLine);
        basicLine.y = 100;
        basicLine.x = 250*historyWindow.basicLineCount;

        if(basicLine.placementX > scrollableWindow.width){
            historyWindow.width += 2* basicLine.placementX;
        }

        historyWindow.basiclineCount++;
        historyWindow.basiclineNameCount++;

    }
    else
    {
        error.visible = true;
        error.errorMessageProperty = "Please create a timeline first!"

    }

}
