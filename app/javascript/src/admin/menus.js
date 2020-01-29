import Rails from "@rails/ujs";
//import sortable from "html5sortable/dist/html5sortable.es";
import Sortable from 'sortablejs';

export const MenuShowView = {

  sortedMenu: null,
  sortedSubmenus: Array(),

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

    $('#create-menu-item-modal').on('shown.bs.modal', function (e) {
      MenuShowView.choosePageItemSelected($(this));
    });

    $('#choose-page-select').on('change', function (e) {
      let modal = $('#create-menu-item-modal');
      MenuShowView.choosePageItemSelected(modal);
    });

    let menuItems = document.getElementById('menu-items');
    MenuShowView.sortedMenu = Sortable.create(menuItems, {
      handle: '.drag-placeholder',
      group: 'items',
      animation: 150,
      ghostClass: 'menu-item-drop'
    });

    let nestedSortables = document.querySelectorAll('.sub-menu');
    for (var i = 0; i < nestedSortables.length; i++) {
      MenuShowView.sortedSubmenus[i] = new Sortable(nestedSortables[i], {
        ghostClass: 'menu-item-drop',
        group: 'items',
        animation: 0,
        fallbackOnBody: true,
        swapThreshold: 0.65
      });
    }

    // $("#menu-items").sortable({
    //   handle: '.draggable',
    //   onDrop: function ($item, container, _super, event) {
    //     $item.removeClass(container.group.options.draggedClass).removeAttr("style");
    //     $("body").removeClass(container.group.options.bodyClass);
    //   }
    // });

    // sortable('#menu-items', {
    //   forcePlaceholderSize: true,
    //   items: '.menu-item',
    //   acceptFrom: '.sub-menu',
    //   placeholderClass: 'menu-item-drop',
    //   handle: '.drag-placeholder'
    // });
    //
    // sortable('.usub-men', {
    //   forcePlaceholderSize: true,
    //   items: '.menu-item',
    //   acceptFrom: '#menu-items, .sub-menu',
    //   placeholderClass: 'menu-item-drop',
    //   handle: '.drag-placeholder'
    // });

    // sortable('#menu-items')[0].addEventListener('sortstart', function(e) {
    //   let container = e.detail.origin.container;
    //   container.classList.add('sorting');
    // });
    //
    // sortable('#menu-items')[0].addEventListener('sortupdate', function(e) {
    //   let container = e.detail.origin.container;
    //   container.classList.remove('sorting');
    // });

    document.getElementById('save-menu-items-order-btn')
      .addEventListener('click', MenuShowView.saveMenuItemsOrderBtnClickHandler);

    document.getElementById('create-menu-item-btn')
      .addEventListener('click', MenuShowView.createMenuItemBtnClickHandler);
  },

  choosePageItemSelected: function(modal) {
    let label = $('#choose-page-menu-item-label');
    label.val(modal.find('option:selected').text());
    label.focus();
  },

  createMenuItemBtnClickHandler: function(e) {
    let form = document.querySelector('#create-menu-item-modal .tab-pane.active form');
    Rails.fire(form, 'submit');
  },

  saveMenuItemsOrderBtnClickHandler: function(e) {
    //MenuShowView.saveMenuItemsOrderChanges();
    const data = MenuShowView.sortedMenu.toArray();
    console.log(data);
    const json = { data: [] };

    for(let i = 0; i < data.length; i++) {
      //console.log(data[i]);

      let submenu

      json['data'].push({
        itemPosition: i+1,
        itemId: parseInt(data[i]),
        children: []
      });
    }

    console.log(json);


    // for(let i = 0; i < MenuShowView.sortedSubmenus.length; i++) {
    //   let sortedSubmenu = MenuShowView.sortedSubmenus[i];
    //   let data = sortedSubmenu.toArray();
    //   if(Array.isArray(data) && data.length > 0) {
    //     console.log(sortedSubmenu.el.dataset.submenuId + ' : ' + data);
    //   }
    // }


  },

  saveMenuItemsOrderChanges: function() {
    // const myJSON = {data: [
    //     {
    //       itemPosition: 42,
    //       itemId: 13,
    //       children: []
    //     }
    //   ]};
    //
    // let data =  [
    //   [
    //     {
    //       "itemPosition": 1,
    //       "itemId": 13,
    //       "children": [
    //         []
    //       ]
    //     },
    //     {
    //       "itemPosition": 2,
    //       "itemId": 12,
    //       "children": [
    //         []
    //       ]
    //     },
    //     {
    //       "itemPosition": 3,
    //       "itemId": 11,
    //       "children": [
    //         []
    //       ]
    //     },
    //     {
    //       "itemPosition": 4,
    //       "itemId": 10,
    //       "children": [
    //         []
    //       ]
    //     },
    //     {
    //       "itemPosition": 5,
    //       "itemId": 14,
    //       "children": [
    //         []
    //       ]
    //     },
    //     {
    //       "itemPosition": 6,
    //       "itemId": 15,
    //       "children": [
    //         []
    //       ]
    //     }
    //   ]
    // ]


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