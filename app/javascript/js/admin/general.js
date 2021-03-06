import LBD from "light-bootstrap-dashboard"
import ButtonAction from "./components/button_action";

const General = {

  init: function() {
    LBD.init();
    ButtonAction.init();

    // Action which calls URL and deletes some model row in DB.
    $('[data-action=delete-model]').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let button = $(this);
      General.showDeleteWindow(button.data('delete-label'), button.data('url'))
    });

    $('.custom-file-input').on('change', function() {
      let fileName = $(this).val().split('\\').pop();
      $(this).siblings('.custom-file-label').addClass('selected').html(fileName);
    });
  },

  showDeleteWindow: function(delete_label, delete_url) {
    let window = $('#delete-modal');
    window.html(window.html().split(/%model_name%/i).join(delete_label));
    window.find('.delete-btn').attr('href', delete_url);
    window.modal();
  },

};

export default General;