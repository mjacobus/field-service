'use strict';

/** global: google */

// https://developers.google.com/maps/documentation/javascript/examples/polygon-hole
// https://developers.google.com/maps/documentation/javascript/examples/polygon-arrays

class TerritoryMap {
  static draw({ container, territory }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    const territoryMap = new TerritoryMap({ territory, map });
    territoryMap.draw(map);
    return territoryMap;
  }

  constructor({ territory, container, map }) {
    this.getMarkers = this._getMarkers.bind(this);
    this.centralize = this.centralize.bind(this);

    this.map = map;
    this.territory = territory;
    this.markers = this._getMarkers();
  }

  centralize() {
    // sum of lat/lon
    const sum = this.markers.reduce((accumulator, marker) => {
      accumulator.lat += marker.position.lat;
      accumulator.lng += marker.position.lon;

      return accumulator;
    }, { lat: 0, lng: 0 });

    // average of lat/lon
    const length = this.markers.length;
    const average = { lat: sum.lat/length, lng: sum.lng/length };

    this.map.setCenter(average);
  }

  draw() {
    this.centralize();

    const map = this.map;

    this.markers.forEach((marker) => {
      new google.maps.Marker({
        position: new google.maps.LatLng(marker.position.lat, marker.position.lon),
        icon: Icons.mapPin,
        map: map,
        title: marker.title
      });
    });

    this._drawPolygon();
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

  _drawPolygon() {
    const drawingManager = new google.maps.drawing.DrawingManager({
      drawingControl: true,
      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: ['polygon']
      },
      circleOptions: {
        fillColor: null,
        fillOpacity: 0,
        strokeWeight: 5,
        clickable: false,
        editable: true,
        zIndex: 1
      }
    });

    drawingManager.setMap(this.map);

    google.maps.event.addListener(drawingManager, 'polygoncomplete', (poly) => {
      const coordinates = [];
      poly.getPath().forEach((loc) => coordinates.push({ lat: loc.lat(), lng: loc.lng() }));
      console.log(coordinates);
    });

    // Define the LatLng coordinates for the polygon.
    const coordenates = this._savedMap();

    // Construct the polygon.
    const savedTerritory = new google.maps.Polygon({
      paths: coordenates,
      editable: true,
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 3,
      fillColor: '#FF0000',
      fillOpacity: 0
    });
    savedTerritory.setMap(this.map);
  }

  _savedMap() {
    return [
      { lat: 53.55050557090095, lng: 9.994030470886173 },
      { lat: 53.54823631218663, lng: 9.995489592590275 },
      { lat: 53.54917972665483, lng: 10.003171439208927 },
      { lat: 53.55065855025642, lng: 10.00209855560297 }
    ];
  }

}
