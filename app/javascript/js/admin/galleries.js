import sortable from "html5sortable/dist/html5sortable.es"
import Flash from "./components/flash";

export const  GalleriesShowView = {

  init: function() {
    sortable('.gallery-list', {
      forcePlaceholderSize: true,
      items: '.gallery-item',
      acceptFrom: '.gallery-list',
      placeholderClass: 'gallery-item-drop',
      handle: '.drag-placeholder'
    });

    let galleryList = document.getElementsByClassName('gallery-list')[0];
    galleryList.addEventListener("sortupdate", function (e) {
      let items = this.getElementsByClassName('gallery-item');
      let json = {
        items: []
      };
      for(let j = 0; j < items.length; j++) {
        json['items'].push(parseInt(items[j].dataset.itemId));
      }

      $.ajax({
        method: 'put',
        url: galleryList.dataset.updateUrl,
        data: { data: json },
        success: function() {
          Flash.success("Nastavení uloženo");
        }
      });
    });
  }

};