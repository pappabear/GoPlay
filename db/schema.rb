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

ActiveRecord::Schema.define(version: 20160228001401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "activities_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "activity_id", null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.integer  "activity_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "activity_id"
    t.integer  "event_type_id"
    t.integer  "venue_id"
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.text     "details"
    t.string   "price"
    t.string   "restrictions"
    t.string   "info_url"
    t.string   "registration_url"
    t.date     "start_date"
    t.string   "start_time"
    t.integer  "recurrence"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                             default: false
    t.string   "activation_digest"
    t.boolean  "activated",                         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "zip"
    t.date     "dob"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "basic_notifications_mode",          default: "none"
    t.string   "basic_notifications_email"
    t.string   "basic_notifications_phone_number"
    t.string   "basic_notifications_frequency"
    t.string   "urgent_notifications_mode",         default: "none"
    t.string   "urgent_notifications_email"
    t.string   "urgent_notifications_phone_number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "formatted_address"
  end

end
