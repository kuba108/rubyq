class Gallery < ApplicationRecord

  has_many :gallery_items, dependent: :destroy
  belongs_to :admin_user

  def ordered_items
    gallery_items.order(position: :asc)
  end

  def last_item_position
    if ordered_items.present?
      ordered_items.last.position
    else
      1
    end
  end

end
