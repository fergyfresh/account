class RelationshipPolicy < ApplicationPolicy
  class Scope < Scope
    def create
      user.admin
    end
  end

  def destroy?
    user.admin?
  end
end
