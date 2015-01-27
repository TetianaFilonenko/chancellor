require 'rails_helper'

RSpec.describe EntityDecorator, :type => :decorator do
  subject(:decorator) { entity.decorate }

  context 'when all address lines are present' do
    let(:entity) do
      temp_entity = build(:entity)
      location = build(:location, :entity => temp_entity)
      temp_entity.primary_location = location
      temp_entity
    end

    its(:display_string) do
      is_expected.to eq("#{entity.reference} - \
#{entity.name}, \
#{entity.primary_location.street_address}, \
#{entity.primary_location.city}, \
#{entity.primary_location.region}, \
#{entity.primary_location.region_code}, \
#{entity.primary_location.country}")
    end

    its(:long_name) do
      is_expected.to eq("#{entity.reference} - \
#{entity.name}, \
#{entity.primary_location.street_address}, \
#{entity.primary_location.city}, \
#{entity.primary_location.region}, \
#{entity.primary_location.region_code}, \
#{entity.primary_location.country}")
    end
  end
end
