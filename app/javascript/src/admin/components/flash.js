const Flash = {

  success: function (msg) {
    $.notify({
      // options
      message: msg
    }, {
      // settings
      element: '#flash-messages',
      type: 'success',
      position: 'fixed',
      delay: 50000,
      allow_dismiss: true,
      onShown: function() {
        // so it wont get animated again with turbolinks page visit
        $(this).removeClass('animated');
      }
    });
  },

  error: function (msg) {
    $.notify({
      // options
      message: msg
    }, {
      // settings
      element: '#flash-messages',
      position: 'fixed',
      type: 'danger',
      delay: 1000000,
      timer: 1000000,
      allow_dismiss: true,
      onShown: function() {
        // so it wont get animated again with turbolinks page visit
        $(this).removeClass('animated');
      }
    });
  }
};

export default Flash