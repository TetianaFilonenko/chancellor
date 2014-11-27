class Entity < ActiveRecord::Base


  validates_presence_of :name
  validates_presence_of :reference
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :region
  validates_presence_of :region_code
  validates_presence_of :country
  validates_presence_of :uuid

  
end
