require 'rails_helper'

RSpec.describe CreateContact, :type => :interactor do
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:title) { Faker::Name.title }
  let(:email_address) { Faker::Internet.email }
  let(:fax_number) { Faker::PhoneNumber.phone_number }
  let(:mobile_number) { Faker::PhoneNumber.cell_phone }
  let(:phone_number) { Faker::PhoneNumber.phone_number }
  let(:entity) { create(:entity) }
  let(:user) { create(:user) }
  subject(:context) do
    CreateContact.call(
      :entity => entity,
      :first_name => first_name,
      :last_name => last_name,
      :title => title,
      :email_address => email_address,
      :fax_number => fax_number,
      :mobile_number => mobile_number,
      :phone_number => phone_number,
      :user => user)
  end

  context 'valid parameters' do
    describe 'context' do
      it { is_expected.to be_a_success }

      it 'message contains success' do
        expect(context.message).to match(/success/i)
      end

      it 'has set the contact' do
        expect(context.contact).to be_present
      end
    end

    describe Contact do
      subject { context.contact }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:entity) { is_expected.to be_present }
      its('versions.size') { is_expected.to eq(1) }
      its(:originator) { is_expected.to eq(user.id.to_s) }
    end
  end

  context 'invalid parameters' do
    let(:first_name) { nil }

    describe 'context' do
      it { is_expected.to be_a_failure }

      it 'message contains fail' do
        expect(context.message).to match(/invalid/i)
      end

      it 'has set the contact' do
        expect(context.contact).to be_present
      end
    end

    describe Contact do
      subject(:contact) { context.contact }

      its(:present?) { is_expected.to be_truthy }
      its(:persisted?) { is_expected.to be_falsey }
      its(:entity) { is_expected.to be_present }
    end
  end
end
