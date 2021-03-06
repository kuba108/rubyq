module Admin
  module Editors
    module SelectEditorHelper

      def select_editor(label, value, url, gname, name, comp_id, items = [], i18n_scope = nil, allow_update = false, args = {})
        text = I18n.t(value, scope: i18n_scope)
        unique_id = rand(1000000)
        default = {
          method: 'put',
          class: 'custom-input',
          remote: true,
          custom_values: {}
        }
        args = default.merge(args)

        return label unless allow_update

        raw "
        <div id='#{comp_id}' class='select-editor'>
          <div class='editor-label'>
            <span>#{label}</span>
          </div>
          <div class='se-show'>
            <span class='editor-text'>#{text}</span>
            <button class='btn-edit btn btn-sm btn-warning'><span class='fa fa-pencil-alt'></span></button>
          </div>
          <div class='se-edit'>
            <form action='#{url}' accept-charset='UTF-8' data-remote='#{args[:remote]}' method='post'>
              <div class='form-group'>
                #{hidden_field_tag '_method', args[:method], id: "_method_#{unique_id}"}
                #{hidden_field_tag 'update_type', 'admin_component'}
                #{hidden_field_tag 'type', 'select_editor'}
                #{hidden_field_tag 'comp_id', comp_id}
                #{hidden_field_tag 'i18n_scope', i18n_scope}
                #{args[:custom_values].map {|k, v| "#{hidden_field_tag k, v}" }.join('')}
                <div class='input-group'>
                  #{select_tag "#{gname}[#{name}]", items, class: "form-control #{args[:class]}"}
                  <div class='input-group-append'>
                    <button class='btn-cancel btn btn-danger'><span class='fa fa-times'></span></button>
                    <button class='btn-submit btn btn-success'><span class='fa fa-check'></span></button>
                  </div>
                </div>
              </div>
            </form>
          </div>
        </div>
        "
      end

    end
  end
end
