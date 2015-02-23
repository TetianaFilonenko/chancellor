require 'rails_helper'

RSpec.describe Admin::UsersController, :type => :controller do
  before do
    sign_in(user)

    allow(UserEntry)
      .to receive(:new) { user_entry }
  end

  context 'when authorized' do
    let(:user) { create(:user, :all_roles) }

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

  describe 'PATCH update' do
    before do
      patch :update, :id => other_user.id, :user_entry => {}
    end

    let(:other_user) { create(:user) }
    let(:user) { create(:user, :all_roles) }
    let(:user_entry) { double(:to_h => {}, :valid? => true) }

    context 'when user details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(admin_user_path(other_user)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when user details are not valid' do
      let(:user_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'when update user fails' do
      let(:other_user) do
        temp_user = create(:user)

        allow(temp_user)
          .to receive(:update_attributes) { false }
        allow(User)
          .to receive(:find).with(temp_user.id.to_s).and_return(temp_user)

        temp_user
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'when not authorized' do
      let(:user) { create(:user, :confirmed) }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash[:alert] }
    end
  end
end
