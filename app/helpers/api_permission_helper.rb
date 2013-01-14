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
      Rails.logger.info "--> false"
      forbidden # See ApiErrorHelper
    end
  end

  # Validates the users DELETE right
  def has_delete_project_right?
    Rails.logger.info "--> filter has_delete_right?"
    if @project.user_id == @auth_user.id
      Rails.logger.info "--> true"
      true
    else
      Rails.logger.info "--> false"
      forbidden # See ApiErrorHelper
    end
  end

  # Validates the users UPDATE right
  def has_edit_project_right?
    Rails.logger.info "--> filter has_edit_right?"
    if @project.writer?(@auth_user)
      Rails.logger.info "--> true"
      true
    else
      Rails.logger.info "--> false"
      forbidden # See ApiErrorHelper
    end
  end


  def has_change_project_coworkers_right?
    Rails.logger.info "--> filter has_change_project_coworkers_right?"
    if @project.admin?(@auth_user)
      Rails.logger.info "--> true"
      true
    else
      Rails.logger.info "--> false"
      forbidden # See ApiErrorHelper
    end
  end

  def has_change_task_right?
    Rails.logger.info "--> filter has_change_task_right?"
    if @project.admin?(@auth_user)
      # user is admin
      Rails.logger.info "--> true (User is admin)"
      true
    elsif @project.writer?(@auth_user) && @task.worker == @auth_user
      # user is writer and worker of task
      Rails.logger.info "--> true (User is writer & worker)"
      true
    else
      Rails.logger.info "--> false"
      forbidden("you do not have the permission to perform this action") # See ApiErrorHelper
    end
  end

  # Validates the users view profile right
  def has_view_profile_right?
    Rails.logger.info "--> filter has_view_profile_right?"
    if @profile.user.friends.include?(current_user) || @profile == @auth_user.profile
      true
    else
      Rails.logger.info "--> false"
      forbidden("you can only view your and your contacts profiles") # See ApiErrorHelper
    end
  end

  # Validates the users update profile right
  def has_update_profile_right?
    Rails.logger.info "--> filter has_update_profile_right?"
    if @profile == @auth_user.profile
      true
    else
      Rails.logger.info "--> false"
      forbidden("you can only update your own profile") # See ApiErrorHelper
    end
  end

  # Validates the users view user right
  def has_view_user_right?
    Rails.logger.info "--> filter has_view_user_right?"
    return true if @user == @auth_user
    if @user.friends.include?(current_user)
      true
    else
      Rails.logger.info "--> false"
      forbidden("you can only view your and your contacts profiles") # See ApiErrorHelper
    end
  end

  # Validates the users view user right
  def has_update_user_right?
    Rails.logger.info "--> filter has_update_user_right?"
    if @user == current_user
      true
    else
      Rails.logger.info "--> false"
      forbidden("you can only update your own account") # See ApiErrorHelper
    end
  end

  # Validates the users view user right
  def has_delete_user_right?
    Rails.logger.info "--> filter has_delete_user_right?"
    if @user == current_user
      true
    else
      Rails.logger.info "--> false"
      forbidden("you can only update your own account") # See ApiErrorHelper
    end
  end
end
