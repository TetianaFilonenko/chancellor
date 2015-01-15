require 'rails_helper'

RSpec.describe Admin::UsersController, :type => :controller do
  before { sign_in(user) }

  context 'when authorized' do
    let(:user) do
      create(:user, :confirmed, :authenticated, :admin, :user_admin)
    end

    describe 'GET index' do
      it 'responds with status equal to 200' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'assigns @users' do
        get :index
        expect(assigns(:users)).to eq([user])
      end
    end

    describe 'GET show' do
      it 'responds with status equal to 200' do
        get :show, :id => user.id
        expect(response.status).to eq(200)
      end

      it 'assigns @user' do
        get :show, :id => user.id
        expect(assigns(:user)).to eq(user)
      end

      it 'renders the index template' do
        get :show, :id => user.id
        expect(response).to render_template('show')
      end
    end
  end

  context 'when not authorized' do
    let(:user) { create(:user, :confirmed) }

    describe 'GET show' do
      it 'responds with status equal to 302' do
        get :show, :id => user.id
        expect(response.status).to eq(302)
      end

      it 'redirects to the home page' do
        get :show, :id => user.id
        expect(response).to redirect_to(root_path)
      end

      it 'shows a not authorized message' do
        get :show, :id => user.id
        expect(flash[:alert])
          .to match(I18n.t('user_policy.show?', :scope => :pundit))
      end
    end
  end
end
