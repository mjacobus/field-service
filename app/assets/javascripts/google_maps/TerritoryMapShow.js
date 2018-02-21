'use strict';

/** global: google */

// https://developers.google.com/maps/documentation/javascript/examples/polygon-hole
// https://developers.google.com/maps/documentation/javascript/examples/polygon-arrays
// https://developers.google.com/maps/documentation/javascript/examples/control-custom
// https://gist.github.com/christophercliff/1380958

class TerritoryMapShow {
  static draw({ container, territory }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    const territoryMap = new TerritoryMapShow({ territory, map, config: territory.map });
    territoryMap.draw();
    return territoryMap;
  }

  constructor({ territory, container, map, config }) {
    this.config = config;
    this.getMarkers = this._getMarkers.bind(this);
    this.drawBorders = this.drawBorders.bind(this);

    this.map = map;
    this.territory = territory;
    this.markers = this._getMarkers();
  }

  draw() {
    this.map.setCenter(this.config.center);
    const map = this.map;

    this.getMarkers().forEach((marker) => {
      new google.maps.Marker({
        position: new google.maps.LatLng(marker.position.lat, marker.position.lon),
        icon: Icons.mapPin,
        map: map,
        title: marker.title
      });
    });

    this.drawBorders();
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

  drawBorders() {
    const coordinates = this.config.coordinates;

    // Construct the polygon.
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
