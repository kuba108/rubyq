class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :page, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.integer :position, null: false, default: 1
      t.string :css_classes, array: true, default: []
      t.timestamps
    end
  end
end
