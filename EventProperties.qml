// This QML file (called Dialog.qml) is used to create a simple popup
// It will show an overlay on top of the parent and a small white area
// that is the dialog itself. For demo purposes no fancy stuff in the popup
import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import "."

// Use an item as container to group both the overlay and the dialog
// I do this because the overlay itself has an opacity set, and otherwise
// also the dialog would have been semi-transparent.
// I use an Item instead of an Rectangle. Always use an 'Item' if it does not
// display stuff itself, this is better performance wise.
Item {
    id: eventPropertiesDialog
    property int filterCount
    property int imageCount
    Positioner:parent
    x:512
    y:350
    z: 10

    Component.onCompleted:{

    }

    Rectangle{
        TabView {
            width: 800
            height: 500
            anchors.centerIn: parent

            Component.onCompleted: {
                addTab("Event Properties" , tab1)

            }

            Component {
                id: tab1
                Rectangle {
                    color: "gray";

                    TextArea {
                        width:790
                        height:200
                        id: eventDesc
                    }

                    Row{
                        id:imageContainer
                        width:790
                        height:100
                        x:3
                        y:220
                        spacing:10
                    }
                    Row{
                        id:filterContainer
                        width:790
                        height:100
                        x:0
                        y:340
                        spacing:10

                    }

                    Row{
                        x:100
                        y:480
                        spacing: 100
                        Button{
                            id:filters

                            buttonLabel: "Add filter"

                            MouseArea{
                                anchors.fill:parent

                                onClicked:{
                                    if(filterCount < 8){
                                        Qt.createQmlObject(
                                                    'import QtQuick 2.2; import QtQuick.Controls 1.2; TextField {id: tf'
                                                    + filterCount +
                                                    '; width: 90;height: 30;}',filterContainer);
                                        console.log(filterCount)
                                        filterCount++;
                                    }
                                }
                            }
                        }
                        Button{
                            id:addImage

                            buttonLabel: "Add Images"

                            MouseArea{
                                anchors.fill:parent

                                onClicked:{
                                    if(imageCount < 7){
                                        Qt.createQmlObject("import QtQuick 2.0; Image{ id:img"
                                                           + imageCount + ";width:100; height:100;}",
                                                           imageContainer,"imageError");
                                        fileDialog.open()
                                    }

                                }
                            }
                        }
                        Button{
                            id:close

                            buttonLabel: "Close"

                            MouseArea{
                                anchors.fill:parent

                                onClicked:{
                                    eventPropertiesDialog.visible = false;

                                }
                            }
                        }

                        FileDialog {
                            id: fileDialog
                            title: "Please choose a file"
                            selectMultiple: false
                            onAccepted: {
                                imageContainer.children[imageCount].source = fileDialog.fileUrl;
                                imageCount++;

                            }
                            onRejected: {
                                imageContainer.children[imageCount].destroy();
                                fileDialog.close();
                            }
                        }

                    }
                }

            }

        }
    }
}

