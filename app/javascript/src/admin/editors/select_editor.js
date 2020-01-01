const SelectEditor = {

  init: function () {
    $(document).on('ajaxSuccess', function (event, xhr, settings) {
      try {
        json = $.parseJSON(xhr.responseText);
        switch(json.source) {
          case 'select_editor':
            SelectEditor.showSavedAttribute(json.comp_id);
            break;
        }
      }
      catch(e) {
        // not JSON
      }
    });

    let select_editor = $('.select-editor');

    select_editor.find('.btn-submit').off('click').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.select-editor');
      p.find('form').submit();
    });

    select_editor.find('.btn-edit').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.select-editor');
      SelectEditor.showEditForm(p.attr('id'));
    });

    select_editor.find('.btn-cancel').on('click', function(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      let p = $(this).parents('.select-editor');
      SelectEditor.hideEditForm(p.attr('id'));
    });
  },

  showSavedAttribute: function (component_id) {
    let component = $('#' + component_id);
    component.find('.editor-text').html(json.value);
    SelectEditor.hideEditForm(component_id);
  },

  showEditForm: function (component_id) {
    let component = $('#' + component_id);
    component.addClass('edited');
  },

  hideEditForm: function (component_id) {
    let component = $('#' + component_id);
    component.removeClass('edited');
  }

};

export default SelectEditor;