'use strict';

/** global: google */

const messages = {
  confirmSave: 'Tem certeza que deseja salvar as bordas do mapa?',
  confirmDelete: 'Tem certeza de que deseja excluir as bordas do mapa?'
};

class TerritoryMapEdit extends TerritoryMapShow {
  constructor(props) {
    super(props);
    this.saveBorders = props.saveBorders.bind(this);
    this.getCoordinates = props.getCoordinates.bind(this);
    this.removeBorders = props.removeBorders.bind(this);
    this.borders.setEditable(true);
    this.addControlls();

  }

  addControlls() {
    const { map, borders, endpoint, mapUrl } = this;

    const controlDiv = document.createElement('div');

    controlDiv.index = 1;
    map.controls[google.maps.ControlPosition.RIGHT_CENTER].push(controlDiv);

    const controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.marginBottom = '22px';
    controlUI.style.textAlign = 'center';
    controlUI.title = 'Click to recenter the map';
    controlDiv.appendChild(controlUI);

    const saveButton = document.createElement('div');
    saveButton.style.backgroundColor = 'green';
    saveButton.style.color = 'white';
    saveButton.style.fontFamily = 'Roboto,Arial,sans-serif';
    saveButton.style.fontSize = '16px';
    saveButton.style.lineHeight = '38px';
    saveButton.style.paddingLeft = '5px';
    saveButton.style.paddingRight = '5px';
    saveButton.innerHTML = 'Salvar';
    controlUI.appendChild(saveButton);

    const deleteButton = document.createElement('div');
    deleteButton.style.backgroundColor = 'red';
    deleteButton.style.margin = '10px 0 0 0';
    deleteButton.style.color = 'white';
    deleteButton.style.fontFamily = 'Roboto,Arial,sans-serif';
    deleteButton.style.fontSize = '16px';
    deleteButton.style.lineHeight = '38px';
    deleteButton.style.paddingLeft = '5px';
    deleteButton.style.paddingRight = '5px';
    deleteButton.innerHTML = 'Excluir';
    controlUI.appendChild(deleteButton);

    saveButton.addEventListener('click', () => {
      if (confirm(messages.confirmSave)) {
        this.saveBorders({ endpoint, redirectTo: mapUrl })(borders);
      }
    });

    deleteButton.addEventListener('click', () => {
      if (confirm(messages.confirmDelete)) {
        this.removeBorders({ endpoint, redirectTo: mapUrl });
      }
    });
  }
}

