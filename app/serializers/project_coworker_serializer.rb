class ProjectCoworkerSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :project_id, :permission
end
