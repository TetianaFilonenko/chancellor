require 'rails_helper'

RSpec.describe SalespeopleController, :type => :controller do
  before { sign_in(user) }

  context 'when authorized' do
    let(:entity) { create(:entity) }
    let(:user) do
      create(:user, :all_roles)
    end

    describe 'POST create' do
      before do
        context = double(:entity => entity,
                         :message => 'success',
                         :success? => true)
        salesperson_entry = double(:salesperson_entry,
                                   :to_h => {},
                                   :valid? => true)
        allow(CreateSalesperson)
          .to receive(:call) { context }
        allow(SalespersonEntry)
          .to receive(:new) { salesperson_entry }

        post :create, :entity_id => entity.id, :salesperson_entry => {}
      end

      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the user page' do
        expect(response).to redirect_to(entity_path(entity))
      end

      it 'flashes a success message' do
        expect(request.flash[:notice]).to_not be_nil
      end
    end

    describe 'DELETE destroy' do
      before do
        salesperson = create(:salesperson, :entity => entity)
        delete :destroy, :id => salesperson.id
      end
      it 'responds with status equal to 302' do
        expect(response.status).to eq(302)
      end

      it 'redirects to the entity path' do
        expect(response).to redirect_to(entity_path(entity))
      end
    end
  end
end
