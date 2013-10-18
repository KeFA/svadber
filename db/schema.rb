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

ActiveRecord::Schema.define(version: 20131017130453) do

  create_table "cars", force: true do |t|
    t.integer  "wedding_id"
    t.string   "driver"
    t.string   "phone_number"
    t.integer  "hours_count",          default: 0
    t.integer  "cost_for_hour",        default: 0
    t.integer  "cost_for_decorations", default: 0
    t.integer  "paid",                 default: 0
    t.integer  "seats_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "check_items", force: true do |t|
    t.string   "description"
    t.boolean  "done"
    t.integer  "wedding_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "expenditures", force: true do |t|
    t.integer  "wedding_id"
    t.integer  "cost",        default: 0
    t.string   "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "paid",        default: 0
  end

  create_table "guests", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "city"
    t.string   "status"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "wedding_id"
    t.integer  "congratulate_order", default: 999999
  end

  add_index "guests", ["wedding_id"], name: "index_guests_on_wedding_id"

  create_table "todos", force: true do |t|
    t.boolean  "done"
    t.string   "description"
    t.integer  "wedding_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todos", ["wedding_id"], name: "index_todos_on_wedding_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weddings", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "weddings", ["user_id"], name: "index_weddings_on_user_id"

end
