class TaskSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :title, :desc, :project_id, :completed, :completed_at, :completed_by, :estimated_hours, :worked_hours

  has_many :comments, :key => :comment_ids, embed: :ids
  has_one :creator, :key => :creator_id, embed: :ids
  has_one :worker, :key => :worker_id, embed: :ids
  has_many :time_sessions, :key => :time_session_ids, embed: :ids
  has_many :open_time_sessions, :key => :open_time_session_ids, embed: :ids

  def open_time_sessions
    object.time_sessions.uncompleted
  end
end