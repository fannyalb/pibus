import QtQuick 2.5
import QtQuick.Controls 1.4
import QtLocation 5.9
import QtPositioning 5.5

Map {
    id: map
    anchors.fill: parent
    plugin: mapPlugin
    zoomLevel: (maximumZoomLevel - minimumZoomLevel) /2
    center: navigationRect.locationInnsburck
    signal geocodeFinished()
    signal routeError()
    signal showGeocodeInfo()
    signal coordinatesCaptured()

    function geocodeMessage()
    {
        var street, district, city, county, state, countryCode, country, postalCode, latitude, longitude, text
        latitude = Math.round(geocodeModel.get(0).coordinate.latitude * 10000) / 10000
        longitude =Math.round(geocodeModel.get(0).coordinate.longitude * 10000) / 10000
        street = geocodeModel.get(0).address.street
        district = geocodeModel.get(0).address.district
        city = geocodeModel.get(0).address.city
        county = geocodeModel.get(0).address.county
        state = geocodeModel.get(0).address.state
        countryCode = geocodeModel.get(0).address.countryCode
        country = geocodeModel.get(0).address.country
        postalCode = geocodeModel.get(0).address.postalCode

        text = "<b>Latitude:</b> " + latitude + "<br/>"
        text +="<b>Longitude:</b> " + longitude + "<br/>" + "<br/>"
        if (street) text +="<b>Street: </b>"+ street + " <br/>"
        if (district) text +="<b>District: </b>"+ district +" <br/>"
        if (city) text +="<b>City: </b>"+ city + " <br/>"
        if (county) text +="<b>County: </b>"+ county + " <br/>"
        if (state) text +="<b>State: </b>"+ state + " <br/>"
        if (countryCode) text +="<b>Country code: </b>"+ countryCode + " <br/>"
        if (country) text +="<b>Country: </b>"+ country + " <br/>"
        if (postalCode) text +="<b>PostalCode: </b>"+ postalCode + " <br/>"
        return text
    }

    function calculateScale()
    {
        var coord1, coord2, dist, text, f
        f = 0
        coord1 = map.toCoordinate(Qt.point(0,scale.y))
        coord2 = map.toCoordinate(Qt.point(0+scaleImage.sourceSize.width,scale.y))
        dist = Math.round(coord1.distanceTo(coord2))

        if (dist === 0) {
            // not visible
        } else {
            for (var i = 0; i < scaleLengths.length-1; i++) {
                if (dist < (scaleLengths[i] + scaleLengths[i+1]) / 2 ) {
                    f = scaleLengths[i] / dist
                    dist = scaleLengths[i]
                    break;
                }
            }
            if (f === 0) {
                f = dist / scaleLengths[i]
                dist = scaleLengths[i]
            }
        }

        text = Helper.formatDistance(dist)
        scaleImage.width = (scaleImage.sourceSize.width * f) - 2 * scaleImageLeft.sourceSize.width
        scaleText.text = text
    }

    function deleteMarkers()
    {
        var count = map.markers.length
        for (var i = 0; i<count; i++){
            map.removeMapItem(map.markers[i])
            map.markers[i].destroy()
        }
        map.markers = []
        markerCounter = 0
    }

    function deleteMapItems()
    {
        var count = map.mapItems.length
        for (var i = 0; i<count; i++){
            map.removeMapItem(map.mapItems[i])
            map.mapItems[i].destroy()
        }
        map.mapItems = []
    }

    function addMarker()
    {
        var count = map.markers.length
        markerCounter++
        var marker = Qt.createQmlObject ('Marker {}', map)
        map.addMapItem(marker)
        marker.z = map.z+1
        marker.coordinate = mouseArea.lastCoordinate

        //update list of markers
        var myArray = new Array()
        for (var i = 0; i<count; i++){
            myArray.push(markers[i])
        }
        myArray.push(marker)
        markers = myArray
    }

    function addGeoItem(item)
    {
        var count = map.mapItems.length
        var co = Qt.createComponent(item+'.qml')
        if (co.status === Component.Ready) {
            var o = co.createObject(map)
            o.setGeometry(map.markers, currentMarker)
            map.addMapItem(o)
            //update list of items
            var myArray = new Array()
            for (var i = 0; i<count; i++){
                myArray.push(mapItems[i])
            }
            myArray.push(o)
            mapItems = myArray

        } else {
            console.log(item + " is not supported right now, please call us later.")
        }
    }

    function deleteMarker(index)
    {
        //update list of markers
        var myArray = new Array()
        var count = map.markers.length
        for (var i = 0; i<count; i++){
            if (index != i) myArray.push(map.markers[i])
        }

        map.removeMapItem(map.markers[index])
        map.markers[index].destroy()
        map.markers = myArray
        if (markers.length == 0) markerCounter = 0
    }

    function calculateMarkerRoute()
    {
        routeQuery.clearWaypoints();
        for (var i = currentMarker; i< map.markers.length; i++){
            routeQuery.addWaypoint(markers[i].coordinate)
        }
        routeQuery.travelModes = RouteQuery.CarTravel
        routeQuery.routeOptimizations = RouteQuery.ShortestRoute
        routeQuery.setFeatureWeight(0, 0)
        routeModel.update();
    }

    function calculateCoordinateRoute(startCoordinate, endCoordinate)
    {
        //! [routerequest0]
        // clear away any old data in the query
        routeQuery.clearWaypoints();

        // add the start and end coords as waypoints on the route
        routeQuery.addWaypoint(startCoordinate)
        routeQuery.addWaypoint(endCoordinate)
        routeQuery.travelModes = RouteQuery.CarTravel
        routeQuery.routeOptimizations = RouteQuery.FastestRoute

        //! [routerequest0]

        //! [routerequest0 feature weight]
        for (var i=0; i<9; i++) {
            routeQuery.setFeatureWeight(i, 0)
        }
        //for (var i=0; i<routeDialog.features.length; i++) {
        //    map.routeQuery.setFeatureWeight(routeDialog.features[i], RouteQuery.AvoidFeatureWeight)
        //}
        //! [routerequest0 feature weight]

        //! [routerequest1]
        routeModel.update();

        //! [routerequest1]
        //! [routerequest2]
        // center the map on the start coord
        map.center = startCoordinate;
        //! [routerequest2]
    }

    function geocode(fromAddress)
    {
        //! [geocode1]
        // send the geocode request
        geocodeModel.query = fromAddress
        geocodeModel.update()
        //! [geocode1]
    }


    MapItemView {
        model: searchModel
        delegate: MapQuickItem {
            coordinate: place.location.coordinate
            anchorPoint.x: image.width * 0.5
            anchorPoint.y: image.height
            sourceItem: Column {
                Image { id: image; source: "images/marker.png"}
                Text { text: title; font.bold: true}
            }
        }
    }

    MapItemView {
        model:geocodeModel
        delegate: pointDelegate
    }

}

