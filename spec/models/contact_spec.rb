require 'rails_helper'

RSpec.describe Contact, :type => :model do
  let(:entity) { build(:entity) }
  subject { build(:contact, :entity => entity) }

  describe 'associations' do
    it { is_expected.to belong_to(:entity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entity) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:uuid) }
  end
end
