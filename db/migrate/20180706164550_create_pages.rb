class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :content
      t.string :uuid, index: true, limit: 36
      t.references :admin_user, null: false, index: true, foreign_key: true
      t.string :meta_title, null: true
      t.string :meta_description, null: true
      t.string :meta_keywords, null: true
      t.string :og_title, null: true
      t.string :og_description, null: true
      t.string :og_image, null: true
      t.string :layout, null: false
      t.string :language, null: false
      t.string :state, null: false, default: 'hidden'
      t.string :publish_type, null: false, default: 'public'
      t.integer :revision_parent, null: true
      t.integer :revision, null: false, default: 1
      t.string :revision_kind, null: false, default: 'private', limit: 30
      t.timestamp :published_at, null: true
      t.timestamps null: false
    end
  end
end
