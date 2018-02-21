'use strict';

/** global: google */

class TerritoryMapShow {
  static draw({ container, territory }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    const territoryMap = new TerritoryMapShow({ map, config: territory.map });
    territoryMap.draw();
    return territoryMap;
  }

  constructor({ container, map, config }) {
    this.config = config;
    this.addMarkers = this.addMarkers.bind(this);
    this.drawBorders = this.drawBorders.bind(this);
    this.map = map;
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

    if (this.config.center.present) {
      this.map.setCenter(this.config.center);
    } else {
      const hamburg = { lat: 53.5535103, lng: 9.9899721 };
      this.map.setCenter(hamburg);
    }

    this.drawBorders();
  }

  drawBorders() {
    const coordinates = this.config.coordinates;

    const boundaries = new google.maps.Polygon({
      paths: coordinates,
      editable: false,
      strokeColor: 'black',
      strokeOpacity: 0.3,
      strokeWeight: 5,
      fillColor: 'white',
      fillOpacity: 0
    });

    boundaries.setMap(this.map);
  }
}
