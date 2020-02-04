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

ActiveRecord::Schema.define(version: 2020_02_04_011656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.integer "wiki_id"
    t.string "file"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["wiki_id"], name: "index_attachments_on_wiki_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "page_id"
    t.integer "user_id"
    t.text "content"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment"], name: "index_histories_on_comment"
    t.index ["page_id"], name: "index_histories_on_page_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "key_name"
    t.string "title"
    t.string "path"
    t.integer "wiki_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_name"], name: "index_notifications_on_key_name"
    t.index ["path"], name: "index_notifications_on_path"
    t.index ["title"], name: "index_notifications_on_title"
    t.index ["wiki_id"], name: "index_notifications_on_wiki_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "wiki_id", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_pages_on_title"
    t.index ["wiki_id"], name: "index_pages_on_wiki_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "wiki_id"
    t.integer "page_id"
    t.integer "user_id"
    t.integer "history_id"
    t.text "content", null: false
    t.string "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["history_id"], name: "index_requests_on_history_id"
    t.index ["page_id"], name: "index_requests_on_page_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
    t.index ["wiki_id"], name: "index_requests_on_wiki_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "name", null: false
    t.string "avatar"
    t.string "avatar_cache"
    t.string "sns_image"
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "watches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "wiki_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_watches_on_user_id"
    t.index ["wiki_id"], name: "index_watches_on_wiki_id"
  end

  create_table "wiki_maintainers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "wiki_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "level", default: 1, null: false
    t.index ["user_id"], name: "index_wiki_maintainers_on_user_id"
    t.index ["wiki_id"], name: "index_wiki_maintainers_on_wiki_id"
  end

  create_table "wikis", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "terms"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "nav"
    t.integer "can_page_create_level", default: 1, null: false
    t.integer "can_page_edit_level", default: 2, null: false
    t.integer "can_page_request_level", default: 0, null: false
    t.integer "can_page_frozen_level", default: 2, null: false
    t.integer "can_page_archive_level", default: 2, null: false
    t.integer "can_navs_edit_level", default: 2, null: false
    t.integer "first_page_id"
    t.index ["title"], name: "index_wikis_on_title"
  end

  add_foreign_key "watches", "users"
  add_foreign_key "watches", "wikis"
  add_foreign_key "wiki_maintainers", "users"
  add_foreign_key "wiki_maintainers", "wikis"
end
