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

ActiveRecord::Schema.define(version: 20160411161056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appetite_size_quantities", force: :cascade do |t|
    t.integer "group_id",         null: false
    t.integer "appetite_size_id", null: false
    t.integer "quantity",         null: false
  end

  add_index "appetite_size_quantities", ["appetite_size_id"], name: "index_appetite_size_quantities_on_appetite_size_id", using: :btree
  add_index "appetite_size_quantities", ["group_id"], name: "index_appetite_size_quantities_on_group_id", using: :btree

  create_table "appetite_sizes", force: :cascade do |t|
    t.string "name",        null: false
    t.float  "coefficient", null: false
  end

  create_table "group_recipes_quantities", force: :cascade do |t|
    t.integer "group_id",           null: false
    t.integer "recipe_id",          null: false
    t.integer "quantity",           null: false
    t.integer "individuals_served"
  end

  add_index "group_recipes_quantities", ["group_id"], name: "index_group_recipes_quantities_on_group_id", using: :btree
  add_index "group_recipes_quantities", ["recipe_id"], name: "index_group_recipes_quantities_on_recipe_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",              null: false
    t.text     "description"
    t.integer  "user_id",           null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "total_individuals"
    t.float    "total_servings"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "ingredient_unit_costs", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "unit_id",       null: false
    t.float   "price",         null: false
  end

  add_index "ingredient_unit_costs", ["ingredient_id"], name: "index_ingredient_unit_costs_on_ingredient_id", using: :btree
  add_index "ingredient_unit_costs", ["unit_id"], name: "index_ingredient_unit_costs_on_unit_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "user_id",      null: false
    t.string   "store"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "note"
    t.integer  "unit_type_id"
    t.string   "usda_id"
  end

  add_index "ingredients", ["unit_type_id"], name: "index_ingredients_on_unit_type_id", using: :btree
  add_index "ingredients", ["user_id"], name: "index_ingredients_on_user_id", using: :btree

  create_table "meal_categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "meal_categories_recipes", id: false, force: :cascade do |t|
    t.integer "meal_category_id", null: false
    t.integer "recipe_id",        null: false
  end

  create_table "meal_components", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "meal_components_recipes", id: false, force: :cascade do |t|
    t.integer "meal_component_id", null: false
    t.integer "recipe_id",         null: false
  end

  create_table "recipe_ingredients_quantities", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "recipe_id",     null: false
    t.float   "quantity",      null: false
    t.integer "unit_id"
  end

  add_index "recipe_ingredients_quantities", ["ingredient_id"], name: "index_recipe_ingredients_quantities_on_ingredient_id", using: :btree
  add_index "recipe_ingredients_quantities", ["recipe_id"], name: "index_recipe_ingredients_quantities_on_recipe_id", using: :btree
  add_index "recipe_ingredients_quantities", ["unit_id"], name: "index_recipe_ingredients_quantities_on_unit_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "servings_count", null: false
    t.text     "instruction"
    t.integer  "user_id",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "recipes_tags", id: false, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "tag_id",    null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name",    null: false
    t.integer "user_id", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "unit_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string  "name"
    t.float   "coefficient"
    t.integer "unit_type_id"
  end

  add_index "units", ["unit_type_id"], name: "index_units_on_unit_type_id", using: :btree

  create_table "usda_food_groups", id: false, force: :cascade do |t|
    t.string "code",        null: false
    t.string "description", null: false
  end

  add_index "usda_food_groups", ["code"], name: "index_usda_food_groups_on_code", using: :btree

  create_table "usda_foods", id: false, force: :cascade do |t|
    t.string  "nutrient_databank_number", null: false
    t.string  "food_group_code"
    t.string  "long_description",         null: false
    t.string  "short_description",        null: false
    t.string  "common_names"
    t.string  "manufacturer_name"
    t.boolean "survey"
    t.string  "refuse_description"
    t.integer "percentage_refuse"
    t.float   "nitrogen_factor"
    t.float   "protein_factor"
    t.float   "fat_factor"
    t.float   "carbohydrate_factor"
  end

  add_index "usda_foods", ["food_group_code"], name: "index_usda_foods_on_food_group_code", using: :btree
  add_index "usda_foods", ["nutrient_databank_number"], name: "index_usda_foods_on_nutrient_databank_number", using: :btree

  create_table "usda_foods_nutrients", force: :cascade do |t|
    t.string  "nutrient_databank_number",     null: false
    t.string  "nutrient_number",              null: false
    t.float   "nutrient_value",               null: false
    t.integer "num_data_points",              null: false
    t.float   "standard_error"
    t.string  "src_code",                     null: false
    t.string  "derivation_code"
    t.string  "ref_nutrient_databank_number"
    t.boolean "add_nutrient_mark"
    t.integer "num_studies"
    t.float   "min"
    t.float   "max"
    t.integer "degrees_of_freedom"
    t.float   "lower_error_bound"
    t.float   "upper_error_bound"
    t.string  "statistical_comments"
    t.string  "add_mod_date"
    t.string  "confidence_code"
  end

  add_index "usda_foods_nutrients", ["nutrient_databank_number", "nutrient_number"], name: "foods_nutrients_index", using: :btree

  create_table "usda_nutrients", id: false, force: :cascade do |t|
    t.string  "nutrient_number",       null: false
    t.string  "units",                 null: false
    t.string  "tagname"
    t.string  "nutrient_description",  null: false
    t.string  "number_decimal_places", null: false
    t.integer "sort_record_order",     null: false
  end

  add_index "usda_nutrients", ["nutrient_number"], name: "index_usda_nutrients_on_nutrient_number", using: :btree

  create_table "usda_units_coefficients", force: :cascade do |t|
    t.integer "unit_id",       null: false
    t.integer "ingredient_id", null: false
    t.float   "coefficient",   null: false
  end

  add_index "usda_units_coefficients", ["ingredient_id"], name: "index_usda_units_coefficients_on_ingredient_id", using: :btree
  add_index "usda_units_coefficients", ["unit_id"], name: "index_usda_units_coefficients_on_unit_id", using: :btree

  create_table "usda_weights", force: :cascade do |t|
    t.string  "nutrient_databank_number", null: false
    t.string  "sequence_number",          null: false
    t.float   "amount",                   null: false
    t.string  "measurement_description",  null: false
    t.float   "gram_weight",              null: false
    t.integer "num_data_points"
    t.float   "standard_deviation"
  end

  add_index "usda_weights", ["nutrient_databank_number"], name: "index_usda_weights_on_nutrient_databank_number", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "appetite_size_quantities", "appetite_sizes"
  add_foreign_key "appetite_size_quantities", "groups"
  add_foreign_key "group_recipes_quantities", "groups"
  add_foreign_key "group_recipes_quantities", "recipes"
  add_foreign_key "groups", "users"
  add_foreign_key "ingredient_unit_costs", "ingredients"
  add_foreign_key "ingredient_unit_costs", "units"
  add_foreign_key "ingredients", "users"
  add_foreign_key "recipe_ingredients_quantities", "ingredients"
  add_foreign_key "recipe_ingredients_quantities", "recipes"
  add_foreign_key "recipes", "users"
  add_foreign_key "tags", "users"
end
