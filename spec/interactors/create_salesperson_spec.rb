require 'rails_helper'

RSpec.describe CreateSalesperson, :type => :interactor do
  let(:entity) { create(:entity) }
  let(:location) { create(:location, :entity => entity) }
  let(:reference) { Faker::Number.number(8) }
  let(:city) { Faker::Address.city }
  let(:gender) { 'female' }
  let(:phone) { Faker::PhoneNumber.phone_number }
  let(:user) { create(:user) }
  subject(:context) do
    CreateSalesperson.call(
      :entity => entity,
      :gender => gender,
      :reference => reference,
      :phone => phone,
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
                 :model => I18n.t('ar.models.salesperson')))
      end

      it 'should have salesperson present' do
        expect(context.salesperson).to be_present
      end
    end

    describe Salesperson do
      subject(:salesperson) { context.salesperson }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:default_location) { is_expected.to be_present }

      describe 'papertrail' do
        it 'has 1 version' do
          expect(subject.versions.size).to eq(1)
        end

        it 'was created by user' do
          expect(subject.originator).to eq(user.id.to_s)
        end
      end
    end

    describe Entity do
      subject { context.entity }

      it 'should have a salesperson' do
        expect(subject.salesperson).to eq(context.salesperson)
      end

      describe 'papertrail' do
        it 'should not change version' do
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

      it 'has set the salesperson' do
        expect(context.salesperson).to be_present
      end
    end

    describe Salesperson do
      subject(:salesperson) { context.salesperson }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:default_location) { is_expected.to be_present }
    end
  end
end
