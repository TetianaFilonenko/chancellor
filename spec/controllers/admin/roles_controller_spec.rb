require 'rails_helper'

RSpec.describe Admin::RolesController, :type => :controller do
  before { sign_in(user) }
  let(:user_to_manage) { create(:user, :confirmed) }

  context 'when authorized' do
    let(:user) do
      create(:user, :authenticated, :admin, :user_admin)
    end

    describe 'GET new' do
      it 'responds with status equal to 200' do
        get :new, :user_id => user_to_manage.id
        expect(response.status).to eq(200)
      end

      it 'renders the new template' do
        get :new, :user_id => user_to_manage.id
        expect(response).to render_template('new')
      end

      it 'assigns @user' do
        get :new, :user_id => user_to_manage.id
        expect(assigns(:user)).to eq(user_to_manage)
      end

      it 'assigns @grant' do
        get :new, :user_id => user_to_manage.id
        expect(assigns(:grant)).to be_present
      end
    end
  end

  context 'when not authorized' do
    let(:user) { create(:user, :confirmed) }

    describe 'GET new' do
      it 'responds with status equal to 302' do
        get :new, :user_id => user_to_manage.id
        expect(response.status).to eq(302)
      end

      it 'redirects to the home page' do
        get :new, :user_id => user_to_manage.id
        expect(response).to redirect_to(root_path)
      end

      it 'shows a not authorized message' do
        get :new, :user_id => user_to_manage.id
        expect(flash[:alert])
          .to match(I18n.t('user_policy.edit?', :scope => :pundit))
      end
    end
  end
end
