class TaskSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :title

  has_many :comments, embed: :ids
  has_one :creator, embed: :ids
  has_one :worker, embed: :ids

end