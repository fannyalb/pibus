import QtQuick 2.12
import QtQuick.Controls 2.6
import QtQuick.Shapes 1.12
import QtPositioning 5.12
import QtLocation 5.12

Rectangle {
    width: parent.width
    height: parent.height
    visible: false

    Text {
        id: navigationTxt
        text: qsTr("Navigation")
    }

    Plugin {
        id: mapPlugin
        name: "osm"
        PluginParameter { name: "osm.useragent"; value: "My great Qt OSM application" }
        PluginParameter { name: "osm.mapping.host"; value: "http://osm.tile.server.address/" }
        PluginParameter { name: "osm.mapping.copyright"; value: "All mine" }
        PluginParameter { name: "osm.routing.host"; value: "http://osrm.server.address/viaroute" }
        PluginParameter { name: "osm.geocoding.host"; value: "http://geocoding.server.address" }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        zoomLevel: (maximumZoomLevel - minimumZoomLevel) /2
        center {
            latitude: 47.2870
            longitude: 11.4232
        }

    }

    MouseArea {
       anchors.fill: parent
       onPressAndHold: {
           var crd = map.toCoordinate(Qt.point(mouseX, mouseY))
           console.log(crd)
           markerModel.clear()
           markerModel.append({ "latidude": crd.latidude, "longitude": crd.longitude})
       }
    }

    GeocodeModel {
        id: geocodeModel
        plugin: map.plugin
        onStatusChanged: {
            if((status == GeocodeModel.Ready) || (status == GeocodeModel.Error))
                map.geocodeFinished()
        }
        onLocationsChanged: {
            if(count == 1){
                map.center.latitude = get(0).coordinate.latitude
                map.center.longitude = get(0).coordinate.longitude
            }else{
                console.log("count not 1")
            }
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

    Address {
        id: fromAddress
        street: "Finkenbergweg 27"
        city: "Innsbruck"
        country: "Austria"
        state: ""
        postalCode: "6020"
    }

    Button {
       id: plusButton
       anchors.top: parent.top
       text: "+"
       onClicked: map.zoomLevel = map.zoomLevel + 1
    }

    Button {
       id: minusButton
       anchors.top: parent.top
       anchors.left: plusButton.right
       text: "-"
       onClicked: map.zoomLevel = map.zoomLevel - 1
    }

    Button {
       id: queryButton
       anchors.right: parent.right
       text: "Ok"
       onClicked: {
           geocodeModel.query = fromAddress
           geocodeModel.update()
       }
    }
}



