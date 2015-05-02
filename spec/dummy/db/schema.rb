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

ActiveRecord::Schema.define(version: 20150502214349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chancellor_contacts", force: :cascade do |t|
    t.integer  "entity_id",                            null: false
    t.string   "first_name",                           null: false
    t.string   "last_name",                            null: false
    t.string   "display_name",                         null: false
    t.string   "title"
    t.string   "email_address"
    t.string   "fax_number"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.integer  "is_active",                default: 1, null: false
    t.string   "uuid",          limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "chancellor_customers", force: :cascade do |t|
    t.integer  "default_contact_id"
    t.integer  "default_location_id"
    t.integer  "entity_id",                                  null: false
    t.integer  "parent_customer_id"
    t.string   "reference",                                  null: false
    t.integer  "salesperson_id"
    t.integer  "is_active",                      default: 1, null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "chancellor_entities", force: :cascade do |t|
    t.string   "cached_long_name", limit: 1024,             null: false
    t.string   "display_name",                              null: false
    t.integer  "is_active",                     default: 1, null: false
    t.string   "name",                                      null: false
    t.integer  "parent_entity_id"
    t.string   "reference",                                 null: false
    t.string   "uuid",             limit: 32,               null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "chancellor_locations", force: :cascade do |t|
    t.integer  "entity_id",                                                      null: false
    t.string   "location_name",                                                  null: false
    t.string   "street_address",                                                 null: false
    t.string   "city",                                                           null: false
    t.string   "region",                                                         null: false
    t.string   "region_code",                                                    null: false
    t.string   "country",                                                        null: false
    t.decimal  "latitude",                  precision: 10, scale: 8
    t.decimal  "longitude",                 precision: 11, scale: 8
    t.integer  "is_active",                                          default: 1, null: false
    t.string   "uuid",           limit: 32,                                      null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "chancellor_salespeople", force: :cascade do |t|
    t.integer  "entity_id",                                  null: false
    t.string   "gender",              limit: 7
    t.integer  "is_active",                      default: 1, null: false
    t.integer  "default_location_id"
    t.string   "phone"
    t.string   "reference",                                  null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "chancellor_vendors", force: :cascade do |t|
    t.integer  "default_contact_id"
    t.integer  "default_location_id"
    t.integer  "entity_id",                                  null: false
    t.string   "reference",                                  null: false
    t.integer  "is_active",                      default: 1, null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
