class GalleryItemTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :gallery_items, :label_i18n, :json
    add_column :gallery_items, :description_i18n, :json
  end
end
