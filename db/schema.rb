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

ActiveRecord::Schema.define(:version => 20130718180618) do

  create_table "beats", :force => true do |t|
    t.decimal  "price",             :precision => 3, :scale => 2, :default => 0.99
    t.string   "name",                                                                   :null => false
    t.string   "genre",                                                                  :null => false
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.string   "beat_file_name"
    t.string   "beat_content_type"
    t.integer  "beat_file_size"
    t.datetime "beat_updated_at"
    t.string   "state",                                           :default => "pending"
    t.integer  "count",                                           :default => 0
  end

  create_table "tracks", :force => true do |t|
    t.integer  "beat_id",                          :null => false
    t.integer  "user_id",                          :null => false
    t.string   "name"
    t.string   "track",                            :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "state",      :default => "public"
    t.string   "slug"
  end

  add_index "tracks", ["slug"], :name => "index_tracks_on_slug", :unique => true

  create_table "user_beats", :force => true do |t|
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "beat_file_name"
    t.string   "beat_content_type"
    t.integer  "beat_file_size"
    t.datetime "beat_updated_at"
    t.integer  "user_id"
    t.string   "genre"
    t.string   "name"
    t.string   "state",             :default => "public"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "username",                                  :null => false
    t.string   "slug"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
