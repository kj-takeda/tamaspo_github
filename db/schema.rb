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

ActiveRecord::Schema.define(version: 2021_09_26_035252) do

  create_table "active_storage_attachments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "areas", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comment_goods", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "comment_id", default: 0, null: false
    t.bigint "user_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_comment_goods_on_comment_id"
    t.index ["user_id"], name: "index_comment_goods_on_user_id"
  end

  create_table "comments", charset: "utf8mb4", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", default: 0, null: false
    t.bigint "match_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_comments_on_match_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "entries", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", default: 0, null: false
    t.bigint "match_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_entries_on_match_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "genres", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hide_lists", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "hideuser_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hideuser_id"], name: "index_hide_lists_on_hideuser_id"
    t.index ["user_id", "hideuser_id"], name: "index_hide_lists_on_user_id_and_hideuser_id", unique: true
    t.index ["user_id"], name: "index_hide_lists_on_user_id"
  end

  create_table "lines", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "event_detail", null: false
    t.date "day", null: false
    t.time "time", null: false
    t.bigint "area_id"
    t.text "area_detail", null: false
    t.bigint "genre_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_matches_on_area_id"
    t.index ["genre_id"], name: "index_matches_on_genre_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "messages", charset: "utf8mb4", force: :cascade do |t|
    t.string "body", null: false
    t.bigint "current_id"
    t.bigint "partner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["current_id"], name: "index_messages_on_current_id"
    t.index ["partner_id"], name: "index_messages_on_partner_id"
  end

  create_table "notifications", charset: "utf8mb4", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "match_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["match_id"], name: "index_notifications_on_match_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "place_genres", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "place_id", default: 0, null: false
    t.bigint "genre_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_place_genres_on_genre_id"
    t.index ["place_id"], name: "index_place_genres_on_place_id"
  end

  create_table "places", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "tel", null: false
    t.text "address", null: false
    t.text "url", null: false
    t.text "place_detail", null: false
    t.bigint "area_id", default: 0, null: false
    t.bigint "train_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["area_id"], name: "index_places_on_area_id"
    t.index ["train_id"], name: "index_places_on_train_id"
    t.index ["user_id"], name: "index_places_on_user_id"
  end

  create_table "relationships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_relationships_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "trains", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "line_id", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["line_id"], name: "index_trains_on_line_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "introduction", size: :tiny, null: false
    t.bigint "genre_id", null: false
    t.string "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["genre_id"], name: "index_users_on_genre_id"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comment_goods", "comments"
  add_foreign_key "comment_goods", "users"
  add_foreign_key "comments", "matches"
  add_foreign_key "comments", "users"
  add_foreign_key "entries", "matches"
  add_foreign_key "entries", "users"
  add_foreign_key "hide_lists", "users"
  add_foreign_key "hide_lists", "users", column: "hideuser_id"
  add_foreign_key "matches", "areas"
  add_foreign_key "matches", "genres"
  add_foreign_key "place_genres", "genres"
  add_foreign_key "place_genres", "places"
  add_foreign_key "places", "areas"
  add_foreign_key "places", "trains"
  add_foreign_key "places", "users"
  add_foreign_key "relationships", "users"
  add_foreign_key "relationships", "users", column: "follow_id"
  add_foreign_key "trains", "lines"
end
