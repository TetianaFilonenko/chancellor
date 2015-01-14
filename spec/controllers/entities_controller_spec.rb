require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do
  before { sign_in(user) }

  context 'when authorized' do
    let(:user) { create(:user, :confirmed, :authenticated, :entity_admin) }

    describe 'GET index' do
      it 'responds with status equal to 200' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'assigns @entities' do
        entity = create(:entity)
        get :index
        expect(assigns(:entities)).to eq([entity])
      end

      it 'assigns @search' do
        create(:entity)
        get :index
        expect(assigns(:search)).to be_a_kind_of(Ransack::Search)
      end

      it '@entities contains decorated entity instances' do
        create(:entity)
        get :index
        expect(assigns(:entities).first).to be_a_kind_of(EntityDecorator)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  context 'when not authorized' do
    let(:user) { create(:user, :confirmed) }

    describe 'DELETE destroy' do
      it 'responds with status equal to 302' do
        entity = create(:entity)
        delete :destroy, :id => entity.id
        expect(response.status).to eq(302)
      end

      it 'redirects to the root path' do
        entity = create(:entity)
        delete :destroy, :id => entity.id
        expect(response).to redirect_to('/')
      end
    end
  end
end
