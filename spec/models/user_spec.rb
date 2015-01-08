require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:is_active) { 1 }
  let(:roles) { [] }
  let(:user) do
    build(:user, :is_active => is_active, :roles => roles)
  end
  subject { user }

  describe 'associations' do
    it { is_expected.to have_many(:roles) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:is_active) }
  end

  describe '.has_role?' do
    subject { user.has_role?(:test) }

    context 'when user has role' do
      let(:roles) { [] }

      it { is_expected.to eq(false) }
    end

    context 'when user does not have role' do
      let(:roles) { [build(:user_role, :name => 'test')] }

      it { is_expected.to eq(true) }
    end
  end

  describe '.is_active?' do
    subject { user.is_active? }

    context 'when is_active is 0' do
      let(:is_active) { 0 }

      it { is_expected.to eq(false) }
    end

    context 'when is_active is 1' do
      let(:is_active) { 1 }

      it { is_expected.to eq(true) }
    end
  end
end
