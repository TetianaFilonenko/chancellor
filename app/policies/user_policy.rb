# Policy to control access to +User+ details.
class UserPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? && user.has_role?(:user_admin)
  end

  def show?
    super
  end

  def update?
    authenticated? && user.has_role?(:user_admin)
  end

  def destroy?
    authenticated? && user.has_role?(:user_admin)
  end
end
