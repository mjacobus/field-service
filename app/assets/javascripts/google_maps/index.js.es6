'use strict';

const ajax = jQuery.ajax;
const fetch = (url) => jQuery.ajax({ url });

// const token = () => jQuery('meta[name="csrf-token"]').attr('content');
//
// jQuery.ajaxSetup({
//   beforeSend: (xhr) => {
//     console.log(token())
//     return xhr.setRequestHeader('X-CSRF-Token', token());
//   }
// });

const loadTerritoryMap = ({ mapUrl, app, territoryUrl, containerId, action }) => {
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
      ajax,
      territory: jsonResponse.data,
      endpoint: territoryUrl,
      mapUrl,
      container: document.getElementById(containerId)
    });
  });
}
