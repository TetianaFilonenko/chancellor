require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do
  before { sign_in(user) }
  let(:entity) { create(:entity) }
  let(:contact) { create(:contact, :entity => entity) }

  context 'when authorized' do
    let(:user) { create(:user, :all_roles) }

    describe 'POST create' do
      before do
        context = double(:entity => entity,
                         :message => 'success',
                         :success? => true)
        contact_entry = double(:contact_entry, :to_h => {}, :valid? => true)
        allow(CreateContact)
          .to receive(:call) { context }
        allow(ContactEntry)
          .to receive(:new) { contact_entry }

        post :create, :entity_id => entity.id, :contact_entry => {}
      end

      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to entity_path(entity) }
      it 'flashes a success message' do
        expect(subject.request.flash[:notice]).to_not be_nil
      end
    end

    describe 'DELETE destroy' do
      before { delete :destroy, :id => contact.id }

      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to entity_path(entity) }
    end

    describe 'GET edit' do
      before { get :edit, :id => contact.id }

      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template 'edit' }
      it 'assigns @location' do
        expect(assigns(:contact)).to eq(contact)
      end
    end
  end

  context 'when not authorized' do
    before { get :edit, :id => contact.id }
    let(:user) { create(:user, :confirmed) }

    describe 'GET edit' do
      it { is_expected.to respond_with 302 }
      it { is_expected.to redirect_to root_path }
    end
  end
end
