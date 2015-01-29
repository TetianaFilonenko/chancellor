require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do
  before { sign_in(user) }
  let(:location) { create(:entity).primary_location }

  context 'when authorized' do
    let(:user) { create(:user, :confirmed, :authenticated, :location_admin) }

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
