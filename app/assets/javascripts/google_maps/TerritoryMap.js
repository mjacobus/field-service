'use strict';

class TerritoryMap {
  constructor({ territory }) {
    this.territory = territory;
    this.getMarkers = this._getMarkers.bind(this);
    this.markers = this._getMarkers();
  }

  drawIn(container) {
    const center = this._getCenter();

    const map = new google.maps.Map(container, {
      zoom: 15,
      center,
      mapTypeId: 'terrain'
    });

    this.markers.forEach((marker) => {
      new google.maps.Marker({
        position: new google.maps.LatLng(marker.position.lat, marker.position.lon),
        // icon: 'https://maps.google.com/mapfiles/kml/shapes/library_maps.png',
        map: map,
        title: marker.title
      });
    });
  }

  _getCenter() {
    const length = this.markers.length;
    const sum = this.markers.reduce((accumulator, marker) => {
      accumulator.lat += marker.position.lat;
      accumulator.lng += marker.position.lon;

      return accumulator;
    }, { lat: 0, lng: 0 });

    return { lat: sum.lat/length, lng: sum.lng/length }
  }

  _getMarkers() {
    const householders = this.territory.householders.filter(
      (householder) => householder.geolocation.present
    );

    return householders.map((householder) => {
      return {
        title: [householder.address, householder.name].join("\n"),
        position: {
          lat: householder.geolocation.lat,
          lon: householder.geolocation.lon
        }
      };
    });
  }
}
