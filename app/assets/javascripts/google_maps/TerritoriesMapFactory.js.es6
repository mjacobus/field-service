'use strict';

/** global: google */

class TerritoriesMapFactory {
  static create({ container, className, ...otherOptions }) {
    otherOptions.map = new google.maps.Map(container, {
      zoom: 11.5,
      mapTypeId: 'terrain'
    });

    return new TerritoriesMap(otherOptions);
  }
}
