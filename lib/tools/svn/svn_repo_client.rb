##
# The SvnRepoClient class
#
# this is the svn repo client
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 16.01.2013

class SvnRepoClient

  def init_with_model(repo_model)
    @repo_model = repo_model
  end

  def get_repo_info
    Rails.logger.info "--> SVNRepoClient"
    commits = log(@repo_model.url)
  end

  def get_all_commits

  end

  def get_commit(id)

  end

  private

  def log(url, from=1, to=Time.infinity)

    svn = RSCM::Subversion.new(url)

    svn.username ||= "sfr"
    svn.password ||= "sfr4dev"

    revisions = svn.revisions(from, {:to_identifier => to})
    # Rails.logger.info revisions
    revisions
  end
end