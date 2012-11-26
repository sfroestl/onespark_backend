##
# The ApiPermissionHelper class
#
# provides methods for handling project permissions
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 10.11.2012

module ApiPermissionHelper

def has_view_project_right?
    Rails.logger.info "--> filter has_view_right?"
    if @project.reader?(@auth_user)
      Rails.logger.info "--> true"
      true
    else
      # See ApiErrorHelper
      Rails.logger.info "--> false"
      forbidden
    end
  end

  # Validates the users DELETE right
  def has_delete_project_right?
    Rails.logger.info "--> filter has_delete_right?"
    if @project.user_id == @auth_user.id
      Rails.logger.info "--> true"
      true
    else
      # See ApiErrorHelper
      Rails.logger.info "--> false"
      forbidden
    end
  end

  # Validates the users UPDATE right
  def has_edit_project_right?
    Rails.logger.info "--> filter has_edit_right?"
    if @project.writer?(@auth_user)
      Rails.logger.info "--> true"
      true
    else
      # See ApiErrorHelper
      Rails.logger.info "--> false"
      forbidden
    end
  end

end
