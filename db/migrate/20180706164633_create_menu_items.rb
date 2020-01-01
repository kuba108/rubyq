class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.references :menu, index: true, foreign_key: true
      t.references :page, foreign_key: true, null: true
      t.integer :parent, null: true, index: true
      t.string :menu_name, null: false, index: true
      t.string :label, null: false, limit: 100
      t.string :url, null: false
      t.integer :position, null: false, default: 0
      t.string :kind, null: false, default: 'internal', limit: 50
      t.boolean :new_window, null: false, default: false
      t.timestamps null: false
    end
  end
end
