import Rails from "@rails/ujs";
import Sortable from 'sortablejs';
import Flash from './components/flash';

export const MenuShowView = {

  sortedMenu: null,
  sortedSubmenus: Array(),

  init: function() {
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
    let menu = document.getElementById('menu-items');
    let data = { items: MenuShowView.serializeMenu(menu) };
    if(data.typeof !== 'undefined') {
      Rails.ajax({
        type: "PUT",
        url: menu.dataset.updateUrl,
        beforeSend(xhr, options) {
          xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
          options.data = JSON.stringify(data);
          return true
        },
        success: function (array) {
          Flash.success(array.msg);
        }
      });
    }
  },

  serializeMenu: function(menu) {
    let dataItems = [];
    if(!menu) {
      return dataItems;
    }
    // Solves problem with direct children items.
    let menuItems = Array.prototype.filter.call(menu.children, function(item) {
      return item.matches('.menu-item');
    });
    Array.prototype.forEach.call(menuItems, function(menuItem) {
      dataItems.push({
        itemId: parseInt(menuItem.dataset.id),
        children: MenuShowView.serializeMenu(menuItem.querySelector('.sub-menu'))
      });
    });
    return dataItems;
  }

};