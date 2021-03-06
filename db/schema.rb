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

ActiveRecord::Schema.define(version: 20200918170947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.integer  "station_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["station_id"], name: "index_groups_on_station_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "share_id"
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "moneymaker", default: false, null: false
  end

  add_index "members", ["share_id"], name: "index_members_on_share_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.integer  "needed_sum"
    t.boolean  "show_statistics",      default: true
    t.boolean  "offer_minimum_active", default: true
    t.boolean  "offer_medium_active",  default: true
    t.boolean  "offer_maximum_active", default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "total_shares",         default: 145,  null: false
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "name",                                     null: false
    t.float    "size",                                     null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "email"
    t.string   "password_digest"
    t.float    "offer_minimum"
    t.float    "offer_medium"
    t.float    "offer_maximum"
    t.string   "activation_digest"
    t.boolean  "activated",                default: false
    t.boolean  "agreed",                                   null: false
    t.integer  "land_help_days"
    t.string   "skills"
    t.boolean  "no_help",                                  null: false
    t.string   "password_reset_digest"
    t.datetime "password_reset_timestamp"
    t.datetime "activation_timestamp"
    t.text     "feedback"
    t.string   "telephone"
    t.boolean  "moneymaker",               default: false, null: false
    t.boolean  "super_moneymaker",         default: false, null: false
  end

  add_index "shares", ["group_id"], name: "index_shares_on_group_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "description",                 null: false
    t.string   "file",                        null: false
    t.boolean  "public",      default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "workgroup_shares", force: :cascade do |t|
    t.integer  "share_id"
    t.integer  "workgroup_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "workgroups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "groups", "stations"
  add_foreign_key "members", "shares"
  add_foreign_key "shares", "groups"
end
