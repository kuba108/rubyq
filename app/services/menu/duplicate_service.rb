class Menu::DuplicateService

  def initialize(source_menu, target_menu)
    @source_menu = source_menu
    @target_menu = target_menu
  end

  def duplicate_menu
    @source_menu.base_items.each do |item|
      duplicate_nested(item, nil)
    end
    @target_menu.cache_html
  end

  private

  def duplicate_nested(item, parent)
    new_item = duplicate_item(item, parent)
    if item.has_nested_items?
      item.nested_items.each do |nested_item|
        duplicate_nested(nested_item, new_item)
      end
    end
  end

  def duplicate_item(item, parent)
    source_page = item.page
    target_page = Page.find_by(uuid: source_page.uuid, language: @target_menu.language) if source_page
    MenuItem.create menu_id: @target_menu.id,
                    page_id: target_page.present? ? target_page.id : nil,
                    parent: parent.present? ? parent.id : nil,
                    label: target_page.present? ? target_page.title : item.label,
                    url: target_page.present? ? target_page.route.permalink : "",
                    position: item.position,
                    kind: item.kind,
                    new_window: item.new_window
  end

end