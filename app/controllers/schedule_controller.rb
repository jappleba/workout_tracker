
class ScheduleController < ApplicationController

  get "/schedules/new" do
    erb :"schedules/new"
  end

  post "/schedules/new" do
    schedule = GenerateSchedule.new(params[:exercise])
    schedule.populate_workout_dates
    schedule.schedule.user_id = session["id"]
    schedule.schedule.save
    user = current_user
    new_sched = schedule.schedule.id
    user.update(schedule_id: new_sched)
    user.save
    redirect "/schedules/#{new_sched}/show"
  end

  get "/schedules/:id/edit" do
    @user = current_user
    @schedule = current_schedule
    erb :"schedules/edit"
  end

  post "/schedules/:id/edit" do
    binding.pry
  end

  get "/schedules/:id/show" do
    if session["id"] != nil
      @user = current_user
      @schedule = current_schedule
      erb :"schedules/show"
    else
      redirect "/users/failure"
    end
  end

end
