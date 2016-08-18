class RecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def destroy?
    user.admin? || record.user == user
  end
end
