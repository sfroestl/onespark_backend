##
# The Api::V1::UsersController class
#
# Handles all user specific API requests
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # basic authentification
  before_filter :authenticate_basic, except: [:create]
  before_filter :find_user, only: [:show]

  respond_to :json

  def show
    if @user
      workmates =  users_to_workmates_dto(@user.friends)

      user_dto = UserSimpleDTO.new(@user.username, @user.email, workmates)
      Rails.logger.info ">> UserSimpleDTO #{user_dto.email} #{user_dto.username} "

    end
    respond_with user_dto
  end

  # Creates a new user and returns it
  # In case of error, returns 422 error details
  def create
    user = User.new(params[:user])
    if user.save
      user_dto = UserDTO.new(user.username, user.email)
      render json: user_dto, status: :created
    else
      render json: { errors: user.errors }, :status => :unprocessable_entity
    end

  end

  def show_auth_user
    respond_with user_to_user_dto(@auth_user)
  end

  def update_auth_user
    if @auth_user.update_attributes(params[:user])
      render json: user_to_user_dto(@auth_user), status: :ok
    else
      render json: { errors: @auth_user.errors}, status: :unprocessable_entity
    end
  end

  def destroy_auth_user
    user = @auth_user
    if user
      respond_with User.destroy(user.id)
    end
  end


  private

    def find_user
      @user = User.find_by_username(params[:id])
    end

    # RecordNotFound Exception handling return method
    def record_not_found(exception)
      Rails.logger.error ">>> Error in Api::V1::ProjectsController: Not Found: #{exception.message}"
      render :json => { :error => exception.message }, :status => :not_found
    end
end