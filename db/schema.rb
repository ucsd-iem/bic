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

ActiveRecord::Schema.define(:version => 20130321014333) do

  create_table "abstracts", :force => true do |t|
    t.string   "title"
    t.string   "authors"
    t.text     "affiliations"
    t.string   "email"
    t.text     "body"
    t.text     "personal_statement"
    t.string   "video_url"
    t.integer  "year"
    t.integer  "attendee_id"
    t.integer  "order_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "biosketch_file_name"
    t.string   "biosketch_content_type"
    t.integer  "biosketch_file_size"
    t.datetime "biosketch_updated_at"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.string   "presentation_file_name"
    t.string   "presentation_content_type"
    t.integer  "presentation_file_size"
    t.datetime "presentation_updated_at"
    t.integer  "position"
    t.string   "presenter_first_name"
    t.string   "presenter_middle_name"
    t.string   "presenter_last_name"
    t.string   "presenter_affiliation"
  end

  create_table "announcements", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attendees", :force => true do |t|
    t.integer  "eid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "order_type"
    t.string   "barcode"
    t.integer  "order_id"
    t.float    "amount_paid"
    t.string   "currency"
    t.string   "discount"
    t.integer  "quantity"
    t.integer  "ticket_id"
    t.integer  "event_id",    :limit => 8
    t.string   "event_date"
    t.datetime "created"
    t.datetime "modified"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "stop"
    t.integer  "abstract_id"
    t.integer  "session"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "location"
  end

  create_table "moderators", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "affiliaiton"
    t.integer  "event_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "biosketch_file_name"
    t.string   "biosketch_content_type"
    t.integer  "biosketch_file_size"
    t.datetime "biosketch_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "registrants", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "affiliation"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.string   "food_preference"
    t.string   "special_needs"
    t.string   "token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "email"
    t.string   "phone"
    t.string   "level"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "eid"
    t.string   "barcode"
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "ticket_id"
    t.integer  "event_id"
    t.integer  "attendee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
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
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
