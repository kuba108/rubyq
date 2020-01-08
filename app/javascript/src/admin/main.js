import General from "./general"
import AjaxListener from "./components/ajax_listener"
import Modal from "./components/modal"
import Flash from "./components/flash"
import Filter from "./components/filter"
import TextEditor from "./editors/text_editor"
import NumberEditor from "./editors/number_editor"
import TextAreaEditor from "./editors/text_area_editor"
import SelectEditor from "./editors/select_editor"
import DateEditor from "./editors/date_editor"
//import Dashboard from "dashboard"

import { PagesNewView } from "./pages"

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

      Filter.init();
      TextEditor.init();
      NumberEditor.init();
      TextAreaEditor.init();
      SelectEditor.init();
      //DateEditor.init();
    }
  },

  dashboard: {
    show: function() {
      Dashboard.init();
    }
  },

  admin_user_policies: {
    index: function() {
      AdminUserPoliciesIndexView.init();
    }
  },

  menus: {
    show: function() {
      MenuShowView.init();
    }
  },

  pages: {
    new: function() {
      PagesNewView.init();
    }
  },

  sections: {
    index: function() {
      SectionsIndexView.init();
    }
  },

  galleries: {
    show: function() {
      GalleriesShowView.init();
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
