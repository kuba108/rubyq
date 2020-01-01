class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.integer :routable_id
      t.string :routable_type
      t.string :permalink, null: false
      t.string :route_type, null: false, default: 'standard'
      t.timestamps null: false
    end

    add_index :routes, :routable_id
    add_index :routes, :routable_type
    add_index :routes, :permalink
    add_index :routes, :route_type
  end
end
