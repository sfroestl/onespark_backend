class Tools::SvnRepositoriesController < ApplicationController
	# require 'rscm'
	layout 'project'

  before_filter :find_project

  # GET project/:id/tools/svn_repositories
  # GET project/:id/tools/svn_repositories.json
	def index
	end

  # GET project/:id/tools/svn_repositories/1
  # GET project/:id/tools/svn_repositories/1.json
	def show
	end

  # GET project/:id/tools/svn_repositories/new
  # GET project/:id/tools/svn_repositories/new.json
	def new
		@svn_repository = @project.svn_repositories.build
	end

  # POST project/:id/tools/svn_repositories
  # POST project/:id/tools/svn_repositories.json
	def create
		@svn_repository = @project.svn_repositories.create(params[:svn_repository])
		redirect_to project_tasklist_path(@project, @svn_repository), :flash => { :success => 'Tasklist was successfully created.' }
	end

  # DELETE project/:id/tools/svn_repositories/1
  # DELETE project/:id/tools/svn_repositories/1.json
  def destroy
	end

	private

	def find_project
		@project = Project.find(params[:project_id])
	end
end

