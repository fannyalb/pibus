import QtQuick 2.0
import QtMultimedia 5.12

Item {
    id: radioView
    visible: false
    width: parent.width
    height: parent.height

    Rectangle {
        id: radioRoot
        color: radioColor
        width: parent.width
        height: parent.height
        property int margins: 5
        property int spacing: 10

        QtObject {
            id: d
            property int buttonHeight:  radioRoot.height > radioRoot.width ? radioRoot.width / 3 : radioRoot.height / 3
            property int buttonWidth: (radioRoot.width - radioRoot.spacing * 4) / 4
        }

        Radio {
            id: radio
            band: Radio.FM
        }

        Column {
            anchors.fill: parent
            anchors.margins: radioRoot.margins

            Rectangle {
                color: radioRoot.color
                width: parent.width
                height: radioRoot.height - d.buttonHeight - 40

                Text {
                    id: freq
                    verticalAlignment: Text.AlignVCenter
                    text: "" + radio.frequency / 1000 + " kHz"
                    anchors {
                        bottom: parent.bottom
                        margins: radioRoot.margins
                    }
                }

                Text {
                    id: sig
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        margins: radioRoot.margins
                    }

                    verticalAlignment: Text.AlignVCenter
                    text: (radio.availability == Radio.Available ? "No Signal " : "No Radio Found")
                }
            }

            // Frequency Display
            Row {
                spacing: radioRoot.spacing

                Rectangle {
                    width: radioRoot.width - 10
                    height: 20
                    color: "black"

                    Rectangle {
                        width: 5
                        height: 20
                        color: "red"
                        y: 0
                        x: (parent.width -5) * ((radio.frequency - radio.minimumFrequency) / (radio.maximumFrequency - radio.minimumFrequency))
                    }
                }
            }
            Row {
                spacing: radioRoot.spacing
                RadioButton {
                    text: "Scan Down"
                    onClicked: radio.scanDown()
                }
                RadioButton {
                    text: "Freq Down"
                    onClicked: radio.tuneDown()
                }
                RadioButton {
                    text: "Freq Up"
                    onClicked: radio.tuneUp()
                }
                RadioButton {
                    text: "Scan Up"
                    onClicked: radio.scanUp()
                }
            }
        }
    }
}
