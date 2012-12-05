##
# The Api::V1::ProjectsController Class
#
# Handles all project specific API requests
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class Api::V1::ProjectsController < Api::V1::ApiController
  # Basic authentification filter
  before_filter :authenticate_basic

  before_filter :find_project, only: [:show, :update, :destroy]
  # Permission filters see ApiPermissionHelper
  before_filter :has_delete_project_right?, only: [:destroy]
  before_filter :has_view_project_right?, only: [:show]
  before_filter :has_edit_project_right?, only: [:update]

  respond_to :json

  def index
    if params[:ids]
      Rails.logger.info "--> ProjectsController#index with ids query: #{params[:ids]}"
      ids = params[:ids].split(',')
      render json: Project.find(ids), :each_serializer => ProjectSerializer
    else
      render json: Project.by_user(@auth_user), :each_serializer => ProjectSerializer
    end
  end

  def show
    render json: @project
  end

  def create
    new_project = @auth_user.projects.build(params[:project])

    if new_project.save
      render json: new_project, status: :created
    else
      render json: { error: new_project.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    if @project.update_only_changed_attributes(params[:project])
      render json: @project, status: :ok
    else
      render json: { errors: @project.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with Project.destroy(params[:id])
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
