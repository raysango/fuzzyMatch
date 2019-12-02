# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_27_043640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "insurance_matches", force: :cascade do |t|
    t.string "name"
    t.bigint "insurance_id"
    t.index ["insurance_id"], name: "index_insurance_matches_on_insurance_id"
    t.index ["name"], name: "index_insurance_matches_on_name"
  end

  create_table "insurance_webhooks", force: :cascade do |t|
    t.string "status"
    t.jsonb "wh_data"
    t.bigint "insurance_id"
    t.index "(((wh_data -> 'Company'::text) -> 'ID'::text))", name: "index_insurance_webhooks_on_company_id"
    t.index ["insurance_id"], name: "index_insurance_webhooks_on_insurance_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.string "name"
    t.index "to_tsvector('english'::regconfig, 'name'::text)", name: "insurances_gin_name", using: :gin
  end

end
