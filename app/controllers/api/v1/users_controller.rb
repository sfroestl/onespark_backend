##
# The Api::V1::UsersController class
#
# Handles all user specific API requests
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class Api::V1::UsersController < Api::V1::ApiController
  # basic authentification filter
  before_filter :authenticate_basic, except: [:create]

  before_filter :find_user, only: [:show]

  respond_to :json

  def show
    render json: @user
  end

  # Creates a new user and returns it
  # In case of error, returns 422 error details
  def create
    user = User.new(params[:user])
    if user.save
      user.create_profile
      render json: user, status: :created
    else
      render json: { errors: user.errors }, :status => :unprocessable_entity
    end

  end

  def show_auth_user
    render json: @auth_user, :serializer => AuthUserSerializer
  end

  def update
    params[:user].delete(:profile_id)
    if @auth_user.update_only_changed_attributes(params[:user])
      render json: @auth_user, :serializer => AuthUserSerializer, status: :ok
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
      @user ||= User.find(params[:id])
    end
end
