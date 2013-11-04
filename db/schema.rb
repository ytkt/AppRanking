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

ActiveRecord::Schema.define(version: 20131104082634) do

  create_table "apps", force: true do |t|
    t.string "name",       limit: 64
    t.string "developer",  limit: 64
    t.string "img_url"
    t.string "detail_url"
    t.string "bundle_id"
  end

  create_table "fetch_dates", force: true do |t|
    t.datetime "fetched_at"
  end

  create_table "rankings", force: true do |t|
    t.integer  "position"
    t.integer  "app_id"
    t.integer  "fetch_date_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
