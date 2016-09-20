class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all.where("id != ?", current_user.id).paginate(page: params[:page])
  end
  
  def promote
    @user = User.find(params[:employee_id])
    @user.supervisor = true
    @user.save
    respond_to do |format|
      format.html { redirect_to action: "index", controller: "users" }
      format.js
    end
  end 
end
