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

ActiveRecord::Schema[7.0].define(version: 2022_10_04_224308) do
  create_table "matches", force: :cascade do |t|
    t.integer "home_team_id", null: false
    t.integer "away_team_id", null: false
    t.integer "home_team_goals", default: 0
    t.integer "away_team_goals", default: 0
    t.time "start_at"
    t.time "finished_at"
    t.time "current_time"
    t.integer "stage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["stage_id"], name: "index_matches_on_stage_id"
  end

  add_foreign_key "matches", "away_teams"
  add_foreign_key "matches", "home_teams"
  add_foreign_key "matches", "stages"
end
