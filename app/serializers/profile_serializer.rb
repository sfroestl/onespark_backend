class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :forename, :surname, :city, :about, :avatar_url, :user_id
end
