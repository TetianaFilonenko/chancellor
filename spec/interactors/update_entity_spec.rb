require 'rails_helper'

RSpec.describe UpdateEntity, :type => :interactor do
  let(:entity) { create(:entity) }
  let(:is_active) { 1 }
  let(:name) { Faker::Company.name }
  let(:reference) { entity.reference }
  let(:user) { create(:user) }
  subject(:context) do
    UpdateEntity.call(
      :entity_id => entity.id,
      # :is_active => is_active,
      :name => name,
      :reference => reference,
      :user => user)
  end

  context 'when the parameters are valid' do
    describe 'context' do
      subject { context }

      it { is_expected.to be_a_success }
      its(:entity) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.success.messages.updated',
                 :model => I18n.t('ar.models.entity')))
      end
    end

    describe Entity do
      subject { context.entity }

      its(:errors) { is_expected.to be_empty }
    end
  end

  # context 'when disabling an entity' do
  #   let(:is_active) { 0 }

  #   describe 'context' do
  #     subject { context }

  #     it { is_expected.to be_a_success }
  #     its(:customer) { is_expected.to be_present }
  #     its(:message) do
  #       is_expected.to eq(
  #         I18n.t('ar.success.messages.updated',
  #                :model => I18n.t('ar.models.entity')))
  #     end
  #   end

  #   describe Entity do
  #     subject { context.entity }

  #     its(:is_active) { is_expected.to eq(0) }
  #   end
  # end

  context 'when the parameters are invalid' do
    let(:reference) { nil }

    describe 'context' do
      subject { context }

      it { is_expected.to be_a_failure }
      its(:entity) { is_expected.to be_present }
      its(:message) do
        is_expected.to eq(
          I18n.t('ar.failure.messages.validate',
                 :model => I18n.t('ar.models.entity')))
      end
    end

    describe Entity do
      subject { context.entity }

      describe 'papertrail' do
        it 'should not increase the version' do
          expect { subject }.not_to change { context.entity.versions.size }
        end
      end
    end
  end
end
