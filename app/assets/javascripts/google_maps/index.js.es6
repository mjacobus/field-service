'use strict';

const loadTerritoryMap = ({ app, territoryUrl, containerId }) => {
  jQuery.ajax({
    url: territoryUrl,
    success: (jsonResponse) => {
      app.map = TerritoryMap.draw({
        territory: jsonResponse.data,
        container: document.getElementById(containerId)
      });
    }
  })
}
