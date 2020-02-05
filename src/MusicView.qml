import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12
import  QtQuick.Controls 2.0

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

        //        ListView {
        //            width: 200
        //            height: 300

        //            FolderListModel {
        //                id: folderModel
        //                nameFilters: ["*.mp3", "*.wav"]
        //                folder: "/home/fannya/Musik"
        //            }

        //            Component {
        //                id: fileDelegate
        //                Text { text: fileName }
        //            }

        //            model: folderModel
        //            delegate: fileDelegate
        //        }
        property int musicBtnHeight: 50
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Column {
                spacing: 10
                Rectangle {
                    //            color: musicColor
                    color: "#558855"
                    height: 50
                    width: 200
                    opacity: region.pressed? 0:1
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 25
                        text: musicplayer.songName

                    }
                }
            }

            Column {
                spacing: 10
                Rectangle {
                    id: songnameRct
                    //            color: musicColor
                    color: "#998855"
                    height: 50
                    width: 200
                    TextField {
                        id: songnameTxt
                        anchors.centerIn: parent
                        font.pointSize: 25
                        placeholderText: "songnmae"
                        cursorVisible: true
                    }
                }
                Button {
                    text: "Go"
                    anchors.top: songnameRct.songnameTxt.bottom
                    anchors.margins: 5
                    onClicked: {
                        musicplayer.songName = songnameTxt.text
                    }
                }
            }

            Row {
                property int musicBtnHeight: 50
                spacing: 10

                Button {
                    height: musicBtnHeight
                    id: playBtn
                    text: "Play"
                    onClicked: playPressed()
                }

                Button {
                    height: musicBtnHeight
                    id: stopBtn
                    text: "Stop"
                    onClicked: stopPressed()
                }

                Button {
                    height: musicBtnHeight
                    id: pausBtn
                    text: "Pause"
                    onClicked: pausePressed()
                }

            }
        }

    }
}
