##
# The Api::V1::ContactsController Class
#
# This adopts the functionality of "friendships" -> see FriendshipsController
#
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 10.12.2012

class Api::V1::ContactsController < Api::V1::ApiController
  # Basic authentification filter
  before_filter :authenticate_basic

  # before_filter :find_friendships

  respond_to :json

  def index
    if params[:ids]
      ids = params[:ids].split(',')
      render json: @auth_user.friendships.find(ids), each_serializer: ContactSerializer
    else
      render json: @auth_user.friendships, each_serializer: ContactSerializer
    end
  end

  def show
    render json: @auth_user.friendships.find(params[:id]), serializer: ContactSerializer
  end

  def create
    new_contact_raw = params[:contact]
    req_user = User.find(new_contact_raw[:contact_id])
    if Friendship.exists?(@auth_user, req_user)
      render json: { error: "already requested this user" }, :status => :unprocessable_entity
    elsif contact = Friendship.request(@auth_user, req_user)
      render json: contact, status: :created, serializer: ContactSerializer
    else
      render json: { errors: contact.errors.to_json }, :status => :unprocessable_entity
    end
  end

 # This update method is used for accepting a contact-request (friendship-request)
  def update
    new_contact_raw = params[:contact]
    if new_contact_raw[:status] == "accepted"
      Friendship.accept(@auth_user, new_contact_raw[:contact_id])
      render json: acc_contact = Friendship.find_by_user_id_and_friend_id(@auth_user.id, new_contact_raw[:contact_id]) , serializer: ContactSerializer
    end
  end

  def destroy
    Rails.logger.info "BREAKUP #{params[:id]}"
    contact = Friendship.find_by_id(params[:id])
    respond_with  Friendship.breakup(@auth_user, contact.friend_id)
  end


end
