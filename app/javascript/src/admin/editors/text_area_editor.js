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
      textAreaEditor.find('.btn-submit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let p = $(this).parents('.text-area-editor');
        p.find('form').submit();
      });

      textAreaEditor.find('.btn-edit').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let p = $(this).parents('.text-area-editor');
        let text_area = p.find('form textarea');
        TextAreaEditor.showTextEditForm(p.attr('id'));
        text_area.focus();
      });

      textAreaEditor.find('.btn-cancel').on('click', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation();
        let p = $(this).parents('.text-area-editor');
        TextAreaEditor.hideTextEditForm(p.attr('id'));
      });
    });
  },

  showSavedAttribute: function (componentID, value) {
    let component = document.getElementById(componentID);
    component.querySelector('.editor-text').innerHTML = value;
    TextAreaEditor.hideEditForm(componentID);
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

export default TextAreaEditor;