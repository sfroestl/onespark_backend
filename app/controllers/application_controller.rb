##
# The ApplicationController class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 01.11.2012

class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper :sessions, :rest_github, :path, :date
  include SessionsHelper, DateHelper, ApplicationHelper, PermissionHelper
  require 'digest'



end
