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

ActiveRecord::Schema.define(version: 20140728141314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: true do |t|
    t.string  "title"
    t.decimal "rating"
    t.integer "votes"
    t.string  "votes_distribution"
    t.integer "year"
    t.integer "year_part"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username",                           null: false
    t.string   "auth_token"
    t.boolean  "admin"
    t.boolean  "deleted",            default: false, null: false
    t.string   "confirmation_code"
    t.datetime "confirmed_at"
    t.string   "password_digest"
    t.boolean  "enabled",            default: false, null: false
    t.integer  "login_count",        default: 0,     null: false
    t.integer  "failed_login_count", default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "movie_ids",          default: [],                 array: true
  end

end
