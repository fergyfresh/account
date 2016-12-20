class RelationshipsController < ApplicationController
  def create
    @relationship = Relationship.new(supervisor_id: params[:supervisor_id], employee_id: params[:employee_id], project_id: params[:project_id])
    @employee = User.find(params[:employee_id])
    if @relationship.save
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @supervisor = User.find(params[:supervisor_id])
    @employee = User.find(params[:employee_id])
    @supervisor.fire(@employee, params[:project_id])
    render json: @employee
  end
end
