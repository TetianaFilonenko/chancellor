# Captures +Entity+ information.
class EntityEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :display_name, String
  attribute :name, String
  attribute :reference, String

  validates \
    :name,
    :reference, :presence => true
end
