import QtQuick 2.12
import QtQuick.Controls 2.6

Rectangle {
    id: button
    property string text
    property string color
    signal clicked
    color: "#999999"
    border.color: "black"
    border.width: 2
    radius: 5
    anchors.margins: 10

    height: 30
    width: button.height * 1.63

    anchors {
        margins: radioRoot.margins
        top: parent.top
    }

    Text {
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: qsTr(button.text)
    }

    TapHandler {
        onTapped: button.clicked();
    }

}
