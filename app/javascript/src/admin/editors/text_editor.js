import Rails from "@rails/ujs";

const TextEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'text_editor':
          TextEditor.showSavedAttribute(json.comp_id, json.value);
          break;
      }
    });

    let textEditors = document.getElementsByClassName('text-editor');
    Array.prototype.forEach.call(textEditors, function(textEditor) {
      textEditor.querySelector('.btn-submit').addEventListener('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.text-editor');
        let form = parent.querySelector('form');
        Rails.fire(form, 'submit');
      });

      textEditor.querySelector('.btn-edit').addEventListener('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.text-editor');
        let textInput = parent.querySelector('form input[type=text]');
        TextEditor.showEditForm(parent.id);
        textInput.focus();
      });

      textEditor.querySelector('.btn-cancel').addEventListener('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.text-editor');
        TextEditor.hideEditForm(parent.id);
      });
    });
  },

  showSavedAttribute: function (componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.te-show .editor-text').innerHTML = value;
    TextEditor.hideEditForm(componentID);
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

export default TextEditor;