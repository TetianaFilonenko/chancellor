require 'paranoia'

module Chancellor
  # A +Contact+ represents that contact details for an +Entity+
  class Contact < ActiveRecord::Base
    include Disableable

    self.table_name = 'contacts'

    acts_as_paranoid

    belongs_to :entity

    has_paper_trail

    validates \
      :entity,
      :first_name,
      :last_name,
      :is_active,
      :uuid,
      :presence => true

    def to_s
      display_name
    end
  end
end
