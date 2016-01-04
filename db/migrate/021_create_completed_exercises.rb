class CreateCompletedExercises < ActiveRecord::Migration
  def change
  	create_table :completed_exercises do |t|
      t.string :name
      t.string :reps
      t.string :sets
  	end
  end
end
