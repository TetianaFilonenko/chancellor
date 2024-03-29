# Captures +Location+ information.
class LocationEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :is_active, Integer
  attribute :location_name, String
  attribute :street_address, String
  attribute :city, String
  attribute :region, String
  attribute :region_code, String
  attribute :country, String

  validates \
    :is_active,
    :location_name,
    :street_address,
    :city,
    :region,
    :region_code,
    :country, :presence => true
end
