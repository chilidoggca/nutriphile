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

ActiveRecord::Schema.define(version: 20180427200459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", force: :cascade do |t|
    t.integer "food_number"
    t.integer "food_code"
    t.integer "food_group_id"
    t.integer "food_source_id"
    t.string "food_name"
    t.string "food_name_f"
    t.date "food_date_of_entry"
    t.date "food_date_of_publication"
    t.integer "country_code"
    t.string "scientific_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutrient_amounts", force: :cascade do |t|
    t.integer "food_number"
    t.integer "nutrient_number"
    t.float "nutrient_value"
    t.integer "standard_error"
    t.integer "number_of_observations"
    t.integer "nutrient_source_id"
    t.date "nutrient_date_of_entry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutrient_names", force: :cascade do |t|
    t.integer "nutrient_number"
    t.integer "nutrient_code"
    t.string "nutrient_symbol"
    t.string "nutrient_unit"
    t.string "nutrient_name"
    t.string "nutrient_name_f"
    t.string "tagname"
    t.integer "nutrient_decimals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutrients", force: :cascade do |t|
    t.integer "nutrient_number"
    t.bigint "nutrient_name_id"
    t.bigint "nutrient_amount_id"
    t.bigint "food_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_nutrients_on_food_id"
    t.index ["nutrient_amount_id"], name: "index_nutrients_on_nutrient_amount_id"
    t.index ["nutrient_name_id"], name: "index_nutrients_on_nutrient_name_id"
    t.index ["nutrient_number"], name: "index_nutrients_on_nutrient_number"
  end

  add_foreign_key "nutrients", "foods"
  add_foreign_key "nutrients", "nutrient_amounts"
  add_foreign_key "nutrients", "nutrient_names"
end
