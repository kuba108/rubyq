import Rails from "@rails/ujs";

const SelectEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'select_editor':
          SelectEditor.showSavedAttribute(json.comp_id, json.value);
          break;
      }
    });

    let selectEditors = document.getElementsByClassName('select-editor');
    Array.prototype.forEach.call(selectEditors, function(selectEditor) {
      selectEditor.find('.btn-submit').off('click').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.select-editor');
        let form = parent.querySelector('form');
        Rails.fire(form, 'submit');
      });

      selectEditor.find('.btn-edit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.select-editor');
        SelectEditor.showEditForm(parent.id);
      });

      selectEditor.find('.btn-cancel').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.select-editor');
        NumberEditor.hideEditForm(parent.id);
      });
    });
  },

  showSavedAttribute: function (componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.editor-text').innerHTML = value;
    SelectEditor.hideEditForm(componentID);
  },

  showEditForm: function (componentID) {
    let component = document.getElementById(componentID);
    component.classList.add('edited');
  },

  hideEditForm: function (componentID) {
    let component = document.getElementById(componentID);
    component.classList.remove('edited');
  }
};

export default SelectEditor;