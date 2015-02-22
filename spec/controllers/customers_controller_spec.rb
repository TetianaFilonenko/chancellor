require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do
  before do
    sign_in(user)

    allow(CustomerEntry)
      .to receive(:new) { customer_entry }
  end

  let(:context) do
    double(:entity => entity, :message => 'success', :success? => true)
  end
  let(:entity) { create(:entity) }
  let(:customer) { create(:customer, :entity => entity) }
  let(:customer_entry) { double(:to_h => {}, :valid? => true) }
  let(:user) { create(:user, :all_roles) }

  describe 'POST create' do
    before do
      allow(CreateCustomer)
        .to receive(:call) { context }

      post :create, :entity_id => entity.id, :customer_entry => {}
    end

    context 'when customer details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where customer details are not valid' do
      let(:customer_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }
    end

    context 'where create customer fails' do
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
      allow(UpdateCustomer)
        .to receive(:call) { context }

      patch :update, :id => customer.id, :customer_entry => {}
    end

    context 'when customer details are valid' do
      it { is_expected.to respond_with(302) }
      it { is_expected.to redirect_to(entity_path(entity)) }
      it { is_expected.to set_flash[:notice] }
    end

    context 'where customer details are not valid' do
      let(:customer_entry) { double(:to_h => {}, :valid? => false) }

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:edit) }
    end

    context 'where update customer fails' do
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
    before { get :edit, :id => customer.id }

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
