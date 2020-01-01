class CreateWidgets < ActiveRecord::Migration[5.2]
  def change
    create_table :widgets do |t|
      t.string :name
      t.string :description
      t.boolean :global, null: false, default: false, index: true
      t.string :status, index: true
      t.text :json
      t.timestamps
    end
  end
end
