require 'rails_helper'

RSpec.describe Entities::VersionsController, :type => :controller do
  before { sign_in(user) }
  let(:entity) { create(:entity) }

  context 'when authorized' do
    let(:user) { create(:user, :confirmed, :authenticated, :entity_admin) }

    describe 'GET index with versions' do
      before do
        get :index, :id => entity.id
      end

      it 'responds with status equal to 200' do
        expect(response.status).to eq(200)
      end

      it 'assigns @entity_versions' do
        entity_versions = { entity.versions.last => entity }
        expect(assigns(:entity_versions)).to eq(entity_versions)
      end

      it 'renders the index template' do
        expect(response).to render_template('index')
      end
    end
  end

  context 'when not authorized' do
    before { get :index, :id => entity.id }
    let(:user) { create(:user, :confirmed) }

    describe 'GET index' do
      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to('/')
      end
    end
  end
end
