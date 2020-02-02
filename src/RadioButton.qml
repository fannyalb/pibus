import QtQuick 2.0

Rectangle {
    id: radioBtn
    border.color: "black"
    border.width: 1
    radius: 5

    property string text
    signal clicked
    width: d.buttonWidth
    height: d.buttonHeight

    anchors {
        margins: radioRoot.margins
        top: parent.top
    }

    Text {
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: radioBtn.text
    }

    MouseArea {
        anchors.fill: parent
        onClicked: radioBtn.clicked();
    }

}
