import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: addressForm
    property alias streetName: streetName.text
    property alias cityName: cityName.text
    property alias countryName: countryName.text
    property alias searchButton: searchButton
    Rectangle {
        width: parent.width
        height: parent.height
        color: "#dddddd"

    Rectangle {
        id: tabRectangle
        y: 20
        height: tabTitle.height * 2
        color: "#46a2da"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: tabTitle
            color: "#ffffff"
            text: qsTr("Geocode")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    GridLayout {
        id: formLayout
        columns:2
        rowSpacing: 5
        columnSpacing: 5

        Label { text: "Straße"; font.bold: true;}
        TextField { id: streetName; Layout.fillWidth: true}
        Label { text: "Stadt"; font.bold: true;}
        TextField { id: cityName; Layout.fillWidth: true}
        Label { text: "Land"; font.bold: true;}
        TextField { id: countryName; Layout.fillWidth: true}

        Button {
            id: searchButton
            text: "Suchen"
        }
    }
    }
}
