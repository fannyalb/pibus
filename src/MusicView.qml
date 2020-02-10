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


        Row {
            spacing: 20
            anchors.top: parent.top
            anchors.left: parent.left


            Column {
                anchors.margins: 20
                spacing: 10

                Rectangle {
                    color: musicColor
                    height: 50
                    width: 200
                    Column {
                    Text {
                        id: songTitle
                        font.pointSize: 25
                        text: musicplayer.metaData.title
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        id: songArtist
                        font.pointSize: 15
                        text: musicplayer.metaData.albumArtist
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                    }
                }

                Slider {
                    id: slider
                    width: 300
                    from: 0
                    stepSize: 1000
                    to: musicplayer.duration
                    Binding {
                        target: slider
                        property: "value"
                        value: musicplayer.position
                        when: !slider.pressed
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
                            if(musicplayer.volume > 0)
                                musicplayer.volume = musicplayer.volume - 0.1
                        }
                    }

                }
            }


            Rectangle {
                id: fileRect
                height: 400; width: 300
                property int lineHeight: 30
                property int lineWidth: 300
                Button {
                    id: folderUpBtn
                    text: "../"
                    height: fileRect.lineHeight
                    width: fileRect.lineWidth
                    onClicked: {
                        folderModel.folder = folderModel.parentFolder
                    }
                    background: Rectangle {
                        border.color: "black"
                    }
                }

                ListView {
                    width:300; height: parent.height
                    anchors.top: folderUpBtn.bottom

                    FolderListModel {
                        id: folderModel
                        rootFolder: "file:///home/$USER/"
                        nameFilters: ["*.mp3", "*.wav"]
                    }

                    Component {
                        id: fileDelegate
                        Button {
                            text: fileName
                            height: fileRect.lineHeight
                            width: fileRect.lineWidth
                            onClicked: {
                                if(fileIsDir)
                                    folderModel.folder = fileURL
                                else
                                    musicplayer.source = fileURL
                            }
                            background: Rectangle {
                                color: fileIsDir ? "orange" : "gray"
                                border.color: "black"
                            }
                        }
                    }

                    model: folderModel
                    delegate: fileDelegate
                }
            }
        }
    }
}
