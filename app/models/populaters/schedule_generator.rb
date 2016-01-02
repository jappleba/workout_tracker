require "./config/environment"
require 'pry'

class GenerateSchedule
  attr_accessor :handstand_starting_exercise, :prep_starting_exercise, :knuckle_starting_exercise, :rock_starting_exercise, :fingertip_starting_exercise, :number, :days, :workout, :workout_date, :schedule, :time

#set starting point for each answer in questionaire
  @@handstand_hash = {
    "1" => "HS/PE1",
    "2" => "HS/PE4",
    "3" => "HS/PE8",
    "4" => "HS/PE12",
    "5" => "HS/SE1",
    "6" => "HS/SE8"
  }
  @@wrist_hash = {
    "1" => {prep: "WP/PE1", knuckle: "FKP/PE1", rock: "WR/PE1", fingertip: "FTP/PE1"},
    "2" => {prep: "WP/PE3", knuckle: "FKP/PE3", rock: "WR/PE3", fingertip: "FTP/PE3"},
    "3" => {prep: "WP/SE1", knuckle: "FKP/SE1", rock: "WR/SE1", fingertip: "FTP/SE1"},
    "4" => {prep: "WP/SE3", knuckle: "FKP/SE3", rock: "WR/SE3", fingertip: "FTP/SE3"}
  }

  #initialize - define the starting point based on questionaire
  def initialize(args)
    @handstand_starting_exercise = BaseExercise.find_by(short_name: @@handstand_hash[args["handstand_hold"]])
    @prep_starting_exercise = BaseExercise.find_by(short_name: @@wrist_hash[args["fingertip_pushup"]][:prep])
    @knuckle_starting_exercise = BaseExercise.find_by(short_name: @@wrist_hash[args["fingertip_pushup"]][:knuckle])
    @rock_starting_exercise = BaseExercise.find_by(short_name: @@wrist_hash[args["fingertip_pushup"]][:rock])
    @fingertip_starting_exercise = BaseExercise.find_by(short_name: @@wrist_hash[args["fingertip_pushup"]][:fingertip])
    @days = args["days"].to_i
    @number = (args["number"].to_i) * 2
    self.set_other_variables
  end

  def set_other_variables
    @starting_exercises = [@prep_starting_exercise, @knuckle_starting_exercise, @rock_starting_exercise, @fingertip_starting_exercise]
    @time = Time.now
    @schedule = Schedule.create
  end
#MAIN POPULATION METHOD
  def populate_workout_dates
    i=1
    (@days*12).times do
      self.create_workout_date
      self.populate_handstand_workout(i)
      self.populate_wrist_workout(i)
      i+=1
    end
    self.assign_dates_to_workout_dates
  end

#HELPER METHODS
  def create_workout_date
    @workout_date = WorkoutDate.create
    @workout_date.schedule_id = @schedule.id
    @workout = Workout.create
    @workout_date.workout_id = @workout.id
    @workout_date.save
  end

  def populate_handstand_workout(i)
    c = 0
    @number.times do
      @workout.base_exercises << BaseExercise.find(@handstand_starting_exercise.id + ((i/@days).to_f).ceil-1 + (c * 12))
      @workout.save
      @workout_date.save
      c+=1
    end
  end

  def populate_wrist_workout(i)
    @starting_exercises.each do |exercise|
      @workout.base_exercises << BaseExercise.find(exercise.id + ((i/@days.to_f).ceil-1))
      @workout.save
      @workout_date.save
      @schedule.workout_dates << workout_date
    end
  end

  def assign_dates_to_workout_dates
    calendar_hash = generate_calendar_hash
    calendar_hash[days].each_with_index do |x,index|
      workout_date = schedule.workout_dates[index]
      workout_date.workout_date = @time + (x*60*60*24)
      workout_date.save
    end
  end

  def generate_calendar_hash
    weekly_calendar_template = {
      1 => [1],
      2 => [1,3],
      3 => [1,3,5],
      4 => [1,3,5,6],
      5 => [1,3,4,5,7],
      6 => [1,3,4,5,6,7],
      7 => [1,2,3,4,5,6,7]
    }
    calendar_hash = {}
    weekly_calendar_template.each do |key,value|
      i=0
      12.times do
        array = []
        value.each do |x|
          array << (x + 7*i)
        end
        if calendar_hash[key] == nil
          calendar_hash[key] = array
        else
          calendar_hash[key] << array
          calendar_hash[key].flatten!
        end
      i+=1
      end
    end
    calendar_hash
  end


#to be deleted once completed
  def clear_all
    WorkoutDate.destroy_all
    Schedule.destroy_all
    Workout.destroy_all
  end


end
