'use strict';

const ajax = jQuery.ajax;
const fetch = (url) => jQuery.ajax({ url });

const getCoordinates = (polygon) => {
  const coordinates = [];

  polygon.getPath().forEach((loc) => {
    coordinates.push({ lat: loc.lat(), lng: loc.lng() })
  });

  return coordinates;
};

const saveTerritoryBorders = ({ endpoint, ajax, redirectTo }) => {
  return (polygon) => {
    const map_coordinates = getCoordinates(polygon);

    ajax({
      url: endpoint,
      type: 'PATCH',
      data: { territory: { map_coordinates } }
    }).then(() => window.location.href = redirectTo);
  };
};

const loadTerritoryMap = ({ mapUrl, app, territoryUrl, containerId, action }) => {
  const className = {
    show: TerritoryMapShow,
    new: TerritoryMapNew,
    edit: TerritoryMapEdit,
  }[action];

  if (!className) {
    alert(`No operation for action ${action}`);
    return;
  }

  fetch(territoryUrl).then((jsonResponse) => {
    app.map = TerritoryMapFactory.create({
      className,
      ajax,
      config: jsonResponse.data.map,
      endpoint: territoryUrl,
      mapUrl,
      saveTerritoryBorders,
      container: document.getElementById(containerId)
    });
  });
}
