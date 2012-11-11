##
# The ApiErrorHelper class
#
# provides methods for handling project permissions
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 10.11.2012

module ApiErrorHelper

  # Returns the forbidden error message as json
  def forbidden
    render :json =>  { :error => "Not allowed!" }, :status => :forbidden
  end

  # Returns RecordNotFound Exception handling
  def record_not_found(exception)
    Rails.logger.error ">>> Error in Api::V1::ProjectsController: Not Found: #{exception.message}"
    render :json => { :error => exception.message }, :status => :not_found
  end
end
