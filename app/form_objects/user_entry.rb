# Captures information needed to update an existing +User+
class UserEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :first_name, String
  attribute :last_name, String
  attribute :display_name, String
  attribute :is_active, Integer

  validates \
    :first_name,
    :last_name,
    :display_name,
    :is_active, :presence => true
end
