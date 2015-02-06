require 'rails_helper'

RSpec.describe ContactEntry, :type => :model do
  subject do
    ContactEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end
end
