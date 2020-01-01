import General from "app/general"
import AjaxListener from "app/components/ajax_listener"
import Modal from "app/components/modal"
import Flash from "app/components/flash"

import Dashboard from "app/dashboard"

const UTIL = {
  exec: function( controller, action ) {
    var ns = SITENAME,
      action = ( action === undefined ) ? "init" : action;

    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      ns[controller][action]();
    }
  },

  init: function() {
    var body = document.body,
      controller = body.getAttribute( "data-controller" ),
      action = body.getAttribute( "data-action" );

    UTIL.exec( "common" );
    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};

const SITENAME = {
  common: {
    init: function() {
      // General init
      General.init();

      // Components init
      AjaxListener.init();
    }
  },

  dashboard: {
    show: function() {
      Dashboard.init();
    }
  }
};

document.addEventListener('turbolinks:load', function(e) {
  UTIL.init();

  if(window.success) {
    if (window.success.modal) {
      Modal.showOkModal(window.success.modal_title || 'Úspěch', window.success.msg);
    }
    else {
      Flash.success(window.success.msg);
    }

    window.success = null;
  }

  if(window.error) {
    if (window.error.modal) {
      Modal.showErrorModal(window.error.modal_title || 'Došlo k chybě', window.error.msg);
    }
    else {
      Flash.error(window.error.msg);
    }

    window.error = null;
  }
});

document.addEventListener('turbolinks:before-render', function(e) {
  // Unbinds AJAX success listener.
  $(document).unbind('ajaxSuccess');

  // Unbinds AJAX error listener.
  $(document).unbind('ajaxError');
});
