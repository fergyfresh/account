class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        user.jobs
      end
    end
  end

  def destroy?
    user.admin?
  end
end
