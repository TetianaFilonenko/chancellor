require 'rails_helper'

RSpec.describe Salesperson, :type => :model do
  let(:default_location) { nil }
  subject do
    build(:salesperson,
          :default_location => default_location,
          :entity => create(:entity))
  end

  describe 'associations' do
    it { is_expected.to belong_to(:default_location) }
    it { is_expected.to belong_to(:entity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entity) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_uniqueness_of(:reference) }
  end

  describe '.active' do
    subject { Salesperson.active }
    before do
      create(:salesperson,
             :entity => create(:entity),
             :is_active => is_active)
      create(:salesperson,
             :entity => create(:entity),
             :is_active => is_active)
    end

    context 'when there are no active salespeople' do
      let(:is_active) { 0 }

      its(:any?) { is_expected.to be_falsey }
      its(:empty?) { is_expected.to be_truthy }
      its(:size) { is_expected.to eq(0) }
    end

    context 'when there are active salespeople' do
      let(:is_active) { 1 }

      its(:any?) { is_expected.to be_truthy }
      its(:empty?) { is_expected.to be_falsey }
      its(:size) { is_expected.to eq(2) }
    end
  end
end
