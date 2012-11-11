##
# The ApiPermissionHelper class
#
# provides methods for handling project permissions
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 10.11.2012

module ApiPermissionHelper

def has_view_right?
    Rails.logger.info "--> filter has_view_right?"
    if @project.reader?(@auth_user)
      true
    else
      # See ApiErrorHelper
      forbidden
    end
  end

  # Validates the users DELETE right
  def has_delete_right?
    Rails.logger.info "--> filter has_delete_right?"
    if @project.user_id == @auth_user.id
      true
    else
      # See ApiErrorHelper
      forbidden
    end
  end

  # Validates the users UPDATE right
  def has_edit_right?
    Rails.logger.info "--> filter has_edit_right?"
    if @project.writer?(@auth_user)
      true
    else
      # See ApiErrorHelper
      forbidden
    end
  end

end
