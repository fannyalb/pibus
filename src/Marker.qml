import QtQuick 2.0

Rectangle {
    width: image.width
    Image {
        id: image
        anchors.centerIn: parent
        source: "images/marker.png"
        Text{
            y: parent.height/10
            width: parent.width
            color: "white"
            font.bold: false
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            text: index
        }
    }
}
