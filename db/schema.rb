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

ActiveRecord::Schema.define(version: 20160917041422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "desc"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comments"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "user_id"
    t.index ["task_id"], name: "index_comments_on_task_id", using: :btree
  end

  create_table "models", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_models_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree
  end

  create_table "preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "notifyfor_newtask"
    t.boolean  "notifyfor_taskupdate"
    t.boolean  "notifyfor_comment2task"
    t.boolean  "notifyfor_taskcomplete"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "remarks"
    t.date     "due_date"
    t.integer  "status"
    t.integer  "priority"
    t.integer  "category_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "numviews",      default: 0
    t.integer  "user_id"
    t.integer  "assignedto_id"
  end

  create_table "trackings", force: :cascade do |t|
    t.string   "task_id"
    t.string   "user_id"
    t.text     "change"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "avatar"
    t.string   "firstname"
    t.string   "lastname"
    t.text     "address"
    t.string   "city"
    t.string   "country"
    t.string   "customer_id"
    t.string   "mobile"
    t.integer  "pin"
    t.string   "gender"
    t.integer  "status"
  end

  add_foreign_key "comments", "tasks"
end
