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
        # you probably want to guard against a wrong username, and encrypt the
        # password but this is the idea.
        user = User.find_by_username(username)
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
end
