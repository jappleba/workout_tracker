require "./config/environment"
require "sinatra/activerecord/rake"

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r ./app/controllers/application_controller.rb"
end
