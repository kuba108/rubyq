# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_02_130606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.json "acl", default: {}, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["deleted_at"], name: "index_admin_users_on_deleted_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["first_name"], name: "index_admin_users_on_first_name"
    t.index ["last_name"], name: "index_admin_users_on_last_name"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "galleries", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "admin_user_id", null: false
    t.string "description"
    t.integer "item_image"
    t.string "state", default: "visible", null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_galleries_on_admin_user_id"
  end

  create_table "gallery_items", force: :cascade do |t|
    t.bigint "gallery_id", null: false
    t.string "label"
    t.string "description"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "label_i18n"
    t.json "description_i18n"
    t.index ["gallery_id"], name: "index_gallery_items_on_gallery_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "page_id"
    t.integer "parent"
    t.string "label", limit: 100, null: false
    t.string "url", null: false
    t.integer "position", default: 0, null: false
    t.string "kind", limit: 50, default: "internal", null: false
    t.boolean "new_window", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["page_id"], name: "index_menu_items_on_page_id"
    t.index ["parent"], name: "index_menu_items_on_parent"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.string "uuid", limit: 36
    t.string "language", null: false
    t.string "layout", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_menus_on_name"
    t.index ["uuid"], name: "index_menus_on_uuid"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "uuid", limit: 36
    t.bigint "admin_user_id", null: false
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.string "og_title"
    t.string "og_description"
    t.string "og_image"
    t.string "layout", null: false
    t.string "language", null: false
    t.string "state", default: "hidden", null: false
    t.string "publish_type", default: "public", null: false
    t.integer "revision_parent"
    t.integer "revision", default: 1, null: false
    t.string "revision_kind", limit: 30, default: "private", null: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "home_page", default: false, null: false
    t.index ["admin_user_id"], name: "index_pages_on_admin_user_id"
    t.index ["uuid"], name: "index_pages_on_uuid"
  end

  create_table "routes", force: :cascade do |t|
    t.integer "routable_id"
    t.string "routable_type"
    t.string "permalink", null: false
    t.string "route_type", default: "standard", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permalink"], name: "index_routes_on_permalink"
    t.index ["routable_id"], name: "index_routes_on_routable_id"
    t.index ["routable_type"], name: "index_routes_on_routable_type"
    t.index ["route_type"], name: "index_routes_on_route_type"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.string "name", null: false
    t.string "description"
    t.integer "position", default: 1, null: false
    t.string "css_classes", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_sections_on_page_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.string "value_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "global", default: false, null: false
    t.string "status"
    t.text "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["global"], name: "index_widgets_on_global"
    t.index ["status"], name: "index_widgets_on_status"
  end

  create_table "wrapper_widgets", force: :cascade do |t|
    t.bigint "wrapper_id", null: false
    t.bigint "widget_id", null: false
    t.integer "position", default: 1, null: false
    t.string "part", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["widget_id"], name: "index_wrapper_widgets_on_widget_id"
    t.index ["wrapper_id"], name: "index_wrapper_widgets_on_wrapper_id"
  end

  create_table "wrappers", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "name", null: false
    t.string "description"
    t.integer "position", default: 1, null: false
    t.string "css_classes", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_wrappers_on_section_id"
  end

  add_foreign_key "galleries", "admin_users"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "menu_items", "pages"
  add_foreign_key "pages", "admin_users"
  add_foreign_key "sections", "pages"
  add_foreign_key "wrapper_widgets", "widgets"
  add_foreign_key "wrapper_widgets", "wrappers"
  add_foreign_key "wrappers", "sections"
end
