require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:is_active) { 1 }
  let(:user) do
    create(:user, :is_active => is_active)
  end
  subject { user }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:is_active) }
  end

  describe '.active?' do
    subject { user.active? }

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
