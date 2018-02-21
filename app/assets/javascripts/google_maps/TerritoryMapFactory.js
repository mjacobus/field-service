'use strict';

/** global: google */

class TerritoryMapFactory {
  static create({ container, territory, className, endpoint, ajax, mapUrl }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    return new className({ map, config: territory.map, endpoint, ajax, mapUrl });
  }
}

