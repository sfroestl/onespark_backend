##
# The PermissionHelper class
#
# provides methods for handling project permissions
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 10.11.2012

module PermissionHelper

  def has_view_right?
    Rails.logger.info "--> filter has_view_right?"
    if @project.reader?(current_user)
      true
    else
      render 'public/403', layout: nil
    end
  end

  # Validates the users DELETE right
  def has_delete_right?
    Rails.logger.info "--> filter has_delete_right?"
    if @project.user_id == @current_user.id
      true
    else
      render 'public/403', layout: nil
    end
  end

  # Validates the users UPDATE right
  def has_edit_right?
    Rails.logger.info "--> filter has_edit_right?"
    if @project.writer?(current_user)
      true
    else
      render 'public/403', layout: nil
    end
  end

end