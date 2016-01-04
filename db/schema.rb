# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 22) do

  create_table "base_exercises", force: :cascade do |t|
    t.string  "name"
    t.integer "template_id"
    t.string  "long_name"
    t.string  "short_name"
  end

  create_table "completed_exercises", force: :cascade do |t|
    t.string "name"
    t.string "reps"
    t.string "sets"
  end

  create_table "schedules", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string  "block"
    t.integer "week"
    t.integer "reps"
    t.integer "sets"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "password_digest"
    t.integer "schedule_id"
  end

  create_table "workout_dates", force: :cascade do |t|
    t.date    "workout_date"
    t.integer "schedule_id"
    t.integer "workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "name"
  end

  create_table "workouts_base_exercises", force: :cascade do |t|
    t.integer "workout_id"
    t.integer "base_exercise_id"
  end

  create_table "workouts_completed_exercises", force: :cascade do |t|
    t.integer "workout_id"
    t.integer "completed_exercise_id"
  end

end
