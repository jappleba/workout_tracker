class CreateSchedules < ActiveRecord::Migration
  def change
  	create_table :schedules do |t|
      t.string :name
      t.integer :user_id
  	end
  end
end
