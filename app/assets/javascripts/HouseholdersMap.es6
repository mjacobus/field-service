'use strict';

class HouseholdersMap {
  constructor(container, householders, navigator) {
    this._container = container;
    this._householders = householders;
    this._navigator = navigator;
    this._map = new google.maps.Map(container, { zoom: 15 });
    this._geocoder = new google.maps.Geocoder();
    this._infoWindow = new google.maps.InfoWindow;
  }

  draw() {
    this._householders.forEach((householder, index)  => {
      this.markHouseholder(householder, index == 0);
    });
  }

  handleLocationError(browserHasGeolocation) {
    let pos = this._map.getCenter();
    this._infoWindow.setPosition(pos);
    this._infoWindow.setContent(browserHasGeolocation ?
      'Error: The Geolocation service failed.' :
      'Error: Your browser doesn\'t support geolocation.');
    this._infoWindow.open(map);
  }

  markHouseholder(householder, center) {
    let location = null;

    if (householder.location.lat && householder.location.lon) {
      location = { lat: householder.location.lat, lng: householder.location.lon };
      return this.addMarker(householder, location, center);
    }

    const address = householder.address;
    console.log('Could not find householder:', address, householder.name);

    this._geocoder.geocode({'address': address},  (results, status)  => {
      if (status == 'OK') {
        location = results[0].geometry.location;
        return this.addMarker(householder, location, center);

      } else {
        console.log('Geocode was not successful for the following reason: ' + status);
      }
    });
  }

  addMarker(householder, location, center) {
    if (center) {
      this._map.setCenter(location);
    }

    new google.maps.Marker({
      map: this._map,
      position: location,
      title: householder.address,
      label: householder.name
    });
  }
}

