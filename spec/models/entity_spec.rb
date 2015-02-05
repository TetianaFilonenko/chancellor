require 'rails_helper'

RSpec.describe Entity, :type => :model do
  subject { build(:entity) }

  describe 'associations' do
    it { is_expected.to have_many(:locations) }
    it { is_expected.to have_one(:customer) }
    it { is_expected.to have_one(:salesperson) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cached_long_name) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_presence_of(:uuid) }
  end
end
