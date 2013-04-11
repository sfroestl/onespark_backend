class Api::V1::Tools::RepositoriesController < Api::V1::ApiController
  require 'tools/github/github_repo_client'
  require 'tools/svn/svn_repo_client'

  before_filter :find_project_and_repository, only: [:show, :destroy]
  # before_filter :has_view_project_right?
  before_filter :init_repo_client

  respond_to :json

  def index
  end

  def show
    repo_info = @client.get_repo_info
    commits = @client.get_all_commits
    Rails.logger.info "INFO"
    repo = RepositorySerializer.new(@repo_model)
    render json: {repo: repo, info: repo_info, commits:commits.count }
  end

  def create
  end

  def destroy
  end

  private

  def find_project_and_repository
    Rails.logger.info "--> RepositoriesController: find_project_and_repository"
    @repo_model = Tools::Repository.find(params[:id], :include => :project)
    @project = @repo_model.project
    Rails.logger.info "--> #{@project.id}"
    # !!(@repo_model && @project) || not_found  # See ApiErrorHelper
  end

  def init_repo_client
    case @repo_model.repo_type
      when "github"
        @client = GithubRepoClient.new
        @client.init_with_model(@repo_model)
      when "svn"
        @client = SvnRepoClient.new
        @client.init_with_model(@repo_model)
    end
  end
end
