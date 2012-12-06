class Tools::SvnRepository < ActiveRecord::Base
	require 'rscm', 'uri'
  attr_accessible :url, :title, :svn_username, :svn_password # rails accessor for DB columns

	belongs_to :project

	validates_presence_of :title
	validates :url, 
		:uri => { :schemes => [:svn, :http, :https] }, 
		:presence => true

	def log(from=Time.new.utc, to=Time.infinity)
		# from	= Time.utc(...) or revision number
		# to		= Time.utc(...) or revision number
		#@return RSCM::Revisions, http://rscm.rubyforge.org/
		
		# SVN username AND password are required or none of them
		if self.svn_username and not self.svn_password
			#raise NoSvnPassword
			#raise ArgumentError
		elsif not self.svn_username and self.svn_password
			#raise NoSvnUsername
			#raise ArgumentError
		end

		svn = RSCM::Subversion.new(self.url)

		svn.username = self.svn_username if self.svn_username
		svn.password = self.svn_password if self.svn_password

		revisions = svn.revisions(from, {:to_identifier => to})
	end

end
