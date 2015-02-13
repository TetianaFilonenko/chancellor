# A +Contact+ represents that contact details for an +Entity+
class Contact < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :entity

  has_paper_trail

  validates \
    :entity,
    :first_name,
    :last_name,
    :uuid,
    :presence => true

  def to_s
    display_name
  end
end
