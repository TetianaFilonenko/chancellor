# Captures +Vendor+ information.
class VendorEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :reference, String
  attribute :default_contact_id, Integer
  attribute :default_location_id, Integer
  attribute :is_active, Integer

  validates \
    :reference, :presence => true
end
