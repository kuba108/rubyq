class AddHomePageBooleanToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :home_page, :boolean, null: false, default: false, index: true
  end
end
