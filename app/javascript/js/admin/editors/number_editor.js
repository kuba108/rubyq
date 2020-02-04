import Rails from "@rails/ujs";

const NumberEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'number_editor':
          NumberEditor.showSavedAttribute(json.comp_id, json.text);
          break;
      }
    });

    let numberEditors = document.getElementsByClassName('number-editor');
    Array.prototype.forEach.call(numberEditors, function(numberEditor) {
      numberEditor.querySelector('.btn-submit').addEventListener('click', NumberEditor.submitButtonClickHandler);
      numberEditor.querySelector('input[type="number"]').addEventListener('keypress', NumberEditor.submitEnterHandler);
      numberEditor.querySelector('.btn-edit').addEventListener('click', NumberEditor.editButtonClickHandler);
      numberEditor.querySelector('.btn-cancel').addEventListener('click', NumberEditor.cancelButtonClickHandler);
    });
  },

  submitButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.number-editor');
    let form = parent.querySelector('form');
    Rails.fire(form, 'submit');
  },

  submitEnterHandler: function(e) {
    // Unless keyCode is number, prevent default action.
    if((e.keyCode <= 48 && e.keyCode >= 57) || (e.keyCode <= 96 && e.keyCode >= 105)) {
      e.preventDefault();
      e.stopImmediatePropagation();
    }
    else if(e.key === 'Enter') {
      let parent = this.closest('.number-editor');
      let form = parent.querySelector('form');
      Rails.fire(form, 'submit');
    }
  },

  editButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.number-editor');
    let numberInput = parent.querySelector('form input[type=number]');
    NumberEditor.showEditForm(parent.id);
    numberInput.focus();
  },

  cancelButtonClickHandler: function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    let parent = this.closest('.number-editor');
    NumberEditor.hideEditForm(parent.id);
  },

  showSavedAttribute: function(componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.ne-show .editor-text').innerHTML = value;
    NumberEditor.hideEditForm(componentID);
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

export default NumberEditor;