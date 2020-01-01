class Widget < ApplicationRecord

  has_many :wrapper_widgets, dependent: :destroy
  has_many :wrappers, through: :wrapper_widgets
  has_many_attached :attachments

  serialize :json, JSON

end
