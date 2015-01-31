# Captures information needed to create a new +Salesperson+
class NewSalesperson
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :gender, String
  attribute :reference, String
  attribute :phone, String
  attribute :location_id, Integer

  validates \
    :reference, :presence => true
end
