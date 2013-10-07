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

ActiveRecord::Schema.define(version: 20131007065258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "found_items", force: true do |t|
    t.boolean  "returned"
    t.string   "location"
    t.datetime "when"
    t.text     "description"
    t.integer  "taxi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_name"
    t.string   "plate_no"
    t.text     "taxi_description"
    t.string   "contact"
  end

  create_table "founds", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "founds", ["item_id"], name: "index_founds_on_item_id", using: :btree
  add_index "founds", ["user_id"], name: "index_founds_on_user_id", using: :btree

  create_table "items", force: true do |t|
    t.boolean  "returned"
    t.string   "location"
    t.datetime "when"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_name"
    t.string   "plate_no"
    t.text     "taxi_description"
    t.string   "contact"
  end

  create_table "losts", force: true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: true do |t|
    t.text     "comment"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "taxi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxis", force: true do |t|
    t.string   "plate_no"
    t.string   "owner"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
