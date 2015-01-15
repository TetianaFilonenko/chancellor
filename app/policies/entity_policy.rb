# Policy to control access to Entities
class EntityPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? && user.has_any_role?(:entity_admin, :entity_user)
  end

  def show?
    super && user.has_any_role?(:entity_admin, :entity_user)
  end

  def create?
    authenticated? && user.has_role?(:entity_admin)
  end

  def update?
    authenticated? && user.has_role?(:entity_admin)
  end

  def destroy?
    authenticated? && user.has_role?(:entity_admin)
  end
end
