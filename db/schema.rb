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

ActiveRecord::Schema.define(version: 20131115033948) do

  create_table "action_brothers", force: true do |t|
    t.integer  "action_id"
    t.integer  "brother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actions", force: true do |t|
    t.integer  "brother_id"
    t.integer  "rushee_id"
    t.date     "date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approvals", force: true do |t|
    t.integer  "brother_id"
    t.integer  "rushee_id"
    t.boolean  "vote"
    t.boolean  "met"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "event_id"
    t.integer  "rushee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brothers", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "fraternity_id"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_verified",            default: false
  end

  add_index "brothers", ["email"], name: "index_brothers_on_email", unique: true
  add_index "brothers", ["reset_password_token"], name: "index_brothers_on_reset_password_token", unique: true

  create_table "comments", force: true do |t|
    t.integer  "brother_id"
    t.integer  "rushee_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fraternity_id"
  end

  create_table "fraternities", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rushees", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "cellphone"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "profile_picture_url"
    t.string   "dorm"
    t.string   "room_number"
    t.string   "hometown"
    t.string   "sports"
    t.string   "frats_rushing"
    t.integer  "primary_contact_id"
    t.string   "action_status"
    t.string   "bid_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
