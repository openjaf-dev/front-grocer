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

ActiveRecord::Schema.define(version: 20140810160146) do

  create_table "dimensions", force: true do |t|
    t.integer  "height"
    t.integer  "width"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dimensions", ["image_id"], name: "index_dimensions_on_image_id"

  create_table "images", force: true do |t|
    t.string   "url"
    t.integer  "position"
    t.string   "title"
    t.string   "type"
    t.integer  "variant_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id"
  add_index "images", ["variant_id"], name: "index_images_on_variant_id"

  create_table "options", force: true do |t|
    t.string   "option_type"
    t.string   "option_value"
    t.integer  "variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["variant_id"], name: "index_options_on_variant_id"

  create_table "orders", force: true do |t|
    t.string   "number"
    t.string   "status"
    t.string   "channel"
    t.string   "email"
    t.string   "currency"
    t.datetime "placed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "sku"
    t.string   "description"
    t.float    "price"
    t.float    "cost_price"
    t.date     "available_on"
    t.string   "permalink"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.string   "shipping_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.string   "name"
    t.string   "presentation"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["product_id"], name: "index_properties_on_product_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "variants", force: true do |t|
    t.string   "sku"
    t.float    "price"
    t.float    "cost_price"
    t.integer  "quantity"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id"

end
