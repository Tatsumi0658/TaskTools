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

ActiveRecord::Schema.define(version: 2019_03_02_190114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "labels", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "todotask_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todotask_id"], name: "index_labels_on_todotask_id"
  end

  create_table "todotasks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", null: false
    t.datetime "deadline", null: false
    t.integer "priority", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["name"], name: "index_todotasks_on_name"
    t.index ["priority"], name: "index_todotasks_on_priority"
    t.index ["user_id"], name: "index_todotasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_flag", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "labels", "todotasks"
  add_foreign_key "todotasks", "users"
end
