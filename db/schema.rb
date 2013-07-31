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

ActiveRecord::Schema.define(:version => 20130718074954) do

  create_table "account_members", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "city_id"
    t.integer  "state_id"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "role_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "status",             :default => 1
  end

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

  create_table "carts", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "purchased_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "status",     :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "slug"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.integer  "city_status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 1
  end

  create_table "customer_supports", :force => true do |t|
    t.string   "name"
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "destinations", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.integer  "status",                                    :default => 1
    t.decimal  "price",      :precision => 10, :scale => 0
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "quantity",   :default => 1
    t.integer  "order_id"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "account_member_id"
    t.integer  "status",                                                :default => 0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.integer  "destination_id"
    t.decimal  "total_all_price",        :precision => 10, :scale => 0
    t.integer  "cart_id"
    t.decimal  "total_all_price_dollar", :precision => 10, :scale => 2
    t.string   "code_order"
  end

  create_table "photo_products", :force => true do |t|
    t.string   "image_product"
    t.text     "description"
    t.integer  "product_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "code_product"
    t.string   "name_product"
    t.integer  "stock"
    t.integer  "status",                                      :default => 1
    t.integer  "category_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.decimal  "price",        :precision => 10, :scale => 0
    t.text     "description"
  end

  create_table "review_products", :force => true do |t|
    t.integer  "account_member_id"
    t.integer  "product_id"
    t.text     "description"
    t.integer  "status",            :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string   "name"
    t.integer  "state_status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "testimonials", :force => true do |t|
    t.integer  "account_member_id"
    t.text     "description"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "status",            :default => 0
  end

  create_table "viewed_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "total",      :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
