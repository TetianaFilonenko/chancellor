class EntityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user && user.has_role?(:entity_admin, :entity_user)
  end

  def show?
    super && user && user.has_role?(:entity_admin, :entity_user)
  end

  def create?
    user && user.has_role?(:entity_admin)
  end

  def update?
    user && user.has_role?(:entity_admin)
  end

  def destroy?
    user && user.has_role?(:entity_admin)
  end
end
