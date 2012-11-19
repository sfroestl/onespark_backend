class UserSerializer < ActiveModel::Serializer
  attributes :username, :email
  has_one :profile


end
