# Policy to control access to Customers
class CustomerPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? &&
      user.has_any_role?(:customer_write, :entity_read)
  end

  def show?
    super && user.has_any_role?(:customer_read, :customer_write, :entity_read)
  end

  def create?
    authenticated? && user.has_any_role?(:customer_write)
  end

  def update?
    authenticated? && user.has_any_role?(:customer_write)
  end

  def destroy?
    authenticated? && user.has_any_role?(:customer_write)
  end
end
