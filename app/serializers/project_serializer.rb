class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :desc, :due_date, :title

  has_one :user, :key => :owner_id, embed: :ids
  has_many :project_coworkers, :key => :project_coworker_ids, embed: :ids #:serializer => ProjectCoworkerSerializer
  has_many :tasks, :key => :task_ids, embed: :ids # :serializer => TaskShortSerializer

end
