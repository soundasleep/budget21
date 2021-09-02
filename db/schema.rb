# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_09_081923) do

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_csv"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color", default: "black", null: false
    t.integer "order", default: 0, null: false
  end

  create_table "rules", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "description_matches"
    t.string "reference_matches"
    t.string "particular_matches"
    t.string "code_matches"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "any_matches"
    t.index ["category_id"], name: "index_rules_on_category_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.datetime "date", null: false
    t.string "description"
    t.string "source_code"
    t.string "tp_ref"
    t.string "tp_part"
    t.string "tp_code"
    t.string "op_ref"
    t.string "op_code"
    t.string "op_name"
    t.string "op_bank_account"
    t.decimal "amount", precision: 9, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "op_part"
    t.integer "cached_category_id"
    t.integer "cached_rule_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["cached_category_id"], name: "index_transactions_on_cached_category_id"
    t.index ["cached_rule_id"], name: "index_transactions_on_cached_rule_id"
  end

end
