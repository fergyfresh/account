class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def destroy?
    user.admin?
  end
  
  def promote? 
    user.admin? or user.supervisor? 
  end 

end
