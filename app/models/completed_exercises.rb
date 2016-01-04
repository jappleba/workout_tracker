class CompletedExercise < ActiveRecord::Base
  has_many :workouts_completed_exercises
  has_many :workouts, through: :workouts_completed_exercises
end
