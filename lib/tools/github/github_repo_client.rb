##
# The SvnRepoClient class
#
# this is the github repo client
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 16.01.2013

class GithubRepoClient
require 'tools/github/github_api'

  def init_with_model(repo_model)
    @repo_model = repo_model
  end

  def get_repo_info
    Rails.logger.info "--> GithubRepoClient"
    split_parts = @repo_model.url.split('/')
    repo_name = split_parts[-1].split('.')[0]
    owner_name = split_parts[-2]
    Rails.logger.info "--> GithubRepoClient: repo #{repo_name} owner: #{owner_name}"
    github_api = GitHubApi.new
    github_api.repos.get(owner_name, repo_name)
  end

  def get_all_commits

  end

  def get_commit(id)

  end

end