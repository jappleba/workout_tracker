class WorkoutsCompletedExercise < ActiveRecord::Base
  belongs_to :workout
  belongs_to :completed_exercise
end
