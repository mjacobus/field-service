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

ActiveRecord::Schema.define(version: 20161115174851) do

  create_table "householders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "territory_id"
    t.string   "street_name"
    t.integer  "house_number"
    t.string   "name"
    t.boolean  "show"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["territory_id"], name: "index_householders_on_territory_id", using: :btree
  end

  create_table "territories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["name"], name: "index_territories_on_name", unique: true, using: :btree
  end

  add_foreign_key "householders", "territories"
end
