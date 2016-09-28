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

ActiveRecord::Schema.define(version: 20160928032440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_locations", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "location_id"
    t.integer  "troops_sent"
    t.string   "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "success"
  end

  create_table "characters", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "name"
    t.string   "image_link"
    t.string   "personality"
    t.integer  "role",        default: 0
    t.boolean  "deployed"
    t.string   "status"
    t.integer  "level",       default: 1
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "energy",      default: 1000
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.boolean  "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.string   "status",                default: "pending"
    t.integer  "turn"
    t.integer  "winner"
    t.string   "map_name",              default: "Endless Swamp"
    t.integer  "map_size",              default: 12
    t.string   "map_style_link"
    t.string   "map_image_link"
    t.string   "background_image_link"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "controlled_by"
    t.integer  "game_id"
    t.string   "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "players", force: :cascade do |t|
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
    t.string   "uid"
    t.string   "provider"
    t.string   "alias"
    t.integer  "current_game_id"
    t.index ["email"], name: "index_players_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree
  end

end
