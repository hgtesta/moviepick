class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "name"
      t.string   "email"
      t.string   "username",                              null: false
      t.string   "auth_token"
      t.boolean  "admin"
      t.boolean  "deleted",               default: false, null: false
      t.string   "confirmation_code"
      t.datetime "confirmed_at"
      t.string   "password_digest"
      t.boolean  "enabled",               default: false, null: false
      t.integer  "login_count",           default: 0,     null: false
      t.integer  "failed_login_count",    default: 0,     null: false
      t.datetime "last_request_at"
      t.datetime "current_login_at"
      t.datetime "last_login_at"
      t.string   "current_login_ip"
      t.string   "last_login_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
