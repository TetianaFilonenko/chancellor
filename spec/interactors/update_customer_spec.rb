require 'rails_helper'

RSpec.describe UpdateCustomer, :type => :interactor do
  let(:entity) do
    temp_entity = create(:entity)

    create(:customer,
           :entity => temp_entity,
           :default_contact => create(:contact, :entity => temp_entity),
           :default_location => create(:location, :entity => temp_entity),
           :salesperson => create(:salesperson, :entity => create(:entity)))

    temp_entity
  end
  let(:contact) { create(:contact, :entity => entity) }
  let(:is_active) { 1 }
  let(:location) { create(:location, :entity => entity) }
  let(:reference) { entity.customer.reference }
  let(:salesperson) { create(:salesperson, :entity => create(:entity)) }
  let(:user) { create(:user) }
  subject(:context) do
    UpdateCustomer.call(
      :entity => entity,
      :default_contact_id => contact.id,
      :default_location_id => location.id,
      :is_active => is_active,
      :reference => reference,
      :salesperson_id => salesperson.id,
      :user => user)
  end

  context 'when the parameters are valid' do
    describe 'context' do
      subject { context }

      it { is_expected.to be_a_success }
      its(:customer) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.customer')))
      end
    end

    describe Customer do
      subject { context.customer }

      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'when disabling a customer' do
    let(:is_active) { 0 }

    describe 'context' do
      subject { context }

      it { is_expected.to be_a_success }
      its(:customer) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.customer')))
      end
    end

    describe Customer do
      subject { context.customer }

      its(:is_active) { is_expected.to eq(0) }
    end
  end

  context 'when the parameters are invalid' do
    let(:reference) { nil }

    describe 'context' do
      subject { context }

      it { is_expected.to be_a_failure }
      its(:customer) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.failure.messages.validate',
                 :model => I18n.t('ar.models.customer')))
      end
    end

    describe Customer do
      subject { context.customer }

      describe 'papertrail' do
        it 'should not increase the version' do
          expect { subject }.not_to change { context.entity.versions.size }
        end
      end
    end
  end
end
