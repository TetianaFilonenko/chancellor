# An entity is a representation of an organization.
#
# Entities can be any kind of organization, customer, vendor, etc.
class Entity < ActiveRecord::Base
  acts_as_paranoid

  has_many :contacts
  has_many :locations, :inverse_of => :entity
  has_one :customer
  has_one :salesperson

  has_paper_trail

  resourcify

  validates \
    :name,
    :cached_long_name,
    :reference,
    :uuid,
    :presence => true

  class << self
    def find_version(version_id)
      PaperTrail::Version.find(version_id).reify
    end
  end

  def salesperson
    Salesperson.unscoped { super }
  end

  def to_s
    name
  end
end
