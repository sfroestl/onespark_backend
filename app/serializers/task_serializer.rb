class TaskSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :title

  has_many :comments
  has_one :creator
  has_one :worker

end