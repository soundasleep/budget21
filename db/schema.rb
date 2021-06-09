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

ActiveRecord::Schema.define(version: 20210609061217) do

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
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

end
