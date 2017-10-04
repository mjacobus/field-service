'use strict';

class HouseholdersMap {
  static draw(container, householders) {
    const locations = this.getLogcationsFromHouseholders(householders);
    const zoom = 16;
    const map  = new OpenLayers.Map(container);
    map.addLayer(new OpenLayers.Layer.OSM());
    let lonLat = new OpenLayers.LonLat(locations[0].lon, locations[0].lat).transform(
      new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
      map.getProjectionObject() // to Spherical Mercator Projection
    );
    const markers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(markers);
    markers.addMarker(new OpenLayers.Marker(lonLat));

    locations.forEach((location, index) => {
      lonLat = new OpenLayers.LonLat(location.lon, location.lat).transform(
        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
        map.getProjectionObject() // to Spherical Mercator Projection
      );
      markers.addMarker(new OpenLayers.Marker(lonLat));
      map.setCenter (lonLat, zoom);
    });
  }

  static getLogcationsFromHouseholders(householders) {
    return householders.filter(
      (householders) => {
        return (householders.location.lat && householders.location.lon);
      }
    ).map(householders => householders.location);
  }
}
