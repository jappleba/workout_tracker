
class UserController < ApplicationController

  get "/users/signup" do
    erb :"users/signup"
  end

  post "/users/signup" do
    user = User.new(:username => params[:username], :password => params[:password])
		if user.save
				redirect to "/users/login"
		else
				redirect to "/users/failure"
		end
  end

  get "/users/login" do
    erb :"users/login"
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
				session[:id] = user.id
				redirect "/users/success"
		else
				redirect "/users/failure"
		end
  end

  get "/users/success" do
    @user = current_user
    if @user.schedule_id != nil
      if logged_in?
        @user = User.find(session[:id])
        erb :"users/account"
      else
        redirect "/users/login"
      end
    else
      redirect "/schedules/new"
    end
  end

  get "/users/failure" do
    erb :"users/failure"
  end

  get "/users/logout" do
    session.clear
    redirect "/"
  end

end
