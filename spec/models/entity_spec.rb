require 'rails_helper'

RSpec.describe Entity, :type => :model do

  subject { create(:entity) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:region_code) }

end
