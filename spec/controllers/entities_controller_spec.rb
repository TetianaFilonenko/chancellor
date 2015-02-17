require 'rails_helper'

RSpec.describe EntitiesController, :type => :controller do
  before do
    sign_in(user)

    allow(EntityEntry)
      .to receive(:new) { entity_entry }
  end

  let(:context) do
    double(:entity => entity, :message => 'success', :success? => true)
  end
  let(:entity) { create(:entity) }
  let(:entity_entry) do
    double(:merge_hash => nil, :to_h => {}, :valid? => true)
  end
  let(:user) { create(:user, :all_roles) }

  describe 'POST create' do
    before do
      allow(CreateEntity)
        .to receive(:call) { context }

      post :create, :entity_entry => {}
    end

    context 'when entity details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where entity details are not valid' do
      let(:entity_entry) do
        double(:merge_hash => nil, :to_h => {}, :valid? => false)
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }
    end

    context 'where create entity fails' do
      let(:context) do
        double(:entity => entity, :message => 'failure', :success? => false)
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }
    end

    context 'when not authorized' do
      let(:user) { create(:user, :confirmed) }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash[:alert] }
    end
  end

  describe 'PATCH update' do
    before do
      allow(UpdateEntity)
        .to receive(:call) { context }

      patch :update, :id => entity.id, :entity_entry => {}
    end

    context 'when entity details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where entity details are not valid' do
      let(:entity_entry) do
        double(:merge_hash => nil, :to_h => {}, :valid? => false)
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'where update entity fails' do
      let(:context) do
        double(:entity => entity, :message => 'failure', :success? => false)
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

  describe 'GET edit' do
    before { get :edit, :id => entity.id }

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:edit) }

    context 'when not authorized' do
      let(:user) { create(:user, :confirmed) }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash[:alert] }
    end
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:new) }

    context 'when not authorized' do
      let(:user) { create(:user, :confirmed) }

      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(root_path) }
      it { is_expected.to set_flash[:alert] }
    end
  end
end
