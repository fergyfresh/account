class UsersController < ApplicationController
  def index
    @users = policy_scope(User).paginate(page: params[:page])
  end
end
