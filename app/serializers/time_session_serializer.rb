class TimeSessionSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :task_id, :user_id
end