class Api::V1::TasksController < Api::V1::ApiController

  # basic authentification filter
  before_filter :authenticate_basic
  before_filter :find_task, only: [:show]

  respond_to :json

  def index
    # Tasks of user
  end

  def show
    render json: @task
  end

  def create
    project = find_project(params[:task][:project_id])
    params[:task][:creator_id] = @auth_user.id
    new_task = project.tasks.build(params[:task])
    Rails.logger.info "**--> Create Task: #{new_task.to_json}"

    if new_task.save
      render json: new_task, status: :created
    else
      render json: { error: new_task.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end

  private

    def find_task
      Rails.logger.info "--> find task"
      @task = Task.find(params[:id])
    end

end
