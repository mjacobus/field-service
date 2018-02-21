'use strict';

/** global: google */

const getCoordinates = (polygon) => {
  const coordinates = [];

  polygon.getPath().forEach((loc) => {
    coordinates.push({ lat: loc.lat(), lng: loc.lng() })
  });

  return coordinates;
};

const saveTerritory = ({ endpoint, ajax, redirectTo }) => {
  return (polygon) => {
    const map_coordinates = getCoordinates(polygon);

    ajax({
      url: endpoint,
      type: 'PATCH',
      data: { territory: { map_coordinates } }
    }).then(() => window.location.href = redirectTo);
  };
};

class TerritoryMapNew extends TerritoryMapShow {
  constructor(params) {
    super(params);
    this.drawEditor();
  }

  drawEditor() {
    const drawingManager = new google.maps.drawing.DrawingManager({
      drawingControl: true,
      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: ['polygon']
      },
      polygonOptions: {
        fillColor: null,
        fillOpacity: 0,
        strokeWeight: 2,
        clickable: false,
        editable: !true,
        zIndex: 1
      }
    });

    drawingManager.setMap(this.map);

    const { endpoint, ajax } = this;
    const redirectTo = this.mapUrl;

    google.maps.event.addListener(
      drawingManager,
      'polygoncomplete',
      saveTerritory({ endpoint, ajax, redirectTo })
    );
  }
}
