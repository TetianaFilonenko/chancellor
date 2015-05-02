require 'rails_helper'

module Chancellor
  RSpec.describe Entity, :type => :model do
    subject { build(:entity) }

    describe 'associations' do
      it { is_expected.to belong_to(:parent_entity) }
      it { is_expected.to have_many(:locations) }
      it { is_expected.to have_one(:customer) }
      it { is_expected.to have_one(:salesperson) }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of(:cached_long_name) }
      it { is_expected.to validate_presence_of(:is_active) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:reference) }
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_uniqueness_of(:reference) }
    end

    describe '#active?' do
      let(:entity) { build(:entity, :is_active => is_active) }
      subject { entity.active? }

      context 'when is_active equals 0' do
        let(:is_active) { 0 }

        it { is_expected.to eq(false) }
      end

      context 'when is_active equals 1' do
        let(:is_active) { 1 }

        it { is_expected.to eq(true) }
      end
    end

    describe '.next_reference' do
      subject { Entity.next_reference }

      context 'when there are no existing entities' do
        it { is_expected.to eq('1') }
      end

      context 'when there are existing entities' do
        before do
          create(:entity, :reference => '1000000')
          create(:entity, :reference => '1000001')
        end

        it { is_expected.to eq('1000002') }
      end
    end

    describe '#valid?' do
      before { entity.valid? }

      let(:entity) { build(:entity) }

      subject { entity }

      describe 'validate methods are invoked' do
        before do
          allow(subject).to receive(:parent_is_not_child)
          allow(subject).to receive(:parent_is_not_self)

          entity.valid?
        end

        it { is_expected.to have_received(:parent_is_not_self) }
        it { is_expected.to have_received(:parent_is_not_child) }
      end

      context 'when parent is not self' do
        let(:entity) { build(:entity, :parent_entity => build(:entity)) }

        its(:valid?) { is_expected.to be_truthy }
        it 'should not add an error to parent' do
          expect(entity.errors[:parent_entity]).to be_empty
        end
      end

      context 'when parent is self' do
        let(:entity) do
          temp_entity = build(:entity)
          temp_entity.parent_entity = temp_entity
          temp_entity
        end

        its(:valid?) { is_expected.to be_falsey }
        it 'should add an error to parent' do
          expect(entity.errors.messages[:parent_entity]).to be_present
        end
        it 'should add the error can\'t be itself' do
          expect(entity.errors.messages[:parent_entity])
            .to eq(["can't be itself"])
        end
      end

      context 'when parent is not a child' do
        let(:entity) { build(:entity, :parent_entity => build(:entity)) }

        its(:valid?) { is_expected.to be_truthy }
        it 'should not add an error to parent' do
          expect(entity.errors[:parent_entity]).to be_empty
        end
      end

      context 'when parent is a child' do
        let(:entity) do
          parent_entity = create(:entity)
          child_entity = create(:entity, :parent_entity => parent_entity)

          temp_entity = build(:entity)
          temp_entity.parent_entity = child_entity
          temp_entity
        end

        its(:valid?) { is_expected.to be_falsey }
        it 'should add an error to parent' do
          expect(entity.errors.messages[:parent_entity]).to be_present
        end
        it 'should add the error can\'t be a child' do
          expect(entity.errors.messages[:parent_entity])
            .to eq(["can't be a child"])
        end
      end
    end
  end
end
