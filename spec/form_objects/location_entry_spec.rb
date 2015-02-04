require 'rails_helper'

RSpec.describe LocationEntry, :type => :model do
  subject do
    LocationEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:region) }
    it { is_expected.to validate_presence_of(:region_code) }
    it { is_expected.to validate_presence_of(:country) }
  end
end
