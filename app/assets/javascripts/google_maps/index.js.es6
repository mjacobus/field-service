'use strict';

const loadTerritoryMap = ({ territoryUrl, containerId }) => {
  jQuery.ajax({
    url: territoryUrl,
    success: (jsonResponse) => {
      const territory = jsonResponse.data;
      const map = new TerritoryMap({ territory });
      map.drawIn(document.getElementById(containerId));
    }
  })
}
