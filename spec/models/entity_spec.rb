require 'rails_helper'

RSpec.describe Entity, :type => :model do
  subject { build(:entity) }

  describe 'associations' do
    it { is_expected.to have_many(:locations) }
    it { is_expected.to have_one(:customer) }
    it { is_expected.to have_one(:salesperson) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:cached_long_name) }
    it { is_expected.to validate_presence_of(:is_active) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_uniqueness_of(:reference) }
  end

  describe '#active?' do
    let(:entity) { build(:entity, :is_active => is_active) }
    subject { entity.active? }

    context 'when is_active equals 0' do
      let(:is_active) { 0 }

      it { is_expected.to eq(false) }
    end

    context 'when is_active equals 1' do
      let(:is_active) { 1 }

      it { is_expected.to eq(true) }
    end
  end
end
