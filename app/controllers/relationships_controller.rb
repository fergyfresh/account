class RelationshipsController < ApplicationController
  def create
    @supervisor = User.find(params[:supervisor_id])
    @employee = User.find(params[:employee_id])
    @supervisor.hire(@employee, params[:project_id])
    render json: @employee
  end

  def destroy
    @supervisor = User.find(params[:supervisor_id])
    @employee = User.find(params[:employee_id])
    @supervisor.fire(@employee, , params[:project_id])
    render json: @employee
  end
end
