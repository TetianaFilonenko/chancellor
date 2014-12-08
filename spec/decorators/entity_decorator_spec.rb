require 'rails_helper'

RSpec.describe EntityDecorator, :type => :decorator do

  subject(:decorator) { entity.decorate }

  context 'when all address lines are present' do
    let(:entity) { create(:entity) }

    its(:address_lines) { is_expected.to eq([
      entity.street_address, 
      entity.city, 
      entity.region, 
      entity.region_code, 
      entity.country]) 
    }

    its(:long_address) {
      is_expected.to eq("#{entity.street_address}, \
#{entity.city}, \
#{entity.region}, \
#{entity.region_code}, \
#{entity.country}")
    }
  end

  
end