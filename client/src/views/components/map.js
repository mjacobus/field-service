import React from 'react';

import Icon from './icon';

import Map from 'ol/map';
import View from 'ol/view';
import TitleLayer from 'ol/layer/tile';
import Osm from 'ol/layer/osm';
import XYZ from 'ol/source/xyz';
import proj from 'ol/proj';
import Overlay from 'ol/overlay';

const draw = ({ id, markerId, markers }) => {
  const icon = document.createElement('div');
  icon.innerHTML = 'X';

  const layer = new TitleLayer({
    source: new OSM()
  });

  const map = new Map({
    layers: [layer],
    target: id,
    view: new View({
      center: [0, 0],
      zoom: 2
    })
  });

  const pos = proj.fromLonLat([16.3725, 48.208889]);

  // Vienna marker
  let marker = new Overlay({
    position: pos,
    positioning: 'center-center',
    element: document.getElementById(markerId),
    stopEvent: false
  });
  map.addOverlay(marker);

  // Vienna label
  let vienna = new Overlay({
    position: pos,
    element: icon,
  });

  map.addOverlay(vienna);

  // // Popup showing the position the user clicked
  // let popup = new ol.Overlay({
  //   element: document.getElementById('popup')
  // });
  //
  // map.addOverlay(popup);
};

export default ({ markers }) => {
  const id = 'the-map-id';
  const markerId = `${id}-marker`;

  setTimeout(() => {
    console.log('drawwing');
    draw({ id, markers, markerId });
  }, 100);

  return <div id={ id }><div id={ markerId }></div></div>;
};
