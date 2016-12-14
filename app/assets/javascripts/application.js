// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/extras/dataTables.responsive
//= require bootstrap
//= require bootstrap-sprockets
//= require d3
//= require_self
//= require_tree .

jQuery(function() {
  var offerConfirm = function() {
    var size = jQuery('#share_size').val();
    var minimumOffer = jQuery('#share_offer_minimum').val();
    var maximumOffer = jQuery('#share_offer_maximum').val();

    var message = 'Möchtet ihr wirklich mindestens ' + minimumOffer + '€ bzw. maximal ' + maximumOffer + '€ für ' + size.toString() + ' Ernteanteile zahlen?'

    return message;
  };

  $('.share-update-submit').click(function(event){
      if(!confirm(offerConfirm()))
          event.preventDefault();
  });

  jQuery('.flash-message').fadeOut(10000);

  jQuery('.statistic-button').click(function() {
    jQuery('#statistic-modal').modal('show');
  });

  jQuery('.settings-button').click(function() {
    jQuery('#settings-modal').modal('show');
  });

  jQuery('.minimum-participation-button').click(function() {
    jQuery('#minimum-participation-modal').modal('show');
  });

  jQuery('.dropdown-toggle').dropdown();

  jQuery("form").submit(function () {
    jQuery('.loading-overlay').show();
  });

  jQuery('.share-table').DataTable({
    responsive: true,
    'searching': true,
    'paging': false,
    'bInfo': false,
    'order': [[ 0, 'asc' ]],
    'aoColumnDefs': [
        { 'bSortable': false, 'aTargets': [6,5,4,3] }
     ]
  });

});
