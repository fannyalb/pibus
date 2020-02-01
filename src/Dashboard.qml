import QtQuick 2.12
import QtQuick.Controls 2.6

Component {
    id: dashboardComponent

    signal musicPressed()
    signal radioPressed()
    signal cameraPressed()

    property int abstand: 30
    property int buttonHeight: 75
    property int buttonWidth: 150

    Item {
        y: abstand
        x: abstand
        height: 80
        width: 3*height + 2*abstand

        Rectangle {
            id: musicbutton
            color: "green"
            width: buttonWidth
            height: buttonHeight
            anchors.left: parent.left
            anchors.top: parent.top

            Text {
                text: "Musik"
                anchors.centerIn: parent
            }

            TapHandler {
                onTapped: musicPressed()
            }
        }

        Rectangle {
            id: radiobutton
            width: buttonWidth
            height: buttonHeight
            anchors.left: musicbutton.right
            anchors.leftMargin: abstand
            anchors.top: parent.top
            color: "red"

            Text {
                text: "Radio"
                anchors.centerIn: parent
            }
            TapHandler {
                onTapped: radioPressed()
            }
        }

        Rectangle {
            id: camerabutton
            width: buttonWidth
            height: buttonHeight
            anchors.left: radiobutton.right
            anchors.leftMargin: abstand
            anchors.top: parent.top
            color: "yellow"

            Text {
                text: "Camera"
                anchors.centerIn: parent
            }

            TapHandler {
                onTapped: cameraPressed()
            }
        }
    }

