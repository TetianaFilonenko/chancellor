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

ActiveRecord::Schema.define(version: 20150225172448) do

  create_table "contacts", force: true do |t|
    t.integer  "entity_id",                            null: false
    t.string   "first_name",                           null: false
    t.string   "last_name",                            null: false
    t.string   "display_name",                         null: false
    t.string   "title"
    t.string   "email_address"
    t.string   "fax_number"
    t.string   "mobile_number"
    t.string   "phone_number"
    t.string   "uuid",          limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_active",                default: 1, null: false
  end

  create_table "customers", force: true do |t|
    t.integer  "default_contact_id"
    t.integer  "default_location_id"
    t.integer  "entity_id",                                  null: false
    t.integer  "parent_customer_id"
    t.string   "reference",                                  null: false
    t.integer  "salesperson_id"
    t.integer  "is_active",                      default: 1, null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", force: true do |t|
    t.string   "cached_long_name", limit: 1024,             null: false
    t.string   "display_name",                              null: false
    t.string   "name",                                      null: false
    t.string   "contact_name"
    t.string   "comments"
    t.string   "reference",                                 null: false
    t.string   "uuid",             limit: 32,               null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_entity_id"
    t.integer  "is_active",                     default: 1, null: false
  end

  create_table "locations", force: true do |t|
    t.integer  "entity_id",                                                      null: false
    t.string   "location_name",                                                  null: false
    t.string   "street_address",                                                 null: false
    t.string   "city",                                                           null: false
    t.string   "region",                                                         null: false
    t.string   "region_code",                                                    null: false
    t.string   "country",                                                        null: false
    t.string   "uuid",           limit: 32,                                      null: false
    t.decimal  "latitude",                  precision: 10, scale: 8
    t.decimal  "longitude",                 precision: 11, scale: 8
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_active",                                          default: 1, null: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "salespeople", force: true do |t|
    t.integer  "entity_id",                                  null: false
    t.string   "gender",              limit: 7
    t.integer  "location_id"
    t.string   "phone"
    t.string   "reference",                                  null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_location_id"
    t.integer  "is_active",                      default: 1, null: false
  end

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_active",              default: 1
    t.string   "display_name",                        null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "vendors", force: true do |t|
    t.integer  "default_contact_id"
    t.integer  "default_location_id"
    t.integer  "entity_id",                                  null: false
    t.string   "reference",                                  null: false
    t.integer  "is_active",                      default: 1, null: false
    t.string   "uuid",                limit: 32,             null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "version_associations", force: true do |t|
    t.integer "version_id"
    t.string  "foreign_key_name", null: false
    t.integer "foreign_key_id"
  end

  add_index "version_associations", ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
  add_index "version_associations", ["version_id"], name: "index_version_associations_on_version_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.integer  "transaction_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  add_index "versions", ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree

end
