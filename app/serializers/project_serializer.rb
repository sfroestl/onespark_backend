class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :desc, :due_date, :title

  has_many :coworkers, :key => :contributors, embed: :ids #:serializer => UserShortSerializer
  has_many :tasks, embed: :ids # :serializer => TaskShortSerializer

end