class TaskShortSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :title
end
