import Rails from "@rails/ujs";

const TextAreaEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'text_area_editor':
          TextAreaEditor.showSavedAttribute(json.comp_id, json.value);
          break;
      }
    });

    let textAreaEditors = document.getElementsByClassName('text-area-editor');
    Array.prototype.forEach.call(textAreaEditors, function(textAreaEditor) {
      textAreaEditor.querySelector('.btn-submit').addEventListener('click', TextAreaEditor.submitButtonClickHandler);
      textAreaEditor.querySelector('.btn-edit').addEventListener('click', TextAreaEditor.editButtonClickHandler);
      textAreaEditor.querySelector('.btn-cancel').addEventListener('click', TextAreaEditor.cancelButtonClickHandler);
    });
  },

  submitButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.text-area-editor');
    let form = parent.querySelector('form');
    Rails.fire(form, 'submit');
  },

  editButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.text-area-editor');
    let textInput = parent.querySelector('form input[type=text]');
    TextAreaEditor.showEditForm(parent.id);
    textInput.focus();
  },

  cancelButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.text-area-editor');
    TextAreaEditor.hideEditForm(parent.id);
  },

  showSavedAttribute: function(componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.tea-show .editor-text').innerHTML = value;
    TextAreaEditor.hideEditForm(componentID);
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

export default TextAreaEditor;