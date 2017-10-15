'use strict';

class HouseholderForm {
  constructor(form, navigator, googleMaps) {
    this._form = form;
    this._button = form.querySelector('.js-address-lookup');
    this._streetNameInput = form.querySelector('.js-street-name');
    this._houseNumberInput = form.querySelector('.js-house-number');
    this._navigator = navigator;
    this._geocoder = new googleMaps.Geocoder();

    const handler = (event) => {
      event.preventDefault();
      this.disableButton();
      this.updateLocation();
    };

    this._button.addEventListener('click', handler, false);
  }

  updateLocation() {
    this._navigator.geolocation.getCurrentPosition((position)  => {
      const location = [position.coords.latitude, position.coords.longitude].join(',');

      this._geocoder.geocode({'address': location},  (results, status)  => {
        this.enableButton();

        if (status == 'OK') {
          if (results.length > 0) {
            return this.updateAddress(new GoogleMapsAddress(results[0]));
          }
        }

        alert('Geocode was not successful for the following reason: ' + status);
      });
    });
  };

  updateAddress(address) {
    this._streetNameInput.value = address.getStreetName();
    this._houseNumberInput.value = address.getHouseNumber();
  }

  disableButton() {
    this._button.classList.add('disabled');
  }

  enableButton() {
    this._button.classList.remove('disabled');
  }
}

class GoogleMapsAddress {
  constructor(data) {
    this._data = data;
    this._components = data.address_components;
  }

  getStreetName() {
    return this._getComponent('route').short_name || null;
  }

  getHouseNumber() {
    return this._getComponent('street_number').short_name || null;
  }

  _getComponent(type) {
    const elements = this._components.filter((el)  => {
      return el.types.includes(type);
    });

    if (elements.length == 0) {
      return {};
    }

    return elements[0];
  }
}
