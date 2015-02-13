require 'rails_helper'

RSpec.describe Salesperson, :type => :model do
  let(:default_location) { nil }
  subject { build(:salesperson, :default_location => default_location) }

  describe 'associations' do
    it { is_expected.to have_one(:default_location) }
    it { is_expected.to belong_to(:entity) }
  end

  describe 'delegates' do
    it { is_expected.to delegate_method(:location).to(:default_location) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entity) }
    it { is_expected.to validate_presence_of(:reference) }
    it { is_expected.to validate_presence_of(:uuid) }
  end

  describe '.active' do
    subject { Salesperson.active }
    before do
      create(:salesperson,
             :entity => create(:entity),
             :deleted_at => deleted_at)
      create(:salesperson,
             :entity => create(:entity),
             :deleted_at => deleted_at)
    end

    context 'when there are no active salespeople' do
      let(:deleted_at) { Date.current }

      its(:any?) { is_expected.to be_falsey }
      its(:empty?) { is_expected.to be_truthy }
      its(:size) { is_expected.to eq(0) }
    end

    context 'when there are active salespeople' do
      let(:deleted_at) { nil }

      its(:any?) { is_expected.to be_truthy }
      its(:empty?) { is_expected.to be_falsey }
      its(:size) { is_expected.to eq(2) }
    end
  end

  describe '#location' do
    context 'when there is a default location' do
      let(:default_location) { DefaultLocation.new(:location => Location.new) }

      its(:location) { is_expected.to be_present }
    end

    context 'when there is no default location' do
      let(:default_location) { nil }

      its(:location) { is_expected.to be_nil }
    end
  end
end
