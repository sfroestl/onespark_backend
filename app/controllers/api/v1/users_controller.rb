class Api::V1::UsersController < ApplicationController

  # before_filter :authenticate_basic, except: [:create]

  respond_to :json

  def show
    user = User.find_by_username(params[:id])

    user_dto = UserSimpleDTO.new(user.username, user.email, user.friends)
    Rails.logger.info ">> UserSimpleDTO #{user_dto.email} #{user_dto.username} "
    respond_with user_dto

  end

  def show_auth_user
    user = User.find_by_username(params[:id])

    project_list = []

    user.projects.each do |project|
      project_dto = ProjectSimpleDTO.new(project)
      project_list << project_dto
    end

    user_dto = UserDTO.new(user.username, user.email, project_list, user.friends)
    Rails.logger.info ">> UserDTO #{user_dto.email} #{user_dto.username} "
    respond_with user_dto

  end

  def create
    respond_with User.create(params[:user])
  end

  def update
    respond_with User.update(params[:id], params[:user])
  end

  def destroy
    respond_with User.destroy(params[:id])
  end
end