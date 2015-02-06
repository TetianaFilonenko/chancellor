require 'rails_helper'

RSpec.describe CreateLocation, :type => :interactor do
  let(:location_name) { Faker::Company.name }
  let(:street_address) { Faker::Address.street_address }
  let(:city) { Faker::Address.city }
  let(:region) { Faker::Address.state }
  let(:region_code) { Faker::Address.zip_code }
  let(:country) { 'United States' }
  let(:entity) { create(:entity) }
  let(:user) { create(:user) }
  subject(:context) do
    CreateLocation.call(
      :entity => entity,
      :location_name => location_name,
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

      it 'has set the location' do
        expect(context.location).to be_present
      end
    end

    describe Location do
      subject { context.location }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:entity) { is_expected.to be_present }

      describe 'papertrail' do
        it 'has 1 version' do
          expect(subject.versions.size).to eq(1)
        end

        it 'was created by user' do
          expect(subject.originator).to eq(user.id.to_s)
        end
      end
    end
  end

  context 'invalid parameters' do
    let(:location_name) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the location' do
        expect(context.location).to be_present
      end
    end

    describe Location do
      subject(:location) { context.location }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:entity) { is_expected.to be_present }
    end
  end
end
