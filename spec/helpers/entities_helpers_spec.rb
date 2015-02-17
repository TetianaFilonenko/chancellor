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

  describe '#parent_entity_string' do
    let(:object) { double(:parent_entity => parent_entity) }

    subject { helper.parent_entity_string(object) }

    context 'when parent_entity is nil' do
      let(:parent_entity) { nil }

      it { is_expected.to eq('None') }
    end

    context 'when parent_entity is present' do
      let(:parent_entity) { build(:entity) }

      it { is_expected.to eq(parent_entity.cached_long_name) }
    end
  end
end
