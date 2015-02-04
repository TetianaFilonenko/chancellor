require 'rails_helper'

RSpec.describe DefaultLocation, :type => :model do
  let(:entity_type) { [:salesperson].sample }
  let(:base_entity) { create(:entity) }
  let(:entity) { create(entity_type, :entity => base_entity) }
  let(:location) do
    create(:location,
           :entity => base_entity,
           :location_name => base_entity.name)
  end
  subject do
    create(:default_location, :entity => entity, :location => location)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:entity) }
    it { is_expected.to belong_to(:location) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:entity) }
    it { is_expected.to validate_presence_of(:location) }
    # it { is_expected.to validate_uniqueness_of(:location_id)
    #                       .scoped_to([:entity_id, :entity_type]) }
    # rubocop:disable Metrics/LineLength
    it 'should require unique value for location scoped to entity_id and entity_type' do
      # I created this expectation by hand as validate_uniqueness_of included
      # the following information in the resulting message...
      # "has already been taken (attribute: \"location\", value: ...
      create(:default_location, :entity => entity, :location => location)
      default_location = build(:default_location,
                               :entity => entity,
                               :location => location)
      default_location.valid?
      expect(default_location.errors).to have_key(:location)
      expect(default_location.errors[:location]).to eq(['has already been taken'])
    end
    # rubocop:enable Metrics/LineLength
  end

  describe 'relationships' do
    let(:entity_type) { :salesperson }

    context 'when entity is sales person' do
      its(:entity) { is_expected.to eq(entity) }
      its(:entity_type) { is_expected.to eq('Salesperson') }
      its(:location) { is_expected.to eq(location) }
    end
  end
end
