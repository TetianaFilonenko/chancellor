# Policy to control access to Vendors
class VendorPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? &&
      user.has_any_role?(:vendor_write, :entity_read)
  end

  def show?
    super && user.has_any_role?(:vendor_read, :vendor_write, :entity_read)
  end

  def create?
    authenticated? && user.has_any_role?(:vendor_write)
  end

  def update?
    authenticated? && user.has_any_role?(:vendor_write)
  end

  def destroy?
    authenticated? && user.has_any_role?(:vendor_write)
  end
end
