class AuthUserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email

  has_many :projects, :key => :owned_projects, :embed => :ids
  has_many :project_permissions, :key => :collaborated_projects, :embed => :ids
  has_one :profile

  has_many :friends, :key => :contacts, :embed => :ids #, :serializer => UserShortSerializer
end
