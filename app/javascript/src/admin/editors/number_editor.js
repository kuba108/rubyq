import Rails from "@rails/ujs";

const NumberEditor = {
  init: function () {
    document.addEventListener('ajax:success', function(event) {
      let json = event.detail[0];
      switch(json.source) {
        case 'number_editor':
          NumberEditor.showSavedAttribute(json.comp_id, json.value);
          break;
      }
    });

    let numberEditors = document.getElementsByClassName('number-editor');
    Array.prototype.forEach.call(numberEditors, function(numberEditor) {
      numberEditor.find('.btn-submit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.number-editor');
        let form = parent.querySelector('form');
        Rails.fire(form, 'submit');
      });

      numberEditor.find('.btn-edit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.text-editor');
        let numberInput = parent.querySelector('form input[type=number]');
        NumberEditor.showEditForm(parent.id);
        numberInput.focus();
      });

      numberEditor.find('.btn-cancel').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let parent = this.closest('.number-editor');
        NumberEditor.hideEditForm(parent.id);
      });

      numberEditor.on('keydown', function(e) {
        let key = e.charCode || e.keyCode || 0;

        if(key == 188) {
          alert('Používejte desetinnou tečku!');
        }

        // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
        // home, end, period, and numpad decimal
        return (
          key == 8 ||
          key == 9 ||
          key == 13 ||
          key == 46 ||
          key == 110 ||
          key == 190 ||
          (key >= 35 && key <= 40) ||
          (key >= 48 && key <= 57) ||
          (key >= 96 && key <= 105)
        );
      });
    })
  },

  showSavedAttribute: function (componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.editor-text').innerHTML = value;
    NumberEditor.hideEditForm(componentID);
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

export default NumberEditor;