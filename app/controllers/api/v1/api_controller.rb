##
# The Api::V1::ApiController Class
#
# Basic abstract API Controller
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 10.11.2012


class Api::V1::ApiController < ApplicationController
  include SessionsHelper, DateHelper, ApplicationHelper, ApiHelper, ApiPermissionHelper, ApiErrorHelper

  # rescues the RecordNotFound Error with method "record_not_found" in ApiErrorHelper
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found



  protected
    # basic authentification method
    def authenticate_basic
      Rails.logger.info ">> ApiController: Authenticate filter for Basic Auth"
      authenticate_or_request_with_http_basic do |username, password|
        # Finds the user by username and checks authentication
        user = User.find_by_username(username.downcase)
        if user && user.authenticate(password)
          Rails.logger.info "--> Request: #{request.method} #{request.url}"
          Rails.logger.info "--> Basic auth params: #{username}"
          @auth_user = user
          true
        else
          false
        end
      end
    end

    def current_user
      @auth_user
    end
end
