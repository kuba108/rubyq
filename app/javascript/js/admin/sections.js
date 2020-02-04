import Widget from "./components/widget";
import sortable from "html5sortable/dist/html5sortable.es"

export const SectionsIndexView = {

  init: function() {
    Widget.init();

    $('#save-all-widgets-btn').on('click', function(e) {
      e.stopImmediatePropagation();
      e.preventDefault();
      let btn = $(this);
      let widgets = $('.widget');

      widgets.find('.widget-save-btn').click();
    });

    SectionsIndexView.initializeSectionsSorting();
    SectionsIndexView.initializeWrappersSorting();
    SectionsIndexView.initializeWidgetSorting();
  },

  initializeSectionsSorting: function() {
    sortable('.section-list', {
      forcePlaceholderSize: true,
      items: '.section',
      acceptFrom: '.section-list',
      placeholderClass: 'section-drop',
      handle: '.drag-placeholder'
    });

    let sectionList = document.getElementsByClassName('section-list')[0];
    sectionList.addEventListener("sortupdate", function (e) {
      let sections = this.getElementsByClassName('section');
      let json = {
        items: []
      };
      for(let j = 0; j < sections.length; j++) {
        json['items'].push(parseInt(sections[j].dataset.itemId));
      }

      $.ajax({
        method: 'put',
        url: document.getElementById('sections').dataset.updateUrl,
        data: { data: json },
        success: function() {
          console.log('saved');
        }
      });
    });
  },

  initializeWrappersSorting: function() {
    sortable('.wrapper-list', {
      forcePlaceholderSize: true,
      items: '.wrapper-card',
      acceptFrom: '.wrapper-list',
      placeholderClass: 'wrapper-drop',
      handle: '.drag-placeholder'
    });

    let wrapperLists = document.getElementsByClassName('wrapper-list');
    for(let i = 0; i < wrapperLists.length; i++) {
      wrapperLists[i].addEventListener("sortupdate", function (e) {
        let wrappers = this.getElementsByClassName('wrapper-card');
        let json = {
          sectionId: parseInt(this.dataset.sectionId),
          items: []
        };
        for(let j = 0; j < wrappers.length; j++) {
          json['items'].push(parseInt(wrappers[j].dataset.itemId));
        }

        $.ajax({
          method: 'put',
          url: document.getElementById('sections').dataset.updateWrapperUrl,
          data: { data: json },
          success: function() {
            console.log('saved');
          }
        });
      });
    }
  },

  initializeWidgetSorting: function() {
    sortable('.widget-wrapper', {
      forcePlaceholderSize: true,
      items: '.widget',
      acceptFrom: '.widget-wrapper',
      placeholderClass: 'widget-drop',
      handle: '.widget-header'
    });

    let widgetWrappers = document.getElementsByClassName('widget-wrapper');
    for(let i = 0; i < widgetWrappers.length; i++) {
      widgetWrappers[i].addEventListener("sortupdate", function (e) {
        let widgets = this.getElementsByClassName('widget');
        let json = {
          wrapperId: parseInt(this.dataset.wrapperId),
          wrapperPart: this.dataset.wrapperPart,
          items: []
        };
        for(let j = 0; j < widgets.length; j++) {
          json['items'].push(parseInt(widgets[j].dataset.itemId));
        }

        $.ajax({
          method: 'put',
          url: document.getElementById('sections').dataset.updateWidgetUrl,
          data: { data: json },
          success: function() {
            console.log('saved');
          }
        });
      });
    }
  }

};