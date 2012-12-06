class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
  has_one :profile, key: :profile_id, embed: :ids

  # Only authorized user properties
  has_many :projects, :key => :owned_project_ids, :embed => :ids
  has_many :project_permissions, :key => :collaborated_project_ids, :embed => :ids
  has_many :project_coworkers, :key => :project_coworker_ids, :embed => :ids
  has_many :friends, :key => :contact_ids, :embed => :ids #, :serializer => UserShortSerializer

  # Scope for authorized properties
  def include_projects?
    scope == object
  end

  def include_projects?
    scope == object
  end

  def include_project_permissions?
    scope == object
  end
  def include_project_coworkers?
    scope == object
  end
  
  def include_friends?
    scope == object
  end
end
