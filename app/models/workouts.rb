class Workout < ActiveRecord::Base
  has_many :workouts_base_exercises
  has_many :base_exercises, through: :workouts_base_exercises
  has_many :workout_dates
end
