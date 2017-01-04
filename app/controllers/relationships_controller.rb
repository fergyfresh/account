class RelationshipsController < ApplicationController
  def create
    if current_user.admin? or current_user.id == Project.find(params[:project_id]).user_id
      @relationship = Relationship.new(supervisor_id: params[:supervisor_id], employee_id: params[:employee_id], project_id: params[:project_id])
      @employee = User.find(params[:employee_id])
      if @relationship.save
        render json: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if current_user.admin? or current_user.id == Project.find(params[:project_id]).user_id
      @relationship = Relationship.where(supervisor_id: params[:supervisor_id], employee_id: params[:employee_id], project_id: params[:project_id]).delete_all
      @employee = User.find(params[:employee_id])
      if @relationship
        render json: @employee
      else
        render json: @employee.errors, status: :unprocessable_entity
      end
    end
  end
end
