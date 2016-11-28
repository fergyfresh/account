class ProjectsController < ApplicationController
  def index
    @projects = policy_scope(Project)
    @users = User.all.where("supervisor = ?", true)
  end

  def show
    @project = Project.find(params[:id])
    @pm = User.find(@project.user_id)
    @supervisor_ids = Relationship.all.where("supervisor_id = ?", @project.user_id).pluck(:employee_id)
    @supervisors = @supervisor_ids
    @employees = {}
    for supervisor in @supervisor_ids
      @employees[supervisor] = User.all.where("id = ?", Relationship.all.where("supervisor_id = ?", supervisor).pluck(:employee_id))
    end
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
