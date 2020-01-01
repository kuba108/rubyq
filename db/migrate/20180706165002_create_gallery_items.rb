class CreateGalleryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :gallery_items do |t|
      t.references :gallery, null: false
      t.string :label, null: true
      t.string :description, null: true
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
