require 'rails_helper'

RSpec.describe UpdateSalesperson, :type => :interactor do
  let(:entity) do
    create(:salesperson, :entity => create(:entity)).entity
  end
  let(:location) { create(:location, :entity => entity) }
  let(:reference) { Faker::Number.number(8) }
  let(:city) { Faker::Address.city }
  let(:gender) { 'female' }
  let(:phone) { Faker::PhoneNumber.phone_number }
  let(:user) { create(:user) }
  subject(:context) do
    UpdateSalesperson.call(
      :entity => entity,
      :gender => gender,
      :reference => reference,
      :phone => phone,
      :location_id => location ? location.id : nil,
      :user => user)
  end

  context 'when the parameters are valid' do
    describe 'context' do
      it 'should be successful' do
        expect(context).to be_a_success
      end

      it 'should have the correct localized message' do
        expect(context.message).to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.salesperson')))
      end

      it 'should have salesperson present' do
        expect(context.salesperson).to be_present
      end
    end

    describe Salesperson do
      subject { context.salesperson }

      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'when the location is removed' do
    let(:location) { nil }

    describe Salesperson do
      subject { context.salesperson }

      its(:default_location) { is_expected.to be_nil }
    end
  end

  context 'when the parameters are invalid' do
    let(:reference) { nil }

    describe 'context' do
      it 'is failure' do
        expect(context).to be_a_failure
      end

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the salesperson' do
        expect(context.salesperson).to be_present
      end
    end

    describe Salesperson do
      subject(:salesperson) { context.salesperson }

      describe 'papertrail' do
        it 'should not increase the version' do
          expect { context }.not_to change { context.entity.versions.size }
        end
      end
    end
  end
end
