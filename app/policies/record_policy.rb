class RecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.supervisor?
        scope.where(user: user.employing)
      else
        scope.where(user: user)
      end
    end
  end

  def destroy?
    user.admin? || record.user == user
  end
end
