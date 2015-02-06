# Policy to control access to +Contact+ information.
class ContactPolicy < ApplicationPolicy
  # Scope
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    authenticated? &&
      user.has_any_role?(:contact_read, :contact_write)
  end

  def show?
    super && user.has_any_role?(:contact_read, :contact_write, :entity_read)
  end

  def create?
    authenticated? && user.has_any_role?(:contact_write)
  end

  def update?
    authenticated? && user.has_any_role?(:contact_write)
  end

  def destroy?
    authenticated? && user.has_any_role?(:contact_write)
  end
end
