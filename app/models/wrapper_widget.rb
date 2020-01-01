class WrapperWidget < ApplicationRecord

  belongs_to :wrapper
  belongs_to :widget

  before_validation :set_default

  private

  def set_default
    if self.position.blank?
      last_item = WrapperWidget.where(page_wrapper_id: self.page_wrapper_id, part: self.part).order(position: :desc).limit(1).first
      self.position = last_item.present? ? last_item.position + 1 : 1
    end
  end

end
