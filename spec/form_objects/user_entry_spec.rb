require 'rails_helper'

RSpec.describe UserEntry, :type => :model do
  subject do
    UserEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:is_active) }
  end
end
