# An entity is a representation of an organization.
#
# Entities can be any kind of organization, customer, vendor, etc.
class Entity < ActiveRecord::Base
  acts_as_paranoid

  has_many :locations, :inverse_of => :entity
  belongs_to :primary_location,
             :class_name => Location

  resourcify

  validates \
    :name,
    :cached_long_name,
    :reference,
    :uuid,
    :presence => true
end
