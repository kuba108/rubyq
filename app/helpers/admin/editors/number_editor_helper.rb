module Admin
  module Editors
    module NumberEditorHelper

      def number_editor(label, text, url, gname, name, comp_id, allow_update = false, args = {})
        default = {
          method: 'put',
          remote: true,
          custom_values: {}
        }
        args = default.merge(args)

        return text unless allow_update

        raw "
        <div id='#{comp_id}' class='number-editor'>
          <div class='editor-label'>
            <span>#{label}</span>
          </div>
          <div class='ne-show'>
            <span class='editor-text'>#{format_label(text)}</span>
            <button class='btn-edit btn btn-sm btn-warning'><span class='fa fa-pencil-alt'></span></button>
          </div>
          <div class='ne-edit'>
            <form action='#{url}' accept-charset='UTF-8' data-remote='#{args[:remote]}' method='#{args[:method]}'>
              <div class='form-group'>
                #{hidden_field_tag 'update_type', 'admin_component'}
                #{hidden_field_tag 'type', 'number_editor'}
                #{hidden_field_tag 'comp_id', comp_id}
                #{args[:custom_values].map {|k, v| "#{hidden_field_tag k, v}" }.join('')}
                <div class='input-group'>
                  #{number_field_tag "#{gname}[#{name}]", text, class: 'form-control'}
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