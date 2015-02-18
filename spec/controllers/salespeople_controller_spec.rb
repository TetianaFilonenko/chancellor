require 'rails_helper'

RSpec.describe SalespeopleController, :type => :controller do
  before do
    sign_in(user)

    allow(SalespersonEntry)
      .to receive(:new) { salesperson_entry }
  end

  let(:context) do
    double(:entity => entity, :message => 'success', :success? => true)
  end
  let(:entity) { create(:entity) }
  let(:salesperson) { create(:salesperson, :entity => entity) }
  let(:salesperson_entry) { double(:to_h => {}, :valid? => true) }
  let(:user) { create(:user, :all_roles) }

  describe 'POST create' do
    before do
      allow(CreateSalesperson)
        .to receive(:call) { context }

      post :create, :entity_id => entity.id, :salesperson_entry => {}
    end

    context 'when salesperson details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where salesperson details are not valid' do
      let(:salesperson_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }
    end

    context 'where create salesperson fails' do
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
      allow(UpdateSalesperson)
        .to receive(:call) { context }

      patch :update, :id => salesperson.id, :salesperson_entry => {}
    end

    context 'when salesperson details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where salesperson details are not valid' do
      let(:salesperson_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'where create salesperson fails' do
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
    before { get :edit, :id => salesperson.id }

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
