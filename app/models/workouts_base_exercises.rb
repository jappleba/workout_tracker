class WorkoutsBaseExercise < ActiveRecord::Base
  belongs_to :workout
  belongs_to :base_exercise
end
