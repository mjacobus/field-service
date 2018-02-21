'use strict';

/** global: google */

class TerritoryMapFactory {
  static create({ container, territory, className }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    const territoryMap = new className({ map, config: territory.map });
    territoryMap.draw();
    return territoryMap;
  }
}

