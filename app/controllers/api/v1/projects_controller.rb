class Api::V1::ProjectsController < ApplicationController

  before_filter :authenticate_basic

  respond_to :json

  def index
    respond_with Project.all
  end

  def show
    respond_with Project.find(params[:id])
  end

  def create
    Rails.logger.info ">>> API Projects controller: CREATE #{params[:project]} for #{params[:username]}"
    user = User.find_by_username(params[:username])

    respond_with user.projects.build(params[:project])
  end

  def update
    respond_with Project.update(params[:id], params[:project])
  end

  def destroy
    respond_with Project.destroy(params[:id])
  end

end