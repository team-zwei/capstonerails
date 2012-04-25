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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120411143103) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "auctions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.text     "terms"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "starting_bid_price",    :precision => 15, :scale => 2
    t.decimal  "minimum_bid_increment", :precision => 15, :scale => 2
    t.integer  "current_bid_id"
    t.integer  "winner_id"
    t.text     "data"
    t.string   "property_type"
    t.string   "area"
    t.integer  "street_num"
    t.string   "street_name"
    t.string   "city"
    t.string   "county"
    t.text     "legal_description"
    t.decimal  "lot_size"
    t.integer  "year_built"
    t.string   "elementary_school"
    t.string   "middle_school"
    t.string   "high_school"
    t.integer  "square_feet"
    t.integer  "beds"
    t.integer  "baths"
    t.integer  "half_baths"
    t.integer  "fireplaces"
    t.integer  "num_rooms"
    t.integer  "time_increment"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "status"
  end

  create_table "auctions_categories", :id => false, :force => true do |t|
    t.integer "auction_id"
    t.integer "category_id"
  end

  create_table "bids", :force => true do |t|
    t.decimal  "amount",     :precision => 15, :scale => 2
    t.integer  "auction_id"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "real_estate"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "auction_image"
    t.string   "title"
    t.integer  "auction_id"
    t.boolean  "main",          :default => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "payment_methods", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.string   "card_type"
    t.integer  "last4"
    t.datetime "expiration"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "auction_id"
    t.integer  "payment_method_id"
    t.decimal  "amount",            :precision => 15, :scale => 2
    t.string   "charge_id"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "stripe_customer_token"
    t.string   "auth_token"
    t.boolean  "admin"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
