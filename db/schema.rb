# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_06_065217) do
  create_table "note_tags", charset: "utf8", force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_note_tags_on_note_id"
    t.index ["tag_id"], name: "index_note_tags_on_tag_id"
  end

  create_table "notes", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "prompt_id"
    t.integer "category_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "is_public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id"], name: "index_notes_on_prompt_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "prompt_tags", charset: "utf8", force: :cascade do |t|
    t.bigint "prompt_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id"], name: "index_prompt_tags_on_prompt_id"
    t.index ["tag_id"], name: "index_prompt_tags_on_tag_id"
  end

  create_table "prompts", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "category_id", null: false
    t.string "title", null: false
    t.text "content", null: false
    t.boolean "is_public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_prompts_on_user_id"
  end

  create_table "references", charset: "utf8", force: :cascade do |t|
    t.integer "click_count", default: 0
    t.string "referencable_type"
    t.bigint "referencable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referencable_type", "referencable_id"], name: "index_references_on_referencable"
  end

  create_table "tags", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.text "profile"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "note_tags", "notes"
  add_foreign_key "note_tags", "tags"
  add_foreign_key "notes", "prompts"
  add_foreign_key "notes", "users"
  add_foreign_key "prompt_tags", "prompts"
  add_foreign_key "prompt_tags", "tags"
  add_foreign_key "prompts", "users"
end
