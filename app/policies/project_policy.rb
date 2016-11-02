class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user.jobs | user.projects)
      end
    end
  end

  def destroy?
    user.admin? || record.user == user
  end
end
