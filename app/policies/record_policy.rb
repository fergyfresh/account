class RecordPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
end
