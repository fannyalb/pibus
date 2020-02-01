import QtQuick 2.0
import QtPositioning 5.12
import QtLocation 5.12

Item {
    Rectangle {
        width: 100
        height: 100
        x: 100
        y: 100

        Text {
            id: navigationTxt
            text: qsTr("Navigation")
        }
    }

}


