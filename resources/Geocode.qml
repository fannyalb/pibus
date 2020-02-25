import QtQuick 2.0

AddressForm {
    id: geocodeAddress
    visible:false
    property variant address
    signal showPlace(variant address)
    signal closeForm()

    searchButton.onClicked: {
        address.street = streetName
        address.city = cityName
        address.country = countryName
        console.log("Ok button:")
        showPlace(address)
        stack.pop()
    }

    Component.onCompleted: {
        streetName = address.street
        cityName = address.city
        countryName = address.country
    }


}
