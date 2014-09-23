// This QML file (called Dialog.qml) is used to create a simple popup
// It will show an overlay on top of the parent and a small white area
// that is the dialog itself. For demo purposes no fancy stuff in the popup
import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import "."
import "TimeLine.js" as Timeline

// Use an item as container to group both the overlay and the dialog
// I do this because the overlay itself has an opacity set, and otherwise
// also the dialog would have been semi-transparent.
// I use an Item instead of an Rectangle. Always use an 'Item' if it does not
// display stuff itself, this is better performance wise.
Item {
    id: dialogComponent
    anchors.fill: parent

    property variant timelineArray:[]

    // Add a simple animation to fade in the popup
    // let the opacity go from 0 to 1 in 400ms
    PropertyAnimation { target: dialogComponent; property: "opacity";
        duration: 400; from: 0; to: 1;
        easing.type: Easing.InOutQuad ; running: true }

    // This rectange is the a overlay to partially show the parent through it
    // and clicking outside of the 'dialog' popup will do 'nothing'
    Rectangle {
        anchors.fill: parent
        id: overlay
        color: "#000000"
        opacity: 0.6
        // add a mouse area so that clicks outside
        // the dialog window will not do anything
        MouseArea {
            anchors.fill: parent
            onClicked: {dialogComponent.visible = false;
                startDateDate.text ="";
                startDateMonth.text = "";
                startDateYear.text = "";
                endDateDate.text="";
                endDateMonth.text= "";
                endDateYear.text= "";
                period.text = "";
                }
        }
    }
    Rectangle{

        color: "white"

        Column{
            Row{
                ExclusiveGroup{id:startDateRadioButtons}

                Text{
                    text: "Start Date  "
                }
                TextField{
                    id:startDateDate
                    placeholderText: qsTr("01");
                    maximumLength:2
                }
                TextField{
                    id:startDateMonth
                    placeholderText: qsTr("Jan")
                    maximumLength:3
                }
                TextField{
                    id:startDateYear
                    placeholderText: qsTr("yyyy")
                    maximumLength:4
                }
                RadioButton{
                    id:adStartDate
                    checked:true
                    text:"A.D/C.E"
                    exclusiveGroup: startDateRadioButtons
                }
                RadioButton{
                    id:bcStartDate
                    text:"B.C/B.C.E"
                    exclusiveGroup: startDateRadioButtons
                }
            }
            Row{
                Text{
                    text: "End Date    "
                }

                ExclusiveGroup{id:endDateRadioButtons}
                TextField{
                    id:endDateDate
                    placeholderText: qsTr("01");
                    maximumLength:2
                }
                TextField{
                    id:endDateMonth
                    placeholderText: qsTr("Jan")
                    maximumLength:3
                }
                TextField{
                    id:endDateYear
                    placeholderText: qsTr("yyyy")
                    maximumLength: 4
                }

                RadioButton{
                    id:adEndDate
                    checked:true
                    text:"A.D/C.E"
                    exclusiveGroup: endDateRadioButtons
                }
                RadioButton{
                    id:bcEndDate
                    text:"B.C/B.C.E"
                    exclusiveGroup: endDateRadioButtons
                }
            }
            Row{
                Text{
                    text:"Time period"
                }

                TextField{

                    id:period
                    placeholderText: qsTr("Time Period")
                }
            }

            Button{
                id:ok

                onButtonClick:
                {    Timeline.populate(timelineArray,startDateDate.text,startDateMonth.text,
                                       startDateYear.text, endDateDate.text,endDateMonth.text, endDateYear.text,
                                       period.text, adStartDate.checked,bcStartDate.checked, adEndDate.checked,
                                       bcEndDate.checked);
                    dialogComponent.visible = false;
                }

            }
        }
    }
}

