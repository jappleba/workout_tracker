class CreateWorkoutDates < ActiveRecord::Migration
  def change
  	create_table :workout_dates do |t|
      t.date :workout_date
      t.integer :schedule_id
      t.integer :workout_id
  	end
  end
end
