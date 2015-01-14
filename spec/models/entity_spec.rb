require 'rails_helper'

RSpec.describe Entity, :type => :model do
  subject { build(:entity) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cached_long_name) }
  it { is_expected.to validate_presence_of(:reference) }
  it { is_expected.to validate_presence_of(:street_address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:region) }
  it { is_expected.to validate_presence_of(:region_code) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:street_address) }
end
