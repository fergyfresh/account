class RecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.where(user: user.employing) #change to scope.all when supervisor? is created.
      else
        scope.where(user: user)
      end
    end
  end

  def destroy?
    user.admin? || record.user == user
  end
end
