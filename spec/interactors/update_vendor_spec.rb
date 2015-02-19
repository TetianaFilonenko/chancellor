require 'rails_helper'

RSpec.describe UpdateVendor, :type => :interactor do
  let(:entity) do
    temp_entity = create(:entity)

    create(:vendor,
           :entity => temp_entity,
           :default_contact => create(:contact, :entity => temp_entity),
           :default_location => create(:location, :entity => temp_entity))

    temp_entity
  end
  let(:contact) { create(:contact, :entity => entity) }
  let(:is_active) { 1 }
  let(:location) { create(:location, :entity => entity) }
  let(:reference) { entity.vendor.reference }
  let(:user) { create(:user) }
  subject(:context) do
    UpdateVendor.call(
      :entity => entity,
      :default_contact_id => contact.id,
      :default_location_id => location.id,
      :is_active => is_active,
      :reference => reference,
      :user => user)
  end

  context 'when the parameters are valid' do
    describe 'context' do
      subject { context }

      it { is_expected.to be_a_success }
      its(:vendor) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.vendor')))
      end
    end

    describe Vendor do
      subject { context.vendor }

      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'when disabling a vendor' do
    let(:is_active) { 0 }

    describe 'context' do
      subject { context }

      it { is_expected.to be_a_success }
      its(:vendor) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.vendor')))
      end
    end

    describe Vendor do
      subject { context.vendor }

      its(:is_active) { is_expected.to eq(0) }
    end
  end

  context 'when the parameters are invalid' do
    let(:reference) { nil }

    describe 'context' do
      subject { context }

      it { is_expected.to be_a_failure }
      its(:vendor) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.failure.messages.validate',
                 :model => I18n.t('ar.models.vendor')))
      end
    end

    describe Vendor do
      subject { context.vendor }

      describe 'papertrail' do
        it 'should not change the versions size' do
          expect { subject }.not_to change { context.entity.versions.size }
        end
      end
    end
  end
end
