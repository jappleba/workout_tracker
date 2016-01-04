require 'bundler'
Bundler.require

configure :development do
	set :database, {adapter: "sqlite3", database: "db/database.sqlite3"}
end

require_all './app/models'
require_all './app/controllers'

require 'open-uri'
require "pry"
