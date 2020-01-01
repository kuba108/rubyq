import LBD from "light-bootstrap-dashboard"

let General = {

  init: function() {
    LBD.init();

    // $('.wysiwyg-widget-editor').froalaEditor({
    //   key: 'bC2A8B5C6C5F4G2H3H3J2C5B4==',
    //   // Define new paragraph styles.
    //   paragraphStyles: {
    //     class1: 'Class 1',
    //     class2: 'Class 2'
    //   },
    //   linkStyles: {
    //     'btn btn-success': 'Zelené tlačítko',
    //     'btn btn-warning': 'Oranzove tlačítko'
    //   },
    //   toolbarButtons: ['bold', 'italic', 'underline', 'strikeThrough', 'fontFamily',
    //     'fontSize', '|', 'align', 'formatOL', 'formatUL', 'paragraphStyle', 'paragraphFormat', 'align', 'insertLink', '|', 'undo', 'redo', 'html', 'clearFormatting'],
    //   language: 'cs'
    // });

    $('[data-action=send-form]').on('click', function() {
      let button = $(this);
      let form = $(button.data('form'));
      form.submit();
    });

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