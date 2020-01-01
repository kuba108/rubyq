class Wrapper < ApplicationRecord

  belongs_to :section
  has_many :wrapper_widgets, dependent: :destroy
  has_many :widgets, through: :wrapper_widgets, dependent: :destroy
  serialize :json, JSON

  before_validation :set_default

  private

  def set_default
    if self.position.blank?
      last_widget = Wrapper.where(page_id: self.page_id).order(position: :desc).limit(1).first
      self.position = last_widget.present? ? last_widget.position + 1 : 1
    end
  end

end
