# An entity is a representation of an organization.
#
# Entities can be any kind of organization, customer, vendor, etc.
class Entity < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :primary_location, :class_name => Location
  has_many :locations, :inverse_of => :entity

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
end
