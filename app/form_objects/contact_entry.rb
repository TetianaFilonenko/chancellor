# Captures information needed to create a new +Contact+
class ContactEntry
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :first_name, String
  attribute :last_name, String
  attribute :display_name, String
  attribute :is_active, Integer
  attribute :title, String
  attribute :email_address, String
  attribute :fax_number, String
  attribute :mobile_number, String
  attribute :phone_number, String

  validates \
    :first_name,
    :last_name,
    :is_active, :presence => true
end
