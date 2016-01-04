class CreateWorkoutsCompletedExercises < ActiveRecord::Migration
  def change
  	create_table :workouts_completed_exercises do |t|
      t.integer :workout_id
      t.integer :completed_exercise_id
  	end
  end
end
