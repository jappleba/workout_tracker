class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end
#HELPER METHODS
  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id])
  end

  def current_schedule
    Schedule.find(current_user.schedule_id)
  end

end
