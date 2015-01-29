require 'rails_helper'

RSpec.describe Location, :type => :model do
  subject { build(:location) }

  describe 'associations' do
    it { is_expected.to belong_to(:entity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entity) }
    it { is_expected.to validate_presence_of(:location_name) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:region) }
    it { is_expected.to validate_presence_of(:region_code) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:uuid) }
  end
end
