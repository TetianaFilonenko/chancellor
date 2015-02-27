# ---------------------------------
# Auto-generated file. Do not edit.
# ---------------------------------

module Chancellor::Publishers

  # ------------------------------------------------------------------

  class Contact
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :entity_id
    publish :first_name
    publish :last_name
    publish :display_name
    publish :title
    publish :email_address
    publish :fax_number
    publish :mobile_number
    publish :phone_number
    publish :is_active
    publish :uuid
  end

  # ------------------------------------------------------------------

  class Customer
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :entity_id
    publish :uuid
    publish :default_contact_id
    publish :default_location_id
    publish :salesperson_id
    publish :reference
    publish :is_active
  end

  # ------------------------------------------------------------------

  class Entity
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :cached_long_name
    publish :comments
    publish :display_name
    publish :is_active
    publish :name
    publish :reference
    publish :uuid
  end

  # ------------------------------------------------------------------

  class Location
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :entity_id
    publish :location_name
    publish :street_address
    publish :city
    publish :region
    publish :region_code
    publish :country
    publish :latitude
    publish :longitude
    publish :is_active
    publish :uuid
  end

  # ------------------------------------------------------------------

  class Salesperson
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :entity_id
    publish :uuid
    publish :default_location_id
    publish :gender
    publish :phone
    publish :reference
    publish :is_active
  end

  # ------------------------------------------------------------------

  class Vendor
    include Promiscuous::Publisher::Model::Mock
    mock :from => 'chancellor'

    publish :entity_id
    publish :uuid
    publish :default_contact_id
    publish :default_location_id
    publish :reference
    publish :is_active
  end
end
