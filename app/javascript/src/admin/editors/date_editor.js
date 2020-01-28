import Rails from "@rails/ujs";

const DateEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'date_editor':
          DateEditor.showSavedAttribute(json.comp_id, json.value);
          break;
      }
    });

    let dateEditors = document.getElementsByClassName('date-editor');
    Array.prototype.forEach.call(dateEditors, function(dateEditor) {
      dateEditor.querySelector('.btn-submit').addEventListener('click', DateEditor.submitButtonClickHandler);
      dateEditor.querySelector('.btn-edit').addEventListener('click', DateEditor.editButtonClickHandler);
      dateEditor.querySelector('.btn-cancel').addEventListener('click', DateEditor.cancelButtonClickHandler);
    });
  },

  submitButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.date-editor');
    let form = parent.querySelector('form');
    Rails.fire(form, 'submit');
  },

  editButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.date-editor');
    let textInput = parent.querySelector('form input[type=text]');
    DateEditor.showEditForm(parent.id);
    textInput.focus();
  },

  cancelButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.date-editor');
    DateEditor.hideEditForm(parent.id);
  },

  showSavedAttribute: function (componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.de-show .editor-text').innerHTML = value;
    DateEditor.hideEditForm(componentID);
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

export default DateEditor;