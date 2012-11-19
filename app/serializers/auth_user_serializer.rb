class AuthUserSerializer < ActiveModel::Serializer
  attributes :username, :email

  has_many :projects, :serializer => ProjectShortSerializer
  has_one :profile

  has_many :friends, :key => :contacts, :serializer => UserSerializer

end
