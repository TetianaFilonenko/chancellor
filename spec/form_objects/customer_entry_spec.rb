require 'rails_helper'

RSpec.describe CustomerEntry, :type => :model do
  subject do
    CustomerEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference) }
  end
end
