require 'rails_helper'

RSpec.describe User::Role, :type => :model do
  let(:role) do
    build(:user_role)
  end
  subject { role }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
