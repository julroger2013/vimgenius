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

ActiveRecord::Schema[7.1].define(version: 2025_07_19_211011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authem_sessions", force: :cascade do |t|
    t.string "role", null: false
    t.string "subject_type", null: false
    t.bigint "subject_id", null: false
    t.string "token", limit: 60, null: false
    t.datetime "expires_at", null: false
    t.integer "ttl", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject"
    t.index ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true
    t.index ["subject_type", "subject_id"], name: "index_authem_sessions_on_subject"
  end

  create_table "commands", id: :serial, force: :cascade do |t|
    t.integer "level_id"
    t.string "name"
    t.string "keystroke"
    t.string "start_mode"
    t.index ["level_id"], name: "index_commands_on_level_id"
  end

  create_table "commands_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "command_id"
    t.index ["command_id"], name: "index_commands_users_on_command_id"
    t.index ["user_id"], name: "index_commands_users_on_user_id"
  end

  create_table "lessons", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "summary"
    t.string "slug"
    t.text "directions"
    t.text "done_message"
  end

  create_table "levels", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "sequence_number"
    t.string "name"
    t.string "slug"
    t.text "intro"
    t.index ["lesson_id"], name: "index_levels_on_lesson_id"
  end

  create_table "levels_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "level_id"
    t.string "timestamps"
    t.index ["level_id"], name: "index_levels_users_on_level_id"
    t.index ["user_id"], name: "index_levels_users_on_user_id"
  end

  create_table "user_lessons", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "lesson_id"
    t.decimal "accuracy"
    t.decimal "average_time"
    t.boolean "completed", default: false
    t.index ["lesson_id"], name: "index_user_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_user_lessons_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
    t.string "password_reset_token"
    t.string "session_token"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "temporary", default: false
  end

end
