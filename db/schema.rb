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

ActiveRecord::Schema[7.2].define(version: 2024_07_17_092607) do
  create_table "loan_profits", force: :cascade do |t|
    t.integer "loan_id", null: false
    t.decimal "max_loan_amount_purchase_price"
    t.decimal "max_loan_amount_arv"
    t.decimal "loan_amount"
    t.decimal "total_interest_expense"
    t.decimal "estimated_profit"
    t.decimal "purchase_price_ratio", default: "0.9"
    t.decimal "arv_ratio", default: "0.7"
    t.decimal "annual_interest_rate", default: "0.13"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_profits_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.string "address"
    t.integer "loan_term"
    t.decimal "purchase_price"
    t.decimal "repair_budget"
    t.decimal "after_repair_value"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "loan_profits", "loans"
end
