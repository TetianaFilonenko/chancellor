class Entity < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of \
    :name,
    :cached_long_name,
    :reference,
    :street_address,
    :city,
    :region,
    :region_code,
    :country,
    :uuid
  
end
