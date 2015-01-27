require 'rails_helper'

RSpec.describe LocationDecorator, :type => :decorator do
  subject(:decorator) { location.decorate }

  context 'when all address lines are present' do
    let(:location) { build(:location) }

    its(:address_lines) do
      is_expected.to eq([
        location.street_address,
        location.city,
        location.region,
        location.region_code,
        location.country])
    end

    its(:long_address) do
      is_expected.to eq("#{location.street_address}, \
#{location.city}, \
#{location.region}, \
#{location.region_code}, \
#{location.country}")
    end
  end
end
