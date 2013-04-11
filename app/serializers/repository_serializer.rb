class RepositorySerializer < ActiveModel::Serializer
  attributes :title, :url, :project_id
end