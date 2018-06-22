// lat: 53.6555, lon: 10.007

/** global: google */

const averageLocation = (territories) => {
  const latitudes = [];
  const longitudes = []

  territories.forEach((territory) => {
    territory.coordinates.forEach((coordinate) => {
      latitudes.push(coordinate.lat);
      longitudes.push(coordinate.lng);
    })
  });


  const lat = (Math.min.apply(null, latitudes) + Math.max.apply(null, latitudes)) / 2;
  const lng = (Math.min.apply(null, longitudes) + Math.max.apply(null, longitudes)) / 2;

  return { lat, lng };
}

class TerritoriesMap {
  constructor({ container, map, config, endpoint, ajax, mapUrl, territories }) {
    this.map = map;
    map.setCenter({ lat: 53.6555, lng: 10.007 });

    this.drawBorders = this.drawBorders.bind(this);
    this.setLabel = this.setLabel.bind(this);

    territories.forEach(territory => this.drawBorders(territory))
    territories.forEach(territory => this.setLabel(territory))
    this.centralize(territories);
  }

  drawBorders(territory) {
    const coordinates = territory.coordinates;
    this.borders = new google.maps.Polygon({
      paths: coordinates,
      editable: false,
      strokeColor: 'black',
      strokeOpacity: 0.3,
      strokeWeight: 2,
      fillColor: 'white',
      fillOpacity: 0
    });

    this.borders.setMap(this.map);
  }

  centralize(territories) {
    const center = averageLocation(territories);
    this.map.setCenter(center);
  }

  setLabel(territory) {
    const center = averageLocation([territory]);
    new google.maps.Marker({
      position: center,
      map: this.map,
      label: territory.name
    });
  }
}
