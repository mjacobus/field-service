// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree ./legacy

$(function(){
  $(document).foundation();

  $('body').on('click', '#js-show-map',  function () {
    var link = $(this);

    if (!link.data('mapShown')) {
      link.data('mapShown', true)
      var mapContainerId = link.data('map-container');
      $('#' + mapContainerId + '-container').show();
      var addresses = link.data().mapAddresses;
      HouseholdersMap.draw(mapContainerId, addresses);
    }
  });

  $(document).on('click', '.change-assignment-completion-status', 'input[type=radio]', function () {
    var el = $(this).find(':checked');
    var payload = Object.assign({}, el.data('territoryAssignment'));
    var id = payload.id;
    delete payload.id;
    var service = new TerritoryAssignmentService();
    service.update(id, payload).fail(function () {
      alert(['Failed for', id].join(' '))
    });
  });
});
