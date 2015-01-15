require 'rails_helper'

describe UserPolicy, :type => :policy do
  let(:user) { create(:user) }
  let(:user_to_manage) { create(:user) }

  subject { UserPolicy.new(user, user_to_manage) }

  context 'when no user' do
    let(:user) { nil }

    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has no roles' do
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the authenticated role' do
    before { user.add_role :authenticated }

    it { is_expected.to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the user admin role' do
    before do
      user.add_role :authenticated
      user.add_role :user_admin
    end

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:destroy) }
  end
end
