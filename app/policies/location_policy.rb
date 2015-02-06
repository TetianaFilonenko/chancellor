# Policy to control access to Locations
class LocationPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? &&
      user.has_any_role?(:location_write, :entity_read)
  end

  def show?
    super && user.has_any_role?(:location_read, :location_write, :entity_read)
  end

  def create?
    authenticated? && user.has_any_role?(:location_write)
  end

  def update?
    authenticated? && user.has_any_role?(:location_write)
  end

  def destroy?
    authenticated? && user.has_any_role?(:location_write)
  end
end
