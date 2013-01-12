class TimeSession < ActiveRecord::Base
  attr_accessible :end, :start, :user
  belongs_to :task
  belongs_to :user

  validates :task_id, :user_id, :start, presence: true
  validates_datetime :start
  validates_datetime :end, :allow_nil => true, :allow_blank => true

  validates_date :end, :on_or_after => lambda { :start }, :allow_nil => true, :allow_blank => true

end
