Promiscuous.define do
  publish :customer do
    attributes :entity_id,
               :uuid,
               :default_contact_id,
               :default_location_id,
               :salesperson_id,
               :reference,
               :is_active
  end
end
