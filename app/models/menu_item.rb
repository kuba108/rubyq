class MenuItem < ApplicationRecord

  belongs_to :menu

  # Selects nested items with cached SQL query.
  def nested_items
    MenuItem.where(parent: self.id).order(position: :asc)
  end

  # Detects if current item has nested items.
  def has_nested_items?
    nested_items.present?
  end

  def page
    page_id.present? ? Page.find(self.page_id) : nil
  end

  def internal_page?
    page.present?
  end

end
