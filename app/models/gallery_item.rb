class GalleryItem < ApplicationRecord

  has_one_attached :image
  belongs_to :gallery

end
