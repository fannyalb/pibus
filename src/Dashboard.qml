import QtQuick 2.11
import QtQuick.Controls 2.3
Rectangle {
        id: dashboardView
        property int abstand: 30
        property int buttonHeight: 75
        property int buttonWidth: 150
        height: 480; width: 800
        anchors.centerIn: parent

        Item{
        height: 80
        width: 4 * dashboardView.buttonWidth + 3 * dashboardView.abstand
        anchors.centerIn: parent

        DashboardButton {
            id: musicbutton
            anchors.left: parent.left
            color: musicColor
            text: "Musik"
            onClicked: {
                dashboard.musicButtonPressed()
                stack.push(musicView)
            }
        }

        DashboardButton {
            id: radiobutton
            anchors.left: musicbutton.right
            color: radioColor
            text: "Radio"
            onClicked: stack.push(radioView)
        }

        DashboardButton {
            id: camerabutton
            anchors.left: radiobutton.right
            color: cameraColor
            text: "Camera"
            onClicked: stack.push(cameraView)
        }

        // navigation
        DashboardButton {
            id: navigationbutton
            anchors.left: camerabutton.right
            color: navigationColor
            text: "Navigation"
            onClicked: stack.push(navigationView)
        }
    }

}
