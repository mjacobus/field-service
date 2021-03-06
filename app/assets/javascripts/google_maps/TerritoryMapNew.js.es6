'use strict';

/** global: google */

class TerritoryMapNew extends TerritoryMapShow {
  constructor(props) {
    super(props);
    this.saveBorders = props.saveBorders.bind(this);
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
      this.saveBorders({ endpoint, ajax, redirectTo })
    );
  }
}
