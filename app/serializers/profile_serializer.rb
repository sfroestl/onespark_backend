class ProfileSerializer < ActiveModel::Serializer
  attributes :forename, :surname, :city, :about, :avatar_url
end
