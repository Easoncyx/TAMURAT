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

ActiveRecord::Schema.define(version: 20190404211625) do

  create_table "answers", force: :cascade do |t|
    t.integer "company_id"
    t.integer "question_id"
    t.integer "level"
    t.boolean "validated"
    t.integer "validator_id"
    t.string "validator_comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.float "weight_sum", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer "user_id"
    t.float "company_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.integer "subcategory_id"
    t.float "weight", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subcategory_id"], name: "index_questions_on_subcategory_id", unique: true
  end

  create_table "scenarios", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_scenarios_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.float "weight", default: 0.0
    t.float "weight_sum", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_subcategories_on_category_id", unique: true
  end

  create_table "subcompanies", force: :cascade do |t|
    t.integer "parent_company_user_id", null: false
    t.integer "child_company_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_company_user_id"], name: "index_subcompanies_on_child_company_user_id", unique: true
    t.index ["parent_company_user_id"], name: "index_subcompanies_on_parent_company_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "role"
    t.integer "login_id"
    t.boolean "approved", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
  end

end
