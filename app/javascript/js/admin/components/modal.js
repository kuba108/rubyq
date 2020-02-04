const Modal = {

  showOkModal: function(title, msg, reload) {
    var window = $('#ok-modal');

    if(typeof title === "undefined" || title == '') {
      title = 'Unknown title'
    }

    if(typeof msg === "undefined" || msg == '') {
      msg = 'Unknown message'
    }

    if(typeof reload === "undefined" || reload == '') {
      reload = false
    }

    window.find('.modal-title').html(title);
    window.find('.modal-body').html(msg);

    window.modal();

    if(reload) {
      window.off('hidden.bs.modal').on('hidden.bs.modal', function () {
        Turbolinks.visit(location.toString());
      });
    }
  },

  showErrorModal: function(title, msg) {
    var window = $('#error-modal');

    if(typeof title === "undefined" || title == '') {
      title = 'Unknown title'
    }

    if(typeof msg === "undefined" || msg == '') {
      msg = 'Unknown message'
    }

    window.find('.modal-title').html(title);
    window.find('.modal-body').html(msg);

    window.modal();
  },

  showExportModal: function(file_name, file_type, path, file_description, reload) {
    var window = $('#export-modal');
    var download_btn = window.find('#export-modal-file-btn');

    if(typeof file_name === "undefined" || file_name == '') {
      title = 'Unknown file name'
    }

    if(typeof file_type === "undefined" || file_type == '') {
      msg = 'Unknown type'
    }

    if(typeof reload === "undefined" || reload == '') {
      reload = false
    }

    window.find('.modal-title').find('.file-type').html(file_type);
    window.find('.modal-body').find('.file-type').html(file_type);
    window.find('.modal-body').find('.file-description').html(file_description);

    download_btn.attr('href', path);

    window.modal();

    if(reload) {
      window.off('hidden.bs.modal').on('hidden.bs.modal', function () {
        Turbolinks.visit(location.toString());
      });
    }
  }

};

export default Modal