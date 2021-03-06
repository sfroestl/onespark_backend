##
# The ProjectCoworker Model class
#
# the association table for project-user association
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 21.07.2012


class ProjectCoworker < ActiveRecord::Base
  attr_accessible :user_id, :permission
  belongs_to :project
  belongs_to :user

  validates :project_id, presence: true
  validates :user_id, presence: true
  validates :permission, presence: true, :inclusion => { :in => [0, 1, 2, 3] }
  validates_uniqueness_of :user_id, :scope => :project_id, :message => "Already in this project."
  validates_exclusion_of :user_id, :in =>  lambda{|x| [ x.project.user_id]  },:if => lambda{|x| x.project}, :message => "Can't be a coworker of own project."
  
  default_scope :order => 'created_at DESC'

  def self.exists?(project, user)
    not find_by_project_id_and_user_id(project.id, user.id).nil?
  end

  # def self.find_by_project_id_and_user_id(project, user)
  # 	ProjectCoworker.find_by_project_id_and_user_id(project.id, user.id)
  # end

  def self.by_project(project)
    where(:project_id => project.id)
  end
end

