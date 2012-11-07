##
# The Api::V1::ProjectsController Class
#
# Handles all project specific API requests
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Editor:: Sebastian Fröstl
# Last Edit:: 26.10.2012


class Api::V1::ProjectsController < ApplicationController
  # RecordNotFound Exception rescue
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # basic authentification
  before_filter :authenticate_basic
  before_filter :find_project, only: [:show, :update, :destroy]
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
    user = @auth_user
    new_project = user.projects.build(params[:project])

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

  def has_view_right?
    Rails.logger.info "--> filter has_view_right?"
    if @project.reader?(@auth_user)
      true
    else
      forbidden
    end
  end

  # Validates the users DELETE right
  def has_delete_right?
    Rails.logger.info "--> filter has_delete_right?"
    if @project.user_id == @auth_user.id
      true
    else
      forbidden
    end
  end

  # Validates the users UPDATE right
  def has_edit_right?
    Rails.logger.info "--> filter has_edit_right?"
    if @project.writer?(@auth_user)
      true
    else
      forbidden
    end
  end

  # returns all owned projects of a user
  def get_owned_projects_of (user)
    @projects = Project.by_user(user) unless user.nil?
  end

  # returns all collaborated projects of a user
  def get_collab_projects_of (user)
    @collab_projects = user.project_permissions unless user.nil?
  end

  def forbidden
    render :json =>  { :error => "Not allowed!" }, :status => :forbidden
  end

  # RecordNotFound Exception handling return method
  def record_not_found(exception)
    Rails.logger.error ">>> Error in Api::V1::ProjectsController: Not Found: #{exception.message}"
    render :json => { :error => exception.message }, :status => :not_found
  end
end