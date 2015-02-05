require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do
  before { sign_in(user) }
  let(:entity) { create(:entity) }
  let(:location) { create(:location, :entity => entity) }

  context 'when authorized' do
    let(:user) { create(:user, :all_roles) }

    describe 'POST create' do
      before do
        context = double(:entity => entity,
                         :message => 'success',
                         :success? => true)
        location_entry = double(:location_entry,
                                :to_h => {},
                                :valid? => true)
        allow(CreateLocation)
          .to receive(:call) { context }
        allow(LocationEntry)
          .to receive(:new) { location_entry }

        post :create, :entity_id => entity.id, :location_entry => {}
      end

      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the user page' do
        expect(response).to redirect_to(entity_path(entity))
      end

      it 'flashes a success message' do
        expect(request.flash[:notice]).to_not be_nil
      end
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, :id => location.id
      end
      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the entity path' do
        expect(response).to redirect_to(entity_path(entity))
      end
    end

    describe 'GET edit' do
      before { get :edit, :id => location.id }

      it 'responds with status equal to 200' do
        expect(response.status).to eq(200)
      end

      it 'assigns @location' do
        expect(assigns(:location)).to eq(location)
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end
  end

  context 'when not authorized' do
    before { get :edit, :id => location.id }
    let(:user) { create(:user, :confirmed) }

    describe 'GET edit' do
      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to('/')
      end
    end
  end
end
