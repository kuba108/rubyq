class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :name, null: false
      t.references :admin_user, null: false, index: true, foreign_key: true
      t.string :description, null: true
      t.integer :item_image, null: true
      t.string :state, null: false, default: 'visible'
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
