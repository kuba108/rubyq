class CreateAdminUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_users do |t|
      t.string :first_name, index: true
      t.string :last_name, index: true
      t.json :acl, null: false, default: {}
      t.timestamp :deleted_at, index: true
      t.timestamps
    end
  end
end
