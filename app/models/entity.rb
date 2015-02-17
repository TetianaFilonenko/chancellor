# An entity is a representation of an organization.
#
# Entities can be any kind of organization, customer, vendor, etc.
class Entity < ActiveRecord::Base
  acts_as_paranoid

  has_many :contacts
  has_many :locations, :inverse_of => :entity
  has_one :customer
  has_one :salesperson
  has_one :vendor

  has_paper_trail

  resourcify

  validates \
    :name,
    :cached_long_name,
    :reference,
    :uuid,
    :presence => true

  def to_s
    name
  end
end
