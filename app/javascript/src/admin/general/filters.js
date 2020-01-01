var Filters = {

  init: function() {
    $('.clear-filter-btn').on('click', function(e) {
      e.preventDefault();
      window.location.href = window.location.href.split('?')[0];
    });

    $('.open-filter-btn').on('click', function(e) {
      e.preventDefault();
      var filter = $('#filter');
      if(filter.hasClass('open')) {
        $('#filter').removeClass('open');
      }
      else {
        $('#filter').addClass('open');
      }
    });

    $('.close-filter-btn').on('click', function(e) {
      e.preventDefault();
      $('#filter').removeClass('open');
    });
  }

};