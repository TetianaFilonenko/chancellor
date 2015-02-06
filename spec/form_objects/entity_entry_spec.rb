require 'rails_helper'

RSpec.describe EntityEntry, :type => :model do
  subject { EntityEntry.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:reference) }
  end
end
