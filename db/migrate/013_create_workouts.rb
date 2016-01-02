class CreateWorkouts < ActiveRecord::Migration
  def change
  	create_table :workouts do |t|
  		t.string :name
  	end
  end
end
