# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150716200400) do

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description",     limit: 65535
    t.text     "image_url",       limit: 65535
    t.text     "requirements",    limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id",         limit: 4
    t.text     "tracking",        limit: 65535
    t.text     "cover_image_url", limit: 65535
  end

  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "campaign_id",        limit: 4
    t.integer  "user_id",            limit: 4
    t.string   "media_type",         limit: 255
    t.string   "source",             limit: 255
    t.string   "external_id",        limit: 255
    t.text     "external_data",      limit: 65535
    t.string   "status",             limit: 255
    t.text     "unmet_requirements", limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "rejection_message",  limit: 65535
  end

  add_index "entries", ["campaign_id", "source", "external_id"], name: "index_entries_on_campaign_id_and_source_and_external_id", unique: true, using: :btree
  add_index "entries", ["campaign_id"], name: "index_entries_on_campaign_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "campaigns", "users"
  add_foreign_key "entries", "campaigns"
  add_foreign_key "entries", "users"
end
