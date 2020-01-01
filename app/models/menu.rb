class Menu < ApplicationRecord

  has_many :menu_items, dependent: :destroy

  # Selects base items which has no parent.
  def base_items
    menu_items.where(parent: nil).order(position: :asc)
  end

  def cache_html
    self.content = self.decorate.content
    self.save!
  end

end