'use strict';

/** global: google */

class TerritoryMapShow {
  constructor({ container, map, config, endpoint, ajax, mapUrl }) {
    this.config = config;
    this.addMarkers = this.addMarkers.bind(this);
    this.drawBorders = this.drawBorders.bind(this);
    this.map = map;
    this.ajax = ajax;
    this.endpoint = endpoint;
    this.mapUrl = mapUrl;
    this.draw();
  }

  addMarkers() {
    const withGeolocation = this.config.markers.filter(marker => marker.geolocation.present);
    const map = this.map

    withGeolocation.forEach((marker) => {
      new google.maps.Marker({
        position: new google.maps.LatLng(marker.geolocation.lat, marker.geolocation.lng),
        icon: marker.icon,
        map: map,
        title: marker.title
      });
    });
  }

  draw() {
    this.addMarkers();
    this.drawBorders();
    this.centralize();
  }

  centralize() {
    if (this.config.center.present) {
      this.map.setCenter(this.config.center);
      return;
    }

    const hamburg = { lat: 53.5535103, lng: 9.9899721 };
    this.map.setCenter(hamburg);
  }

  drawBorders() {
    const coordinates = this.config.coordinates;

    this.borders = new google.maps.Polygon({
      paths: coordinates,
      editable: false,
      strokeColor: 'black',
      strokeOpacity: 0.3,
      strokeWeight: 5,
      fillColor: 'white',
      fillOpacity: 0
    });

    this.borders.setMap(this.map);
  }
}
