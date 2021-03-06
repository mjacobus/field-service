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

const saveBorders = ({ endpoint, redirectTo }) => {
  return (polygon) => {
    const map_coordinates = getCoordinates(polygon);

    ajax({
      url: endpoint,
      type: 'PATCH',
      data: { territory: { map_coordinates } }
    }).then(() => window.location.href = redirectTo);
  };
};

const removeBorders = ({ endpoint, redirectTo }) => {
  return ajax({
    url: endpoint,
    type: 'PATCH',
    data: { territory: { map_coordinates: '' }}
  }).then(() => window.location.href = redirectTo);
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
      getCoordinates,
      mapUrl,
      saveBorders,
      removeBorders,
      container: document.getElementById(containerId)
    });
  });
}

const loadTerritoriesMap = ({ app, mapsEndpoint, containerId }) => {
  fetch(mapsEndpoint).then((jsonResponse) => {
    app.map = TerritoriesMapFactory.create({
      app,
      territories: jsonResponse.data,
      container: document.getElementById(containerId)
    });
  });
}
