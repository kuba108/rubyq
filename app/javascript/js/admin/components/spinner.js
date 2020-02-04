var Spinner = {

  init: function() {
    $('[data-spinner=show]').on('click.mixit', function() {
      Spinner.show();
    });
  },

  show: function () {
    $('#spinner').fadeIn('fast');
  },

  hide: function () {
    $('#spinner').fadeOut('fast');
  }

};