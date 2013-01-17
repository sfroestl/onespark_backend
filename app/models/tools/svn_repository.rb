class Tools::SvnRepository < ActiveRecord::Base
	require 'rscm'
	require 'uri'
  attr_accessible :url, :title, :svn_username, :svn_password # rails accessor for DB columns

	belongs_to :project

	validates :title,
		:presence => true
	validates :url,
		:presence => true,
		:uri => { :schemes => [:svn, :http, :https] }

	# from	= Time.utc(...) or revision number
	# to		= Time.utc(...) or revision number
	#@return RSCM::Revisions, http://rscm.rubyforge.org/
	def log(from=Time.new.utc, to=Time.infinity)

		svn = RSCM::Subversion.new(self.url)

		svn.username = self.svn_username if self.svn_username
		svn.password = self.svn_password if self.svn_password

		revisions = svn.revisions(from, {:to_identifier => to})
	end

end
