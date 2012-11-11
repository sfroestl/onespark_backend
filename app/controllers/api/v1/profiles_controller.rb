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

  respond_to :json

  def update
     if @auth_user.profile.update_attributes(params[:profile])
      render json: user_to_dto(@auth_user), status: :ok
    else
      render json: { errors: @auth_user.profile.errors}, status: :unprocessable_entity
    end
  end

end