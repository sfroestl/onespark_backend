class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :desc, :due_date, :title

  has_one :user, :key => :owner_id, embed: :ids
  has_many :coworkers, :key => :contributor_ids, embed: :ids #:serializer => UserShortSerializer
  has_many :tasks, :key => :task_ids, embed: :ids # :serializer => TaskShortSerializer

end