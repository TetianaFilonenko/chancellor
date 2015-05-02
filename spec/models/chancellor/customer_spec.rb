require 'rails_helper'

module Chancellor
  RSpec.describe Customer, :type => :model do
    subject { build(:customer, :entity => create(:entity)) }

    describe 'associations' do
      it { is_expected.to belong_to(:default_contact) }
      it { is_expected.to belong_to(:default_location) }
      it { is_expected.to belong_to(:entity) }
      it { is_expected.to belong_to(:parent_customer) }
      it { is_expected.to belong_to(:salesperson) }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of(:entity) }
      it { is_expected.to validate_presence_of(:is_active) }
      it { is_expected.to validate_presence_of(:reference) }
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_uniqueness_of(:reference) }
    end

    describe '#active?' do
      let(:customer) { build(:customer, :is_active => is_active) }
      subject { customer.active? }

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
end
