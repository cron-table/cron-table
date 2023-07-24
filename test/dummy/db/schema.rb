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

ActiveRecord::Schema[7.0].define(version: 2023_07_23_000000) do
  create_table "cron_table", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "next_run_at"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.index ["next_run_at"], name: "index_cron_table_on_next_run_at"
  end

end
