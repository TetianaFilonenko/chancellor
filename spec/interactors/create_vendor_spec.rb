require 'rails_helper'

RSpec.describe CreateVendor, :type => :interactor do
  let(:entity) { create(:entity) }
  let(:contact) { create(:contact, :entity => entity) }
  let(:location) { create(:location, :entity => entity) }
  let(:reference) { Faker::Number.number(8) }
  let(:user) { create(:user) }
  subject(:context) do
    CreateVendor.call(
      :entity => entity,
      :reference => reference,
      :default_contact_id => contact.id,
      :default_location_id => location.id,
      :user => user)
  end

  context 'valid parameters' do
    describe 'context' do
      it 'should be successful' do
        expect(context).to be_a_success
      end

      it 'should have the correct localized message' do
        expect(context.message).to eq(
          I18n.t('ar.success.messages.created',
                 :model => I18n.t('ar.models.vendor')))
      end

      it 'should have vendor present' do
        expect(context.vendor).to be_present
      end
    end

    describe Vendor do
      subject { context.vendor }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:default_contact) { is_expected.to be_present }
      its(:default_location) { is_expected.to be_present }

      describe 'papertrail' do
        its('versions.size') { is_expected.to eq(1) }
        its(:originator) { is_expected.to eq(user.id.to_s) }
      end
    end

    describe Entity do
      subject { context.entity }

      it 'should have a vendor' do
        expect(subject.vendor).to eq(context.vendor)
      end
      describe 'papertrail' do
        it 'should not change the versions size' do
          expect { context }.not_to change { context.entity.versions.size }
        end
      end
    end
  end

  context 'invalid parameters' do
    let(:reference) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the vendor' do
        expect(context.vendor).to be_present
      end
    end

    describe Vendor do
      subject(:vendor) { context.vendor }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:default_contact) { is_expected.to be_present }
      its(:default_location) { is_expected.to be_present }
    end
  end
end
