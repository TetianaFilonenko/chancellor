require 'rails_helper'

describe EntityPolicy, :type => :policy do
  let(:entity) { create(:entity) }
  let(:user) do
    u = create(:user)
    roles.each { |r| u.add_role r }
    u
  end

  subject { EntityPolicy.new(user, entity) }

  context 'when no user' do
    let(:user) { nil }

    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has no roles' do
    let(:roles) { [] }

    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the entity user role' do
    let(:roles) { [:authenticated, :entity_user] }

    it { is_expected.to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'when user has the entity admin role' do
    let(:roles) { [:authenticated, :entity_admin] }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when user does not have the entity user role' do
    let(:roles) { [:authenticated, :admin] }

    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:new) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:edit) }
    it { is_expected.not_to permit_action(:destroy) }
  end
end
