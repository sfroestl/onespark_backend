class UserSerializer < ActiveModel::Serializer
  attributes :id, :username,:email,:contacts
  has_many :projects
  has_one :profile
  def contacts
    []
  end
  def include_email?
	scope == object
  end
  def include_contacts?
	scope == object
  end
  def include_projects?
	scope == object
  end  
end
