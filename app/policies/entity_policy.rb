# Policy to control access to Entities
class EntityPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user && user.role?(:entity_admin, :entity_user)
  end

  def show?
    super && user && user.role?(:entity_admin, :entity_user)
  end

  def create?
    user && user.role?(:entity_admin)
  end

  def update?
    user && user.role?(:entity_admin)
  end

  def destroy?
    user && user.role?(:entity_admin)
  end
end
