class AuthUserSerializer < ActiveModel::Serializer
  self.root('user')
  attributes :id, :username, :email
  has_one :profile

  has_many :projects, :key => :owned_project_ids, :embed => :ids
  has_many :project_permissions, :key => :collaborated_project_ids, :embed => :ids
  has_many :friendships, :key => :contact_ids, :embed => :ids
end
