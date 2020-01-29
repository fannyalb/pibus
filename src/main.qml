import QtQuick 2.12
import QtQuick.Controls 2.6

ApplicationWindow{
	id: root
	width: 800
	height: 480
	visible: true
	signal musicPressed()
	signal radioPressed()
	signal cameraPressed()

	menuBar: MenuBar {
		Menu {
			title: qsTr("File")
			MenuItem {
				text: qsTr("&open")
				onTriggered: console.log("Open action triggered");
			}
			MenuItem {
				text: qsTr("Exit")
				onTriggered: Qt.quit();
			}
		}

	}


	property int abstand: 30

	Item {
		y: abstand
		x: abstand
		height: 80
		width: 3*height + 2*abstand

	Rectangle { 
		id: musicbutton
		color: "green"
		width: parent.height
		height: parent.height
		anchors.left: parent.left
		anchors.top: parent.top

		Text {
			text: "Musik"
		}

		TapHandler {
			onTapped: musicPressed()
		}
	}

	Rectangle { 
		id: radiobutton
		width: parent.height
		height: parent.height
		anchors.left: musicbutton.right
		anchors.leftMargin: abstand
		anchors.top: parent.top
		color: "red"

		Text {
			text: "Radio"
		}
		TapHandler {
			onTapped: radioPressed()
		}
	}

	Rectangle { 
		id: camerabutton
		width: parent.height
		height: parent.height
		anchors.left: radiobutton.right
		anchors.leftMargin: abstand
		anchors.top: parent.top
		color: "yellow"

		Text {
			text: "Camera"
		}
		TapHandler {
			onTapped: cameraPressed()
		}
	}



}

	}

