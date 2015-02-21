require 'rails_helper'

RSpec.describe EntityEntry, :type => :model do
  subject { EntityEntry.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:is_active) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:reference) }
  end

  describe '.build_from_entity' do
    let(:entity) { create(:entity) }

    subject { EntityEntry.build_from_entity(entity) }

    its(:display_name) { is_expected.to eq(entity.display_name) }
    its(:is_active) { is_expected.to eq(entity.is_active) }
    its(:name) { is_expected.to eq(entity.name) }
    its(:reference) { is_expected.to eq(entity.reference) }
  end

  describe '.entity_hash' do
    let(:entity) { create(:entity) }

    subject { EntityEntry.entity_hash(entity) }

    its([:display_name]) { is_expected.to eq(entity.display_name) }
    its([:is_active]) { is_expected.to eq(entity.is_active) }
    its([:name]) { is_expected.to eq(entity.name) }
    its([:reference]) { is_expected.to eq(entity.reference) }
  end

  describe '#merge_hash' do
    let(:entity_entry) { EntityEntry.new }
    let(:hash) do
      {
        :display_name => Faker::Company.name,
        :is_active => 1,
        :name => Faker::Company.name,
        :reference => Faker::Number.number(8)
      }
    end

    subject { entity_entry.merge_hash(hash) }

    its(:display_name) { is_expected.to eq(hash[:display_name]) }
    its(:is_active) { is_expected.to eq(hash[:is_active]) }
    its(:name) { is_expected.to eq(hash[:name]) }
    its(:reference) { is_expected.to eq(hash[:reference]) }
  end
end
