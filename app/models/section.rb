class Section < ApplicationRecord

  belongs_to :page
  has_many :wrappers, dependent: :destroy

end
