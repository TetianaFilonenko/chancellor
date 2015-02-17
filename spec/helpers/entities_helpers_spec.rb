require 'rails_helper'

RSpec.describe EntitiesHelper, :type => :helper do
  describe '#active_string' do
    subject { helper.active_string(object) }

    context 'when active? is equal to false' do
      let(:object) { double(:active? => false) }

      it { is_expected.to eq('Inactive') }
    end

    context 'when active? is equal to true' do
      let(:object) { double(:active? => true) }

      it { is_expected.to eq('Active') }
    end
  end
end
