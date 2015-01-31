require 'rails_helper'

RSpec.describe SalespersonEntry, :type => :model do
  subject do
    SalespersonEntry.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference) }
  end
end
