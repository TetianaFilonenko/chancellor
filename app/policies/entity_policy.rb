class EntityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user && user.has_role?(:entity_user)
  end
end
