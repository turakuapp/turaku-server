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

ActiveRecord::Schema.define(version: 20170715155818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.text "encrypted_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_entries_on_team_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "entry_taggings", force: :cascade do |t|
    t.bigint "entry_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_entry_taggings_on_entry_id"
    t.index ["tag_id"], name: "index_entry_taggings_on_tag_id"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_groups_on_team_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "group_id"
    t.bigint "entry_id"
    t.bigint "tag_id"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_permissions_on_entry_id"
    t.index ["group_id"], name: "index_permissions_on_group_id"
    t.index ["tag_id"], name: "index_permissions_on_tag_id"
    t.index ["team_id"], name: "index_permissions_on_team_id"
    t.index ["user_id"], name: "index_permissions_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "token_hash"
    t.datetime "last_used_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_hash"], name: "index_sessions_on_token_hash"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_tags_on_team_id"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.string "default_permission_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
    t.index ["user_id"], name: "index_team_memberships_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activities", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "entry_id"
    t.text "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_user_activities_on_entry_id"
    t.index ["team_id"], name: "index_user_activities_on_team_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "entries", "teams"
  add_foreign_key "entry_taggings", "entries"
  add_foreign_key "entry_taggings", "tags"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "teams"
  add_foreign_key "permissions", "teams"
  add_foreign_key "tags", "teams"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "team_memberships", "users"
  add_foreign_key "user_activities", "teams"
end
