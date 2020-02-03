import Rails from "@rails/ujs";

const SelectEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'select_editor':
          SelectEditor.showSavedAttribute(json.comp_id, json.text);
          break;
      }
    });

    let selectEditors = document.getElementsByClassName('select-editor');
    Array.prototype.forEach.call(selectEditors, function(selectEditor) {
      selectEditor.querySelector('.btn-submit').addEventListener('click', SelectEditor.submitButtonClickHandler);
      selectEditor.querySelector('.btn-edit').addEventListener('click', SelectEditor.editButtonClickHandler);
      selectEditor.querySelector('.btn-cancel').addEventListener('click', SelectEditor.cancelButtonClickHandler);
    });
  },

  submitButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.select-editor');
    let form = parent.querySelector('form');
    Rails.fire(form, 'submit');
  },

  editButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.select-editor');
    SelectEditor.showEditForm(parent.id);
  },

  cancelButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.select-editor');
    SelectEditor.hideEditForm(parent.id);
  },

  showSavedAttribute: function(componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.se-show .editor-text').innerHTML = value;
    SelectEditor.hideEditForm(componentID);
  },

  showEditForm: function(componentID) {
    let component = document.getElementById(componentID);
    component.classList.add('edited');
  },

  hideEditForm: function(componentID) {
    let component = document.getElementById(componentID);
    component.classList.remove('edited');
  }
};

export default SelectEditor;