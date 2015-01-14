require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  context 'when signed in' do
    before { sign_in(create(:user)) }

    describe 'GET index' do
      it 'responds with status equal to 200' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end
  end

  context 'when not signed in' do
    describe 'GET index' do
      it 'responds with status equal to 302' do
        get :index
        expect(response.status).to eq(302)
      end

      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
