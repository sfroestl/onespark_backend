class Api::V1::ProjectCoworkersController < Api::V1::ApiController
  # Basic authentification filter
  before_filter :authenticate_basic

  before_filter :find_project_coworker, only: [:show, :update, :destroy]
  before_filter :find_just_project, only: [:create]
  # Permission filters see PermissionHelper
  before_filter :has_view_project_right?, only: [:show]
  before_filter :has_change_project_coworkers_right?, only: [:create,:destroy,:update]
  respond_to :json

  def show
    render json: @coworker
  end

  def create
    
    new_coworker_raw = params[:project_coworker]
    new_coworker_raw.delete(:project_id)#remove project_id after searching, as it is not mass-assginable
	new_coworker = project.coworkers.build(new_coworker_raw)	
    if new_coworker.save
      render json: new_coworker, status: :created
    else
      render json: { errors: new_coworker.errors.to_json }, :status => :unprocessable_entity
    end
  end

  def update
    if @coworker.update_only_changed_attributes(params[:project_coworker])
      render json: @coworker, status: :ok
    else
      render json: { errors: @coworker.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    ProjectCoworker.destroy(params[:id])
    render json: { message: "ProjectCoworker deleted." }, status: :ok
  end


  private

  def find_project_coworker
    Rails.logger.info "--> find coworker"
    @coworker = ProjectCoworker.find(params[:id],:include => :project)
    @project = @coworker.try(:project)
    !!(@coworker && @project) || not_found
  end
  
  def find_just_project
    Rails.logger.info "--> find project (for adding coworkers)"
    @project = Project.find(params[:project_coworker][:project_id]) 
    !!@project || not_found
  end

end
