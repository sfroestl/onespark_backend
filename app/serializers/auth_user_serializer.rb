class AuthUserSerializer < ActiveModel::Serializer
  attributes :username, :email

  has_many :projects
  has_one :profile

  has_many :friends, :key => :contacts, :serializer => UserShortSerializer
end
