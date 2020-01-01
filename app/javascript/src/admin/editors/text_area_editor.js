const TextAreaEditor = {

  init: function () {
    $(document).on('ajaxSuccess', function (event, xhr, settings) {
      try {
        json = $.parseJSON(xhr.responseText);
        switch(json.source) {
          case 'text_area_editor':
            TextAreaEditor.showSavedAttribute(json.comp_id);
            break;
        }
      }
      catch(e) {
        // not JSON
      }
    });

    let text_area_editor = $('.text-area-editor');

    text_area_editor.find('.btn-submit').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.text-area-editor');
      p.find('form').submit();
    });

    text_area_editor.find('.btn-edit').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.text-area-editor');
      let text_area = p.find('form textarea');
      TextAreaEditor.showTextEditForm(p.attr('id'));
      text_area.focus();
    });

    text_area_editor.find('.btn-cancel').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.text-area-editor');
      TextAreaEditor.hideTextEditForm(p.attr('id'));
    });
  },

  showSavedAttribute: function (component_id) {
    let component = $('#' + component_id);
    component.find('.editor-text').html(json.value);
    TextAreaEditor.hideTextEditForm(component_id);
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

export default TextAreaEditor;