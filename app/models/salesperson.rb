# Represents the +Salesperson+ trait details for an +Entity+.
class Salesperson < ActiveRecord::Base
  acts_as_paranoid

  delegate :location, :to => :default_location, :allow_nil => true

  belongs_to :entity
  has_one :default_location,
          :as => :entity,
          :autosave => true,
          :foreign_key => :entity_id

  has_paper_trail

  scope :active, -> { unscoped.where(:deleted_at => nil) }

  validates \
    :entity,
    :reference,
    :uuid,
    :presence => true

  def active?
    # is_active == 1 ? true : false
    deleted_at.nil?
  end

  def remove_location
    default_location.destroy
  end

  def location=(location)
    default_location = build_default_location if default_location.nil?
    default_location.location = location
  end

  def to_s
    entity.name
  end
end
