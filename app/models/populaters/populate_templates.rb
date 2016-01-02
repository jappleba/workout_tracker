require "./config/environment"
require 'pry'

class PopulateTemplates
  # t.string :block
  # t.integer :week
  # t.integer :reps
  # t.integer :sets

  @@templates = {
     1 => {block: 1, sets: 3, reps: 1},
     2 => {block: 1, sets: 5, reps: 1},
     3 => {block: 1, sets: 3, reps: 2},
     4 => {block: 1, sets: 3, reps: 1},
     5 => {block: 2, sets: 4, reps: 2},
     6 => {block: 2, sets: 4, reps: 3},
     7 => {block: 2, sets: 5, reps: 3},
     8 => {block: 2, sets: 5, reps: 2},
     9 => {block: 3, sets: 4, reps: 4},
     10 => {block: 3, sets: 4, reps: 5},
     11 => {block: 3, sets: 5, reps: 5},
     12 => {block: 3, sets: 5, reps: 3}
  }
  def self.populate
    @@templates.each do |key, value|
      template = Template.new
      template.block = value[:block]
      template.reps = value[:reps]
      template.sets = value[:sets]
      template.week = key
      template.save
    end
    binding.pry
  end
end
