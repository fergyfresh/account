class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all.where("id != ?", current_user.id).paginate(page: params[:page])
  end
  
  def promote
    @user = current_user
    @users = User.all.where("id != ?", current_user.id).paginate(page: params[:page])
  end  
end
