# A +Location+ represents a mail address.
class Location < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :entity, :inverse_of => :locations

  has_paper_trail

  validates \
    :entity,
    :location_name,
    :street_address,
    :city,
    :region,
    :region_code,
    :country,
    :uuid,
    :presence => true
end
