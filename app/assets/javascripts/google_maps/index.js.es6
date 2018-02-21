'use strict';

const fetch = (url) => jQuery.ajax({ url });

const loadTerritoryMap = ({ app, territoryUrl, containerId, action }) => {
  const className = {
    show: TerritoryMapShow,
    new: TerritoryMapNew,
  }[action];

  if (!className) {
    alert(`No operation for action ${action}`);
    return;
  }

  fetch(territoryUrl).then((jsonResponse) => {
    app.map = TerritoryMapFactory.create({
      className,
      territory: jsonResponse.data,
      container: document.getElementById(containerId)
    });
  });
}
