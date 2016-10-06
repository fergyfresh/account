class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:employee_id])
    current_user.hire(@user)
    respond_to do |format|
      format.html { redirect_to action: "index", controller: "users" }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).employee
    current_user.fire(@user)
    respond_to do |format|
      format.html { redirect_to action: "index", controller: "users" }
      format.js
    end
  end
end
