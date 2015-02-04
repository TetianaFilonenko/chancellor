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
      user.has_any_role?(:location_admin, :location_write, :entity_user)
  end

  def show?
    super && user.has_any_role?(:location_admin, :location_write, :entity_user)
  end

  def create?
    authenticated? && user.has_any_role?(:location_admin, :location_write)
  end

  def update?
    authenticated? && user.has_any_role?(:location_admin, :location_write)
  end

  def destroy?
    authenticated? && user.has_any_role?(:location_admin, :location_write)
  end
end
