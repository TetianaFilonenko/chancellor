# Policy to control access to Salesperson details
class SalespersonPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? && user.has_any_role?(:salesperson_read, :salesperson_write)
  end

  def show?
    super && user.has_any_role?(:salesperson_read, :salesperson_write)
  end

  def create?
    authenticated? && user.has_role?(:salesperson_write)
  end

  def update?
    authenticated? && user.has_role?(:salesperson_write)
  end

  def destroy?
    authenticated? && user.has_role?(:salesperson_write)
  end
end
