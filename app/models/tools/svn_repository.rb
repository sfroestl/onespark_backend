class Tools::SvnRepository < ActiveRecord::Base
  attr_accessible :svn_username, :svn_password, :url

	belongs_to :project

	validates_presence_of :title
	validates_presence_of :url

	def log
	end

end

