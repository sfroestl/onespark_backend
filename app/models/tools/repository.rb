class Tools::Repository < ActiveRecord::Base
  attr_accessible :repo_type, :title, :url, :project_id

  belongs_to :project

  validates :project_id, presence: true
end
