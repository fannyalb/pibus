import QtQuick 2.12
import QtQuick.Controls 2.6
import QtMultimedia 5.12
import QtPositioning 5.8

ApplicationWindow{
    height: 480
    width: 800
    visible: true

    signal musicPressed()
    signal radioPressed()
    signal cameraPressed()
    signal playPressed()
    signal pausePressed()
    signal stopPressed()

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

    Popup {
        id: popup
        property alias msg: popupMsg.text
        x: Math.round((parent.width - width) /2)
        y: 50
        width: 300
        height: 200
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape |
                     Popup.CloseOnPressOutside
        contentItem: Text {
            id: popupMsg
            text: "Content"
        }
    }

    Dashboard {
        id: dashboardView
    }


    // Music View
    MusicView {
        id: musicView
    }

    // Radio View
    RadioView {
        id: radioView
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

//     NavigationView
    NavigationView {
        id: navigationView
    }
}

