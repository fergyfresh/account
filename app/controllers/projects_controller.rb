class ProjectsController < ApplicationController
  def index
    @projects = policy_scope(Project)
    @users = User.all.where("supervisor = ?", true)
  end
  
  def show
    @supervisors = User.all.where("supervisor = ?", true)
    @users = User.all.where("supervisor = ?", false)
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy
    head :no_content
  end

  private

    def project_params
      params.require(:project).permit(:name, :content, :user_id)
    end
end
