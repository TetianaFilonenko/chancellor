require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do
  before do
    sign_in(user)

    allow(LocationEntry)
      .to receive(:new) { location_entry }
  end
  let(:entity) { create(:entity) }
  let(:location) { create(:location, :entity => entity) }
  let(:location_entry) { double(:to_h => {}, :valid? => true) }
  let(:update_result) { true }
  let(:user) { create(:user, :all_roles) }

  describe 'POST create' do
    before do
      allow(CreateLocation)
        .to receive(:call) { context }

      post :create, :entity_id => entity.id, :location_entry => {}
    end
    let(:context) do
      double(:entity => entity, :message => 'success', :success? => true)
    end

    context 'when location details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when location details are not valid' do
      let(:location_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }
    end

    context 'when create location fails' do
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
      allow(Location)
        .to receive(:find).with(location.id.to_s).and_return(location)
      allow(location).to receive(:update_attributes).and_return(update_result)

      patch :update, :id => location.id, :location_entry => {}
    end

    context 'when location details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'when location details are not valid' do
      let(:location_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'when update location fails' do
      let(:update_result) { false }

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
    before { get :edit, :id => location.id }

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
    before { get :new, :entity_id => entity.id }

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
