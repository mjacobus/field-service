'use strict';

const fetch = (url) => jQuery.ajax({ url });

const loadTerritoryMap = ({ app, territoryUrl, containerId, action }) => {
  if (action == 'show') {
    fetch(territoryUrl).then((jsonResponse) => {
        app.map = TerritoryMapShow.draw({
          territory: jsonResponse.data,
          container: document.getElementById(containerId)
        });
    });

    return;
  }

  if (action == 'new') {
    fetch(territoryUrl).then((jsonResponse) => {
        app.map = TerritoryMapNew.draw({
          territory: jsonResponse.data,
          container: document.getElementById(containerId)
        });
    });

    return;
  }
}
