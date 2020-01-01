class CreateWrapperWidgets < ActiveRecord::Migration[5.2]
  def change
    create_table :wrapper_widgets do |t|
      t.references :wrapper, null: false, index: true, foreign_key: true
      t.references :widget, null: false, index: true, foreign_key: true
      t.integer :position, null: false, default: 1
      t.string :part, null: false
      t.timestamps
    end
  end
end
