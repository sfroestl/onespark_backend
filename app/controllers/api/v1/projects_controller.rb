##
# The Api::V1::ProjectsController Class
#
# Handles all project specific API requests
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class Api::V1::ProjectsController < Api::V1::ApiController
  # basic authentification filter
  before_filter :authenticate_basic

  before_filter :find_project, only: [:show, :update, :destroy]
  # permission filters see PermissionHelper
  before_filter :has_delete_right?, only: [:destroy]
  before_filter :has_view_right?, only: [:show]
  before_filter :has_edit_right?, only: [:update]

  respond_to :json

  def index
    respond_with projects_to_simple_dto(Project.by_user(@auth_user))
  end

  def show
    respond_with ProjectDTO.new(@project)
  end

  def create
    new_project = @auth_user.projects.build(params[:project])

    if new_project.save
      project_dto = ProjectDTO.new(new_project)
      render json: project_dto, status: :created
    else
      render json: { error: new_project.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    if @project.update_attributes(params[:project])
      render json: ProjectDTO.new(@project), status: :ok
    else
      render json: { errors: @project.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    Project.destroy(params[:id])
    render json: { message: "Project deleted." }, status: :ok
  end


  private

  def find_project
    Rails.logger.info "--> find project"
    @project = Project.find(params[:id])
  end

  # returns all owned projects of a user
  def get_owned_projects_of (user)
    @projects = Project.by_user(user) unless user.nil?
  end

  # returns all collaborated projects of a user
  def get_collab_projects_of (user)
    @collab_projects = user.project_permissions unless user.nil?
  end

end