import QtQuick 2.12
import QtQuick.Controls 2.6

ApplicationWindow{
    height: 480
    width: 800
    visible: true

    signal musicPressed()
    signal radioPressed()
    signal cameraPressed()

    property int abstand: 30
    property int buttonHeight: 75
    property int buttonWidth: 150
    property string musicColor: "#2275A5"
    property string radioColor: "#EA7317"
    property string cameraColor: "#EEC601"
    property string navigationColor: "#73BEB8"
    property string otherColor: "#3DA5D9"


    menuBar: MenuBar {
        MenuBarItem {
            id: backButton
            visible: stack.depth > 1
            enabled: stack.depth > 1
            text: "<"
            onClicked: stack.pop()
        }
    }

    StackView {
        id: stack
        initialItem: dashboardView
        anchors.fill: parent
    }

    Item {
        id: dashboardView
        height: 80
        width: 4*buttonWidth + 3*abstand
        anchors.centerIn: parent


        Rectangle {
            id: musicbutton
            color: musicColor
            width: buttonWidth
            height: buttonHeight
            anchors.left: parent.left
            anchors.top: parent.top

            Text {
                text: "Musik"
                anchors.centerIn: parent
            }

            TapHandler {
                onTapped: {
                    musicPressed()
                    stack.push(musicView)
                }

            }
        }

        Rectangle {
            id: radiobutton
            width: buttonWidth
            height: buttonHeight
            anchors.left: musicbutton.right
            anchors.leftMargin: abstand
            anchors.top: parent.top
            color: radioColor

            Text {
                text: "Radio"
                anchors.centerIn: parent
            }
            TapHandler {
                onTapped: stack.push(radioView)
            }
        }

        Rectangle {
            id: camerabutton
            width: buttonWidth
            height: buttonHeight
            anchors.left: radiobutton.right
            anchors.leftMargin: abstand
            anchors.top: parent.top
            color: cameraColor

            Text {
                text: "Camera"
                anchors.centerIn: parent
            }

            TapHandler {
                onTapped: stack.push(cameraView)
            }
        }

        // navigation
        Rectangle {
            id: navigationbutton
            width: buttonWidth
            height: buttonHeight
            anchors.left: camerabutton.right
            anchors.leftMargin: abstand
            anchors.top: parent.top
            color: navigationColor

            Text {
                text: "Navigation"
                anchors.centerIn: parent
            }

            TapHandler {
                onTapped: stack.push(navigationView)
            }
        }
    }

    // Music View
    Item {
        id: musicView
        visible: false
        width: parent.width
        height: parent.height

        Rectangle {
            color: musicColor
            width: parent.width
            height: parent.height
        }
    }

    // Radio View
    Item {
        id: radioView
        visible: false
        width: parent.width
        height: parent.height

        Rectangle {
            color: radioColor
            width: parent.width
            height: parent.height
        }
    }

    // Camera View
    Item {
        id: cameraView
        visible: false
        width: parent.width
        height: parent.height

        Rectangle {
            color: cameraColor
            width: parent.width
            height: parent.height
        }
    }

    // Navigation View
    Item {
        id: navigationView
        visible: false
        width: parent.width
        height: parent.height

        Rectangle {
            color: navigationColor
            width: parent.width
            height: parent.height
        }
    }



}

