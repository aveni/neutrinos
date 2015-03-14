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

ActiveRecord::Schema.define(version: 20150314194436) do

  create_table "events", force: :cascade do |t|
    t.text     "name"
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.string   "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_teams", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "team_id",  null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "number"
    t.integer  "blue1_id"
    t.integer  "blue2_id"
    t.integer  "red1_id"
    t.integer  "red2_id"
    t.integer  "red_score"
    t.integer  "blue_score"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "number"
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
