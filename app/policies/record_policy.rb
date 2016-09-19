class RecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all #change to scope.all when supervisor? is created.
      else
        scope.where(user: user.employing)
      end
    end
  end

  def destroy?
    user.admin? || record.user == user
  end
end
