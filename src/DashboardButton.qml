import QtQuick 2.12
import QtQuick.Controls 2.6

Rectangle {
    id: dashboardButton
    width: dashboardView.buttonWidth
    height: dashboardView.buttonHeight
    radius: 3
    border.color: "black"
    border.width: 1
    property string text
    signal clicked
    anchors.top: parent.top
    anchors.leftMargin: dashboardView.abstand

    Text {
        text: dashboardButton.text
        anchors.centerIn: parent
    }

    TapHandler {
        onTapped: dashboardButton.clicked()
    }
}

