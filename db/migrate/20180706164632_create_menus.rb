class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :name, null: false, index: true
      t.string :uuid, index: true, limit: 36
      t.string :language, null: false
      t.string :layout, null: false
      t.text :content
      t.timestamps null: false
    end
  end
end
