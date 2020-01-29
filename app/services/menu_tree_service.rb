class MenuTreeService

  def change_item(item, i)
    menu_item = MenuItem.find_by(id: item['itemId'])
    if menu_item.position != (i + 1)
      menu_item.position = (i + 1)
      menu_item.save
    end

    if item[:children].present?
      children = item[:children]
      nested_items_ids = menu_item.nested_items.pluck(:id)
      new_nested_items_ids = children.map { |ch| ch[:itemId].to_i }
      menu_items_to_add_ids = new_nested_items_ids - nested_items_ids
      menu_items_to_remove_ids = nested_items_ids - new_nested_items_ids

      menu_items_to_add_ids.each do |id|
        MenuItem.where(id: id).update_all(parent: menu_item.id)
      end

      menu_items_to_remove_ids.each do |id|
        MenuItem.where(id: id).update_all(parent: nil)
      end

      children.each_with_index do |child_item, j|
        change_item(child_item, j)
      end
    else
      if menu_item.has_nested_items?
        menu_item.nested_items.update_all(parent: nil)
      end
    end
  end

end