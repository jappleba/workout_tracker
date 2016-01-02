class CreateWorkoutsBaseExercises < ActiveRecord::Migration
  def change
  	create_table :workouts_base_exercises do |t|
      t.integer :workout_id
      t.integer :base_exercise_id
  	end
  end
end
