require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do
  before { sign_in(create(:user)) }

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
