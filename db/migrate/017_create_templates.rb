class CreateTemplates < ActiveRecord::Migration
  def change
  	create_table :templates do |t|
      t.string :block
      t.integer :week
  		t.integer :reps
  		t.integer :sets
  	end
  end
end
