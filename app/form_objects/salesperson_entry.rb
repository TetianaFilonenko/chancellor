# Captures information needed to create a new +Salesperson+
class SalespersonEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :gender, String
  attribute :reference, String
  attribute :phone, String
  attribute :default_location_id, Integer
  attribute :is_active, Integer

  validates \
    :reference, :presence => true
end
