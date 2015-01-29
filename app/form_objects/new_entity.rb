# Captures information needed to create a new +Entity+
class NewEntity
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name, String
  attribute :reference, String
  attribute :street_address, String
  attribute :city, String
  attribute :region, String
  attribute :region_code, String
  attribute :country, String

  validates \
    :name,
    :reference,
    :street_address,
    :city,
    :region,
    :region_code,
    :country, :presence => true
end
