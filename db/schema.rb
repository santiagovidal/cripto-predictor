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

ActiveRecord::Schema.define(version: 2018_05_14_231310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coins", force: :cascade do |t|
    t.string "name"
    t.integer "uid"
    t.string "symbol"
    t.string "website_slug"
    t.float "circulating_supply"
    t.float "total_supply"
    t.float "max_supply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predictions", force: :cascade do |t|
    t.bigint "coin_id"
    t.bigint "tick_id"
    t.date "timeframe"
    t.float "original_price"
    t.float "highest_price_so_far"
    t.boolean "successful", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_predictions_on_coin_id"
    t.index ["tick_id"], name: "index_predictions_on_tick_id"
  end

  create_table "ticks", force: :cascade do |t|
    t.bigint "coin_id"
    t.float "price"
    t.float "daily_volume"
    t.float "market_cap"
    t.float "hourly_change"
    t.float "daily_change"
    t.float "weekly_change"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_ticks_on_coin_id"
  end

  add_foreign_key "predictions", "coins"
  add_foreign_key "predictions", "ticks"
  add_foreign_key "ticks", "coins"
end
