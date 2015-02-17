require 'rails_helper'

RSpec.describe VendorEntry, :type => :model do
  subject do
    VendorEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference) }
  end
end
