require 'rails_helper'

RSpec.describe CreateEntity, :type => :interactor do
  let(:name) { Faker::Company.name }
  let(:reference) { Faker::Number.number(8) }
  let(:street_address) { Faker::Address.street_address }
  let(:city) { Faker::Address.city }
  let(:region) { Faker::Address.state }
  let(:region_code) { Faker::Address.zip_code }
  let(:country) { 'United States' }
  let(:user) { create(:user) }
  subject(:context) do
    CreateEntity.call(
      :name => name,
      :reference => reference,
      :street_address => street_address,
      :city => city,
      :region => region,
      :region_code => region_code,
      :country => country,
      :user => user)
  end

  context 'valid parameters' do
    describe 'context' do
      it 'is successful' do
        expect(context).to be_a_success
      end

      it 'message contains success' do
        expect(context.message).to match(/success/i)
      end

      it 'has set the entity' do
        expect(context.entity).to be_present
      end
    end

    describe Entity do
      subject(:entity) { context.entity }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:primary_location) { is_expected.to be_present }

      describe 'papertrail' do
        # Two versions expected due to the primary location update
        it 'has 2 versions' do
          expect(entity.versions.size).to eq(2)
        end
        # it 'has 1 version' do
        #   expect(entity.versions.size).to eq(1)
        # end

        it 'was created by user' do
          expect(entity.originator).to eq(user.id.to_s)
        end
      end
    end

    describe Location do
      subject(:location) { context.location }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:entity) { is_expected.to be_present }

      describe 'papertrail' do
        it 'has 1 version' do
          expect(location.versions.size).to eq(1)
        end

        it 'was created by user' do
          expect(location.originator).to eq(user.id.to_s)
        end
      end
    end
  end

  context 'invalid parameters' do
    let(:name) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the entity' do
        expect(context.entity).to be_present
      end
    end

    describe Entity do
      subject(:entity) { context.entity }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:primary_location) { is_expected.to be_present }
    end

    describe Location do
      subject(:location) { context.location }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:entity) { is_expected.to be_present }
    end
  end
end
