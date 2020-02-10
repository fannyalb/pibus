import QtQuick 2.5
import QtLocation 5.6
import QtPositioning 5.5
import QtQuick.Controls 2.3
import QtQuick.Shapes 1.11
import QtQuick.VirtualKeyboard 2.11

Rectangle {
    id: navigationRect
    width: parent.width
    height: parent.height
    visible: false
    property variant locationInnsburck: QtPositioning.coordinate(47.2870, 11.4232)

    function places(){
        searchModel.searchTerm = queryField.text
        searchModel.update()
        placesDrawer.visible = true
    }

    Text {
        id: navigationTxt
        text: qsTr("Navigation")
    }

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    MapComponent {
        id: map
        // To locate address or place
        GeocodeModel {
            id: geocodeModel
            plugin: map.plugin
            onStatusChanged: {
                if ((status == GeocodeModel.Ready) || (status == GeocodeModel.Error))
                    map.geocodeFinished()
            }
            onLocationsChanged:
            {
                console.log("Latitude: " + get(0).coordinate.latitude)
                map.center.latitude = get(0).coordinate.latitude
                map.center.longitude = get(0).coordinate.longitude
            }
        }

        onCoordinatesCaptured: {
            var text = "<b>" + qsTr("Latitude:") + "</b> " + Helper.roundNumber(latitude,4) + "<br/><b>" + qsTr("Longitude:") + "</b> " + Helper.roundNumber(longitude,4)
            stackView.showMessage(qsTr("Coordinates"),text);
        }

        onGeocodeFinished:{
            if (geocodeModel.status === GeocodeModel.Ready) {
                if (geocodeModel.count === 0) {
                    console.log("Geocode Model error")
                } else if (geocodeModel.count > 1) {
                    console.log(qsTr("Ambiguous geocode") + geocodeModel.count + " " +
                                qsTr("results found for the given address, please specify location"))
                    popup.msg = geocodeModel.count + " results found for give Address"
                    popup.open()
                } else {
                    console.log(qsTr("Location") + geocodeMessage())
                    popup.msg = geocodeMessage()
                    popup.open()
                }
            } else if (geocodeModel.status === GeocodeModel.Error) {
                console.log(qsTr("Geocode Error: ") + qsTr("Unsuccessful geocode :" + geocodeModel.errorString))
            }
        }

        onRouteError: console.log(qsTr("Route Error") + qsTr("Unable to find a route for the given points"),page)

        PlaceSearchModel {
            id: searchModel
            plugin: mapPlugin
            searchTerm: ""
            Component.onCompleted: update()
        }
    }


    Drawer {
        id: placesDrawer
        y: 30
        width: parent.width / 3
        height: parent.height - 40
        visible: false
        position: 0.3
        edge: Qt.RightEdge
        ListView {
            id: placesView
            visible: true
            width: 300
            model: searchModel
            anchors.right: parent.right
            delegate: Component {
                Row {
                    spacing: 5
                    Marker { height: parent.height }
                    Column {
                        Text { text: title; font.bold: true }
                        Text { text: place.location.address.text}
                    }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }



    Component {
        id: pointDelegate

        MapCircle {
            id: point
            radius: 1000
            color: "#46a2da"
            border.color: "#190a33"
            border.width: 2
            smooth: true
            opacity: 0.25
            center: locationData.coordinate
        }
    }
    //! [pointdel1]

    Address {
        id: fromAddress
        street: "Finkenbergweg 27"
        city: "Innsbruck"
        country: "Austria"
        state: ""
        postalCode: "6020"
    }

    Geocode {
        id: geocode
        address: fromAddress
    }

    Row {
        anchors.bottom: parent.bottom
        spacing: 10

        Button {
            id: plusButton
            text: "+"
            onClicked: map.zoomLevel = map.zoomLevel + 1
        }

        Button {
            id: minusButton
            text: "-"
            onClicked: map.zoomLevel = map.zoomLevel - 1
        }

        TextField {
            id: queryField
            height: 30
            width: 200
        }

        Button {
            id: queryButton
            icon.source: "images/search.svg"
            icon.color: "transparent"
            onClicked: {
                places()
            }
        }

        Button {
            id: searchButton
            text: "Ort suchen"
            onClicked: {
                geocode.address = fromAddress
                stack.push(geocode)
                stack.currentItem.showPlace.connect(map.geocode)
            }
        }
    }
}



