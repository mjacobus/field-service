// http://openlayers.org/en/latest/examples/full-screen-source.html

import React from 'react';

import Icon from './icon';

import Map from 'ol/map';
import View from 'ol/view';
import control from 'ol/control';
import FullScreen from 'ol/control/fullscreen';
import Tile from 'ol/layer/tile';
import OSM from 'ol/source/osm';
import Feature from 'ol/feature';
import Point from 'ol/geom/point';
import proj from 'ol/proj';

const draw = ({ id, markerId, markers }) => {
  console.log("faaaa");

  var rome = new Feature({
    geometry: new Point(proj.fromLonLat([12.5, 41.9]))
  });

  var view = new View({
    // center: [-9101767, 2822912],
    center: proj.fromLonLat([12.5, 41.9]),
    // center: [12.5, 41.9],
    zoom: 14
  });

  var map = new Map({
    // controls: control.defaults().extend([
    //   new FullScreen({
    //     source: 'fullscreen'
    //   })
    // ]),
    layers: [
      new Tile({
        source: new OSM()
      })
    ],
    target: 'map',
    view: view
  });
};

export default ({ markers }) => {
  const id = 'map';
  const markerId = `${id}-marker`;

  setTimeout(() => {
    draw({ id, markers, markerId });
  }, 100);

  return <div><div id={ id }><div id={ markerId }></div></div></div>;
};
