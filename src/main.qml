import QtQuick 2.12
import QtQuick.Controls 2.6
import QtMultimedia 5.12

ApplicationWindow{
    height: 480
    width: 800
    visible: true

    signal musicPressed()
    signal radioPressed()
    signal cameraPressed()

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

    // Navigation View
    NavigationView {
        id: navigationView
        color: navigationColor
    }
}

