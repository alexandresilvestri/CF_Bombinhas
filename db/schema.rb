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

ActiveRecord::Schema[8.1].define(version: 2026_04_06_003743) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "gyms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "corporate_name"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.string "subdomain"
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_gyms_on_subdomain", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.boolean "email_confirm"
    t.string "encrypted_password"
    t.string "first_name"
    t.string "last_name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "gym_id", null: false
    t.string "name", null: false
    t.text "skill"
    t.datetime "updated_at", null: false
    t.text "warm_up"
    t.text "wod"
    t.index ["gym_id"], name: "index_workouts_on_gym_id"
  end

  add_foreign_key "workouts", "gyms"
end
