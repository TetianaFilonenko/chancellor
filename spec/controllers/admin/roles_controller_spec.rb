require 'rails_helper'

RSpec.describe Admin::RolesController, :type => :controller do
  before { sign_in(user) }
  let(:user_to_manage) { create(:user, :confirmed) }

  context 'when authorized' do
    let(:user) do
      create(:user, :authenticated, :admin, :user_admin)
    end

    describe 'POST create' do
      before do
        grant_role = double(:grant_role, :name => 'role', :user => user)
        allow(grant_role).to receive(:save) { true }
        allow(GrantRole)
          .to receive(:new) { grant_role }

        post :create, :user_id => user.id, :grant_role => {}
      end

      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the user page' do
        expect(response).to redirect_to(admin_user_path(user))
      end

      it 'flashes a success message' do
        expect(request.flash[:notice]).to_not be_nil
      end
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
