class ContactSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :contact_id, :status

  def contact_id
    object.friend_id
  end
end