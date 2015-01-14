# Grants +Role+ to a +User+
class GrantRole
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name, String
  attribute :user, User

  validates \
    :name,
    :user, :presence => true

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    user.grant name
  end
end
