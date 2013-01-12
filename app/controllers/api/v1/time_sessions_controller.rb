class Api::V1::TimeSessionsController < Api::V1::ApiController

  # Basic authentification filter
  before_filter :authenticate_basic
  before_filter :find_task, only: [:create]
  before_filter :find_time_session, except: [:create, :index]

  respond_to :json

  def index
    if params[:ids]
      ids = params[:ids].split(',')
      time_session_list = TimeSession.find(ids)
      time_sessions = time_session_list.find_all { |time_session| time_session.task.project.reader?(@auth_user) }
      render json: time_sessions, :each_serializer => TimeSessionSerializer
    else
      render json: TimeSession.find_all_by_user_id(@auth_user.id), :each_serializer => TimeSessionSerializer
    end
  end

  def show
    render json: @time_session
  end

  def create
    new_time_session = @task.time_sessions.build(params[:time_session])
    new_time_session.user = @auth_user

    if new_time_session.save
      render json: new_time_session, status: :created
    else
      render json: { error: new_time_session.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    if @time_session.update_only_changed_attributes(params[:time_session])
      render json: @time_session, status: :ok
    else
      render json: { errors: @time_session.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    respond_with TimeSession.destroy(params[:id])
  end

  private

  def find_task
    @task = Task.find(params[:time_session][:task_id])
    params[:time_session].delete :task_id
  end

  def find_time_session
    @time_session = TimeSession.find(params[:id])
  end
end
