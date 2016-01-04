require './config/environment'
# require './app/controllers/application_controller'
# require './app/controllers/schedule_controller'
# require './app/controllers/user_controller'

use ApplicationController
use ScheduleController
run UserController
