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
