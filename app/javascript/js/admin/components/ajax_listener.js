import Modal from "./modal"

const AjaxListener = {

  init: function() {
    document.addEventListener('ajax:success', AjaxListener.initHandler);
  },

  initHandler: function(event) {
    var json = event.detail[0];
    var status = event.detail[1];
    var xhr = event.detail[2];

    try {
      if (json.redirect_path) {
        Turbolinks.visit(json.redirect_path);
        if (json.msg) {
          window.success = json;
        }
      }
      else {
        if (json.msg) {
          if (json.modal) {
            Modal.showOkModal(json.modal_title || 'Úspěch', json.msg);
          } else {
            Flash.success(json.msg);
          }
        }
      }
      if (json.kind) {
        AjaxListener.router(json, json.kind)
      }
    }
    catch(e) {
      Modal.showErrorModal('Nepodařilo se prečíst odpověď se serveru', xhr.responseText);
    }
  }

};

export default AjaxListener;