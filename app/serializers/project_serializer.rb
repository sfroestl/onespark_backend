class ProjectSerializer < ActiveModel::Serializer
  attributes :id,:desc, :due_date, :title
  
end
