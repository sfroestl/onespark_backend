##
# The Api::V1::ProfilesController Class
#
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 11.11.2012


class Api::V1::ProfilesController < Api::V1::ApiController
  # basic authentification filter
  before_filter :authenticate_basic, except: [:create]
  before_filter :find_profile, only: [:show, :update]
  # be sure to find the profile before the right-filters
  # before_filter :has_view_profile_right?, only: [:show]
  before_filter :has_update_profile_right?, only: [:update]

  respond_to :json

  def update_with_user
     if @auth_user.profile.update_only_changed_attributes(params[:profile])
      render json: @auth_user, :serializer => AuthUserSerializer, status: :ok
    else
      render json: { errors: @auth_user.profile.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @profile.user.id == @auth_user.id
      if @auth_user.profile.update_only_changed_attributes(params[:profile])
        render json: @auth_user.profile, :serializer => ProfileSerializer, status: :ok
      else
        render json: { errors: @auth_user.profile.errors }, status: :unprocessable_entity
      end
    else
      forbidden
    end
  end

  def show
    render json: @profile, status: :ok
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end


end