class AddNamesToBaseExercises < ActiveRecord::Migration
  def change
  	add_column :base_exercises, :long_name, :string
  	add_column :base_exercises, :short_name, :string 
  end
end
