class CreateBaseExercises < ActiveRecord::Migration
  def change
  	create_table :base_exercises do |t|
      t.string :name
      t.integer :template_id
  	end
  end
end
