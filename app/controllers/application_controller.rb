##
# The ApplicationController class
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 21.07.2012

class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper :sessions, :rest_github, :path, :date
  include SessionsHelper, DateHelper, ApplicationHelper
  require "digest"


  before_filter :authenticate

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      # you probably want to guard against a wrong username, and encrypt the
      # password but this is the idea.
      user = User.find_by_username(username)
      if user && user.authenticate(password)
        Rails.logger.info "--> Basic auth: #{username} #{password}"
        @current_user = user
        true
      else
        false
      end
    end
  end
end
