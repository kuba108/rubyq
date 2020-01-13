import Rails from "@rails/ujs";
import * as Sortable from "es-jquery-sortable";

// global export
window.Sortable = Sortable;

export const MenuShowView = {

  init: function() {
    $(document).bind('ajaxSuccess', function (event, xhr, settings) {
      try {
        json = $.parseJSON(xhr.responseText);

        switch(json.kind) {
          case 'add_menu_item_result':
            $('#add-menu-link-modal').modal('hide');
            Turbolinks.visit(json.route);
            window.flash_success = json.msg;
            break;
        }
      }
      catch(e) {
        // not JSON
      }
    });

    $('#menu-edit-toggle-btn').on('click', function(e) {
      var btn = $(this);
      var menu = $('#menu-items');

      if(btn.hasClass('active')) {
        btn.removeClass('active');
        menu.removeClass('edit');
      }
      else {
        btn.addClass('active');
        menu.addClass('edit');
      }

      e.stopImmediatePropagation();
    });

    // $("#menu-items").sortable({
    //   handle: '.draggable',
    //   onDrop: function ($item, container, _super, event) {
    //     $item.removeClass(container.group.options.draggedClass).removeAttr("style");
    //     $("body").removeClass(container.group.options.bodyClass);
    //   }
    // });

    document.getElementById('save-menu-items-order-btn')
      .addEventListener('click', MenuShowView.saveMenuItemsOrderBtnClickHandler);

    document.getElementById('create-menu-item-btn')
      .addEventListener('click', MenuShowView.createMenuItemBtnClickHandler);
  },

  createMenuItemBtnClickHandler: function(e) {
    let form = document.querySelector('#create-menu-item-modal .tab-pane.active form');
    Rails.fire(form, 'submit');
  },

  saveMenuItemsOrderBtnClickHandler: function(e) {
    MenuShowView.saveMenuItemsOrderChanges();
  },

  saveMenuItemsOrderChanges: function() {
    // var menu = $('#menu-items');
    // var data = menu.sortable("serialize").get();
    // var json = JSON.stringify(data, null, ' ');
    //
    // if(json.typeof !== 'undefined') {
    //   $.ajax({
    //     method: 'put',
    //     url: menu.attr('data-update-url'),
    //     data: { data: json },
    //     success: function() {
    //       var save_btn = $('#save-menu-items-order-btn');
    //       save_btn.attr('disabled', 'disabled').addClass('disabled');
    //     }
    //   })
    // }
  }

};