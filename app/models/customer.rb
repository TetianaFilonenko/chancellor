# Represents the +Customer+ trait details for an +Entity+
class Customer < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :default_contact, :class_name => Contact
  belongs_to :default_location, :class_name => Location
  belongs_to :entity
  belongs_to :parent_customer, :class_name => Customer
  belongs_to :salesperson

  has_paper_trail

  validates \
    :entity,
    :is_active,
    :reference,
    :uuid,
    :presence => true

  def active?
    is_active == 1 ? true : false
  end

  def to_s
    entity.display_name
  end
end
