'use strict';

/** global: google */

class TerritoryMapFactory {
  static create({ container, className, ...otherOptions }) {
    otherOptions.map = new google.maps.Map(container, {
      zoom: 14.9,
      mapTypeId: 'terrain'
    });

    return new className(otherOptions);
  }
}
