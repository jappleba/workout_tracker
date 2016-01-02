require "./config/environment"
require 'pry'
class BaseExercise < ActiveRecord::Base
  belongs_to :template
  has_many :workouts_base_exercises
  has_many :workouts, through: :workouts_base_exercises

  def self.edit_names
    BaseExercise.all.each do |x|
      if x.name.include?(":")
        x.long_name = x.name.split(/(Warmup)|[:>]|(Mastery)/)[0]
        x.short_name = x.name.split(/(Warmup)|[:>]|(Mastery)/)[1]
        x.save
      end
    end
  end

  def self.take_out_leading_spaces
    BaseExercise.all.each do |x|
      x.long_name = x.long_name.strip
      x.short_name = x.short_name.strip
      x.save
    end
    binding.pry
  end
end

# BaseExercise.take_out_leading_spaces
