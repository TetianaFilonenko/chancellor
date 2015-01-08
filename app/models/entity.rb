# An entity is a representation of an organization.
#
# Entities can be any kind of organization, customer, vendor, etc.
class Entity < ActiveRecord::Base
  acts_as_paranoid

  # NOTE: Use tags to represent an entities role

  validates \
    :name,
    :cached_long_name,
    :reference,
    :street_address,
    :city,
    :region,
    :region_code,
    :country,
    :uuid,
    :presence => true
end
