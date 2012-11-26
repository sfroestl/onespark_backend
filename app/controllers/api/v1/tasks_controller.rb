class Api::V1::TasksController < Api::V1::ApiController

  # Basic authentification filter
  before_filter :authenticate_basic
  before_filter :find_task, only: [:show, :update, :destroy]
  before_filter :find_project

  # Permission filters see PermissionHelper
  # before_filter :has_delete_task_right?, only: [:destroy]
  # before_filter :has_view_task_right?, only: [:show]
  # before_filter :has_edit_task_right?, only: [:update]

  respond_to :json

  def index
    # Tasks of user
  end

  def show
    render json: @task
  end

  def create
    new_task = @project.tasks.build(params[:task])
    new_task.creator = @auth_user

    # set incompleted
    params[:task][:completed] = false

    if new_task.save
      render json: new_task, status: :created
    else
      render json: { error: new_task.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    if params[:task][:worker_id]
      worker = User.find(params[:task][:worker_id])
      params[:task][:worker] = worker unless worker
    end

    if @task.update_attributes(params[:task])
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    Task.destroy(params[:id])
    render json: { message: "Task deleted." }, status: :ok
  end


  private

    def find_task
      Rails.logger.info "--> find task"
      @task = Task.find(params[:id])
    end

    def find_project
      Rails.logger.info "--> find project"
      if @task
        @project = Project.find(@task.project_id)
      else
        @project = Project.find(params[:task][:project_id])
      end
    end

end
