import QtQuick 2.0
import Qt.labs.folderlistmodel 2.11
import  QtQuick.Controls 2.3
import QtMultimedia 5.11

// Music View
Item {
    id: musicView
    visible: false
    width: parent.width
    height: parent.height
    property string dir: "/home/fanny/Musik/"
        property int musicBtnHeight: 50

    MediaPlayer {
        id: musicplayer
        source: dir + "toxicity.mp3"
    }

    Rectangle {
        color: musicColor
        width: parent.width
        height: parent.height

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
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 25
                        text: "song"
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
                        placeholderText: "songname"
                        cursorVisible: true
                    }
                }
                Button {
                    text: "Go"
                    onClicked: {
                        musicplayer.source = dir + songnameTxt.text
                    }
                }
            }
            Row {
                Slider {
                    width: parent.width
                }
            }


            Row {
                spacing: 10

                Button {
                    height: musicBtnHeight
                    id: playBtn
                    icon.color: "transparent"
                    icon.source: "images/play.svg"
                    onClicked: musicplayer.play()
                }

                Button {
                    height: musicBtnHeight
                    id: stopBtn
                    icon.color: "transparent"
                    icon.source: "images/stop.svg"
                    onClicked: musicplayer.stop()
                }

                Button {
                    height: musicBtnHeight
                    id: pausBtn
                    icon.color: "transparent"
                    icon.source: "images/pause.svg"
                    onClicked: musicplayer.pause()
                }

                Button {
                    height: musicBtnHeight
                    icon.color: "transparent"
                    icon.source: "images/volume_down.svg"
                    onClicked: {
                        musicplayer.volume = musicplayer.volume - 0.1
                    }
                }

            }
        }

    }
}
