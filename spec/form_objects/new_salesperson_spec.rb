require 'rails_helper'

RSpec.describe NewSalesperson, :type => :model do
  subject do
    NewSalesperson.new
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:reference) }
  end
end
