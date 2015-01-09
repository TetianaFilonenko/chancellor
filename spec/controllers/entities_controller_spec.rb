require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do
  before { sign_in(user) }

  context 'when authorized' do
    let(:user) do
      authorized_user = build(:user, :confirmed)
      authorized_user.roles << build(:user_role_entity_admin)
      authorized_user.save!
      authorized_user
    end

    describe 'GET index' do
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
      it 'redirects to the root path' do
        entity = create(:entity)
        delete :destroy, :id => entity.id
        expect(response).to redirect_to('/')
      end
    end
  end
end
