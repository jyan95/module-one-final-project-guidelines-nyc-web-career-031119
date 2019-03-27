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

ActiveRecord::Schema.define(version: 20190327141142) do

  create_table "players", force: :cascade do |t|
    t.string  "username"
    t.integer "high_score"
  end

  create_table "question_masters", force: :cascade do |t|
    t.integer "question_id"
    t.integer "player_id"
    t.boolean "correct"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "category"
    t.string "difficulty"
    t.string "correct_answer"
    t.string "style"
    t.string "incorrect_answers"
  end

end
