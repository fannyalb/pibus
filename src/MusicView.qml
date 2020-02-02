import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

// Music View
Item {
    id: musicView
    visible: false
    width: parent.width
    height: parent.height

    signal playPressed()
    signal pausePressed()
    signal stopPressed()

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

        Row {
            height: 50
            width: parent.width
            anchors.bottom: parent.bottom

            Button {
                id: playBtn
                text: "Play"
                onClicked: playPressed()
            }

            Button {
                id: stopBtn
                text: "Stop"
                onClicked: stopPressed()
            }

            Button {
                id: pausBtn
                text: "Pause"
                onClicked: pausePressed()
            }

        }

    }
}
