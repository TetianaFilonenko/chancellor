# Policy to control access to Entities
class EntityPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? && user.has_any_role?(:entity_write, :entity_read)
  end

  def show?
    super && user.has_any_role?(:entity_write, :entity_read)
  end

  def create?
    authenticated? && user.has_role?(:entity_write)
  end

  def update?
    authenticated? && user.has_role?(:entity_write)
  end

  def destroy?
    authenticated? && user.has_role?(:entity_write)
  end
end
