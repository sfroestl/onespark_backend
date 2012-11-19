class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :desc, :due_date, :title

  has_many :coworkers, :key => :contributors, :serializer => UserShortSerializer
  has_many :tasks, :serializer => TaskShortSerializer

end