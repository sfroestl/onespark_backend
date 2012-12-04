class Api::V1::TasksController < Api::V1::ApiController

  # Basic authentification filter
  before_filter :authenticate_basic
  before_filter :find_just_project, only: [:create]
  before_filter :find_project_and_task, except: [:create, :index]

  # Permission filters see ApiPermissionHelper
  before_filter :has_change_task_right?, only: [:update, :destroy]
  before_filter :has_view_project_right?, only: [:show, :index]
  before_filter :has_edit_project_right?, only: [:create]

  respond_to :json

  def index
    if params[:ids]
      Rails.logger.info "--> TasksController#index with ids query: #{params[:ids]}"
      ids = params[:ids].split(',')
      render json: Task.find(ids), :each_serializer => TaskSerializer
    else
      render json: Task.find_all_by_worker_id(@auth_user.id), :each_serializer => TaskSerializer
    end
  end

  def show
    render json: @task
  end

  def create
    new_task = @project.tasks.build(params[:task])
    new_task.creator = @auth_user

    if new_task.save
      render json: new_task, status: :created
    else
      render json: { error: new_task.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    # checks if worker is valid
    if params[:task][:worker_id]
      worker = User.find(params[:task][:worker_id])
      params[:task][:worker] = worker unless worker
    end

    # if completed, set date and user
    if params[:task][:completed].eql? "true"
      Rails.logger.info"--> TasksController:update >> Task completed!"
      params[:task][:completed_at] = Time.now
      params[:task][:completed_by] = @auth_user.id
    elsif params[:task][:completed].eql? "false"
      params[:task][:completed_at] = nil
      params[:task][:completed_by] = nil
    end

    if @task.update_only_changed_attributes(params[:task])
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with Task.destroy(params[:id])
  end


  private

  def find_just_project
    Rails.logger.info "--> TasksController: find_just_project"
    @project = Project.find(params[:task][:project_id])
  end

  def find_project_and_task
    Rails.logger.info "--> TasksController: find_project_and_task"
    @task = Task.find(params[:id], :include => :project)
    @project = @task.try(:project)
    !!(@task && @project) || not_found  # See ApiErrorHelper
  end

end
