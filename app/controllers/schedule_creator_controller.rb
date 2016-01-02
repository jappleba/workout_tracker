require "./config/environment"
require 'pry'
# require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/create" do
    erb :create
  end

  post "/create" do
    schedule = GenerateSchedule.new(params[:exercise])
    schedule.populate_workout_dates
    schedule.schedule.user_id = session["id"]
    schedule.schedule.save
    user = User.find(session["id"])
    new_sched = schedule.schedule.id
    user.update(schedule_id: new_sched)
    user.save
    redirect to "/show"
  end

# helpers doa
  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id])
  end

end
