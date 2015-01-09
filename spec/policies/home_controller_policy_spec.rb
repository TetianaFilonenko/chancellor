require 'rails_helper'

describe HomeControllerPolicy, :type => :policy do
  subject { HomeControllerPolicy.new(user) }

  context 'when user is not signed in' do
    let(:user) { nil }

    it { is_expected.not_to permit_action(:index) }
  end

  context 'when user is signed in' do
    let(:user) { create(:user, :confirmed) }

    it { is_expected.to permit_action(:index) }
  end
end
