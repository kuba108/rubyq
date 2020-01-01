const DateEditor = {

  init: function () {
    $(document).on('ajaxSuccess', function (event, xhr, settings) {
      try {
        json = $.parseJSON(xhr.responseText);
        switch(json.source) {
          case 'date_editor':
            TextEditor.showSavedAttribute(json.comp_id);
            break;
        }
      }
      catch(e) {
        // not JSON
      }
    });

    let date_editor = $('.date-editor');

    date_editor.find('.btn-submit').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.date-editor');
      p.find('form').submit();
    });

    date_editor.find('.btn-edit').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.date-editor');
      let text_input = p.find('form input[type=text]');
      TextEditor.showTextEditForm(p.attr('id'));
      text_input.focus();
    });

    date_editor.find('.btn-cancel').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.date-editor');
      TextEditor.hideTextEditForm(p.attr('id'));
    });
  },

  showSavedAttribute: function (component_id) {
    let component = $('#' + component_id);
    component.find('.editor-text').html(json.value);
    TextEditor.hideTextEditForm(component_id);
  },

  showTextEditForm: function (component_id) {
    let component = $('#' + component_id);
    component.addClass('edited');
  },

  hideTextEditForm: function (component_id) {
    let component = $('#' + component_id);
    component.removeClass('edited');
  }

};

export default DateEditor;