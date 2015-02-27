Promiscuous.define do
  publish :contact do
    attributes :entity_id,
               :first_name,
               :last_name,
               :display_name,
               :title,
               :email_address,
               :fax_number,
               :mobile_number,
               :phone_number,
               :is_active,
               :uuid
  end
end
