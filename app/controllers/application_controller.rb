require "./config/environment"
require 'pry'
# require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  get "/show" do
    @user = User.find(session["id"])
    @schedule = Schedule.find(@user.schedule_id)
    erb :show_schedule
  end

  post "/signup" do
    user = User.new(:username => params[:username], :password => params[:password])
		if user.save
				redirect to "/login"
		else
				redirect to "/failure"
		end
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
				session[:id] = user.id
				redirect "/success"
		else
				redirect "/failure"
		end
  end

  get "/success" do
    @user = User.find(session[:id])
    if @user.schedule_id != nil
      if logged_in?
        @user = User.find(session[:id])
        erb :account
      else
        redirect "/login"
      end
    else
      redirect "/create"
    end
  end

  get "/edit" do
    @user = User.find(session[:id])
    @schedule = Schedule.find(@user.schedule_id)
    erb :edit
  end

  post "/edit" do
    binding.pry
  end


  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  # helpers doa
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

end
