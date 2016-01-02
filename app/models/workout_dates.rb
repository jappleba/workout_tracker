class WorkoutDate < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :workout
end
