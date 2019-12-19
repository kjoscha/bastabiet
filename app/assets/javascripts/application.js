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

    var message = 'Wir wollen mindestens ' + minimumOffer + '€ bzw. maximal ' + maximumOffer + '€ für ' + size.toString() + ' Ernteanteile zahlen.'

    return message;
  };

  jQuery('.statistic-button').click(function() {
    jQuery('#statistic-modal').modal('show');
  });

  jQuery('.settings-button').click(function() {
    jQuery('#settings-modal').modal('show');
  });

  jQuery('.show-agreement-button').click(function() {
    jQuery('#calculated-offers').text(offerConfirm());
    jQuery('#agreement-modal').modal('show');
  });

  jQuery('.minimum-participation-button').click(function() {
    jQuery('#minimum-participation-modal').modal('show');
  });

  jQuery('.dropdown-toggle').dropdown();

  jQuery("form").submit(function() {
    jQuery('.loading-overlay').show();
  });

  jQuery('.share-table').DataTable({
    responsive: true,
    'searching': true,
    'paging': false,
    'bInfo': false,
    'order': [
      [1, 'asc']
    ],
    'columnDefs': [{
      'targets': [3],
      'visible': false
    }, {
      'targets': [6, 7, 8, 9],
      'sortable': false
    }]
  });

  // Matomo
  _paq = window._paq || [];
  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u="https://matomo.coderat.cc/";
    _paq.push(['setTrackerUrl', u+'matomo.php']);
    _paq.push(['setSiteId', '3']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
  })();
});
