module Admin::MenusHelper

  def admin_menu_item(item, options = {})
    html = "<li class='menu-item' data-item-id='#{item.id}' data-item-position='#{item.position}'>"
    html += "<span class='fa fa-bars draggable'></span> #{item.label}"
    html += "&nbsp;<em>(#{item.url})</em>" if item.url.present?
    html += "&nbsp;|&nbsp;#{I18n.t(item.kind, scope: 'menu_item.kind')}"
    html += link_to admin_menu_item_path(id: item.id), remote: true, method: :delete, class: 'remove-link-btn hint--right', data: { hint: 'Odstraní položku z menu.' } do
      raw "<span class='fa fa-times'></span>"
    end
    html += "<button type='button' class='change-menu-item-btn btn-simple btn-link' data-toggle='modal' data-target='#update-menu-item-modal-#{item.id}'>
            <span class='fa fa-edit'></span>
            </button>"
    html += "<ul class='sub-menu'>"
    item.nested_items.each do |item|
      html += admin_menu_item(item)
    end
    html +="</ul>"
    html + "</li>"
  end

end
