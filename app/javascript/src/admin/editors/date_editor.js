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
      dateEditor.find('.btn-submit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.date-editor');
        let form = parent.querySelector('form');
        Rails.fire(form, 'submit');
      });

      dateEditor.find('.btn-edit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.date-editor');
        TextEditor.showEditForm(parent.id);
      });

      dateEditor.find('.btn-cancel').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.date-editor');
        DateEditor.hideEditForm(parent.id);
      });
    });
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