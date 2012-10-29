class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  before_filter :authenticate_basic, except: [:create]

  respond_to :json

  def show
    user = User.find_by_username(params[:id])
    if user
      workmates =  users_to_workmates_dto(user.friends)

      user_dto = UserSimpleDTO.new(user.username, user.email, workmates)
      Rails.logger.info ">> UserSimpleDTO #{user_dto.email} #{user_dto.username} "

    end
    respond_with user_dto
  end

  def show_auth_user
    user = @auth_user

    # Array for ProjectSimpleDTOs
    project_list = projects_to_simple_dto(user.projects)
    workmates =  users_to_workmates_dto(user.friends)

    user_dto = UserDTO.new(user.username, user.email, project_list, workmates)
    Rails.logger.info ">> UserDTO #{user_dto.email} #{user_dto.username} "

    respond_with user_dto

  end

  def create
    respond_with User.create(params[:user])
  end

  def update_auth_user
    user = @auth_user
    if user
      respond_with User.update(@auth_user.id, params[:user])
    end
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  private

  def record_not_found
    render :json => {:error => error.message}, :status => :not_found
  end
end